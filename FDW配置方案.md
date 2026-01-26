# PostgreSQL FDW 跨库查询配置方案

## 📋 场景说明

- **当前数据库**: 你的主应用数据库（包含 xdr 相关表）
- **远程数据库**: `bigdata_web` 数据库（通过 IP 连接）
- **需要访问的远程表**: 
  - `t_asset_info`
  - `t_ailpha_network_segment`
  - `t_ailpha_security_zone`
  - `t_vulnerability_info`
  - `t_third_auth`

---

## 🚀 完整配置步骤

### 步骤1: 在当前数据库安装 postgres_fdw 扩展

```sql
-- 连接到你的主应用数据库
\c your_main_database

-- 安装 FDW 扩展
CREATE EXTENSION IF NOT EXISTS postgres_fdw;
```

---

### 步骤2: 创建外部服务器

```sql
-- 创建到 bigdata_web 数据库的服务器连接
CREATE SERVER bigdata_web_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (
        host '192.168.1.100',        -- 替换为实际的 IP 地址
        port '5432',                 -- PostgreSQL 端口
        dbname 'bigdata_web'         -- 远程数据库名
    );

-- 查看创建的服务器
\des+
```

**注意**: 请替换为实际的 IP 地址和端口

---

### 步骤3: 创建用户映射

```sql
-- 为当前用户创建到远程数据库的映射
CREATE USER MAPPING FOR current_user
    SERVER bigdata_web_server
    OPTIONS (
        user 'remote_username',      -- 远程数据库的用户名
        password 'remote_password'   -- 远程数据库的密码
    );

-- 或者为特定用户创建映射
CREATE USER MAPPING FOR dbapp
    SERVER bigdata_web_server
    OPTIONS (
        user 'bigdata_user',
        password 'bigdata_password'
    );
```

---

### 步骤4: 创建本地 schema 并导入外部表

```sql
-- 创建本地 schema（与远程数据库同名）
CREATE SCHEMA IF NOT EXISTS bigdata_web;

-- 方式A: 导入指定的表（推荐）
IMPORT FOREIGN SCHEMA public
    LIMIT TO (
        t_asset_info,
        t_ailpha_network_segment,
        t_ailpha_security_zone,
        t_vulnerability_info,
        t_third_auth
    )
    FROM SERVER bigdata_web_server
    INTO bigdata_web;

-- 方式B: 导入所有表（如果需要）
-- IMPORT FOREIGN SCHEMA public
--     FROM SERVER bigdata_web_server
--     INTO bigdata_web;
```

---

### 步骤5: 验证配置

```sql
-- 查看导入的外部表
\det+ bigdata_web.*

-- 测试查询
SELECT COUNT(*) FROM bigdata_web.t_asset_info;
SELECT COUNT(*) FROM bigdata_web.t_ailpha_network_segment;
SELECT COUNT(*) FROM bigdata_web.t_ailpha_security_zone;
SELECT COUNT(*) FROM bigdata_web.t_vulnerability_info;
SELECT COUNT(*) FROM bigdata_web.t_third_auth;

-- 测试 JOIN 查询（与你的 XML 中的查询类似）
SELECT 
    ti.assetIp, 
    f."name", 
    f.id
FROM bigdata_web.t_asset_info ti
RIGHT JOIN bigdata_web.t_ailpha_network_segment e
    ON e.relation_type='SECURITY_ZONE' 
    AND ti.assetIpNum BETWEEN e.first_ip AND e.last_ip
LEFT JOIN bigdata_web.t_ailpha_security_zone f 
    ON e.relation_id = f.id
WHERE f.id IS NOT NULL
LIMIT 10;
```

---

## ✅ XML 文件无需修改

配置完成后，你的 XML 文件可以**完全不用修改**，继续使用原来的语法：

```xml
<select id="querySecurityZone" resultType="java.util.Map">
    SELECT
        ti.assetIp, f."name", f.id
    FROM
        bigdata_web.t_asset_info ti
    RIGHT JOIN bigdata_web.t_ailpha_network_segment e
        ON e.relation_type='SECURITY_ZONE' 
        AND ti.assetIpNum BETWEEN e.first_ip AND e.last_ip
    LEFT JOIN bigdata_web.t_ailpha_security_zone f 
        ON e.relation_id = f.id
    WHERE f.id IS NOT NULL
</select>
```

---

## 🔐 安全建议

### 1. 使用只读用户

为了安全，建议在远程数据库创建只读用户：

```sql
-- 在 bigdata_web 数据库中执行
CREATE USER readonly_user WITH PASSWORD 'secure_password';

-- 授予只读权限
GRANT CONNECT ON DATABASE bigdata_web TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;

-- 自动授予未来创建的表的查询权限
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO readonly_user;
```

然后在主数据库的用户映射中使用这个只读用户：

```sql
CREATE USER MAPPING FOR current_user
    SERVER bigdata_web_server
    OPTIONS (
        user 'readonly_user',
        password 'secure_password'
    );
```

---

### 2. 配置防火墙

确保主数据库服务器可以访问 `bigdata_web` 数据库服务器：

```bash
# 在 bigdata_web 服务器的防火墙中允许主数据库服务器的 IP
# 示例（iptables）
iptables -A INPUT -p tcp -s <main_server_ip> --dport 5432 -j ACCEPT
```

---

### 3. 配置 pg_hba.conf

在 `bigdata_web` 数据库服务器的 `pg_hba.conf` 中添加：

```conf
# 允许主数据库服务器连接
host    bigdata_web    readonly_user    <main_server_ip>/32    md5
```

然后重新加载配置：

```bash
pg_ctl reload
```

---

## 📊 性能优化

### 1. 创建索引

确保远程表有适当的索引：

```sql
-- 在 bigdata_web 数据库中执行
CREATE INDEX IF NOT EXISTS idx_asset_info_ip 
    ON t_asset_info(assetIp);

CREATE INDEX IF NOT EXISTS idx_asset_info_ipnum 
    ON t_asset_info(assetIpNum);

CREATE INDEX IF NOT EXISTS idx_network_segment_relation 
    ON t_ailpha_network_segment(relation_type, first_ip, last_ip);

CREATE INDEX IF NOT EXISTS idx_security_zone_id 
    ON t_ailpha_security_zone(id);
```

---

### 2. 使用 FDW 选项优化

```sql
-- 设置批量获取大小（默认100）
ALTER SERVER bigdata_web_server 
    OPTIONS (ADD fetch_size '1000');

-- 启用异步执行（PostgreSQL 14+）
ALTER SERVER bigdata_web_server 
    OPTIONS (ADD async_capable 'true');
```

---

### 3. 使用本地缓存表（可选）

如果某些数据不经常变化，可以创建本地缓存表：

```sql
-- 创建本地缓存表
CREATE TABLE local_cache_security_zone AS
SELECT * FROM bigdata_web.t_ailpha_security_zone;

-- 创建索引
CREATE INDEX idx_local_security_zone_id 
    ON local_cache_security_zone(id);

-- 定期刷新（通过定时任务）
TRUNCATE local_cache_security_zone;
INSERT INTO local_cache_security_zone 
    SELECT * FROM bigdata_web.t_ailpha_security_zone;
```

---

## 🔍 监控和维护

### 查看 FDW 连接状态

```sql
-- 查看外部服务器
SELECT * FROM pg_foreign_server;

-- 查看用户映射
SELECT * FROM pg_user_mappings;

-- 查看外部表
SELECT * FROM information_schema.foreign_tables 
WHERE foreign_table_schema = 'bigdata_web';
```

---

### 测试连接

```sql
-- 测试基本查询
SELECT COUNT(*) FROM bigdata_web.t_asset_info;

-- 测试 JOIN 性能
EXPLAIN ANALYZE
SELECT 
    ti.assetIp, f."name", f.id
FROM bigdata_web.t_asset_info ti
RIGHT JOIN bigdata_web.t_ailpha_network_segment e
    ON e.relation_type='SECURITY_ZONE' 
    AND ti.assetIpNum BETWEEN e.first_ip AND e.last_ip
LEFT JOIN bigdata_web.t_ailpha_security_zone f 
    ON e.relation_id = f.id
WHERE f.id IS NOT NULL;
```

---

## 📝 完整配置脚本

```sql
-- ============================================
-- PostgreSQL FDW 跨库查询配置脚本
-- ============================================

-- 1. 安装扩展
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

-- 2. 创建外部服务器
DROP SERVER IF EXISTS bigdata_web_server CASCADE;
CREATE SERVER bigdata_web_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (
        host '192.168.1.100',        -- ⚠️ 修改为实际 IP
        port '5432',
        dbname 'bigdata_web'
    );

-- 3. 创建用户映射
DROP USER MAPPING IF EXISTS FOR current_user SERVER bigdata_web_server;
CREATE USER MAPPING FOR current_user
    SERVER bigdata_web_server
    OPTIONS (
        user 'readonly_user',        -- ⚠️ 修改为实际用户名
        password 'secure_password'   -- ⚠️ 修改为实际密码
    );

-- 4. 创建 schema
CREATE SCHEMA IF NOT EXISTS bigdata_web;

-- 5. 导入外部表
IMPORT FOREIGN SCHEMA public
    LIMIT TO (
        t_asset_info,
        t_ailpha_network_segment,
        t_ailpha_security_zone,
        t_vulnerability_info,
        t_third_auth
    )
    FROM SERVER bigdata_web_server
    INTO bigdata_web;

-- 6. 验证配置
SELECT 
    foreign_table_schema, 
    foreign_table_name 
FROM information_schema.foreign_tables 
WHERE foreign_table_schema = 'bigdata_web';

-- 7. 测试查询
SELECT COUNT(*) FROM bigdata_web.t_asset_info;

\echo '✅ FDW 配置完成！'
```

---

## ⚠️ 注意事项

### 1. 事务限制
- ❌ FDW 不支持跨库的完整事务（2PC）
- ✅ 可以使用只读事务

### 2. 性能考虑
- 网络延迟会影响查询性能
- 大量数据传输时需要优化
- 考虑在应用层做缓存

### 3. 安全性
- 使用只读用户
- 配置防火墙规则
- 使用 SSL 连接（可选）

---

## 🎯 配置后的效果

✅ **XML 文件完全不用修改**
✅ **继续使用 `bigdata_web.table_name` 语法**
✅ **查询结果与 MySQL 时一致**
✅ **代码无需修改**

---

## 📋 需要的信息

请提供以下信息以完成配置：

1. **bigdata_web 数据库的 IP 地址**: `_______________`
2. **bigdata_web 数据库的端口**: `_______________`（通常是 5432）
3. **连接用户名**: `_______________`
4. **连接密码**: `_______________`
5. **主数据库名称**: `_______________`（你的应用数据库）

---

## 🚀 下一步

1. 收集上述信息
2. 在主数据库执行配置脚本
3. 测试 FDW 连接
4. 运行你的应用，验证跨库查询

**XML 文件无需任何修改！** ✅
