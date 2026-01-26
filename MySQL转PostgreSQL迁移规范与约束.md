# MySQL 转 PostgreSQL 16.x 迁移规范与约束文档

> **版本**: 1.0  
> **目标数据库**: PostgreSQL 16.x  
> **源数据库**: MySQL 5.7.x  
> **最后更新**: 2026-01-14

---

## 📋 目录

1. [数据类型映射规范](#1-数据类型映射规范)
2. [字符集与排序规则](#2-字符集与排序规则)
3. [表结构转换规范](#3-表结构转换规范)
4. [索引转换规范](#4-索引转换规范)
5. [约束转换规范](#5-约束转换规范)
6. [自增主键转换](#6-自增主键转换)
7. [SQL语法差异](#7-sql语法差异)
8. [函数和操作符差异](#8-函数和操作符差异)
9. [存储过程和触发器](#9-存储过程和触发器)
10. [事务与并发控制](#10-事务与并发控制)
11. [性能优化建议](#11-性能优化建议)
12. [迁移步骤与检查清单](#12-迁移步骤与检查清单)
13. [常见问题与解决方案](#13-常见问题与解决方案)

---

## 1. 数据类型映射规范

### 1.1 数值类型

| MySQL 类型 | PostgreSQL 类型 | 说明 | 注意事项 |
|-----------|----------------|------|---------|
| `TINYINT` | `SMALLINT` | 1字节 → 2字节 | PG没有1字节整数 |
| `TINYINT(1)` | `BOOLEAN` | MySQL中常用作布尔 | 0/1 映射为 false/true |
| `SMALLINT` | `SMALLINT` | 2字节整数 | 范围一致 |
| `MEDIUMINT` | `INTEGER` | 3字节 → 4字节 | PG没有3字节整数 |
| `INT/INTEGER` | `INTEGER` | 4字节整数 | 范围一致 |
| `BIGINT` | `BIGINT` | 8字节整数 | 范围一致 |
| `FLOAT` | `REAL` | 单精度浮点 | 精度可能有差异 |
| `DOUBLE` | `DOUBLE PRECISION` | 双精度浮点 | 精度可能有差异 |
| `DECIMAL(M,D)` | `NUMERIC(M,D)` | 定点数 | 推荐使用，精度一致 |

**约束规则**:
- ✅ 所有整数类型必须去除显示宽度，如 `INT(11)` → `INTEGER`
- ✅ `UNSIGNED` 属性需要添加 `CHECK` 约束：`CHECK (column_name >= 0)`
- ✅ 布尔类型统一使用 `BOOLEAN`，不使用 `SMALLINT` 模拟
- ⚠️ `BIGINT(20)` 中的20仅是显示宽度，迁移时去除

### 1.2 字符串类型

| MySQL 类型 | PostgreSQL 类型 | 说明 | 注意事项 |
|-----------|----------------|------|---------|
| `CHAR(N)` | `CHAR(N)` | 定长字符 | PG会自动补空格 |
| `VARCHAR(N)` | `VARCHAR(N)` | 变长字符 | 建议统一使用 |
| `TINYTEXT` | `TEXT` | 小文本 | PG的TEXT无长度限制 |
| `TEXT` | `TEXT` | 文本 | 性能相同 |
| `MEDIUMTEXT` | `TEXT` | 中文本 | 统一为TEXT |
| `LONGTEXT` | `TEXT` | 大文本 | 统一为TEXT |
| `BINARY(N)` | `BYTEA` | 二进制 | 存储方式不同 |
| `VARBINARY(N)` | `BYTEA` | 变长二进制 | 存储方式不同 |
| `BLOB` | `BYTEA` | 二进制大对象 | 所有BLOB类型统一 |
| `ENUM('a','b')` | `VARCHAR(N)` + `CHECK` | 枚举类型 | 或使用PG原生ENUM |
| `SET` | `TEXT[]` | 集合 | 使用数组类型 |

**约束规则**:
- ✅ **推荐**: `VARCHAR(N)` 优于 `CHAR(N)`，除非确实需要定长
- ✅ **推荐**: 小于4000字符的用 `VARCHAR(N)`，超过的用 `TEXT`
- ✅ `TEXT` 类型在PostgreSQL中性能优秀，无需担心
- ⚠️ **中文字符处理**: 
  - PostgreSQL: `CHAR(N)` 和 `VARCHAR(N)` 中的 N 表示**字符数**
  - 如需兼容openGauss: N需要**乘以4**（openGauss中N表示字节数）
  - 示例: MySQL `VARCHAR(100)` 存中文 → PG `VARCHAR(100)` 或 openGauss兼容 `VARCHAR(400)`
- ⚠️ `ENUM` 迁移选择:
  - **方案A**: `VARCHAR(50) CHECK (col IN ('value1', 'value2'))`
  - **方案B**: 创建自定义ENUM类型（推荐用于固定值）
  ```sql
  CREATE TYPE status_type AS ENUM ('active', 'inactive', 'pending');
  ```
- ⚠️ 字符集需统一为 `UTF8`

### 1.3 日期时间类型

| MySQL 类型 | PostgreSQL 类型 | 说明 | 注意事项 |
|-----------|----------------|------|---------|
| `DATE` | `DATE` | 日期 | 一致 |
| `TIME` | `TIME` | 时间 | 一致 |
| `DATETIME` | `TIMESTAMP` | 日期时间（无时区） | 常用 |
| `TIMESTAMP` | `TIMESTAMPTZ` | 时间戳（带时区） | **重要差异** |
| `YEAR` | `SMALLINT` | 年份 | PG无此类型 |

**约束规则**:
- ✅ **关键差异**: MySQL的 `TIMESTAMP` → PostgreSQL的 `TIMESTAMPTZ`（带时区）
- ✅ MySQL的 `DATETIME` → PostgreSQL的 `TIMESTAMP`（不带时区）
- ⚠️ **时区处理**:
  - 建议统一使用 `TIMESTAMPTZ`
  - 应用层统一使用UTC时间
  - 迁移时需要处理时区转换
- ⚠️ **默认值处理**:
  - MySQL: `DEFAULT CURRENT_TIMESTAMP` 
  - PostgreSQL: `DEFAULT CURRENT_TIMESTAMP` 或 `DEFAULT NOW()`
  - MySQL: `ON UPDATE CURRENT_TIMESTAMP` → PG需要触发器实现

### 1.4 JSON类型

| MySQL 类型 | PostgreSQL 类型 | 说明 | 注意事项 |
|-----------|----------------|------|---------|
| `JSON` | `JSONB` | JSON数据 | **推荐JSONB** |
| - | `JSON` | 文本JSON | 仅保留原始格式时用 |

**约束规则**:
- ✅ **强烈推荐**: 使用 `JSONB` 而不是 `JSON`
- ✅ JSONB 优势: 支持索引、查询快、自动去重键
- ✅ JSON 优势: 保留原始格式、插入稍快
- ⚠️ 90%场景应该用 `JSONB`

### 1.5 特殊类型

| MySQL 类型 | PostgreSQL 类型 | 说明 |
|-----------|----------------|------|
| `BIT(N)` | `BIT(N)` 或 `BOOLEAN` | 位字段 |
| `GEOMETRY` | `GEOMETRY` (需PostGIS扩展) | 空间数据 |
| `POINT` | `POINT` (需PostGIS扩展) | 点数据 |

---

## 2. 字符集与排序规则

### 2.1 字符集映射

**MySQL**:
```sql
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
CHARACTER SET utf8 COLLATE utf8_general_ci
```

**PostgreSQL**:
```sql
-- 数据库级别
CREATE DATABASE dbname ENCODING 'UTF8' LC_COLLATE='zh_CN.UTF-8' LC_CTYPE='zh_CN.UTF-8';

-- 列级别（较少使用）
column_name TEXT COLLATE "zh_CN"
```

### 2.2 约束规则

- ✅ **必须**: 数据库编码统一为 `UTF8`
- ✅ **推荐**: 排序规则根据业务需求选择:
  - 中文: `zh_CN.UTF-8`
  - 英文不区分大小写: `en_US.utf8` (需要ICU支持)
  - 区分大小写: `C` 或 `POSIX`
- ⚠️ MySQL的 `utf8` = PostgreSQL的 `UTF8` (3字节)
- ⚠️ MySQL的 `utf8mb4` = PostgreSQL的 `UTF8` (完整Unicode)
- ⚠️ **重要**: PostgreSQL 16支持 ICU 排序规则（推荐）
  ```sql
  CREATE DATABASE mydb 
    ENCODING 'UTF8' 
    LOCALE_PROVIDER = icu 
    ICU_LOCALE = 'zh-CN';
  ```

---

## 3. 表结构转换规范

### 3.1 基本语法对比

**MySQL**:
```sql
CREATE TABLE `ailpha_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uid',
  `type` varchar(100) NOT NULL COMMENT '模型类型',
  `severity` varchar(20) NOT NULL DEFAULT 'low' COMMENT '告警级别',
  `toAlarm` tinyint(3) NOT NULL COMMENT '是否输出',
  `createTime` bigint(32) NULL DEFAULT NULL,
  `updateTime` bigint(32) NULL DEFAULT NULL,
  `isQuoted` smallint(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `modelName`(`modelName`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARACTER SET=utf8 COLLATE=utf8_bin ROW_FORMAT=Dynamic;
```

**PostgreSQL**:
```sql
CREATE TABLE ailpha_model (
  id SERIAL PRIMARY KEY,
  uuid VARCHAR(100) NOT NULL,
  type VARCHAR(100) NOT NULL,
  severity VARCHAR(20) NOT NULL DEFAULT 'low',
  to_alarm SMALLINT NOT NULL,
  create_time BIGINT NULL DEFAULT NULL,
  update_time BIGINT NULL DEFAULT NULL,
  is_quoted SMALLINT NULL DEFAULT NULL
);

-- 单独创建索引
CREATE UNIQUE INDEX idx_model_name ON ailpha_model(model_name);

-- 添加注释
COMMENT ON TABLE ailpha_model IS '模型表';
COMMENT ON COLUMN ailpha_model.uuid IS 'uid';
COMMENT ON COLUMN ailpha_model.type IS '模型类型';
COMMENT ON COLUMN ailpha_model.severity IS '告警级别';
COMMENT ON COLUMN ailpha_model.to_alarm IS '是否输出';
```

### 3.2 表结构约束规则

#### 3.2.1 命名规范

- ✅ **必须**: 去除反引号 `` ` ``
- ✅ **必须**: 数据库名不能使用中划线 `-`
  - MySQL: `bigdata-web` → PostgreSQL: `bigdata_web`
  - 原因: openGauss不支持中划线命名
- ✅ **推荐**: 表名、字段名使用小写+下划线（snake_case）
  - MySQL: `modelName` → PostgreSQL: `model_name`
  - MySQL: `createTime` → PostgreSQL: `create_time`
  - **强烈建议**: 将所有驼峰命名改为下划线命名，避免引号问题
- ✅ **推荐**: 避免使用PostgreSQL保留字（user, table, index, action等）
  - 如必须使用，需加双引号: `"user"`, `"action"`
  - 但查询时也必须加引号，极不方便
- ⚠️ **大小写敏感性差异**:
  - MySQL: 不区分大小写（Windows/Mac），Linux可能区分
  - PostgreSQL: 
    - 不加引号: 自动转为小写 `UserName` → `username`
    - 加引号: 保持原样 `"UserName"` → `UserName`
    - 查询时必须匹配: `SELECT * FROM "UserName"` (不能写成 `username`)
  
  ```sql
  -- 错误示例
  CREATE TABLE UserInfo (UserId INT);  -- 实际创建为 userinfo, userid
  SELECT * FROM UserInfo;              -- 正常工作
  
  CREATE TABLE "UserInfo" ("UserId" INT);  -- 创建为 UserInfo, UserId
  SELECT * FROM UserInfo;              -- 错误! 找不到表
  SELECT * FROM "UserInfo";            -- 正确
  ```

#### 3.2.2 表选项处理

| MySQL 选项 | PostgreSQL 处理 | 说明 |
|-----------|----------------|------|
| `ENGINE=InnoDB` | 删除 | PG只有一个存储引擎 |
| `AUTO_INCREMENT=1` | 使用 `SERIAL` | 见自增主键章节 |
| `CHARACTER SET` | 数据库级设置 | 不在表级指定 |
| `COLLATE` | 数据库级设置 | 不在表级指定 |
| `ROW_FORMAT` | 删除 | PG自动管理 |
| `COMMENT='表注释'` | `COMMENT ON TABLE` | 单独语句 |

#### 3.2.3 列选项处理

| MySQL 选项 | PostgreSQL 处理 | 说明 |
|-----------|----------------|------|
| `COMMENT '注释'` | `COMMENT ON COLUMN` | 单独语句 |
| `COLLATE utf8_bin` | 删除或列级指定 | 少用 |
| `CHARACTER SET` | 删除 | 使用数据库默认 |
| `UNSIGNED` | `CHECK (col >= 0)` | 添加检查约束 |
| `ZEROFILL` | 应用层处理 | PG不支持 |

---

## 4. 索引转换规范

### 4.1 索引类型映射

| MySQL 索引 | PostgreSQL 索引 | 说明 |
|-----------|----------------|------|
| `PRIMARY KEY` | `PRIMARY KEY` | 一致 |
| `UNIQUE INDEX` | `UNIQUE INDEX` | 一致 |
| `INDEX / KEY` | `INDEX` | 一致 |
| `FULLTEXT INDEX` | `GIN INDEX` | 需要分词器 |
| `SPATIAL INDEX` | `GIST INDEX` | 需PostGIS |
| `USING BTREE` | `USING BTREE` | 默认，可省略 |
| `USING HASH` | `USING HASH` | 少用 |

### 4.2 索引创建规范

**MySQL**:
```sql
-- 在CREATE TABLE中
PRIMARY KEY (`id`) USING BTREE,
UNIQUE INDEX `modelName`(`modelName`) USING BTREE,
INDEX `idx_create_time` (`createTime`),
FULLTEXT INDEX `ft_content` (`content`)
```

**PostgreSQL**:
```sql
-- 主键在CREATE TABLE中
PRIMARY KEY (id),

-- 其他索引单独创建
CREATE UNIQUE INDEX idx_model_name ON ailpha_model(model_name);
CREATE INDEX idx_create_time ON ailpha_model(create_time);

-- 全文索引
CREATE INDEX idx_content_gin ON ailpha_model USING GIN(to_tsvector('chinese', content));

-- 部分索引（条件索引）
CREATE INDEX idx_enabled ON ailpha_model(state) WHERE state = 1;
```

### 4.3 索引约束规则

- ✅ **推荐**: 主键在 `CREATE TABLE` 中定义
- ✅ **推荐**: 其他索引用独立的 `CREATE INDEX` 语句
- ✅ **推荐**: 索引命名规范:
  - 普通索引: `idx_tablename_columnname`
  - 唯一索引: `uk_tablename_columnname`
  - 主键: `pk_tablename`
- ✅ **推荐**: 去除 `USING BTREE`（默认即是）
- ⚠️ **NULL值排序差异** (重要):
  - **MySQL**: 索引中NULL值默认排在最前面（升序时）
  - **PostgreSQL**: 可以显式指定NULL值位置
  ```sql
  -- MySQL (默认行为)
  CREATE INDEX idx_name ON table (column);  -- NULL在前
  
  -- PostgreSQL (推荐显式指定)
  CREATE INDEX idx_name ON table (column ASC NULLS FIRST);   -- NULL在前
  CREATE INDEX idx_name ON table (column ASC NULLS LAST);    -- NULL在后
  CREATE INDEX idx_name ON table (column DESC NULLS FIRST);  -- NULL在前
  CREATE INDEX idx_name ON table (column DESC NULLS LAST);   -- NULL在后
  
  -- 默认行为
  -- ASC: NULLS LAST (与MySQL相反!)
  -- DESC: NULLS FIRST
  ```
- ⚠️ **迁移建议**: 显式指定 `NULLS FIRST` 或 `NULLS LAST` 以匹配业务逻辑
- ⚠️ 全文索引需要重写:
  ```sql
  -- 创建GIN索引
  CREATE INDEX idx_ft_content ON table_name 
  USING GIN(to_tsvector('chinese', content));
  
  -- 查询方式
  SELECT * FROM table_name 
  WHERE to_tsvector('chinese', content) @@ to_tsquery('chinese', '搜索词');
  ```
- ⚠️ **PostgreSQL 16 新特性**: 支持更多索引类型
  - BRIN索引: 适合大表时间序列
  - SP-GiST索引: 适合非平衡数据结构

---

## 5. 约束转换规范

### 5.1 约束类型对比

| 约束类型 | MySQL | PostgreSQL | 差异 |
|---------|-------|-----------|------|
| 主键 | `PRIMARY KEY` | `PRIMARY KEY` | 一致 |
| 唯一 | `UNIQUE` | `UNIQUE` | 一致 |
| 非空 | `NOT NULL` | `NOT NULL` | 一致 |
| 默认值 | `DEFAULT` | `DEFAULT` | 语法略有差异 |
| 外键 | `FOREIGN KEY` | `FOREIGN KEY` | PG检查更严格 |
| 检查 | `CHECK` | `CHECK` | PG功能更强 |

### 5.2 外键约束

**MySQL**:
```sql
CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) 
  REFERENCES `user` (`id`) 
  ON DELETE CASCADE 
  ON UPDATE CASCADE
```

**PostgreSQL**:
```sql
CONSTRAINT fk_user_id FOREIGN KEY (user_id) 
  REFERENCES user_table (id) 
  ON DELETE CASCADE 
  ON UPDATE CASCADE
```

### 5.3 检查约束

**场景1: UNSIGNED替代**:
```sql
-- MySQL
`age` INT UNSIGNED NOT NULL

-- PostgreSQL
age INTEGER NOT NULL CHECK (age >= 0)
```

**场景2: ENUM替代**:
```sql
-- MySQL
`status` ENUM('active', 'inactive', 'pending')

-- PostgreSQL 方案A
status VARCHAR(20) CHECK (status IN ('active', 'inactive', 'pending'))

-- PostgreSQL 方案B (推荐)
CREATE TYPE status_enum AS ENUM ('active', 'inactive', 'pending');
status status_enum NOT NULL DEFAULT 'active'
```

### 5.4 约束规则

- ✅ **必须**: 外键约束必须包含 `ON DELETE` 和 `ON UPDATE` 行为
- ✅ **推荐**: 约束命名规范:
  - 主键: `pk_tablename`
  - 外键: `fk_tablename_refcolumn`
  - 唯一: `uk_tablename_columnname`
  - 检查: `ck_tablename_columnname`
- ✅ **推荐**: 使用 `CHECK` 约束替代 `UNSIGNED`
- ⚠️ PostgreSQL的外键检查比MySQL严格，迁移前需确保数据完整性
- ⚠️ 大表添加外键约束会锁表，建议使用 `NOT VALID` 选项:
  ```sql
  ALTER TABLE table_name 
  ADD CONSTRAINT fk_name 
  FOREIGN KEY (col) REFERENCES ref_table(col) 
  NOT VALID;
  
  -- 后续验证
  ALTER TABLE table_name VALIDATE CONSTRAINT fk_name;
  ```

---

## 6. 自增主键转换

### 6.1 转换方案

**MySQL**:
```sql
`id` INT(11) NOT NULL AUTO_INCREMENT,
PRIMARY KEY (`id`)
```

**PostgreSQL 方案对比**:

#### 方案A: SERIAL (传统方式)
```sql
id SERIAL PRIMARY KEY
-- 等价于
id INTEGER NOT NULL DEFAULT nextval('tablename_id_seq'),
PRIMARY KEY (id)
```

#### 方案B: IDENTITY (推荐 - SQL标准)
```sql
id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
-- 或允许手动插入
id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY
```

#### 方案C: 显式序列
```sql
CREATE SEQUENCE tablename_id_seq;
id INTEGER NOT NULL DEFAULT nextval('tablename_id_seq') PRIMARY KEY
```

### 6.2 约束规则

- ✅ **推荐**: PostgreSQL 10+ 使用 `IDENTITY`（SQL标准）
  ```sql
  id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY
  ```
- ✅ **可选**: 使用 `SERIAL` (简洁，广泛支持)
- ⚠️ `GENERATED ALWAYS` vs `GENERATED BY DEFAULT`:
  - `ALWAYS`: 禁止手动插入ID
  - `BY DEFAULT`: 允许手动插入ID（推荐）
- ⚠️ 迁移数据后需要重置序列:
  ```sql
  -- 重置序列到当前最大值
  SELECT setval('tablename_id_seq', (SELECT MAX(id) FROM tablename));
  ```

### 6.3 迁移示例

```sql
-- MySQL表
CREATE TABLE test (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

-- PostgreSQL转换
CREATE TABLE test (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  name VARCHAR(100)
);

-- 数据迁移后
SELECT setval(pg_get_serial_sequence('test', 'id'), 
              (SELECT MAX(id) FROM test));
```

---

## 7. SQL语法差异

### 7.1 反引号与引号

| 用途 | MySQL | PostgreSQL |
|-----|-------|-----------|
| 标识符引用 | `` `column` `` | `"column"` |
| 字符串 | `'string'` 或 `"string"` | `'string'` 只能单引号 |

**约束规则**:
- ✅ **必须**: 字符串只能用单引号 `'string'`
- ✅ **必须**: 标识符引用用双引号 `"Column"` (需要时)
- ✅ **推荐**: 尽量不引用标识符，使用小写命名避免冲突

### 7.2 LIMIT 语法

**MySQL**:
```sql
SELECT * FROM table LIMIT 10;
SELECT * FROM table LIMIT 10, 20;  -- 跳过10条，取20条
```

**PostgreSQL**:
```sql
SELECT * FROM table LIMIT 10;
SELECT * FROM table LIMIT 20 OFFSET 10;  -- SQL标准
```

### 7.3 日期时间函数

| 功能 | MySQL | PostgreSQL |
|-----|-------|-----------|
| 当前时间 | `NOW()` | `NOW()` 或 `CURRENT_TIMESTAMP` |
| 当前日期 | `CURDATE()` | `CURRENT_DATE` |
| 当前时间 | `CURTIME()` | `CURRENT_TIME` |
| 日期格式化 | `DATE_FORMAT(date, '%Y-%m-%d')` | `TO_CHAR(date, 'YYYY-MM-DD')` |
| 字符串转日期 | `STR_TO_DATE('2024-01-01', '%Y-%m-%d')` | `TO_DATE('2024-01-01', 'YYYY-MM-DD')` |
| 日期加减 | `DATE_ADD(date, INTERVAL 1 DAY)` | `date + INTERVAL '1 day'` |
| Unix时间戳 | `UNIX_TIMESTAMP()` | `EXTRACT(EPOCH FROM NOW())::INTEGER` |
| 从时间戳 | `FROM_UNIXTIME(ts)` | `TO_TIMESTAMP(ts)` |

### 7.4 字符串函数

| 功能 | MySQL | PostgreSQL |
|-----|-------|-----------|
| 拼接 | `CONCAT(a, b)` | `CONCAT(a, b)` 或 `a \|\| b` |
| 长度 | `LENGTH(str)` | `LENGTH(str)` 或 `CHAR_LENGTH(str)` |
| 截取 | `SUBSTRING(str, pos, len)` | `SUBSTRING(str FROM pos FOR len)` |
| 替换 | `REPLACE(str, from, to)` | `REPLACE(str, from, to)` |
| 转大写 | `UPPER(str)` | `UPPER(str)` |
| 转小写 | `LOWER(str)` | `LOWER(str)` |
| 去空格 | `TRIM(str)` | `TRIM(str)` |
| 查找 | `LOCATE(substr, str)` | `POSITION(substr IN str)` |
| 分组拼接 | `GROUP_CONCAT(col)` | `STRING_AGG(col, ',')` |

### 7.5 条件函数

| 功能 | MySQL | PostgreSQL |
|-----|-------|-----------|
| IF条件 | `IF(condition, true_val, false_val)` | `CASE WHEN condition THEN true_val ELSE false_val END` |
| 空值处理 | `IFNULL(col, default)` | `COALESCE(col, default)` |
| 空值处理 | `ISNULL(col)` | `col IS NULL` |
| 非空取值 | `NULLIF(a, b)` | `NULLIF(a, b)` |

### 7.6 数学函数

| 功能 | MySQL | PostgreSQL |
|-----|-------|-----------|
| 取整 | `FLOOR(n)` | `FLOOR(n)` |
| 进位 | `CEIL(n)` | `CEIL(n)` 或 `CEILING(n)` |
| 四舍五入 | `ROUND(n, d)` | `ROUND(n, d)` |
| 随机数 | `RAND()` | `RANDOM()` |
| 绝对值 | `ABS(n)` | `ABS(n)` |
| 幂运算 | `POW(x, y)` | `POWER(x, y)` |

### 7.7 类型转换

**MySQL**:
```sql
CAST(value AS type)
CONVERT(value, type)
```

**PostgreSQL**:
```sql
CAST(value AS type)
value::type  -- PostgreSQL特有
```

**示例**:
```sql
-- MySQL
SELECT CAST('123' AS SIGNED);
SELECT CONVERT('2024-01-01', DATE);

-- PostgreSQL
SELECT CAST('123' AS INTEGER);
SELECT '123'::INTEGER;
SELECT '2024-01-01'::DATE;
SELECT TO_DATE('2024-01-01', 'YYYY-MM-DD');
```

### 7.8 INSERT语法

**MySQL特有语法需要改写**:

```sql
-- MySQL: INSERT IGNORE
INSERT IGNORE INTO table (col) VALUES ('value');

-- PostgreSQL: ON CONFLICT DO NOTHING
INSERT INTO table (col) VALUES ('value')
ON CONFLICT (unique_col) DO NOTHING;

-- MySQL: REPLACE INTO
REPLACE INTO table (id, col) VALUES (1, 'value');

-- PostgreSQL: ON CONFLICT DO UPDATE
INSERT INTO table (id, col) VALUES (1, 'value')
ON CONFLICT (id) DO UPDATE SET col = EXCLUDED.col;

-- MySQL: INSERT ... ON DUPLICATE KEY UPDATE
INSERT INTO table (id, col) VALUES (1, 'value')
ON DUPLICATE KEY UPDATE col = 'new_value';

-- PostgreSQL
INSERT INTO table (id, col) VALUES (1, 'value')
ON CONFLICT (id) DO UPDATE SET col = 'new_value';
```

### 7.9 UPDATE JOIN

**MySQL**:
```sql
UPDATE table1 t1
INNER JOIN table2 t2 ON t1.id = t2.id
SET t1.col = t2.col
WHERE t2.status = 1;
```

**PostgreSQL**:
```sql
UPDATE table1 t1
SET col = t2.col
FROM table2 t2
WHERE t1.id = t2.id AND t2.status = 1;
```

### 7.10 DELETE JOIN

**MySQL**:
```sql
DELETE t1 FROM table1 t1
INNER JOIN table2 t2 ON t1.id = t2.id
WHERE t2.status = 1;
```

**PostgreSQL**:
```sql
DELETE FROM table1 t1
USING table2 t2
WHERE t1.id = t2.id AND t2.status = 1;
```

### 7.11 GROUP BY 和 ORDER BY 严格性 (重要)

PostgreSQL对GROUP BY和ORDER BY的要求比MySQL严格得多。

#### GROUP BY 规则

**MySQL (宽松)**:
```sql
-- MySQL允许SELECT非聚合列不在GROUP BY中（非标准SQL）
SELECT user_id, user_name, COUNT(*) 
FROM orders 
GROUP BY user_id;  -- user_name不在GROUP BY中，MySQL允许
```

**PostgreSQL (严格)**:
```sql
-- 错误: user_name必须在GROUP BY中或使用聚合函数
SELECT user_id, user_name, COUNT(*) 
FROM orders 
GROUP BY user_id;  -- 报错!

-- 正确方式1: 添加到GROUP BY
SELECT user_id, user_name, COUNT(*) 
FROM orders 
GROUP BY user_id, user_name;

-- 正确方式2: 使用聚合函数
SELECT user_id, MAX(user_name) as user_name, COUNT(*) 
FROM orders 
GROUP BY user_id;

-- 正确方式3: 使用DISTINCT ON (PostgreSQL特有)
SELECT DISTINCT ON (user_id) user_id, user_name, order_count
FROM (
  SELECT user_id, user_name, COUNT(*) as order_count
  FROM orders 
  GROUP BY user_id, user_name
) t;
```

#### ORDER BY 规则

**MySQL (宽松)**:
```sql
-- MySQL允许ORDER BY的列不在SELECT中
SELECT user_id, user_name 
FROM orders 
ORDER BY created_at;  -- created_at不在SELECT中，MySQL允许
```

**PostgreSQL (严格)**:
```sql
-- 在使用DISTINCT或GROUP BY时，ORDER BY的列必须在SELECT中

-- 错误示例
SELECT DISTINCT user_id, user_name 
FROM orders 
ORDER BY created_at;  -- 报错!

-- 正确方式1: 添加到SELECT
SELECT DISTINCT user_id, user_name, created_at
FROM orders 
ORDER BY created_at;

-- 正确方式2: 如果不需要DISTINCT
SELECT user_id, user_name 
FROM orders 
ORDER BY created_at;  -- 没有DISTINCT时可以

-- 正确方式3: 使用子查询
SELECT user_id, user_name FROM (
  SELECT user_id, user_name, created_at
  FROM orders 
  ORDER BY created_at
) t;
```

**约束规则**:
- ✅ **必须**: GROUP BY中，SELECT的所有非聚合列都必须在GROUP BY中
- ✅ **必须**: 使用DISTINCT时，ORDER BY的列必须在SELECT中
- ✅ **推荐**: 养成标准SQL习惯，即使在MySQL中也遵守这些规则
- ⚠️ 迁移时需仔细检查所有GROUP BY和DISTINCT查询

### 7.12 Schema 处理 (重要)

PostgreSQL有schema（模式）概念，类似命名空间。

**基本概念**:
```sql
-- 完整表名格式: schema_name.table_name
SELECT * FROM public.users;
SELECT * FROM test.users;
```

**约束规则**:
- ✅ **默认行为**: 未指定schema时，PostgreSQL默认使用 `public` schema
- ✅ **必须**: 如使用非public schema，必须显式指定
  ```sql
  -- 查询
  SELECT * FROM test.t_asset_information;
  
  -- 实体类 (Java示例)
  @TableName(value = "test.t_asset_information")
  // 或
  @TableName(value = "t_asset_information", schema = "test")
  ```
- ✅ **推荐**: 生产环境统一使用 `public` schema（简化管理）
- ⚠️ 搜索路径配置:
  ```sql
  -- 查看当前搜索路径
  SHOW search_path;
  
  -- 设置搜索路径（会话级）
  SET search_path TO test, public;
  
  -- 设置默认搜索路径（数据库级）
  ALTER DATABASE dbname SET search_path TO test, public;
  
  -- 设置用户默认搜索路径
  ALTER USER username SET search_path TO test, public;
  ```
- ⚠️ 跨schema查询需要权限:
  ```sql
  GRANT USAGE ON SCHEMA test TO username;
  GRANT SELECT ON ALL TABLES IN SCHEMA test TO username;
  ```

---

## 8. 函数和操作符差异

### 8.1 正则表达式

| 功能 | MySQL | PostgreSQL |
|-----|-------|-----------|
| 正则匹配 | `REGEXP` 或 `RLIKE` | `~` |
| 正则不匹配 | `NOT REGEXP` | `!~` |
| 不区分大小写 | - | `~*` |
| 不匹配不区分 | - | `!~*` |

**示例**:
```sql
-- MySQL
SELECT * FROM users WHERE email REGEXP '^[a-z]+@example.com$';

-- PostgreSQL
SELECT * FROM users WHERE email ~ '^[a-z]+@example.com$';
SELECT * FROM users WHERE email ~* '^[a-z]+@example.com$'; -- 不区分大小写
```

### 8.2 LIKE 操作

**MySQL**:
```sql
-- 不区分大小写 (默认)
SELECT * FROM users WHERE name LIKE '%john%';

-- 区分大小写
SELECT * FROM users WHERE name LIKE BINARY '%John%';
```

**PostgreSQL**:
```sql
-- 区分大小写 (默认)
SELECT * FROM users WHERE name LIKE '%John%';

-- 不区分大小写
SELECT * FROM users WHERE name ILIKE '%john%';
```

### 8.3 JSON操作

**MySQL 5.7+**:
```sql
-- 提取JSON值
SELECT JSON_EXTRACT(data, '$.name') FROM table;
SELECT data->>'$.name' FROM table;

-- JSON数组
SELECT JSON_CONTAINS(tags, '"mysql"') FROM table;
```

**PostgreSQL**:
```sql
-- 提取JSON值（返回JSON类型）
SELECT data->'name' FROM table;

-- 提取JSON值（返回文本）
SELECT data->>'name' FROM table;

-- 嵌套访问
SELECT data->'user'->'address'->>'city' FROM table;

-- 数组访问
SELECT data->'tags'->0 FROM table;

-- JSON数组包含
SELECT * FROM table WHERE data->'tags' ? 'postgresql';

-- JSONB查询操作符
SELECT * FROM table WHERE data @> '{"status": "active"}';
SELECT * FROM table WHERE data ? 'email';  -- 键存在
SELECT * FROM table WHERE data ?| ARRAY['email', 'phone'];  -- 任一键存在
SELECT * FROM table WHERE data ?& ARRAY['email', 'phone'];  -- 所有键存在
```

### 8.4 窗口函数

PostgreSQL的窗口函数功能更强大:

```sql
-- 行号
ROW_NUMBER() OVER (PARTITION BY col ORDER BY col2)

-- 排名
RANK() OVER (ORDER BY score DESC)
DENSE_RANK() OVER (ORDER BY score DESC)

-- 累计
SUM(amount) OVER (PARTITION BY user_id ORDER BY date)

-- 移动平均 (PostgreSQL特有)
AVG(value) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)

-- 首尾值
FIRST_VALUE(col) OVER (PARTITION BY group_id ORDER BY date)
LAST_VALUE(col) OVER (PARTITION BY group_id ORDER BY date)

-- LAG/LEAD
LAG(col, 1) OVER (ORDER BY date)  -- 上一行
LEAD(col, 1) OVER (ORDER BY date)  -- 下一行
```

### 8.5 常用MySQL函数的自定义实现

有些MySQL函数在PostgreSQL中没有直接对应，需要自定义实现。

#### 8.5.1 IFNULL 函数

**MySQL**:
```sql
SELECT IFNULL(column_name, '默认值') FROM table_name;
```

**PostgreSQL标准替代**:
```sql
-- 推荐: 使用COALESCE (SQL标准)
SELECT COALESCE(column_name, '默认值') FROM table_name;

-- 或使用CASE WHEN
SELECT CASE WHEN column_name IS NULL THEN '默认值' ELSE column_name END 
FROM table_name;
```

**自定义IFNULL函数** (可选):
```sql
-- 创建兼容MySQL的IFNULL函数
CREATE OR REPLACE FUNCTION IFNULL(anyelement, anyelement) 
RETURNS anyelement AS $$
  SELECT COALESCE($1, $2);
$$ LANGUAGE SQL IMMUTABLE;

-- 使用
SELECT IFNULL(column_name, '默认值') FROM table_name;
```

#### 8.5.2 IF 函数

**MySQL**:
```sql
SELECT IF(score >= 60, '及格', '不及格') FROM students;
UPDATE table SET status = IF(enabled, 1, 0);
```

**PostgreSQL标准替代**:
```sql
-- 推荐: 使用CASE WHEN (SQL标准)
SELECT CASE WHEN score >= 60 THEN '及格' ELSE '不及格' END FROM students;
```

**自定义IF函数** (可选):
```sql
-- 创建兼容MySQL的IF函数
CREATE OR REPLACE FUNCTION IF(condition boolean, true_result anyelement, false_result anyelement) 
RETURNS anyelement AS $$
BEGIN
  IF condition THEN
    RETURN true_result;
  ELSE
    RETURN false_result;
  END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 使用
SELECT IF(score >= 60, '及格', '不及格') FROM students;
UPDATE table_name SET status = IF(enabled, 1, 0);
```

#### 8.5.3 SUBSTRING_INDEX 函数

**MySQL**:
```sql
-- 获取最后一个逗号后的内容
SELECT SUBSTRING_INDEX('a,b,c', ',', -1);  -- 返回 'c'

-- 获取第二个逗号前的内容
SELECT SUBSTRING_INDEX('a,b,c', ',', 2);   -- 返回 'a,b'
```

**PostgreSQL标准替代**:
```sql
-- 方案A: 使用数组函数 (推荐)
-- 获取最后一个元素
SELECT (STRING_TO_ARRAY('a,b,c', ','))[ARRAY_LENGTH(STRING_TO_ARRAY('a,b,c', ','), 1)];

-- 获取前N个元素并拼接
SELECT ARRAY_TO_STRING((STRING_TO_ARRAY('a,b,c', ','))[1:2], ',');

-- 方案B: 使用split_part (固定位置)
SELECT SPLIT_PART('a,b,c', ',', 3);  -- 获取第3个元素 → 'c'
SELECT SPLIT_PART('a,b,c', ',', 1);  -- 获取第1个元素 → 'a'
```

**自定义SUBSTRING_INDEX函数** (完整兼容):
```sql
CREATE OR REPLACE FUNCTION SUBSTRING_INDEX(
  str TEXT,
  delim TEXT,
  count INTEGER
) RETURNS TEXT AS $$
DECLARE
  arr TEXT[];
  result TEXT;
BEGIN
  -- 分割字符串为数组
  arr := STRING_TO_ARRAY(str, delim);
  
  IF count > 0 THEN
    -- 正数: 从左边取count个
    result := ARRAY_TO_STRING(arr[1:count], delim);
  ELSIF count < 0 THEN
    -- 负数: 从右边取abs(count)个
    result := ARRAY_TO_STRING(
      arr[ARRAY_LENGTH(arr, 1) + count + 1 : ARRAY_LENGTH(arr, 1)], 
      delim
    );
  ELSE
    -- count=0: 返回空字符串
    result := '';
  END IF;
  
  RETURN result;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 使用示例
SELECT SUBSTRING_INDEX('www.mysql.com', '.', 2);   -- 返回 'www.mysql'
SELECT SUBSTRING_INDEX('www.mysql.com', '.', -2);  -- 返回 'mysql.com'
SELECT SUBSTRING_INDEX(visit_count, ',', -1)::INT4 FROM table_name;
```

#### 8.5.4 FIND_IN_SET 函数

**MySQL**:
```sql
SELECT * FROM table_name WHERE FIND_IN_SET('apple', fruit_list);
SELECT FIND_IN_SET('b', 'a,b,c,d');  -- 返回 2
```

**PostgreSQL标准替代**:
```sql
-- 方案A: 使用ANY和STRING_TO_ARRAY (推荐)
SELECT * FROM table_name 
WHERE 'apple' = ANY(STRING_TO_ARRAY(fruit_list, ','));

-- 方案B: 使用位置匹配
SELECT * FROM table_name 
WHERE ',' || fruit_list || ',' LIKE '%,apple,%';
```

**自定义FIND_IN_SET函数** (完整兼容):
```sql
-- 版本1: 返回位置（兼容MySQL）
CREATE OR REPLACE FUNCTION FIND_IN_SET(
  str TEXT,
  strlist TEXT
) RETURNS INTEGER AS $$
DECLARE
  arr TEXT[];
  i INTEGER;
BEGIN
  IF str IS NULL OR strlist IS NULL THEN
    RETURN NULL;
  END IF;
  
  arr := STRING_TO_ARRAY(strlist, ',');
  
  FOR i IN 1..ARRAY_LENGTH(arr, 1) LOOP
    IF arr[i] = str THEN
      RETURN i;
    END IF;
  END LOOP;
  
  RETURN 0;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 版本2: 返回布尔值（更实用）
CREATE OR REPLACE FUNCTION FIND_IN_SET_BOOL(
  str TEXT,
  strlist TEXT
) RETURNS BOOLEAN AS $$
BEGIN
  RETURN str = ANY(STRING_TO_ARRAY(strlist, ','));
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 使用示例
SELECT FIND_IN_SET('b', 'a,b,c,d');  -- 返回 2
SELECT * FROM t_asset_information 
WHERE FIND_IN_SET('AR网关', asset_label) > 0;

-- 或使用布尔版本（推荐）
SELECT * FROM t_asset_information 
WHERE FIND_IN_SET_BOOL('AR网关', asset_label);
```

#### 8.5.5 CURDATE 函数

**MySQL**:
```sql
SELECT CURDATE();  -- 返回 2024-01-15
```

**PostgreSQL**:
```sql
-- 直接使用 CURRENT_DATE (注意没有括号)
SELECT CURRENT_DATE;  -- 返回 2024-01-15

-- 如果习惯用函数形式，可以创建
CREATE OR REPLACE FUNCTION CURDATE() RETURNS DATE AS $$
  SELECT CURRENT_DATE;
$$ LANGUAGE SQL IMMUTABLE;

SELECT CURDATE();  -- 现在可以用了
```

#### 8.5.6 自定义函数使用建议

**约束规则**:
- ✅ **推荐**: 优先使用PostgreSQL原生函数和标准SQL
  - `COALESCE` 而不是 `IFNULL`
  - `CASE WHEN` 而不是 `IF`
  - `STRING_TO_ARRAY` + `ANY` 而不是 `FIND_IN_SET`
- ✅ **可选**: 为了减少代码改动量，可以创建兼容函数
  - 适用于有大量SQL需要迁移的场景
  - 函数统一创建在 `public` schema
- ✅ **必须**: 自定义函数添加 `IMMUTABLE` 标记（如果适用）
  - 提高性能，允许查询优化器优化
- ⚠️ **注意**: 自定义函数需要在所有数据库实例上部署
- ⚠️ **文档化**: 记录所有自定义函数，便于维护

---

## 9. 存储过程和触发器

### 9.1 存储过程

**MySQL**:
```sql
DELIMITER $$
CREATE PROCEDURE get_user(IN user_id INT)
BEGIN
  SELECT * FROM users WHERE id = user_id;
END$$
DELIMITER ;
```

**PostgreSQL**:
```sql
CREATE OR REPLACE FUNCTION get_user(user_id INTEGER)
RETURNS TABLE(id INTEGER, name VARCHAR, email VARCHAR) AS $$
BEGIN
  RETURN QUERY
  SELECT u.id, u.name, u.email FROM users u WHERE u.id = user_id;
END;
$$ LANGUAGE plpgsql;
```

### 9.2 触发器

**场景: 自动更新 update_time**

**MySQL**:
```sql
CREATE TRIGGER update_timestamp
BEFORE UPDATE ON table_name
FOR EACH ROW
SET NEW.update_time = CURRENT_TIMESTAMP;
```

**PostgreSQL**:
```sql
-- 创建触发器函数
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.update_time = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 创建触发器
CREATE TRIGGER trigger_update_timestamp
BEFORE UPDATE ON table_name
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
```

### 9.3 约束规则

- ✅ **必须**: PostgreSQL触发器需要先创建函数
- ✅ **推荐**: 触发器函数使用 `plpgsql` 语言
- ✅ **推荐**: 函数命名: `func_tablename_action`
- ✅ **推荐**: 触发器命名: `trigger_tablename_action`
- ⚠️ MySQL的 `ON UPDATE CURRENT_TIMESTAMP` 需要用触发器实现
- ⚠️ PostgreSQL 16+ 支持 `MERGE` 语句触发器

### 9.4 MySQL Events (定时任务) 处理 (重要)

**关键差异**: PostgreSQL没有类似MySQL Events的内置定时任务功能。

**MySQL Event 示例**:
```sql
-- MySQL定时任务
CREATE EVENT cleanup_old_logs
ON SCHEDULE EVERY 1 DAY
STARTS '2024-01-01 00:00:00'
DO
  DELETE FROM logs WHERE created_at < DATE_SUB(NOW(), INTERVAL 30 DAY);
```

**PostgreSQL 替代方案**:

#### 方案A: pg_cron 扩展 (推荐)

```sql
-- 1. 安装pg_cron扩展
CREATE EXTENSION pg_cron;

-- 2. 创建定时任务
SELECT cron.schedule(
  'cleanup-old-logs',           -- 任务名
  '0 0 * * *',                  -- cron表达式 (每天0点)
  $$DELETE FROM logs WHERE created_at < NOW() - INTERVAL '30 days'$$
);

-- 3. 查看定时任务
SELECT * FROM cron.job;

-- 4. 删除定时任务
SELECT cron.unschedule('cleanup-old-logs');

-- 5. 查看执行历史
SELECT * FROM cron.job_run_details ORDER BY start_time DESC LIMIT 10;
```

#### 方案B: 操作系统定时任务 (crontab)

```bash
# 编辑crontab
crontab -e

# 添加定时任务 (每天0点执行)
0 0 * * * psql -U postgres -d dbname -c "DELETE FROM logs WHERE created_at < NOW() - INTERVAL '30 days'"
```

#### 方案C: 应用层实现 (推荐用于复杂业务)

```java
// Spring Boot示例
@Scheduled(cron = "0 0 0 * * ?")  // 每天0点
public void cleanupOldLogs() {
    jdbcTemplate.execute(
        "DELETE FROM logs WHERE created_at < NOW() - INTERVAL '30 days'"
    );
}
```

**约束规则**:
- ✅ **推荐**: 优先使用应用层实现（Spring @Scheduled, Quartz等）
  - 优点: 便于监控、日志、错误处理
  - 优点: 易于迁移和测试
- ✅ **可选**: 使用pg_cron扩展（需要超级用户权限安装）
- ✅ **备选**: 使用操作系统crontab（简单场景）
- ⚠️ **注意**: pg_cron在RDS等托管数据库可能不可用
- ⚠️ **迁移清单**: 
  1. 列出所有MySQL Events: `SHOW EVENTS;`
  2. 记录每个Event的业务逻辑
  3. 选择合适的替代方案
  4. 测试定时任务执行

---

## 10. 事务与并发控制

### 10.1 事务隔离级别

| 隔离级别 | MySQL | PostgreSQL | 说明 |
|---------|-------|-----------|------|
| READ UNCOMMITTED | ✅ | ❌ | PG不支持 |
| READ COMMITTED | ✅ | ✅ (默认) | 推荐 |
| REPEATABLE READ | ✅ (默认) | ✅ | - |
| SERIALIZABLE | ✅ | ✅ | 最严格 |

**设置隔离级别**:
```sql
-- PostgreSQL
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- 或
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

### 10.2 锁机制

**MySQL**:
```sql
-- 显式锁表
LOCK TABLES users WRITE;
-- 操作
UNLOCK TABLES;

-- 行级锁
SELECT * FROM users WHERE id = 1 FOR UPDATE;
```

**PostgreSQL**:
```sql
-- 表级锁
LOCK TABLE users IN ACCESS EXCLUSIVE MODE;

-- 行级锁
SELECT * FROM users WHERE id = 1 FOR UPDATE;
SELECT * FROM users WHERE id = 1 FOR NO KEY UPDATE;  -- 允许其他外键引用
SELECT * FROM users WHERE id = 1 FOR SHARE;  -- 共享锁
```

### 10.3 死锁处理

**约束规则**:
- ✅ **推荐**: 使用 `READ COMMITTED` 隔离级别（PostgreSQL默认）
- ✅ **推荐**: 避免长事务
- ✅ **推荐**: 按固定顺序访问表，减少死锁
- ⚠️ PostgreSQL的 `REPEATABLE READ` 比MySQL更严格
- ⚠️ PostgreSQL没有 `READ UNCOMMITTED`，会自动使用 `READ COMMITTED`

---

## 11. 性能优化建议

### 11.1 配置优化

**关键参数**:
```ini
# postgresql.conf

# 内存配置
shared_buffers = 4GB                    # 系统内存的25%
effective_cache_size = 12GB             # 系统内存的50-75%
maintenance_work_mem = 1GB              # 维护操作内存
work_mem = 64MB                         # 每个查询操作内存

# WAL配置
wal_buffers = 16MB
max_wal_size = 4GB
min_wal_size = 1GB
checkpoint_completion_target = 0.9

# 查询规划
random_page_cost = 1.1                  # SSD设置为1.1
effective_io_concurrency = 200          # SSD并发

# 并发连接
max_connections = 200
```

### 11.2 索引优化

**最佳实践**:
```sql
-- 1. 为外键创建索引
CREATE INDEX idx_fk_user_id ON orders(user_id);

-- 2. 组合索引顺序：高选择性列在前
CREATE INDEX idx_status_created ON orders(status, created_at);

-- 3. 部分索引（条件索引）
CREATE INDEX idx_active_users ON users(created_at) WHERE status = 'active';

-- 4. 表达式索引
CREATE INDEX idx_lower_email ON users(LOWER(email));

-- 5. 覆盖索引（包含列）
CREATE INDEX idx_user_order ON orders(user_id) INCLUDE (amount, created_at);

-- 6. BRIN索引（时间序列大表）
CREATE INDEX idx_created_brin ON large_table USING BRIN(created_at);

-- 7. GIN索引（JSON/数组）
CREATE INDEX idx_tags_gin ON articles USING GIN(tags);

-- 8. 并发创建索引（不锁表）
CREATE INDEX CONCURRENTLY idx_name ON table(column);
```

### 11.3 查询优化

**1. 使用EXPLAIN ANALYZE**:
```sql
EXPLAIN (ANALYZE, BUFFERS, VERBOSE) 
SELECT * FROM users WHERE email = 'test@example.com';
```

**2. 避免SELECT ***:
```sql
-- 不推荐
SELECT * FROM large_table WHERE id = 1;

-- 推荐
SELECT id, name, email FROM large_table WHERE id = 1;
```

**3. 使用EXISTS代替IN**:
```sql
-- 大表时性能更好
SELECT * FROM users u 
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);
```

**4. 批量操作**:
```sql
-- 批量插入
INSERT INTO table (col1, col2) VALUES 
  ('a', 1),
  ('b', 2),
  ('c', 3);

-- 使用COPY（更快）
COPY table (col1, col2) FROM '/path/to/file.csv' CSV;
```

### 11.4 维护优化

**定期维护**:
```sql
-- 1. 更新统计信息
ANALYZE table_name;
ANALYZE;  -- 所有表

-- 2. 清理死元组
VACUUM table_name;
VACUUM FULL table_name;  -- 完全清理（锁表）

-- 3. 重建索引
REINDEX INDEX idx_name;
REINDEX TABLE table_name;
REINDEX DATABASE dbname;  -- 维护窗口执行

-- 4. 检查膨胀
SELECT schemaname, tablename, 
       pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

**自动清理配置**:
```ini
# postgresql.conf
autovacuum = on
autovacuum_max_workers = 3
autovacuum_naptime = 1min
autovacuum_vacuum_threshold = 50
autovacuum_analyze_threshold = 50
```

### 11.5 分区表

**PostgreSQL 16 分区特性**:
```sql
-- 范围分区（按日期）
CREATE TABLE orders (
  id BIGINT,
  user_id INTEGER,
  amount NUMERIC,
  created_at TIMESTAMP
) PARTITION BY RANGE (created_at);

-- 创建分区
CREATE TABLE orders_2024_01 PARTITION OF orders
FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE orders_2024_02 PARTITION OF orders
FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

-- 列表分区（按区域）
CREATE TABLE users (
  id BIGINT,
  region VARCHAR(50),
  name VARCHAR(100)
) PARTITION BY LIST (region);

CREATE TABLE users_cn PARTITION OF users FOR VALUES IN ('CN', 'HK', 'TW');
CREATE TABLE users_us PARTITION OF users FOR VALUES IN ('US', 'CA');

-- 哈希分区（均匀分布）
CREATE TABLE logs (
  id BIGINT,
  message TEXT
) PARTITION BY HASH (id);

CREATE TABLE logs_1 PARTITION OF logs FOR VALUES WITH (MODULUS 4, REMAINDER 0);
CREATE TABLE logs_2 PARTITION OF logs FOR VALUES WITH (MODULUS 4, REMAINDER 1);
CREATE TABLE logs_3 PARTITION OF logs FOR VALUES WITH (MODULUS 4, REMAINDER 2);
CREATE TABLE logs_4 PARTITION OF logs FOR VALUES WITH (MODULUS 4, REMAINDER 3);
```

---

## 12. 迁移步骤与检查清单

### 12.1 迁移准备阶段

#### 步骤1: 环境准备
- [ ] 安装PostgreSQL 16.x
- [ ] 配置postgres用户密码
- [ ] 创建目标数据库
  ```sql
  CREATE DATABASE target_db 
    ENCODING 'UTF8' 
    LOCALE_PROVIDER = icu 
    ICU_LOCALE = 'zh-CN'
    TEMPLATE template0;
  ```
- [ ] 安装必要扩展
  ```sql
  CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
  CREATE EXTENSION IF NOT EXISTS "pg_trgm";  -- 模糊搜索
  CREATE EXTENSION IF NOT EXISTS "btree_gin"; -- GIN索引增强
  ```

#### 步骤2: 评估与分析
- [ ] 导出MySQL数据库结构
  ```bash
  mysqldump -u user -p --no-data --databases dbname > schema.sql
  ```
- [ ] 导出MySQL数据
  ```bash
  mysqldump -u user -p --no-create-info --databases dbname > data.sql
  ```
- [ ] 分析表大小
  ```sql
  SELECT 
    table_name,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS size_mb
  FROM information_schema.TABLES
  WHERE table_schema = 'dbname'
  ORDER BY size_mb DESC;
  ```
- [ ] 识别存储过程、触发器、视图
  ```sql
  SHOW PROCEDURE STATUS WHERE db = 'dbname';
  SHOW TRIGGERS FROM dbname;
  SHOW FULL TABLES WHERE Table_type = 'VIEW';
  ```

### 12.2 转换阶段

#### 步骤3: 结构转换
- [ ] 使用转换工具（推荐 pgLoader 或手动转换）
- [ ] 转换CREATE TABLE语句
  - [ ] 移除反引号
  - [ ] 转换数据类型
  - [ ] 转换AUTO_INCREMENT为SERIAL/IDENTITY
  - [ ] 转换字符集定义
  - [ ] 移除ENGINE、ROW_FORMAT等MySQL特有选项
- [ ] 转换索引
  - [ ] 主键保留在CREATE TABLE中
  - [ ] 其他索引提取为独立CREATE INDEX语句
  - [ ] 全文索引转换为GIN索引
- [ ] 转换约束
  - [ ] UNSIGNED转换为CHECK约束
  - [ ] ENUM转换为CHECK或自定义类型
  - [ ] 外键保持不变
- [ ] 添加注释
  ```sql
  COMMENT ON TABLE table_name IS '表注释';
  COMMENT ON COLUMN table_name.column_name IS '列注释';
  ```

#### 步骤4: 数据迁移工具选择

**方案A: pgLoader (推荐)**
```bash
# 安装pgLoader
apt-get install pgloader  # Ubuntu/Debian
brew install pgloader      # macOS

# 配置文件 mysql_to_pg.load
LOAD DATABASE
  FROM mysql://user:password@localhost/source_db
  INTO postgresql://user:password@localhost/target_db

WITH include drop, create tables, create indexes, reset sequences,
     workers = 8, concurrency = 1

SET maintenance_work_mem to '512MB',
    work_mem to '128MB'

CAST type datetime to timestamptz 
     drop default drop not null using zero-dates-to-null,
     type date drop not null drop default using zero-dates-to-null;

# 执行迁移
pgloader mysql_to_pg.load
```

**方案B: 手动导出导入 (CSV)**

**MySQL导出CSV**:
```bash
# 方式1: 使用SELECT INTO OUTFILE
mysql -u user -p dbname -e "
SELECT * FROM users 
INTO OUTFILE '/var/lib/mysql-files/users.csv' 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '\"' 
LINES TERMINATED BY '\r\n';"

# 方式2: 使用mysqldump
mysqldump -u user -p \
  --tab=/var/lib/mysql-files \
  --fields-terminated-by=',' \
  --fields-enclosed-by='"' \
  --lines-terminated-by='\n' \
  dbname users

# 方式3: 使用mysql客户端
mysql -u user -p -B -e "SELECT * FROM users" dbname | \
  sed 's/\t/,/g' > /tmp/users.csv
```

**PostgreSQL导入CSV**:
```bash
# 方式1: 使用COPY命令
psql -U user -d dbname -c "
COPY users FROM '/var/lib/mysql-files/users.csv' 
WITH (
  FORMAT csv, 
  HEADER true,
  DELIMITER ',',
  QUOTE '\"',
  ENCODING 'UTF8'
);"

# 方式2: 使用\copy元命令（不需要超级用户）
psql -U user -d dbname -c "
\copy users FROM '/tmp/users.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',');"

# 方式3: 使用psql -f
echo "COPY users FROM STDIN WITH (FORMAT csv, HEADER true);" > import.sql
cat /tmp/users.csv >> import.sql
psql -U user -d dbname -f import.sql
```

**注意事项**:
- ✅ CSV导出前先导出表结构并在PG中创建表
- ✅ 导入前禁用外键约束和触发器
- ✅ 大表建议分批导入
- ⚠️ 注意字段中包含逗号、引号、换行符的处理
- ⚠️ 日期时间格式可能需要调整

**方案C: ETL工具**
- Pentaho Data Integration (Kettle)
- Apache NiFi
- AWS DMS (云环境)

### 12.3 数据迁移阶段

#### 步骤5: 执行数据迁移
- [ ] 按表大小顺序迁移（小表→大表）
- [ ] 禁用约束和触发器
  ```sql
  ALTER TABLE table_name DISABLE TRIGGER ALL;
  ```
- [ ] 批量插入数据
- [ ] 启用约束和触发器
  ```sql
  ALTER TABLE table_name ENABLE TRIGGER ALL;
  ```
- [ ] 重置序列
  ```sql
  SELECT setval(pg_get_serial_sequence('table_name', 'id'), 
                (SELECT MAX(id) FROM table_name));
  ```

#### 步骤6: 验证数据一致性
- [ ] 比对记录数
  ```sql
  -- MySQL
  SELECT COUNT(*) FROM users;
  
  -- PostgreSQL
  SELECT COUNT(*) FROM users;
  ```
- [ ] 比对数据校验和
  ```sql
  -- MySQL
  SELECT MD5(GROUP_CONCAT(id ORDER BY id)) FROM users;
  
  -- PostgreSQL
  SELECT MD5(STRING_AGG(id::TEXT, '' ORDER BY id)) FROM users;
  ```
- [ ] 抽样检查关键数据
- [ ] 验证外键完整性
  ```sql
  -- 查找违反外键的数据
  SELECT * FROM child_table ct
  WHERE NOT EXISTS (
    SELECT 1 FROM parent_table pt WHERE pt.id = ct.parent_id
  );
  ```

### 12.4 应用程序适配阶段

#### 步骤7: 代码修改
- [ ] 更新数据库连接配置
  ```python
  # Python示例
  # MySQL
  # conn = pymysql.connect(host='localhost', user='user', password='pwd', db='db')
  
  # PostgreSQL
  conn = psycopg2.connect(
    host='localhost',
    user='user',
    password='pwd',
    dbname='db'
  )
  ```
- [ ] 修改SQL语句
  - [ ] 反引号 → 双引号（或去除）
  - [ ] LIMIT语法
  - [ ] 日期时间函数
  - [ ] 字符串函数（GROUP_CONCAT → STRING_AGG）
  - [ ] 类型转换（CAST或::）
  - [ ] INSERT IGNORE → ON CONFLICT
  - [ ] REPLACE INTO → ON CONFLICT DO UPDATE
- [ ] 修改ORM配置
  ```python
  # Django示例
  DATABASES = {
      'default': {
          'ENGINE': 'django.db.backends.postgresql',  # 改为postgresql
          'NAME': 'dbname',
          'USER': 'user',
          'PASSWORD': 'password',
          'HOST': 'localhost',
          'PORT': '5432',
      }
  }
  ```

#### 步骤8: 测试
- [ ] 单元测试全部通过
- [ ] 集成测试全部通过
- [ ] 性能测试
  - [ ] 关键查询响应时间
  - [ ] 并发测试
  - [ ] 批量操作测试
- [ ] 功能测试
  - [ ] 用户登录/注册
  - [ ] CRUD操作
  - [ ] 报表生成
  - [ ] 数据导入导出

### 12.5 上线阶段

#### 步骤9: 上线准备
- [ ] 创建数据库备份
  ```bash
  pg_dump -U user -d dbname -F c -f backup.dump
  ```
- [ ] 准备回滚方案
- [ ] 监控配置
  - [ ] 慢查询日志
    ```sql
    ALTER DATABASE dbname SET log_min_duration_statement = 1000; -- 1秒
    ```
  - [ ] 连接数监控
  - [ ] 性能指标监控
- [ ] 通知相关人员

#### 步骤10: 执行切换
- [ ] 停止应用写入
- [ ] 同步最后的增量数据
- [ ] 验证数据一致性
- [ ] 切换应用连接到PostgreSQL
- [ ] 监控运行状态
- [ ] 确认无问题后通知完成

### 12.6 优化阶段

#### 步骤11: 性能优化
- [ ] 收集统计信息
  ```sql
  ANALYZE VERBOSE;
  ```
- [ ] 检查慢查询
  ```sql
  SELECT query, calls, total_time, mean_time
  FROM pg_stat_statements
  ORDER BY mean_time DESC
  LIMIT 20;
  ```
- [ ] 优化索引
- [ ] 调整配置参数
- [ ] 设置自动清理

### 12.7 完整性检查清单

**数据完整性**:
- [ ] 所有表记录数一致
- [ ] 主键无重复
- [ ] 外键关系完整
- [ ] 唯一约束有效
- [ ] 非空约束有效
- [ ] 默认值正确

**功能完整性**:
- [ ] 所有存储过程已转换
- [ ] 所有触发器已转换
- [ ] 所有视图已转换
- [ ] 所有函数已转换
- [ ] 定时任务已迁移

**性能指标**:
- [ ] 查询性能不低于MySQL
- [ ] 内存使用正常
- [ ] 连接数正常
- [ ] 磁盘I/O正常

---

## 13. 常见问题与解决方案

### 13.1 字符集问题

**问题**: 中文乱码

**解决方案**:
```sql
-- 检查数据库编码
SHOW SERVER_ENCODING;

-- 重新创建数据库
DROP DATABASE IF EXISTS dbname;
CREATE DATABASE dbname 
  ENCODING 'UTF8' 
  LC_COLLATE = 'zh_CN.UTF-8' 
  LC_CTYPE = 'zh_CN.UTF-8';

-- 客户端编码
SET client_encoding = 'UTF8';
```

### 13.2 序列未同步

**问题**: 插入数据时主键冲突

**解决方案**:
```sql
-- 重置所有序列
SELECT 'SELECT SETVAL(' ||
       quote_literal(quote_ident(PGT.schemaname) || '.' || quote_ident(S.relname)) ||
       ', COALESCE(MAX(' ||quote_ident(C.attname)|| '), 1) ) FROM ' ||
       quote_ident(PGT.schemaname)|| '.'||quote_ident(T.relname)|| ';'
FROM pg_class AS S,
     pg_depend AS D,
     pg_class AS T,
     pg_attribute AS C,
     pg_tables AS PGT
WHERE S.relkind = 'S'
  AND S.oid = D.objid
  AND D.refobjid = T.oid
  AND D.refobjid = C.attrelid
  AND D.refobjsubid = C.attnum
  AND T.relname = PGT.tablename
ORDER BY S.relname;
```

### 13.3 大小写敏感问题

**问题**: 查询时表名/列名找不到

**解决方案**:
```sql
-- 方案A: 使用小写（推荐）
CREATE TABLE users (
  id INTEGER,
  user_name VARCHAR(100)
);

-- 方案B: 使用双引号（不推荐）
CREATE TABLE "Users" (
  "ID" INTEGER,
  "UserName" VARCHAR(100)
);
-- 查询时也必须加引号
SELECT "ID" FROM "Users";
```

### 13.4 性能问题

**问题**: 查询比MySQL慢

**排查步骤**:
```sql
-- 1. 检查是否有索引
SELECT * FROM pg_indexes WHERE tablename = 'table_name';

-- 2. 检查统计信息是否更新
SELECT schemaname, tablename, last_analyze, last_autoanalyze
FROM pg_stat_user_tables
WHERE tablename = 'table_name';

-- 如未更新，手动分析
ANALYZE table_name;

-- 3. 查看执行计划
EXPLAIN (ANALYZE, BUFFERS) SELECT ...;

-- 4. 检查表膨胀
SELECT schemaname, tablename,
       pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS total_size,
       n_dead_tup, n_live_tup
FROM pg_stat_user_tables
WHERE tablename = 'table_name';

-- 如膨胀严重，执行VACUUM
VACUUM FULL table_name;
```

### 13.5 连接数不足

**问题**: FATAL: sorry, too many clients already

**解决方案**:
```sql
-- 查看当前连接数
SELECT count(*) FROM pg_stat_activity;

-- 查看最大连接数
SHOW max_connections;

-- 修改最大连接数
ALTER SYSTEM SET max_connections = 200;
-- 重启PostgreSQL生效

-- 或使用连接池（推荐）
-- PgBouncer、Pgpool-II
```

### 13.6 锁等待超时

**问题**: 长时间等待锁

**解决方案**:
```sql
-- 查看锁等待
SELECT 
  pid,
  usename,
  pg_blocking_pids(pid) as blocked_by,
  query
FROM pg_stat_activity
WHERE cardinality(pg_blocking_pids(pid)) > 0;

-- 杀死阻塞进程
SELECT pg_terminate_backend(pid);

-- 设置锁等待超时
SET lock_timeout = '30s';
SET statement_timeout = '60s';
```

### 13.7 时区问题

**问题**: 时间差8小时

**解决方案**:
```sql
-- 查看时区
SHOW timezone;

-- 设置时区
SET timezone = 'Asia/Shanghai';

-- 永久设置
ALTER DATABASE dbname SET timezone TO 'Asia/Shanghai';

-- 或在postgresql.conf
timezone = 'Asia/Shanghai'
```

### 13.8 BOOLEAN类型问题

**问题**: TINYINT(1)转换错误

**MySQL数据**: `0`, `1`

**PostgreSQL处理**:
```sql
-- 方案A: 直接转换为BOOLEAN
col BOOLEAN DEFAULT FALSE

-- 迁移数据时
UPDATE table SET col = (old_col::INTEGER = 1);

-- 方案B: 保持INTEGER并添加约束
col SMALLINT CHECK (col IN (0, 1))
```

### 13.9 GROUP_CONCAT问题

**MySQL**:
```sql
SELECT user_id, GROUP_CONCAT(tag ORDER BY tag SEPARATOR ',')
FROM user_tags
GROUP BY user_id;
```

**PostgreSQL**:
```sql
SELECT user_id, STRING_AGG(tag, ',' ORDER BY tag)
FROM user_tags
GROUP BY user_id;
```

### 13.10 REPLACE INTO问题

**MySQL**:
```sql
REPLACE INTO users (id, name) VALUES (1, 'Alice');
```

**PostgreSQL**:
```sql
INSERT INTO users (id, name) VALUES (1, 'Alice')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;
```

### 13.11 数组下标问题

**问题**: PostgreSQL数组下标从1开始，不是0

**示例**:
```sql
-- MySQL风格（使用函数）
SELECT SUBSTRING_INDEX(tags, ',', 1) FROM table_name;

-- PostgreSQL数组
SELECT (STRING_TO_ARRAY(tags, ','))[1] FROM table_name;  -- 第1个元素
SELECT (STRING_TO_ARRAY(tags, ','))[2] FROM table_name;  -- 第2个元素

-- 获取最后一个元素
SELECT (STRING_TO_ARRAY(tags, ','))[
  ARRAY_LENGTH(STRING_TO_ARRAY(tags, ','), 1)
] FROM table_name;
```

### 13.12 VARCHAR长度不足问题

**问题**: 中文字符插入失败或被截断

**排查**:
```sql
-- 检查字段定义
SELECT 
  column_name, 
  data_type, 
  character_maximum_length
FROM information_schema.columns
WHERE table_name = 'your_table';

-- 检查实际数据长度
SELECT 
  column_name,
  LENGTH(column_name) as byte_length,
  CHAR_LENGTH(column_name) as char_length
FROM your_table
WHERE CHAR_LENGTH(column_name) > 95;  -- 接近VARCHAR(100)
```

**解决**:
```sql
-- 扩大字段长度
ALTER TABLE your_table ALTER COLUMN column_name TYPE VARCHAR(400);

-- 或改为TEXT
ALTER TABLE your_table ALTER COLUMN column_name TYPE TEXT;
```

### 13.13 ON UPDATE CURRENT_TIMESTAMP 缺失

**问题**: 更新时间字段不自动更新

**解决方案**: 创建触发器

```sql
-- 1. 创建通用更新时间函数
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.update_time = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. 为需要的表创建触发器
CREATE TRIGGER trigger_update_timestamp
BEFORE UPDATE ON table_name
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 3. 批量创建触发器（示例）
DO $$
DECLARE
  r RECORD;
BEGIN
  FOR r IN 
    SELECT table_name 
    FROM information_schema.columns 
    WHERE column_name = 'update_time' 
    AND table_schema = 'public'
  LOOP
    EXECUTE format('
      CREATE TRIGGER trigger_%I_update_time
      BEFORE UPDATE ON %I
      FOR EACH ROW
      EXECUTE FUNCTION update_timestamp();
    ', r.table_name, r.table_name);
  END LOOP;
END $$;
```

### 13.14 排序结果不一致

**问题**: 相同SQL在MySQL和PostgreSQL返回顺序不同

**原因**:
- MySQL: 无ORDER BY时，通常按主键或插入顺序
- PostgreSQL: 无ORDER BY时，顺序不确定（vacuum后可能变化）

**解决**:
```sql
-- 错误: 依赖隐式排序
SELECT * FROM users LIMIT 10;

-- 正确: 显式指定排序
SELECT * FROM users ORDER BY id LIMIT 10;
SELECT * FROM users ORDER BY created_at DESC, id LIMIT 10;
```

**约束规则**:
- ✅ **必须**: 所有需要稳定顺序的查询都要加 `ORDER BY`
- ✅ **建议**: ORDER BY包含唯一字段（如主键），确保排序稳定性
- ⚠️ 分页查询必须指定ORDER BY，否则可能重复或遗漏数据

### 13.15 位运算符差异

**问题**: 异或运算符不同

**MySQL**:
```sql
SELECT 1 ^ 2;  -- XOR运算，返回 3
```

**PostgreSQL**:
```sql
-- ^ 是幂运算
SELECT 2 ^ 3;  -- 返回 8 (2的3次方)

-- 位异或使用 #
SELECT 1 # 2;  -- 返回 3

-- 逻辑异或 (boolean)
SELECT true != false;  -- 返回 true
```

**解决**: 批量替换位运算表达式

### 13.16 双引号字符串问题

**问题**: MySQL允许双引号表示字符串，PostgreSQL不行

**MySQL**:
```sql
SELECT * FROM users WHERE name = "Alice";  -- 允许
SELECT * FROM users WHERE name = 'Alice';  -- 也允许
```

**PostgreSQL**:
```sql
SELECT * FROM users WHERE name = "Alice";  -- 错误! "Alice"被识别为列名
SELECT * FROM users WHERE name = 'Alice';  -- 正确
```

**解决**: 批量替换双引号为单引号
```bash
# 使用sed批量替换SQL文件
sed -i "s/= \"/= '/g" migration.sql
sed -i 's/"\([^"]*\)"/'"'"'\1'"'"'/g' migration.sql
```

---

## 14. 推荐工具

### 14.1 迁移工具

| 工具 | 类型 | 特点 | 推荐场景 |
|-----|------|------|---------|
| **pgLoader** | 命令行 | 快速、自动化 | 中小型数据库 |
| **AWS DMS** | 云服务 | 持续同步、在线迁移 | 云环境、大型数据库 |
| **ora2pg** | 命令行 | 原为Oracle转PG，也支持MySQL | 复杂迁移 |
| **MySQL Workbench** | GUI | 手动导出/导入 | 小型数据库 |
| **DBeaver** | GUI | 通用数据库工具 | 开发测试环境 |

### 14.2 监控工具

| 工具 | 用途 |
|-----|------|
| **pg_stat_statements** | 慢查询分析 |
| **pgBadger** | 日志分析 |
| **Grafana + Prometheus** | 可视化监控 |
| **pgAdmin 4** | 官方管理工具 |
| **DataGrip** | JetBrains数据库IDE |

### 14.3 性能分析

```sql
-- 启用pg_stat_statements
CREATE EXTENSION pg_stat_statements;

-- 查看慢查询
SELECT query, calls, total_time, mean_time, max_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 20;

-- 查看表大小
SELECT 
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- 查看索引使用情况
SELECT 
  schemaname,
  tablename,
  indexname,
  idx_scan,
  idx_tup_read,
  idx_tup_fetch,
  pg_size_pretty(pg_relation_size(indexrelid)) AS size
FROM pg_stat_user_indexes
WHERE idx_scan = 0  -- 未使用的索引
ORDER BY pg_relation_size(indexrelid) DESC;
```

---

## 15. PostgreSQL 16.x 新特性利用

### 15.1 增强的VACUUM

```sql
-- 并行VACUUM（提高大表清理速度）
VACUUM (PARALLEL 4) large_table;
```

### 15.2 逻辑复制改进

```sql
-- 双向逻辑复制（实现多主）
CREATE PUBLICATION pub_name FOR ALL TABLES;
CREATE SUBSCRIPTION sub_name 
  CONNECTION 'host=... dbname=...' 
  PUBLICATION pub_name;
```

### 15.3 性能提升

- **查询并行度提高**: 更多操作支持并行执行
- **B-tree索引优化**: 去重能力增强
- **COPY性能提升**: 批量导入更快

### 15.4 SQL功能增强

```sql
-- MERGE语句（SQL标准）
MERGE INTO target t
USING source s ON t.id = s.id
WHEN MATCHED THEN
  UPDATE SET t.value = s.value
WHEN NOT MATCHED THEN
  INSERT (id, value) VALUES (s.id, s.value);

-- 增强的正则表达式函数
SELECT regexp_count('abc123def456', '\d+');  -- 计数
SELECT regexp_like('test', 't.st');  -- 匹配
SELECT regexp_substr('abc123def', '\d+');  -- 提取
```

---

## 16. 安全建议

### 16.1 权限管理

```sql
-- 创建只读用户
CREATE USER readonly_user WITH PASSWORD 'password';
GRANT CONNECT ON DATABASE dbname TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_user;

-- 创建应用用户
CREATE USER app_user WITH PASSWORD 'strong_password';
GRANT CONNECT ON DATABASE dbname TO app_user;
GRANT USAGE, CREATE ON SCHEMA public TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_user;
```

### 16.2 连接加密

```sql
-- pg_hba.conf
# TYPE  DATABASE        USER            ADDRESS                 METHOD
hostssl all             all             0.0.0.0/0              md5

-- 强制SSL连接
ALTER DATABASE dbname SET ssl = on;
```

### 16.3 审计日志

```ini
# postgresql.conf
logging_collector = on
log_directory = 'pg_log'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_statement = 'ddl'  # 记录DDL语句
log_duration = on
log_min_duration_statement = 1000  # 记录超过1秒的查询
```

---

## 17. 总结

### 17.1 关键差异速查

| 方面 | MySQL | PostgreSQL |
|-----|-------|-----------|
| 字符串引用 | 单引号或双引号 | 只能单引号 |
| 标识符引用 | 反引号 `` ` `` | 双引号 `"` |
| 自增主键 | `AUTO_INCREMENT` | `SERIAL` / `IDENTITY` |
| 布尔类型 | `TINYINT(1)` | `BOOLEAN` |
| 文本类型 | 多种TEXT | 统一`TEXT` |
| JSON | `JSON` | `JSONB`(推荐) |
| 分页 | `LIMIT n, m` | `LIMIT n OFFSET m` |
| 字符串连接 | `CONCAT()` | `\|\|` 或 `CONCAT()` |
| IF函数 | `IF(c,t,f)` | `CASE WHEN` |
| IFNULL | `IFNULL(a,b)` | `COALESCE(a,b)` |
| GROUP_CONCAT | `GROUP_CONCAT()` | `STRING_AGG()` |
| 日期格式化 | `DATE_FORMAT()` | `TO_CHAR()` |
| 大小写 | 不敏感(默认) | 敏感(默认) |
| LIMIT | `LIKE` | `ILIKE`(不敏感) |
| INSERT IGNORE | `INSERT IGNORE` | `ON CONFLICT DO NOTHING` |
| REPLACE | `REPLACE INTO` | `ON CONFLICT DO UPDATE` |

### 17.2 迁移优先级

**高优先级 (必须)**:
1. ✅ 数据类型转换
2. ✅ 自增主键转换
3. ✅ 字符集统一为UTF8
4. ✅ 外键约束完整性
5. ✅ 应用层SQL语句修改

**中优先级 (重要)**:
1. ⚠️ 索引优化
2. ⚠️ 存储过程和触发器
3. ⚠️ 视图重建
4. ⚠️ 性能测试和调优

**低优先级 (可选)**:
1. 📌 分区表优化
2. 📌 高级特性应用
3. 📌 监控和告警配置

### 17.3 成功要素

1. **充分测试**: 在测试环境完整模拟生产环境
2. **详细计划**: 准备详细的迁移计划和回滚方案
3. **增量迁移**: 优先迁移非核心系统积累经验
4. **监控到位**: 部署完善的监控体系
5. **团队培训**: 确保团队熟悉PostgreSQL特性

---

## 附录A: 快速转换脚本

### A.1 表结构转换Shell脚本

```bash
#!/bin/bash
# mysql_to_pg_schema.sh

# 基本替换
sed -e "s/\`//g" \
    -e "s/ int([0-9]*) / INTEGER /gi" \
    -e "s/ bigint([0-9]*) / BIGINT /gi" \
    -e "s/ smallint([0-9]*) / SMALLINT /gi" \
    -e "s/ tinyint(1) / BOOLEAN /gi" \
    -e "s/ tinyint([0-9]*) / SMALLINT /gi" \
    -e "s/ mediumint([0-9]*) / INTEGER /gi" \
    -e "s/ datetime / TIMESTAMP /gi" \
    -e "s/ AUTO_INCREMENT/ /gi" \
    -e "s/ COMMENT '[^']*'//gi" \
    -e "s/ CHARACTER SET [a-z0-9_]*//gi" \
    -e "s/ COLLATE [a-z0-9_]*//gi" \
    -e "s/ USING BTREE//gi" \
    -e "s/ ENGINE=[A-Za-z]*//gi" \
    -e "s/ ROW_FORMAT=[A-Za-z]*//gi" \
    -e "/^SET /d" \
    -e "/^DROP TABLE/d" \
    mysql_schema.sql > pg_schema.sql
```

### A.2 Python转换脚本

```python
# mysql_to_pg_converter.py
import re

def convert_mysql_to_pg(mysql_sql):
    """转换MySQL DDL为PostgreSQL DDL"""
    
    # 移除反引号
    pg_sql = mysql_sql.replace('`', '')
    
    # 数据类型转换
    type_mapping = {
        r'int\(\d+\)': 'INTEGER',
        r'bigint\(\d+\)': 'BIGINT',
        r'smallint\(\d+\)': 'SMALLINT',
        r'tinyint\(1\)': 'BOOLEAN',
        r'tinyint\(\d+\)': 'SMALLINT',
        r'mediumint\(\d+\)': 'INTEGER',
        r'datetime': 'TIMESTAMP',
        r'double': 'DOUBLE PRECISION',
        r'mediumtext': 'TEXT',
        r'longtext': 'TEXT',
    }
    
    for pattern, replacement in type_mapping.items():
        pg_sql = re.sub(pattern, replacement, pg_sql, flags=re.IGNORECASE)
    
    # 移除MySQL特有选项
    pg_sql = re.sub(r' AUTO_INCREMENT', '', pg_sql, flags=re.IGNORECASE)
    pg_sql = re.sub(r' COMMENT \'[^\']*\'', '', pg_sql)
    pg_sql = re.sub(r' CHARACTER SET [a-z0-9_]+', '', pg_sql, flags=re.IGNORECASE)
    pg_sql = re.sub(r' COLLATE [a-z0-9_]+', '', pg_sql, flags=re.IGNORECASE)
    pg_sql = re.sub(r' USING BTREE', '', pg_sql, flags=re.IGNORECASE)
    pg_sql = re.sub(r' ENGINE\s*=\s*[A-Za-z]+', '', pg_sql, flags=re.IGNORECASE)
    pg_sql = re.sub(r' ROW_FORMAT\s*=\s*[A-Za-z]+', '', pg_sql, flags=re.IGNORECASE)
    
    return pg_sql

# 使用示例
with open('mysql_schema.sql', 'r') as f:
    mysql_sql = f.read()

pg_sql = convert_mysql_to_pg(mysql_sql)

with open('pg_schema.sql', 'w') as f:
    f.write(pg_sql)
```

---

## 附录B: 配置模板

### B.1 postgresql.conf 优化配置

```ini
# PostgreSQL 16.x 生产环境配置模板
# 假设: 32GB内存, 8核CPU, SSD存储

# === 连接配置 ===
max_connections = 200
superuser_reserved_connections = 3

# === 内存配置 ===
shared_buffers = 8GB                    # 内存的25%
effective_cache_size = 24GB             # 内存的75%
maintenance_work_mem = 2GB              # 维护操作
work_mem = 32MB                         # 每个查询操作
huge_pages = try

# === WAL配置 ===
wal_level = replica
wal_buffers = 16MB
max_wal_size = 4GB
min_wal_size = 1GB
checkpoint_completion_target = 0.9
checkpoint_timeout = 15min

# === 查询优化 ===
random_page_cost = 1.1                  # SSD设置
effective_io_concurrency = 200          # SSD并发
max_parallel_workers_per_gather = 4
max_parallel_workers = 8
max_worker_processes = 8

# === 日志配置 ===
logging_collector = on
log_directory = 'log'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_rotation_age = 1d
log_rotation_size = 100MB
log_min_duration_statement = 1000       # 记录慢查询(毫秒)
log_line_prefix = '%t [%p]: [%l-1] user=%u,db=%d,app=%a,client=%h '
log_checkpoints = on
log_connections = on
log_disconnections = on
log_lock_waits = on

# === 自动清理 ===
autovacuum = on
autovacuum_max_workers = 3
autovacuum_naptime = 1min
autovacuum_vacuum_threshold = 50
autovacuum_analyze_threshold = 50
autovacuum_vacuum_scale_factor = 0.1
autovacuum_analyze_scale_factor = 0.05

# === 统计信息 ===
shared_preload_libraries = 'pg_stat_statements'
pg_stat_statements.track = all
pg_stat_statements.max = 10000

# === 时区 ===
timezone = 'Asia/Shanghai'
```

### B.2 pg_hba.conf 安全配置

```ini
# PostgreSQL Client Authentication Configuration

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# 本地连接
local   all             postgres                                peer
local   all             all                                     md5

# IPv4 本地连接
host    all             all             127.0.0.1/32            md5

# IPv6 本地连接
host    all             all             ::1/128                 md5

# 内网连接（根据实际情况调整）
host    all             all             192.168.0.0/16          md5

# 应用服务器连接（建议使用SSL）
hostssl all             app_user        10.0.0.0/8              md5

# 禁止外网连接（安全）
# host    all             all             0.0.0.0/0               reject
```

---

## 18. 组件与框架兼容性

### 18.1 配置管理 - Nacos

**兼容性**: ❌ **Nacos官方不支持PostgreSQL**

Nacos 2.x官方仅支持MySQL作为配置中心存储。

**解决方案**:

#### 方案A: 保持Nacos使用MySQL (推荐)
```yaml
# Nacos继续使用MySQL，业务数据库使用PostgreSQL
nacos:
  datasource:
    platform: mysql
    url: jdbc:mysql://localhost:3306/nacos?...
    username: nacos
    password: nacos123

# 业务数据源
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/business
    username: postgres
    password: postgres123
```

**优点**: 
- 简单稳定，官方支持
- Nacos数据量小，MySQL完全够用
- 不影响业务数据库迁移

#### 方案B: 使用Nacos内置数据库 (单机)
```yaml
# 单机模式使用Derby内置数据库
# 不需要外部数据库配置
```

**适用场景**: 开发/测试环境

#### 方案C: 使用MySQL JDBC代理 (不推荐)
```
使用开源JDBC代理工具将MySQL协议转换为PostgreSQL
项目: https://github.com/siaron/mysql2postgresql-jdbc-agent
风险: 不支持openGauss，稳定性未知
```

**约束规则**:
- ✅ **推荐**: 方案A - Nacos继续使用MySQL
- ✅ **可选**: 方案B - 单机环境使用内置数据库
- ❌ **不推荐**: 方案C - JDBC代理方案风险高

### 18.2 数据库版本管理 - Flyway

**兼容性**: ✅ **Flyway官方支持PostgreSQL**

Flyway从很早版本就支持PostgreSQL，但不支持openGauss。

**配置示例**:

```xml
<!-- pom.xml -->
<dependency>
    <groupId>org.flywaydb</groupId>
    <artifactId>flyway-core</artifactId>
</dependency>

<!-- PostgreSQL驱动 -->
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
</dependency>
```

```yaml
# application.yml
spring:
  flyway:
    enabled: true
    locations: classpath:db/migration
    baseline-on-migrate: true
    baseline-version: 0
    table: flyway_schema_history
    validate-on-migrate: true
```

**迁移脚本命名**:
```
db/migration/
├── V1__init_schema.sql
├── V2__add_user_table.sql
├── V3__add_indexes.sql
└── V4__migrate_data.sql
```

**约束规则**:
- ✅ **支持**: PostgreSQL完全支持
- ⚠️ **注意**: openGauss需测试兼容性
- ✅ **建议**: 
  - 保持SQL脚本符合标准SQL
  - 避免使用数据库特有语法
  - 做好回滚脚本准备

### 18.3 ORM框架兼容性

#### MyBatis/MyBatis-Plus

**兼容性**: ✅ **完全支持**

```xml
<!-- pom.xml -->
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.5.3</version>
</dependency>
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
</dependency>
```

```yaml
# application.yml
spring:
  datasource:
    driver-class-name: org.postgresql.Driver
    url: jdbc:postgresql://localhost:5432/dbname
    username: postgres
    password: postgres123

mybatis-plus:
  global-config:
    db-config:
      id-type: auto
      # PostgreSQL使用序列而不是自增
      logic-delete-field: deleted
      logic-delete-value: 1
      logic-not-delete-value: 0
  configuration:
    # PostgreSQL字段名映射
    map-underscore-to-camel-case: true
```

**注意事项**:
```java
// 主键策略
@TableId(type = IdType.AUTO)  // 使用数据库自增（SERIAL）
private Long id;

@TableId(type = IdType.ASSIGN_ID)  // 使用雪花算法
private Long id;

// Schema指定
@TableName(value = "t_user", schema = "public")
public class User {
    // ...
}

// 大小写敏感字段
@TableField("`UserName`")  // 保持大小写
private String userName;
```

#### JPA/Hibernate

**兼容性**: ✅ **完全支持**

```yaml
spring:
  jpa:
    database-platform: org.hibernate.dialect.PostgreSQLDialect
    hibernate:
      ddl-auto: validate  # 生产环境使用validate或none
    properties:
      hibernate:
        jdbc:
          lob:
            non_contextual_creation: true
        format_sql: true
```

**方言选择**:
```java
// PostgreSQL 16推荐使用
org.hibernate.dialect.PostgreSQLDialect
// 或更具体的版本
org.hibernate.dialect.PostgreSQL16Dialect
```

### 18.4 连接池配置

#### HikariCP (推荐)

```yaml
spring:
  datasource:
    type: com.zaxxer.hikari.HikariDataSource
    hikari:
      maximum-pool-size: 20
      minimum-idle: 5
      connection-timeout: 30000
      idle-timeout: 600000
      max-lifetime: 1800000
      connection-test-query: SELECT 1
      # PostgreSQL特定配置
      data-source-properties:
        ApplicationName: my-app
        # 设置statement超时
        statement_timeout: 60000
```

#### Druid

```yaml
spring:
  datasource:
    type: com.alibaba.druid.pool.DruidDataSource
    druid:
      initial-size: 5
      min-idle: 5
      max-active: 20
      max-wait: 60000
      time-between-eviction-runs-millis: 60000
      min-evictable-idle-time-millis: 300000
      validation-query: SELECT 1
      test-while-idle: true
      test-on-borrow: false
      test-on-return: false
      # PostgreSQL驱动
      driver-class-name: org.postgresql.Driver
```

### 18.5 缓存框架 - Redis

**兼容性**: ✅ **无影响**

Redis作为缓存层，与底层数据库无关。但需注意：

```java
// 缓存key设计可能需要调整
@Cacheable(value = "users", key = "#id")
public User getUser(Long id) {
    // PostgreSQL的序列值可能与MySQL的auto_increment不同
    // 需要确保缓存key的一致性
}
```

### 18.6 定时任务框架

#### Quartz

**兼容性**: ✅ **支持PostgreSQL**

```properties
# quartz.properties
org.quartz.jobStore.driverDelegateClass=org.quartz.impl.jdbcjobstore.PostgreSQLDelegate
org.quartz.dataSource.myDS.driver=org.postgresql.Driver
org.quartz.dataSource.myDS.URL=jdbc:postgresql://localhost:5432/quartz
```

#### xxl-job

**兼容性**: ✅ **支持PostgreSQL**

需要执行PostgreSQL版本的初始化脚本。

### 18.7 分库分表 - ShardingSphere

**兼容性**: ✅ **支持PostgreSQL**

```yaml
spring:
  shardingsphere:
    datasource:
      names: ds0,ds1
      ds0:
        type: com.zaxxer.hikari.HikariDataSource
        driver-class-name: org.postgresql.Driver
        jdbc-url: jdbc:postgresql://localhost:5432/db0
      ds1:
        type: com.zaxxer.hikari.HikariDataSource
        driver-class-name: org.postgresql.Driver
        jdbc-url: jdbc:postgresql://localhost:5432/db1
    rules:
      sharding:
        tables:
          t_order:
            actual-data-nodes: ds$->{0..1}.t_order_$->{0..1}
```

### 18.8 全文搜索 - Elasticsearch

**兼容性**: ✅ **无影响**

ES作为搜索引擎，与底层数据库无关。但数据同步方式可能需要调整：

- **Logstash**: 修改jdbc input插件配置
- **Canal**: 不支持PostgreSQL，需要替换为Debezium
- **Debezium**: 推荐使用，支持PostgreSQL CDC

---

## 19. 集群与高可用方案

### 19.1 主从复制（流复制）

**PostgreSQL内置流复制** (Streaming Replication):

```sql
-- 主库配置 postgresql.conf
wal_level = replica
max_wal_senders = 10
wal_keep_size = 1GB

-- pg_hba.conf
host replication repl_user 192.168.1.0/24 md5
```

### 19.2 高可用方案 - Patroni + Etcd

**推荐方案**: 基于Patroni + Etcd实现自动故障切换

**特点**:
- ✅ 自动故障检测和主从切换
- ✅ 基于Raft算法的leader选举
- ✅ 支持同步/异步复制
- ✅ 可配置切换延迟阈值
- ✅ REST API管理接口

**架构**:
```
         ┌─────────────┐
         │   HAProxy   │  (VIP)
         └──────┬──────┘
                │
    ┌───────────┼───────────┐
    │           │           │
┌───▼───┐   ┌───▼───┐   ┌───▼───┐
│ Node1 │   │ Node2 │   │ Node3 │
│Patroni│   │Patroni│   │Patroni│
│  PG   │   │  PG   │   │  PG   │
└───┬───┘   └───┬───┘   └───┬───┘
    │           │           │
    └───────────┼───────────┘
            ┌───▼───┐
            │ Etcd  │
            │Cluster│
            └───────┘
```

### 19.3 分布式方案 - Citus

**Citus**: PostgreSQL扩展，实现水平扩展

**优点**:
- ✅ 开源免费
- ✅ 只是PG扩展，不是fork
- ✅ 支持分布式事务
- ✅ 支持并行查询
- ✅ 横向扩展方便

**缺点**:
- ⚠️ SQL有一定限制
- ⚠️ 不支持所有PG特性
- ⚠️ 学习曲线较陡

**适用场景**:
- 多租户SaaS应用
- 实时分析
- 时间序列数据
- 超大规模数据

---

## 文档维护

- **创建日期**: 2026-01-14
- **适用版本**: PostgreSQL 16.x, MySQL 5.7+
- **维护者**: 数据库团队
- **更新频率**: 季度审查

---

## 参考资源

### 官方文档
- [PostgreSQL 16 官方文档](https://www.postgresql.org/docs/16/)
- [MySQL 5.7 官方文档](https://dev.mysql.com/doc/refman/5.7/en/)
- [MySQL to PostgreSQL Migration](https://wiki.postgresql.org/wiki/Converting_from_other_Databases_to_PostgreSQL#MySQL)

### 迁移工具
- [pgLoader Documentation](https://pgloader.readthedocs.io/)
- [AWS DMS](https://aws.amazon.com/dms/)
- [DataX](https://github.com/alibaba/DataX)

### 高可用方案
- [Patroni](https://patroni.readthedocs.io/)
- [Citus](https://docs.citusdata.com/)
- [pg_auto_failover](https://pg-auto-failover.readthedocs.io/)

### 性能优化
- [PostgreSQL Performance Tuning](https://wiki.postgresql.org/wiki/Performance_Optimization)
- [PgTune](https://pgtune.leopard.in.ua/)
- [EXPLAIN Visualizer](https://explain.dalibo.com/)

### 社区资源
- [PostgreSQL中文社区](http://www.postgres.cn/)
- [Stack Overflow PostgreSQL Tag](https://stackoverflow.com/questions/tagged/postgresql)

---

**本文档为MySQL转PostgreSQL迁移的完整指南，建议打印后配合实际项目使用。**

**版权声明**: 本文档内容整合自项目实战经验和官方文档，供内部使用和参考。
