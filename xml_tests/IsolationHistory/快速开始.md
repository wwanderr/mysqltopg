# IsolationHistory 快速测试指南

**生成时间**: 2026-01-28  
**测试方法数**: 2 个  
**测试数据范围**: ID 3001-3005  
**对应表**: `t_isolation_history` (主机隔离下发记录表)

---

## 📁 文件说明

```
IsolationHistory/
├── IsolationHistoryTestController.java    # 测试 Controller (所有方法都是 GET)
├── IsolationHistoryMapper.java            # Mapper 接口
├── test_data.sql                           # 测试数据 SQL
└── 快速开始.md                             # 本文档
```

**注意**：实体类从项目中引用，不需要额外创建。

---

## 📊 表结构说明

### t_isolation_history 主要字段

| 字段名 | 类型 | 说明 | 是否必需 |
|--------|------|------|---------|
| `id` | int8 | 主键ID | 自动生成 |
| `strategy_id` | int8 | 策略ID | ✅ 必需 |
| `strategy_name` | varchar(255) | 策略名称 | ✅ 必需 |
| `node_ip` | varchar(255) | 终端操作系统IP | ✅ 必需 |
| `node_id` | varchar(255) | 联动设备ID | ✅ 必需 |
| `os_str` | varchar(128) | 终端操作系统类型 | ✅ 必需 |
| `device_ip` | varchar(16) | 联动设备IP | ✅ 必需 |
| `device_id` | varchar(255) | 联动设备id | ✅ 必需 |
| `device_type` | varchar(255) | 联动设备类型 | 可选 |
| `action` | enum | 下发的主机动作 | ✅ 必需 (枚举) |
| `last_occur_time` | timestamp | 最后一次时间 | 自动 |
| `create_time` | timestamp | 创建时间 | 自动 |
| `update_time` | timestamp | 更新时间 | 自动 |
| `source` | varchar(255) | 策略来源 | 自动 |

### action 枚举类型值

- `'主机一键隔离'`
- `'主机取消隔离'`
- `'未知'` (默认值)

---

## 🚀 快速开始

### 1. 准备测试数据

```bash
psql -U postgres -d xdr22 -f test_data.sql
```

或使用 DBeaver / pgAdmin 执行 `test_data.sql`

### 2. 复制文件到项目

```bash
cp IsolationHistoryTestController.java <项目路径>/src/main/java/com/test/controller/
cp IsolationHistoryMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/linkageHandle/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

---

## 📋 测试接口清单

### 测试1：批量插入隔离记录
**URL**: `GET /test/isolationHistory/batchInsert`  
**方法**: `batchInsert`  
**说明**: 批量插入主机隔离记录

**测试参数** (硬编码):
- strategyId: 2001
- strategyName: "终端隔离策略-测试"
- nodeIp: "192.168.50.200"
- nodeId: "node-test-001"
- osStr: "Windows 10"
- deviceIp: "192.168.1.10"
- deviceId: "device-test-001"
- deviceType: "endpoint"
- action: "主机一键隔离"
- source: "auto"

**预期响应**:
```
SUCCESS: 插入 1 条
```

---

### 测试2：按策略ID统计启动次数
**URL**: `GET /test/isolationHistory/countLaunchTimesByStrategyId`  
**方法**: `countLaunchTimesByStrategyId`  
**说明**: 统计指定策略ID的隔离操作次数

**测试参数** (硬编码):
- strategyIds: [2001, 2002, 2003]

**预期响应**:
```
SUCCESS: 查询到 3 个策略
```

**控制台输出示例**:
```
结果: 共 3 个策略的统计
  - 策略ID=2001, 次数=2
  - 策略ID=2002, 次数=1
  - 策略ID=2003, 次数=2
```

---

## 🧪 使用 Postman 测试

### 示例请求 1：批量插入

```http
GET http://localhost:8080/test/isolationHistory/batchInsert
```

**预期响应**:
```
SUCCESS: 插入 1 条
```

### 示例请求 2：统计策略启动次数

```http
GET http://localhost:8080/test/isolationHistory/countLaunchTimesByStrategyId
```

**预期响应**:
```
SUCCESS: 查询到 3 个策略
```

---

## 📝 测试数据说明

`test_data.sql` 包含 5 条测试数据 (ID: 3001-3005):

1. **ID 3001**: 勒索软件感染 - 主机隔离 (Windows)
2. **ID 3002**: 僵尸网络通信 - 主机取消隔离 (Windows Server)
3. **ID 3003**: 异常外连行为 - 主机隔离 (CentOS)
4. **ID 3004**: 高危漏洞响应 - 主机隔离 (Ubuntu)
5. **ID 3005**: 未知动作 - 测试枚举默认值 (macOS)

涵盖了：
- ✅ 不同操作系统类型 (Windows, Linux, macOS)
- ✅ 不同隔离动作 (隔离, 取消隔离, 未知)
- ✅ 不同策略来源 (auto, manual, template)
- ✅ 不同策略ID (2001, 2002, 2003)

---

## ⚠️ 重要注意事项

### 1. action 枚举值
`action` 字段是枚举类型，**只能使用以下值**:
- `'主机一键隔离'`
- `'主机取消隔离'`
- `'未知'`

❌ **错误示例**: `action = 'isolate'` (会导致插入失败)  
✅ **正确示例**: `action = '主机一键隔离'`

### 2. 必需字段
以下字段**不能为 null**:
- `strategy_id`
- `strategy_name`
- `node_ip`
- `node_id`
- `os_str`
- `device_ip`
- `device_id`

### 3. 时间字段
- `last_occur_time`, `create_time`, `update_time` 会自动设置为 `CURRENT_TIMESTAMP`
- 测试数据中使用 `INTERVAL` 来模拟不同时间点

### 4. 异常处理
所有测试方法都包含 try-catch，错误信息会以 JSON 格式返回：
```json
{
  "error": "测试方法 testBatchInsert 执行失败",
  "exception": "org.mybatis.spring.MyBatisSystemException",
  "message": "Error querying database..."
}
```

---

## 🔗 相关文件

- **Mapper XML**: `C:\Users\wcss\Desktop\mysqlToPg\postgresql_xml_manual\IsolationHistoryMapper.xml`
- **建表SQL**: `C:\Users\wcss\Desktop\mysqlToPg\create_table\migrations_ultimate\V20260122133659019__create_t_isolation_history.sql`
- **测试框架文档**: `C:\Users\wcss\Desktop\mysqlToPg\xml_tests\XML测试框架使用指南.md`

---

**最后更新**: 2026-01-28  
**状态**: ✅ 已修复字段不匹配问题
