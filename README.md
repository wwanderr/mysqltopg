# MySQL to PostgreSQL 16.x 迁移项目

> **项目目标**: 将生产环境的MySQL数据库和MyBatis XML完整迁移到PostgreSQL 16.x  
> **完成时间**: 2026-01-14 至 2026-01-19  
> **项目状态**: ✅ 转换完成，等待测试和部署

---

## 📁 项目结构

```
mysqlToPg/
├── README.md                                    # 本文件
├── 数据库切换PG方案.md                           # 原始参考文档
│
├── docs/                                        # 文档目录
│   ├── MySQL转PostgreSQL迁移规范与约束.md        # DDL迁移规范 (2984行)
│   ├── MyBatis-MySQL转PostgreSQL-SQL语法约束.md  # MyBatis XML SQL语法约束 (1283行)
│   ├── primary_key_conversion_guide.md          # 主键和自增主键转换指南
│   ├── table_index.md                           # 表索引 (214张表)
│   ├── conversion_progress.md                   # DDL转换进度
│   ├── conversion_summary_report.md             # DDL转换总结
│   └── mybatis_xml_conversion_report.md         # MyBatis XML转换报告
│
├── bigdata-web-data.sql                         # 原始MySQL dump (214张表)
│
├── mysql_split/                                 # MySQL dump分割文件
│   ├── batch_01_tables_001-020_mysql.sql
│   ├── batch_02_tables_021-040_mysql.sql
│   ├── ... (共11个文件)
│   └── table_split_index.txt                    # 表分割索引
│
├── output/                                      # PostgreSQL DDL输出
│   ├── batch_01_tables_001-020_postgresql.sql
│   ├── batch_02_tables_021-040_postgresql.sql
│   └── ... (共11个文件)
│
├── mysql/mysql/                                 # 原始MyBatis XML (40个文件)
│   ├── AssetInfoMapper.xml
│   ├── SecurityAlarmHandleMapper.xml
│   └── ... (共40个XML文件)
│
├── postgresql_xml/                              # 转换后的PostgreSQL XML (40个文件)
│   ├── AssetInfoMapper.xml
│   ├── SecurityAlarmHandleMapper.xml
│   └── ... (共40个XML文件)
│
└── scripts/                                     # 转换脚本
    ├── split_tables.py                          # DDL分割脚本
    ├── convert_mysql_to_pg.py                   # DDL转换脚本
    └── convert_mybatis_xml.py                   # MyBatis XML转换脚本
```

---

## 🎯 项目成果

### 1️⃣ DDL转换（建表语句）

**输入**: `bigdata-web-data.sql` (18,027行, 214张表)

**输出**: 11个PostgreSQL DDL文件 (每个文件20张表)

**转换统计**:
- ✅ 表结构: 214张表全部转换
- ✅ 主键: 214个 `PRIMARY KEY` 约束
- ✅ 索引: 提取为独立的 `CREATE INDEX` 语句
- ✅ 注释: 转换为 `COMMENT ON COLUMN/TABLE`
- ✅ 自增主键: `INT AUTO_INCREMENT` → `SERIAL`, `BIGINT AUTO_INCREMENT` → `BIGSERIAL`

**关键转换**:
- `TINYINT` → `SMALLINT` 或 `BOOLEAN`
- `DATETIME` → `TIMESTAMP`
- `MEDIUMTEXT/LONGTEXT` → `TEXT`
- `ENGINE=InnoDB` → 移除
- `AUTO_INCREMENT` → `SERIAL/BIGSERIAL`

### 2️⃣ MyBatis XML转换（业务SQL）

**输入**: 40个MyBatis Mapper XML文件

**输出**: 40个PostgreSQL兼容的XML文件

**转换统计**:
- ✅ 文件转换: 40/40 (100%)
- ✅ LIMIT转换: 21次
- ✅ ON DUPLICATE KEY: 22次
- ✅ GROUP_CONCAT: 31次
- ✅ DATE_FORMAT: 61次
- ✅ IFNULL: 16次
- ✅ IF条件: 11次
- ✅ CONCAT: 136次
- ✅ NOW(): 32次
- ✅ 总计: **~700+次语法转换**

**关键转换**:
- `LIMIT offset, count` → `LIMIT count OFFSET offset`
- `ON DUPLICATE KEY UPDATE` → `ON CONFLICT DO UPDATE`
- `GROUP_CONCAT(col)` → `STRING_AGG(col, ',')`
- `DATE_FORMAT(date, fmt)` → `TO_CHAR(date, fmt)`
- `IFNULL(a, b)` → `COALESCE(a, b)`
- `IF(cond, a, b)` → `CASE WHEN cond THEN a ELSE b END`

---

## 📚 核心文档

### 1. MySQL转PostgreSQL迁移规范与约束.md

**内容**: DDL转换规范，包括数据类型、索引、主键、约束、触发器等

**行数**: 2984行

**适用于**: 数据库管理员、DDL转换、Schema设计

**核心章节**:
- 数据类型映射表
- 主键和自增策略
- 索引转换规则
- 约束处理
- 触发器替代方案
- 组件兼容性

### 2. MyBatis-MySQL转PostgreSQL-SQL语法约束.md

**内容**: MyBatis XML中SQL语法转换规范

**行数**: 1283行

**适用于**: Java开发者、业务代码迁移

**核心章节**:
- 查询语句转换
- 插入/更新/删除转换
- 函数转换大全
- 分页查询转换
- 日期时间处理
- 字符串操作
- MyBatis动态SQL处理

### 3. primary_key_conversion_guide.md

**内容**: 主键和自增主键转换技术指南

**适用于**: 理解SERIAL类型和序列管理

**核心内容**:
- `AUTO_INCREMENT` → `SERIAL/BIGSERIAL`
- 序列管理和重置
- 数据迁移后的处理
- 完整示例对比

### 4. mybatis_xml_conversion_report.md

**内容**: MyBatis XML转换总结报告

**适用于**: 项目验收、测试计划

**核心内容**:
- 转换统计详情
- 典型转换示例
- 注意事项和风险点
- 测试建议
- 部署步骤

---

## 🛠️ 转换工具

### 1. split_tables.py

**功能**: 将大型MySQL dump文件分割成小文件

**用法**:
```bash
python split_tables.py
```

**输出**:
- `mysql_split/batch_XX_tables_XXX-XXX_mysql.sql`
- `mysql_split/table_split_index.txt`

### 2. convert_mysql_to_pg.py

**功能**: 将MySQL DDL转换为PostgreSQL DDL

**用法**:
```bash
python convert_mysql_to_pg.py
```

**处理**:
- 数据类型转换
- 主键和索引转换
- 自增主键 → SERIAL
- 注释提取
- ON UPDATE CURRENT_TIMESTAMP → Trigger

### 3. convert_mybatis_xml.py

**功能**: 将MyBatis XML中的MySQL SQL转换为PostgreSQL SQL

**用法**:
```bash
python convert_mybatis_xml.py
```

**处理**:
- LIMIT语法转换
- ON DUPLICATE KEY转换
- 函数转换 (GROUP_CONCAT, DATE_FORMAT, IFNULL, IF, CONCAT)
- 日期时间函数转换
- 字符串操作转换

---

## ⚠️ 重要注意事项

### 必须手动处理的项目

#### 1. ON CONFLICT 冲突列 ⭐⭐⭐

**问题**: 转换后的 `ON CONFLICT` 没有指定冲突列

**位置**: 22个位置（MyBatis XML中）

**解决方案**:
```sql
-- 当前
ON CONFLICT DO UPDATE SET ...

-- 需要改为
ON CONFLICT (id) DO UPDATE SET ...
-- 或
ON CONFLICT (unique_key_1, unique_key_2) DO UPDATE SET ...
```

**操作**: 根据每个表的主键或唯一键，手动添加冲突列。

#### 2. LIKE vs ILIKE ⭐⭐

**问题**: MySQL的 `LIKE` 默认不区分大小写，PostgreSQL区分大小写

**位置**: 139个位置

**解决方案**:
```sql
-- 如果需要不区分大小写
WHERE name LIKE '%test%'  改为  WHERE name ILIKE '%test%'
```

#### 3. 序列重置 ⭐⭐⭐

**问题**: 数据导入后，序列值需要重置

**操作**: 数据导入完成后，必须运行：
```sql
SELECT setval(
  pg_get_serial_sequence('table_name', 'id'), 
  (SELECT MAX(id) FROM table_name)
);
```

### 建议检查的项目

#### 4. GROUP BY 严格性

PostgreSQL要求SELECT中的非聚合列必须在GROUP BY中。

#### 5. 日期格式

验证所有日期格式转换是否符合预期。

#### 6. 字符集和排序规则

PostgreSQL使用UTF8编码和ICU排序规则。

---

## 🧪 测试计划

### 阶段1: 单元测试

```bash
# 1. 导入DDL
psql -U postgres -d testdb < output/batch_01_tables_001-020_postgresql.sql

# 2. 验证表结构
\d+ table_name

# 3. 测试Mapper
mvn test -Dtest=AssetInfoMapperTest
```

### 阶段2: 集成测试

```bash
# 1. 导入所有DDL
for file in output/*.sql; do
  psql -U postgres -d testdb < $file
done

# 2. 导入数据
# (使用CSV导出/导入或DataX)

# 3. 重置所有序列
# (运行批量重置脚本)

# 4. 运行集成测试
mvn integration-test
```

### 阶段3: 性能测试

```bash
# 1. 执行慢查询分析
EXPLAIN ANALYZE SELECT ...

# 2. 对比MySQL和PostgreSQL性能

# 3. 优化索引
```

### 阶段4: 数据一致性验证

```sql
-- 验证数据量
SELECT COUNT(*) FROM table_name;

-- 验证聚合结果
SELECT SUM(amount), AVG(score) FROM orders;

-- 验证日期格式
SELECT TO_CHAR(create_time, 'YYYY-MM-DD') FROM users LIMIT 10;
```

---

## 🚀 部署步骤

### 1. 开发环境

```yaml
# application-dev.yml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/devdb
    driver-class-name: org.postgresql.Driver
    username: dev_user
    password: dev_password
```

### 2. 测试环境

```bash
# 1. 创建数据库
createdb -U postgres testdb

# 2. 导入Schema
for file in output/*.sql; do
  psql -U postgres -d testdb < $file
done

# 3. 导入数据
# (使用pg_restore或COPY命令)

# 4. 重置序列
psql -U postgres -d testdb < reset_sequences.sql

# 5. 部署应用
java -jar -Dspring.profiles.active=test app.jar
```

### 3. 生产环境

```bash
# 1. 备份MySQL数据
mysqldump -u root -p dbname > backup_mysql.sql

# 2. 创建PostgreSQL数据库
createdb -U postgres proddb

# 3. 导入Schema
for file in output/*.sql; do
  psql -U postgres -d proddb < $file
done

# 4. 数据迁移
# (使用DataX或其他ETL工具)

# 5. 验证数据一致性
# (运行验证脚本)

# 6. 重置序列
psql -U postgres -d proddb < reset_sequences.sql

# 7. 部署应用
# (使用蓝绿部署或金丝雀发布)

# 8. 监控和回滚准备
# (监控应用日志和数据库性能)
```

---

## 📊 项目时间线

| 日期 | 任务 | 状态 |
|------|------|------|
| 2026-01-14 | 创建DDL迁移规范文档 | ✅ 完成 |
| 2026-01-14 | 编写DDL转换脚本 | ✅ 完成 |
| 2026-01-14 | 转换214张表的DDL | ✅ 完成 |
| 2026-01-19 | 创建MyBatis XML转换规范 | ✅ 完成 |
| 2026-01-19 | 编写MyBatis XML转换脚本 | ✅ 完成 |
| 2026-01-19 | 转换40个MyBatis XML文件 | ✅ 完成 |
| 2026-01-19 | 生成转换报告 | ✅ 完成 |
| 待定 | 手动修正ON CONFLICT | ⏳ 待处理 |
| 待定 | 开发环境测试 | ⏳ 待处理 |
| 待定 | 测试环境部署 | ⏳ 待处理 |
| 待定 | 生产环境迁移 | ⏳ 待处理 |

---

## 📖 快速开始

### 新团队成员上手

1. **阅读规范文档**
   ```bash
   # DDL规范
   cat docs/MySQL转PostgreSQL迁移规范与约束.md
   
   # MyBatis XML规范
   cat docs/MyBatis-MySQL转PostgreSQL-SQL语法约束.md
   ```

2. **查看转换报告**
   ```bash
   # DDL转换报告
   cat docs/conversion_summary_report.md
   
   # MyBatis XML转换报告
   cat docs/mybatis_xml_conversion_report.md
   ```

3. **Review转换结果**
   ```bash
   # 对比原始和转换后的文件
   diff mysql/mysql/AssetInfoMapper.xml postgresql_xml/AssetInfoMapper.xml
   ```

4. **本地测试**
   ```bash
   # 启动PostgreSQL
   docker run -d --name pg16 -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:16
   
   # 导入DDL
   psql -U postgres -d postgres < output/batch_01_tables_001-020_postgresql.sql
   
   # 测试查询
   psql -U postgres -d postgres -c "SELECT * FROM t_asset_info LIMIT 10;"
   ```

---

## 🔗 相关资源

### 官方文档
- [PostgreSQL 16 Documentation](https://www.postgresql.org/docs/16/)
- [MyBatis Documentation](https://mybatis.org/mybatis-3/zh/index.html)
- [Spring Boot with PostgreSQL](https://spring.io/guides/gs/accessing-data-postgresql/)

### 迁移工具
- [pgloader](https://pgloader.io/) - MySQL到PostgreSQL数据迁移
- [DataX](https://github.com/alibaba/DataX) - 阿里开源的数据同步工具
- [ora2pg](https://ora2pg.darold.net/) - Oracle到PostgreSQL迁移工具（可参考）

### 性能优化
- [PgTune](https://pgtune.leopard.in.ua/) - PostgreSQL配置优化
- [explain.depesz.com](https://explain.depesz.com/) - EXPLAIN分析工具

---

## 👥 项目团队

- **数据库大师**: DDL和MyBatis XML转换、规范文档编写
- **DBA**: 数据库Schema设计、数据迁移、性能优化
- **开发团队**: MyBatis XML修正、应用测试、部署

---

## 📞 技术支持

遇到问题？请参考：

1. **文档**: 先查阅 `docs/` 目录下的相关文档
2. **示例**: 参考已转换的文件作为模板
3. **测试**: 在开发环境中验证转换结果
4. **社区**: PostgreSQL中文社区、Stack Overflow

---

## 📜 许可证

本项目为内部迁移项目，所有代码和文档仅供公司内部使用。

---

**项目创建时间**: 2026-01-14  
**最后更新时间**: 2026-01-19  
**文档版本**: 1.0  
**项目状态**: ✅ 转换完成，等待测试和部署
