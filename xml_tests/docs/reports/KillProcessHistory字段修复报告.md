# KillProcessHistory 字段不匹配修复报告

**修复时间**: 2026-01-28  
**问题模块**: KillProcessHistory  
**严重程度**: ⚠️ 高 - 表名和字段完全错误

---

## 📋 问题描述

`KillProcessHistory` 模块的 `test_data.sql` 存在**致命错误**：
1. ❌ **表名完全错误**: `t_kill_process_history` (应为 `t_process_kill_history`)
2. ❌ **字段名称完全不匹配**实际表结构
3. ❌ 缺失多个**必需字段**

---

## 🔍 问题详情

### 问题1: 表名错误

```sql
-- ❌ test_data.sql 使用的表名（错误）
INSERT INTO "t_kill_process_history" ...

-- ✅ XML Mapper 和建表SQL 使用的表名（正确）
INSERT INTO "t_process_kill_history" ...
```

**根本原因**: 未核对 XML Mapper 中的实际表名

---

### 问题2: 字段完全不匹配

#### 原 test_data.sql 字段（错误）
```sql
INSERT INTO "t_kill_process_history" (
    "id", 
    "host_ip",          -- ❌ 不存在
    "process_name",     -- ❌ 不存在
    "process_path",     -- ❌ 应为 image
    "kill_reason",      -- ❌ 应为 strategy_name
    "kill_status",      -- ❌ 不存在
    "kill_time",        -- ❌ 应为 last_occur_time
    "operator",         -- ❌ 应为 source
    "create_time"
) VALUES ...
```

#### 实际表结构字段（正确）

根据建表SQL `V20260122133659028__create_t_process_kill_history.sql`:

```sql
CREATE TABLE "t_process_kill_history" (
  "id" int8 NOT NULL,
  "strategy_id" int8 NOT NULL,           -- ✅ 策略ID
  "strategy_name" varchar(255) NOT NULL,  -- ✅ 策略名称
  "node_ip" varchar(255) NOT NULL,        -- ✅ 终端IP
  "node_id" varchar(255) NOT NULL,        -- ✅ 联动设备ID
  "os_str" varchar(128) NOT NULL,         -- ✅ 操作系统
  "device_ip" varchar(16) NOT NULL,       -- ✅ 联动设备IP
  "device_id" varchar(255) NOT NULL,      -- ✅ 联动设备id
  "device_type" varchar(255),             -- ✅ 联动设备类型
  "action" t_process_kill_history_action NOT NULL,  -- ✅ 枚举
  "process_id" varchar(255),              -- ✅ 进程id
  "image" text,                           -- ✅ 进程路径
  "last_occur_time" timestamp(6) NOT NULL,
  "create_time" timestamp(6) NOT NULL,
  "update_time" timestamp(6) NOT NULL,
  "source" varchar(255) NOT NULL
);
```

---

### 问题3: action 枚举类型

```sql
-- 定义的枚举类型
CREATE TYPE "t_process_kill_history_action" AS ENUM (
  '病毒查杀',
  '未知'
);
```

**只能使用这两个值**，其他任何值都会导致插入失败！

---

## 📊 字段对比表

| 原字段 (错误) | 实际字段 (正确) | 类型 | 说明 |
|--------------|----------------|------|------|
| `host_ip` | `node_ip` | varchar(255) | 终端IP |
| `process_name` | - | - | **不存在此字段** |
| `process_path` | `image` | text | 进程路径 |
| `kill_reason` | `strategy_name` | varchar(255) | 策略名称 |
| `kill_status` | - | - | **不存在此字段** |
| `kill_time` | `last_occur_time` | timestamp | 时间 |
| `operator` | `source` | varchar(255) | 来源 |
| ❌ 缺失 | `strategy_id` | int8 | **必需** |
| ❌ 缺失 | `node_id` | varchar(255) | **必需** |
| ❌ 缺失 | `os_str` | varchar(128) | **必需** |
| ❌ 缺失 | `device_ip` | varchar(16) | **必需** |
| ❌ 缺失 | `device_id` | varchar(255) | **必需** |
| ❌ 缺失 | `device_type` | varchar(255) | 可选 |
| ❌ 缺失 | `action` | enum | **必需(枚举)** |
| ❌ 缺失 | `process_id` | varchar(255) | 可选 |
| ❌ 缺失 | `update_time` | timestamp | 自动 |

---

## 🔧 修复措施

### 1. 修复表名

```sql
-- ❌ 修复前
DELETE FROM "t_kill_process_history" WHERE ...
INSERT INTO "t_kill_process_history" ...

-- ✅ 修复后
DELETE FROM "t_process_kill_history" WHERE ...
INSERT INTO "t_process_kill_history" ...
```

### 2. 重写 test_data.sql - 完整字段

```sql
INSERT INTO "t_process_kill_history" (
    "id",
    "strategy_id",          -- 新增
    "strategy_name",        -- 新增
    "node_ip",              -- 替代 host_ip
    "node_id",              -- 新增
    "os_str",               -- 新增
    "device_ip",            -- 新增
    "device_id",            -- 新增
    "device_type",          -- 新增
    "action",               -- 新增（枚举）
    "process_id",           -- 新增
    "image",                -- 替代 process_path
    "last_occur_time",      -- 替代 kill_time
    "create_time",
    "update_time",          -- 新增
    "source"                -- 替代 operator
) VALUES
(4001, 2001, '进程终止策略-勒索软件防护', '192.168.50.200', 'node-win-001',
 'Windows 10 Enterprise', '192.168.1.10', 'device-edr-001', 'endpoint',
 '病毒查杀', '1234', 'C:\Temp\malware.exe',
 CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '1 hour',
 CURRENT_TIMESTAMP - INTERVAL '1 hour', 'auto');
```

**关键改进**:
- ✅ 修正表名
- ✅ 修正所有字段名称
- ✅ 添加所有必需字段
- ✅ 使用正确的枚举值 (`'病毒查杀'`, `'未知'`)
- ✅ 更改测试ID范围：1001-1003 → 4001-4005
- ✅ 增加测试场景：3个 → 5个

### 3. 修复 KillProcessHistoryTestController.java

#### 问题1: 错误的 action 枚举值
```java
// ❌ 修复前
history.setAction("kill");  // 不是有效的枚举值

// ✅ 修复后
history.setAction("病毒查杀");  // 正确的枚举值
```

#### 问题2: 错误的测试策略ID
```java
// ❌ 修复前
history.setStrategyId(4001);  // test_data.sql 中不存在此策略ID
List<Integer> strategyIds = Arrays.asList(4001, 4002, 4003);

// ✅ 修复后
history.setStrategyId(2001);  // 对应 test_data.sql 中的策略ID
List<Integer> strategyIds = Arrays.asList(2001, 2002, 2003);
```

---

## 📊 测试数据覆盖情况

新的 `test_data.sql` 包含 **5 个测试场景**:

| ID | 策略ID | 操作系统 | 进程路径 | 动作 | 来源 | 说明 |
|----|--------|---------|---------|------|------|------|
| 4001 | 2001 | Windows 10 | C:\Temp\malware.exe | 病毒查杀 | auto | 勒索软件进程 |
| 4002 | 2001 | Windows Server | C:\Users\Public\miner.exe | 病毒查杀 | auto | 挖矿木马 |
| 4003 | 2002 | CentOS 7.9 | /tmp/suspicious | 病毒查杀 | manual | 手动查杀 |
| 4004 | 2003 | Ubuntu 20.04 | /var/tmp/evil.sh | 病毒查杀 | template | Linux脚本 |
| 4005 | 2003 | macOS Monterey | /Applications/.../suspicious | 未知 | manual | 测试枚举 |

**覆盖场景**:
- ✅ 3 种操作系统平台 (Windows, Linux, macOS)
- ✅ 2 种查杀动作 (病毒查杀, 未知)
- ✅ 3 种策略来源 (auto, manual, template)
- ✅ 3 个不同策略ID (2001, 2002, 2003)
- ✅ 不同文件路径格式 (Windows, Linux, macOS)

---

## ✅ 验证步骤

### 1. 执行测试数据
```bash
psql -U postgres -d xdr22 -f xml_tests/KillProcessHistory/test_data.sql
```

### 2. 验证数据插入
```sql
SELECT * FROM "t_process_kill_history" WHERE id >= 4001 AND id <= 4005 ORDER BY id;
```

**预期结果**: 5 条记录

### 3. 测试 Controller 接口

#### 测试1: 批量插入
```http
GET http://localhost:8080/test/killProcessHistory/batchInsert
```

**预期**: `SUCCESS: 插入 1 条`

#### 测试2: 统计策略启动次数
```http
GET http://localhost:8080/test/killProcessHistory/countLaunchTimesByStrategyId
```

**预期**: `SUCCESS: 查询到 3 个策略`

---

## 📝 关键学习点

### 1. **必须核对 XML Mapper 中的表名**

**教训**: 编写测试数据前，务必查看：
1. XML Mapper 文件中的 `<insert>`, `<select>` 等标签
2. 确认表名与建表SQL完全一致

**示例**:
```xml
<!-- KillProcessHistoryMapper.xml -->
<insert id="batchInsert">
    INSERT INTO t_process_kill_history (  <!-- ✅ 这里是准确的表名 -->
        strategy_id, strategy_name, ...
    )
</insert>
```

### 2. **枚举类型必须精确匹配**

PostgreSQL 枚举类型对值非常严格：

```sql
-- 定义
CREATE TYPE "t_process_kill_history_action" AS ENUM (
  '病毒查杀',
  '未知'
);

-- ✅ 正确使用
history.setAction("病毒查杀");

-- ❌ 错误使用 - 会导致数据库错误
history.setAction("kill");
history.setAction("病毒杀查");  -- 错别字也不行！
```

### 3. **必需字段的完整性**

标记为 `NOT NULL` 的字段**必须**提供：
- `strategy_id`, `strategy_name`
- `node_ip`, `node_id`, `os_str`
- `device_ip`, `device_id`
- `action` (枚举)
- `source`

### 4. **表名命名规律**

观察到的规律：
- `t_isolation_history` - 主机隔离
- `t_process_kill_history` - 进程终止 (不是 `t_kill_process_history`)

**结论**: 表名通常是 `t_{动作}_{对象}_history`，而不是 `t_{对象}_{动作}_history`

---

## 🎯 总结

### 修复成果
- ✅ 修复了 **表名错误**
- ✅ 修正了 **8 个字段名**
- ✅ 添加了 **8 个缺失的必需字段**
- ✅ 修正了 **枚举类型值**
- ✅ 调整了 **测试ID范围** (1001-1003 → 4001-4005)
- ✅ 增加了 **测试场景覆盖** (3个 → 5个)

### 影响范围
- **test_data.sql**: 完全重写 ✅
- **KillProcessHistoryTestController.java**: 修复 action 和 strategyId ✅
- **修复报告**: 新增 ✅

### 防范措施
**编写测试数据的正确流程**:
1. 📖 查看 XML Mapper 确认**表名**
2. 📖 查看建表SQL确认**字段结构**
3. 📝 编写 test_data.sql
4. 🧪 验证测试
5. 📄 更新文档

---

**修复完成时间**: 2026-01-28  
**修复人**: AI Assistant  
**状态**: ✅ 完成，待测试验证

---

## ⚠️ 重要提醒

根据这两个模块的问题（IsolationHistory 和 KillProcessHistory），**建议检查其他 linkageHandle 相关模块**:

可能存在类似问题的模块:
- ProhibitHistory
- NoticeHistory
- ScanHistory
- ScanHistoryDetail
- VirusKillHistory
- ...

**检查方法**:
```bash
# 1. 找出 test_data.sql 中使用的表名
grep "INSERT INTO" xml_tests/*/test_data.sql

# 2. 对比 XML Mapper 中的表名
grep "INSERT INTO\|FROM" postgresql_xml_manual/*Mapper.xml
```
