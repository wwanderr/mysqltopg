# 主键和自增主键转换技术指南

> **转换工具**: convert_mysql_to_pg.py  
> **目标**: MySQL → PostgreSQL 16.x

---

## 📋 转换策略总览

### 核心原则

1. **自增列**: `AUTO_INCREMENT` → `SERIAL` / `BIGSERIAL`
2. **主键约束**: 保留在 `CREATE TABLE` 中
3. **其他索引**: 提取为独立的 `CREATE INDEX` 语句
4. **MySQL特有选项**: 移除 `USING BTREE`, `ENGINE=InnoDB` 等

---

## 🔄 自增主键转换

### 类型1: INT AUTO_INCREMENT

**MySQL原始**:
```sql
CREATE TABLE `ailpha_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1;
```

**PostgreSQL转换**:
```sql
CREATE TABLE "ailpha_model" (
  "id" SERIAL,                    -- 等价于 INTEGER NOT NULL DEFAULT nextval('...')
  "uuid" VARCHAR(100) NOT NULL,
  PRIMARY KEY ("id")
);
```

**说明**:
- `SERIAL` = `INTEGER` + `NOT NULL` + 自动序列
- 自动创建序列: `ailpha_model_id_seq`
- `int(11)` 中的 `11` 是显示宽度，PostgreSQL不需要

---

### 类型2: BIGINT AUTO_INCREMENT

**MySQL原始**:
```sql
CREATE TABLE `ailpha_model_change` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uuid` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB;
```

**PostgreSQL转换**:
```sql
CREATE TABLE "ailpha_model_change" (
  "id" BIGSERIAL,                 -- 等价于 BIGINT NOT NULL DEFAULT nextval('...')
  "uuid" VARCHAR(255) NOT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ailpha_model_change"."id" IS '主键';
```

**说明**:
- `BIGSERIAL` = `BIGINT` + `NOT NULL` + 自动序列
- 适用于大表，范围更大
- `bigint(20)` 中的 `20` 是显示宽度，PostgreSQL不需要

---

### 类型3: SMALLINT AUTO_INCREMENT (少见)

**MySQL原始**:
```sql
CREATE TABLE `small_table` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
);
```

**PostgreSQL转换**:
```sql
CREATE TABLE "small_table" (
  "id" SMALLSERIAL,               -- 等价于 SMALLINT NOT NULL DEFAULT nextval('...')
  PRIMARY KEY ("id")
);
```

---

## 🎯 转换代码实现

### Python转换逻辑

```python
def convert_auto_increment(col_name, col_def):
    """
    转换AUTO_INCREMENT列
    
    Args:
        col_name: 列名
        col_def: 列定义
    
    Returns:
        转换后的列定义
    """
    if 'AUTO_INCREMENT' in col_def.upper():
        # 提取原始类型
        type_match = re.match(r'(\w+)(?:\([^)]+\))?', col_def, re.IGNORECASE)
        if type_match:
            orig_type = type_match.group(1).upper()
            
            # 根据类型选择对应的SERIAL类型
            if 'BIGINT' in orig_type:
                return 'BIGSERIAL'
            elif 'SMALLINT' in orig_type:
                return 'SMALLSERIAL'
            elif 'INT' in orig_type or 'MEDIUMINT' in orig_type:
                return 'SERIAL'
            else:
                return 'SERIAL'  # 默认
    
    return col_def
```

---

## 🔑 主键约束处理

### 单列主键

**MySQL**:
```sql
PRIMARY KEY (`id`) USING BTREE
```

**PostgreSQL**:
```sql
PRIMARY KEY ("id")
```

**转换规则**:
- ✅ 保留 `PRIMARY KEY`
- ✅ 转换引号: `` ` `` → `"`
- ❌ 移除 `USING BTREE` (PostgreSQL默认B-tree)

---

### 复合主键

**MySQL**:
```sql
CREATE TABLE `ailpha_model_user_status` (
  `id` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(20) NOT NULL DEFAULT '',
  `enable` tinyint(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `type`) USING BTREE
);
```

**PostgreSQL**:
```sql
CREATE TABLE "ailpha_model_user_status" (
  "id" VARCHAR(255) NOT NULL DEFAULT '',
  "type" VARCHAR(20) NOT NULL DEFAULT '',
  "enable" SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY ("id", "type")
);
```

**说明**:
- 复合主键列名用逗号分隔
- 所有列名都转换引号
- 保持列的顺序

---

## 📑 索引分离处理

### UNIQUE INDEX

**MySQL (在CREATE TABLE中)**:
```sql
CREATE TABLE `ailpha_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelName` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `modelName`(`modelName`) USING BTREE
);
```

**PostgreSQL (分离出来)**:
```sql
CREATE TABLE "ailpha_model" (
  "id" SERIAL,
  "modelName" VARCHAR(100) NOT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "modelName" ON "ailpha_model" ("modelName");
```

**原因**:
- PostgreSQL推荐索引独立定义
- 便于维护和管理
- 可以并发创建索引 (`CREATE INDEX CONCURRENTLY`)

---

### 普通INDEX

**MySQL**:
```sql
CREATE TABLE `ailpha_sub_metric` (
  `metricId` varchar(255) NOT NULL,
  PRIMARY KEY (`metricId`) USING BTREE,
  UNIQUE INDEX `INDEX_METRIC_ID`(`metricId`) USING BTREE
);
```

**PostgreSQL**:
```sql
CREATE TABLE "ailpha_sub_metric" (
  "metricId" VARCHAR(255) NOT NULL,
  PRIMARY KEY ("metricId")
);

-- Indexes
CREATE UNIQUE INDEX "INDEX_METRIC_ID" ON "ailpha_sub_metric" ("metricId");
```

---

## 📊 SERIAL类型详解

### SERIAL类型对比

| PostgreSQL类型 | 等价定义 | 范围 | 对应MySQL |
|---------------|---------|------|-----------|
| **SMALLSERIAL** | SMALLINT + 序列 | 1 to 32,767 | SMALLINT AUTO_INCREMENT |
| **SERIAL** | INTEGER + 序列 | 1 to 2,147,483,647 | INT AUTO_INCREMENT |
| **BIGSERIAL** | BIGINT + 序列 | 1 to 9,223,372,036,854,775,807 | BIGINT AUTO_INCREMENT |

### SERIAL的本质

```sql
-- SERIAL是语法糖
CREATE TABLE test1 (
  id SERIAL
);

-- 等价于
CREATE SEQUENCE test1_id_seq;
CREATE TABLE test1 (
  id INTEGER NOT NULL DEFAULT nextval('test1_id_seq')
);
ALTER SEQUENCE test1_id_seq OWNED BY test1.id;
```

---

## 🔧 数据迁移后的处理

### 重要：重置序列

数据导入后，**必须**重置序列到当前最大值：

```sql
-- 方法1: 针对单个表
SELECT setval('ailpha_model_id_seq', (SELECT MAX(id) FROM ailpha_model));

-- 方法2: 使用辅助函数（推荐）
SELECT setval(
  pg_get_serial_sequence('ailpha_model', 'id'), 
  (SELECT MAX(id) FROM ailpha_model)
);

-- 方法3: 批量重置所有序列
DO $$
DECLARE
  r RECORD;
BEGIN
  FOR r IN 
    SELECT 
      table_name,
      column_name,
      pg_get_serial_sequence(table_name, column_name) as seq_name
    FROM information_schema.columns
    WHERE table_schema = 'public' 
      AND column_default LIKE 'nextval%'
  LOOP
    EXECUTE format(
      'SELECT setval(%L, COALESCE((SELECT MAX(%I) FROM %I), 1))',
      r.seq_name, r.column_name, r.table_name
    );
    RAISE NOTICE 'Reset sequence for %.%', r.table_name, r.column_name;
  END LOOP;
END $$;
```

### 为什么需要重置？

```sql
-- 场景：导入了ID为1-1000的数据
-- 但序列还在初始值1

INSERT INTO ailpha_model (uuid, type) VALUES ('test', 'test');
-- ❌ 错误：duplicate key value violates unique constraint
-- 因为序列返回1，但ID=1已存在

-- 重置序列后
SELECT setval(pg_get_serial_sequence('ailpha_model', 'id'), 1000);

INSERT INTO ailpha_model (uuid, type) VALUES ('test', 'test');
-- ✅ 成功：新ID=1001
```

---

## 📋 完整转换示例

### 示例1: 标准自增主键表

**MySQL**:
```sql
DROP TABLE IF EXISTS `ailpha_topology`;
CREATE TABLE `ailpha_topology` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uuid` varchar(255) NOT NULL COMMENT '名称',
  `dataStr` mediumtext NOT NULL COMMENT '数据',
  `startTime` varchar(255) NOT NULL COMMENT '起始时间',
  `endTime` varchar(255) NOT NULL COMMENT '结束时间',
  `srcAddressSize` smallint(12) NULL DEFAULT NULL,
  `destAddressSize` smallint(12) NULL DEFAULT NULL,
  `isError` tinyint(4) NOT NULL COMMENT '是否错误',
  `costTime` varchar(300) NULL DEFAULT '' COMMENT '花费时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 ROW_FORMAT = Dynamic;
```

**PostgreSQL**:
```sql
DROP TABLE IF EXISTS "ailpha_topology";
CREATE TABLE "ailpha_topology" (
  "id" BIGSERIAL,
  "uuid" VARCHAR(255) NOT NULL,
  "dataStr" TEXT NOT NULL,
  "startTime" VARCHAR(255) NOT NULL,
  "endTime" VARCHAR(255) NOT NULL,
  "srcAddressSize" SMALLINT NULL DEFAULT NULL,
  "destAddressSize" SMALLINT NULL DEFAULT NULL,
  "isError" SMALLINT NOT NULL,
  "costTime" VARCHAR(300) NULL DEFAULT '',
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ailpha_topology"."id" IS '主键';
COMMENT ON COLUMN "ailpha_topology"."uuid" IS '名称';
COMMENT ON COLUMN "ailpha_topology"."dataStr" IS '数据';
COMMENT ON COLUMN "ailpha_topology"."startTime" IS '起始时间';
COMMENT ON COLUMN "ailpha_topology"."endTime" IS '结束时间';
COMMENT ON COLUMN "ailpha_topology"."isError" IS '是否错误';
COMMENT ON COLUMN "ailpha_topology"."costTime" IS '花费时间';
```

**转换要点**:
1. ✅ `bigint(20) AUTO_INCREMENT` → `BIGSERIAL`
2. ✅ `mediumtext` → `TEXT`
3. ✅ `tinyint(4)` → `SMALLINT`
4. ✅ `ENGINE/AUTO_INCREMENT/CHARACTER SET/ROW_FORMAT` 全部移除
5. ✅ 注释单独提取为 `COMMENT ON COLUMN`

---

## ⚠️ 注意事项

### 1. 不要手动指定SERIAL列的值

**错误示例**:
```sql
-- 这样会破坏序列
INSERT INTO ailpha_model (id, uuid) VALUES (999, 'test');
```

**正确做法**:
```sql
-- 让PostgreSQL自动生成ID
INSERT INTO ailpha_model (uuid) VALUES ('test');

-- 或者如果确实需要指定，事后重置序列
INSERT INTO ailpha_model (id, uuid) VALUES (999, 'test');
SELECT setval('ailpha_model_id_seq', 999);
```

### 2. SERIAL不是真正的类型

```sql
-- 查看表结构
\d ailpha_model

-- 你会看到：
-- id | integer | not null default nextval('ailpha_model_id_seq'::regclass)
-- 实际类型是INTEGER，不是SERIAL
```

### 3. 备份和恢复

```bash
# pg_dump会正确处理SERIAL
pg_dump -U postgres dbname > backup.sql

# 恢复时序列会自动重置
psql -U postgres dbname < backup.sql
```

---

## 🎯 验证清单

转换完成后，使用以下SQL验证：

```sql
-- 1. 检查所有SERIAL列
SELECT 
  table_name,
  column_name,
  column_default
FROM information_schema.columns
WHERE column_default LIKE 'nextval%'
  AND table_schema = 'public'
ORDER BY table_name, ordinal_position;

-- 2. 检查所有主键
SELECT 
  tc.table_name,
  kcu.column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
  ON tc.constraint_name = kcu.constraint_name
WHERE tc.constraint_type = 'PRIMARY KEY'
  AND tc.table_schema = 'public'
ORDER BY tc.table_name;

-- 3. 检查所有序列及其当前值
SELECT 
  schemaname,
  sequencename,
  last_value,
  is_called
FROM pg_sequences
WHERE schemaname = 'public'
ORDER BY sequencename;

-- 4. 测试自增功能
-- 选择一个表测试
INSERT INTO ailpha_model (uuid, type, "modelName", "chineseName") 
VALUES ('test', 'test', 'test_model', 'test');

SELECT id, uuid FROM ailpha_model WHERE uuid = 'test';
-- 应该返回自动生成的ID

DELETE FROM ailpha_model WHERE uuid = 'test';
```

---

## 📚 参考资源

- [PostgreSQL SERIAL Types](https://www.postgresql.org/docs/16/datatype-numeric.html#DATATYPE-SERIAL)
- [Primary Keys in PostgreSQL](https://www.postgresql.org/docs/16/ddl-constraints.html#DDL-CONSTRAINTS-PRIMARY-KEYS)
- [Sequences](https://www.postgresql.org/docs/16/sql-createsequence.html)

---

**文档版本**: 1.0  
**最后更新**: 2026-01-14  
**适用于**: PostgreSQL 16.x
