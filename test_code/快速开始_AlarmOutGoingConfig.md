# ⚡ 快速开始 - AlarmOutGoingConfig 测试

## 📦 生成的文件清单

```
test_data/
  └─ AlarmOutGoingConfig_test_data.sql          # 测试数据SQL（4条记录）

test_code/
  ├─ AlarmOutGoingConfig.java                    # 实体类（PO）
  ├─ AlarmOutGoingConfigMapper.java              # Mapper接口
  ├─ AlarmOutGoingConfigController.java          # Controller（测试接口）
  ├─ AlarmOutGoingConfig_Postman.json            # Postman测试集合
  └─ AlarmOutGoingConfig_测试说明.md             # 详细测试文档
```

---

## 🚀 5分钟快速测试

### 1️⃣ 准备数据库 (1分钟)

```bash
# PostgreSQL命令行执行
psql -U dbapp -d your_database

# 或者在Navicat中执行以下两个文件：
```

**文件1**: `C:\Users\wcss\Desktop\mysqlToPg\create_table\migrations_ultimate\V20260122133659_create_t_alarm_out_going_config.sql`
- 创建表结构、序列、函数、触发器

**文件2**: `C:\Users\wcss\Desktop\mysqlToPg\test_data\AlarmOutGoingConfig_test_data.sql`
- 插入4条测试数据

### 2️⃣ 部署代码 (2分钟)

```
1. 复制 AlarmOutGoingConfig.java → src/main/java/.../po/
2. 复制 AlarmOutGoingConfigMapper.java → src/main/java/.../mapper/
3. 复制 AlarmOutGoingConfigController.java → src/main/java/.../controller/
4. 确认 AlarmOutGoingConfigMapper.xml 在 resources/mapper/
```

### 3️⃣ 启动应用 (30秒)

```bash
mvn spring-boot:run
```

### 4️⃣ Postman测试 (1分钟30秒)

1. **导入集合**: 导入 `AlarmOutGoingConfig_Postman.json`
2. **执行测试**: 依次点击以下请求的 Send 按钮

---

## 🧪 测试用例速览

| # | 测试名称 | 方法 | URL | 预期结果 |
|---|----------|------|-----|----------|
| 1 | 逻辑删除 | DELETE | `/delete/1004` | is_del=1 |
| 2 | 发送成功 | POST | `/update-status/success` | send_count+1, succeed_count+1 |
| 3 | 发送失败 | POST | `/update-status/failure` | send_count+1, succeed_count不变 |
| 4 | 完整流程 | GET | `/full-test/1003` | 3步骤全部成功 |

---

## ✅ 关键验证点

### 验证1: IS_DEL 字段（整数类型）
```sql
-- XML中使用: IS_DEL = 1 （不是 true）
-- 验证: 删除后查询
SELECT id, is_del FROM t_alarm_out_going_config WHERE id = 1004;
-- 预期: is_del = 1
```

### 验证2: CURRENT_TIMESTAMP
```sql
-- XML中使用: CURRENT_TIMESTAMP （不是 NOW()）
-- 验证: 更新后查询
SELECT id, last_send_time FROM t_alarm_out_going_config WHERE id = 1001;
-- 预期: last_send_time 是最新时间
```

### 验证3: MyBatis IF 条件
```sql
-- XML中: <if test="'成功' == alarmOutGoingConfig.lastSendResult">
-- 验证: 发送成功时
SELECT id, send_count, succeed_count FROM t_alarm_out_going_config WHERE id = 1001;
-- 预期: 两个计数都增加

-- 验证: 发送失败时
SELECT id, send_count, succeed_count FROM t_alarm_out_going_config WHERE id = 1002;
-- 预期: 只有 send_count 增加
```

---

## 📋 Postman 请求详情

### 请求1: 逻辑删除
```
DELETE http://localhost:8080/api/test/alarm-outgoing-config/delete/1004
```

**响应示例**:
```json
{
  "success": true,
  "method": "delById",
  "affectedRows": 1,
  "message": "逻辑删除成功",
  "testId": 1004
}
```

### 请求2: 发送成功
```
POST http://localhost:8080/api/test/alarm-outgoing-config/update-status/success
Content-Type: application/json

{
  "id": 1001
}
```

**响应示例**:
```json
{
  "success": true,
  "method": "updateSendStatus",
  "scenario": "发送成功",
  "affectedRows": 1,
  "message": "更新发送状态成功，send_count +1, succeed_count +1",
  "testId": 1001,
  "lastSendResult": "成功"
}
```

### 请求3: 发送失败
```
POST http://localhost:8080/api/test/alarm-outgoing-config/update-status/failure
Content-Type: application/json

{
  "id": 1002,
  "causeOfFailure": "连接超时，无法访问目标服务器"
}
```

**响应示例**:
```json
{
  "success": true,
  "method": "updateSendStatus",
  "scenario": "发送失败",
  "affectedRows": 1,
  "message": "更新发送状态失败，send_count +1, succeed_count不变",
  "testId": 1002,
  "lastSendResult": "失败",
  "causeOfFailure": "连接超时，无法访问目标服务器"
}
```

### 请求4: 完整流程
```
GET http://localhost:8080/api/test/alarm-outgoing-config/full-test/1003
```

**响应示例**:
```json
{
  "testId": 1003,
  "step1_updateSuccess": 1,
  "step2_updateFailure": 1,
  "step3_delete": 1,
  "success": true,
  "message": "完整测试流程执行成功"
}
```

---

## 🎯 测试成功标准

- ✅ 所有请求返回 `"success": true`
- ✅ 所有 `affectedRows` 等于 1
- ✅ 数据库中数据变化符合预期
- ✅ 无SQL异常或错误日志

---

## 🔧 故障排查

### 问题: 返回 `"success": false`

**检查项**:
1. 数据库连接是否正常
2. 测试数据是否已插入（ID 1001-1004）
3. Mapper XML 文件是否被扫描到
4. 参数名是否匹配（alarmOutGoingConfig）

### 问题: 字段值没有更新

**检查项**:
1. PostgreSQL使用 `CURRENT_TIMESTAMP` 而不是 `NOW()`
2. IS_DEL 字段使用整数 1/0 而不是布尔值
3. MyBatis `<if>` 条件是否正确执行

---

## 📊 最终验证SQL

```sql
-- 执行所有测试后，运行此查询验证结果
SELECT 
    id,
    is_del,
    last_send_result,
    cause_of_failure,
    send_count,
    succeed_count,
    last_send_time
FROM "t_alarm_out_going_config"
WHERE id IN (1001, 1002, 1003, 1004)
ORDER BY id;

-- 预期结果：
-- 1001: send_count增加, succeed_count增加
-- 1002: send_count增加, succeed_count不变, cause_of_failure有值
-- 1003: is_del=1
-- 1004: is_del=1
```

---

## 🎉 下一步

测试通过后，可以：
1. 生成其他39个XML的测试代码
2. 建立自动化测试脚本
3. 记录测试报告

**需要帮助？** 查看详细文档: `AlarmOutGoingConfig_测试说明.md`
