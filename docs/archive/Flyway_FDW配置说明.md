# Flyway FDW 配置说明

## ✅ 已创建 Flyway 迁移脚本

**文件位置**: `create_table/migrations_ultimate/V20260122133659054__setup_fdw_bigdata_web.sql`

---

## 📋 执行顺序

Flyway 将按版本号顺序执行：

```
V20260122133659001 - 创建表1
V20260122133659002 - 创建表2
...
V20260122133659053 - 创建表53
V20260122133659054 - 配置 FDW ⭐ (新增)
```

FDW 配置将在**所有表创建完成后**自动执行。

---

## ⚙️ 配置步骤

### 1. 修改 FDW 配置信息

打开文件：`V20260122133659054__setup_fdw_bigdata_web.sql`

修改以下4处配置：

```sql
-- 第30-31行：修改 IP 和端口
CREATE SERVER bigdata_web_server
    OPTIONS (
        host '192.168.1.100',        -- ⚠️ 改为 bigdata_web 的实际 IP
        port '5432',                 -- ⚠️ 改为实际端口
        ...
    );

-- 第41-42行：修改用户名和密码
CREATE USER MAPPING IF NOT EXISTS FOR PUBLIC
    OPTIONS (
        user 'bigdata_user',         -- ⚠️ 改为实际用户名
        password 'bigdata_password'  -- ⚠️ 改为实际密码
    );
```

### 2. 执行 Flyway 迁移

```bash
# 验证迁移脚本
flyway validate

# 查看待执行的迁移（应该能看到54个脚本）
flyway info

# 执行迁移
flyway migrate

# 确认结果
flyway info
```

### 3. 验证 FDW 配置

执行迁移后，在数据库中验证：

```sql
-- 查看外部服务器
\des+

-- 查看导入的外部表
\det+ bigdata_web.*

-- 测试查询
SELECT COUNT(*) FROM bigdata_web.t_asset_info;
```

---

## 📊 迁移后的效果

### 数据库结构

```
你的主数据库
├── public schema
│   ├── t_alarm_out_going_config
│   ├── t_event_template
│   └── ... (53个表)
│
└── bigdata_web schema (FDW)
    ├── t_asset_info (外部表)
    ├── t_ailpha_network_segment (外部表)
    ├── t_ailpha_security_zone (外部表)
    ├── t_vulnerability_info (外部表)
    └── t_third_auth (外部表)
```

### XML 文件无需修改

配置完成后，这些 XML 文件可以直接使用：

```xml
<!-- SecurityZoneSyncMapper.xml -->
<select id="querySecurityZone">
    SELECT ti.assetIp, f."name", f.id
    FROM bigdata_web.t_asset_info ti
    JOIN bigdata_web.t_ailpha_network_segment e ON ...
    JOIN bigdata_web.t_ailpha_security_zone f ON ...
</select>
```

---

## 🎯 优点

### ✅ 使用 Flyway 管理 FDW 的优势

1. **版本控制**: FDW 配置纳入版本管理
2. **可重复执行**: Flyway 确保幂等性
3. **自动化部署**: 随应用一起自动配置
4. **环境一致性**: 开发、测试、生产环境统一
5. **易于维护**: 所有数据库配置集中管理

---

## ⚠️ 注意事项

### 1. 敏感信息处理

**问题**: 密码明文存储在 SQL 文件中

**解决方案A**: 使用环境变量（推荐）

创建一个独立的配置脚本（不纳入版本控制）：

```sql
-- fdw_config_secrets.sql (加入 .gitignore)
CREATE USER MAPPING IF NOT EXISTS FOR PUBLIC
    SERVER bigdata_web_server
    OPTIONS (
        user '${BIGDATA_USER}',      -- 从环境变量读取
        password '${BIGDATA_PASSWORD}'
    );
```

**解决方案B**: 使用 Flyway 占位符

在 `flyway.conf` 中配置：

```properties
flyway.placeholders.bigdataHost=192.168.1.100
flyway.placeholders.bigdataPort=5432
flyway.placeholders.bigdataUser=bigdata_user
flyway.placeholders.bigdataPassword=bigdata_password
```

然后在 SQL 中使用：

```sql
CREATE SERVER bigdata_web_server
    OPTIONS (
        host '${bigdataHost}',
        port '${bigdataPort}',
        ...
    );
```

**解决方案C**: 手动执行用户映射

将用户映射从 Flyway 脚本中移除，手动执行：

```sql
-- 手动执行（不纳入版本控制）
CREATE USER MAPPING FOR PUBLIC
    SERVER bigdata_web_server
    OPTIONS (user 'xxx', password 'xxx');
```

---

### 2. 网络连接要求

确保以下网络连接可用：

```
主数据库服务器 → bigdata_web 数据库服务器:5432
```

配置防火墙规则：

```bash
# 在 bigdata_web 服务器上
iptables -A INPUT -p tcp -s <主数据库IP> --dport 5432 -j ACCEPT
```

---

### 3. 用户权限

确保 bigdata_web 数据库中的用户有相应权限：

```sql
-- 在 bigdata_web 数据库中执行
GRANT CONNECT ON DATABASE bigdata_web TO bigdata_user;
GRANT USAGE ON SCHEMA public TO bigdata_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO bigdata_user;
```

---

### 4. 回滚支持

Flyway 不自动回滚 DDL，如需回滚 FDW 配置：

```sql
-- 手动回滚脚本
DROP SERVER IF EXISTS bigdata_web_server CASCADE;
DROP SCHEMA IF EXISTS bigdata_web CASCADE;
```

---

## 🔄 不同环境的配置

### 开发环境

```sql
-- V20260122133659054__setup_fdw_bigdata_web.sql
CREATE SERVER bigdata_web_server
    OPTIONS (
        host '192.168.1.100',    -- 开发环境 IP
        port '5432',
        ...
    );
```

### 测试环境

使用 Flyway 占位符：

```properties
# flyway-test.conf
flyway.placeholders.bigdataHost=192.168.2.100
flyway.placeholders.bigdataPort=5432
```

### 生产环境

```properties
# flyway-prod.conf
flyway.placeholders.bigdataHost=10.0.1.100
flyway.placeholders.bigdataPort=5432
```

---

## 📝 完整的 Flyway 迁移清单

现在你的迁移脚本包括：

| 版本 | 脚本 | 说明 |
|------|------|------|
| V20260122133659001 | create_t_alarm_out_going_config | 创建告警配置表 |
| V20260122133659002 | create_t_alarm_status_timing_task | 创建定时任务表 |
| ... | ... | ... |
| V20260122133659053 | create_xdr_schema_version | 创建版本表 |
| **V20260122133659054** | **setup_fdw_bigdata_web** | **配置 FDW ⭐** |

共 **54 个迁移脚本**

---

## 🚀 执行流程

### 初次部署

```bash
# 1. 修改 FDW 配置信息
vi V20260122133659054__setup_fdw_bigdata_web.sql

# 2. 验证所有迁移脚本
flyway validate

# 3. 查看待执行的迁移（应该显示54个）
flyway info

# 4. 执行迁移
flyway migrate

# 5. 验证结果
flyway info
psql -c "SELECT COUNT(*) FROM bigdata_web.t_asset_info"
```

### 后续部署

Flyway 会记录已执行的迁移，不会重复执行。

---

## ✅ 验证清单

部署完成后，验证以下内容：

- [ ] 所有53个业务表已创建
- [ ] FDW 扩展已安装
- [ ] bigdata_web_server 外部服务器已创建
- [ ] 用户映射已创建
- [ ] bigdata_web schema 已创建
- [ ] 5个外部表可以查询
- [ ] JOIN 查询正常工作
- [ ] 应用启动正常
- [ ] XML Mapper 查询正常

---

## 🎊 总结

### ✅ 优势

- **自动化**: Flyway 自动配置 FDW
- **版本控制**: 配置纳入版本管理
- **可重复**: 可在任何环境重复部署
- **零修改**: XML 文件完全不用改

### 📋 检查清单

执行前确认：
1. ✅ 已修改 IP、端口、用户名、密码
2. ✅ 网络连接可用
3. ✅ bigdata_web 数据库权限正确
4. ✅ 敏感信息已妥善处理

**现在可以执行 Flyway migrate 了！** 🚀
