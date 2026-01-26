# AlarmOutGoingConfig 测试文档

## 📋 测试概览

**表名**: `t_alarm_out_going_config`  
**Mapper**: `AlarmOutGoingConfigMapper.xml`  
**测试方法数**: 2个  
**测试数据条数**: 4条

---

## 🎯 测试方法列表

### 1. delById - 逻辑删除
- **方法签名**: `int delById(@Param("alarmOutGoingConfig") AlarmOutGoingConfig alarmOutGoingConfig)`
- **SQL语句**: 
  ```sql
  UPDATE t_alarm_out_going_config SET IS_DEL = 1 WHERE id = #{alarmOutGoingConfig.id}
  ```
- **功能**: 将指定ID的记录标记为已删除
- **测试要点**: 验证IS_DEL字段从0变为1

### 2. updateSendStatus - 更新发送状态
- **方法签名**: `int updateSendStatus(@Param("alarmOutGoingConfig") AlarmOutGoingConfig alarmOutGoingConfig)`
- **SQL语句**:
  ```sql
  UPDATE t_alarm_out_going_config
  SET last_send_time = CURRENT_TIMESTAMP,
      send_count = send_count + 1,
      last_send_result = #{alarmOutGoingConfig.lastSendResult},
      cause_of_failure = #{alarmOutGoingConfig.causeOfFailure}
      <if test="'成功' == alarmOutGoingConfig.lastSendResult">
          ,succeed_count = succeed_count +1
      </if>
  WHERE id = #{alarmOutGoingConfig.id}
  ```
- **功能**: 更新发送状态，成功时增加成功计数
- **测试要点**: 
  - 发送成功时：`send_count +1`, `succeed_count +1`
  - 发送失败时：`send_count +1`, `succeed_count 不变`

---

## 🗄️ 测试数据说明

| ID   | 用途                 | alarm_source   | enable | is_del | last_send_result | send_count | succeed_count |
|------|----------------------|----------------|--------|--------|------------------|------------|---------------|
| 1001 | 正常启用配置         | 防火墙, IDS    | 1      | 0      | 成功             | 10         | 8             |
| 1002 | 发送失败配置         | Web应用防火墙  | 1      | 0      | 失败             | 5          | 3             |
| 1003 | 已禁用配置           | 邮件网关       | 0      | 0      | 成功             | 20         | 20            |
| 1004 | 待删除配置           | 终端检测       | 1      | 0      | 成功             | 100        | 95            |

---

## 🚀 执行步骤

### 步骤1: 准备数据库
```bash
# 1. 执行建表SQL
psql -U dbapp -d your_database -f "C:\Users\wcss\Desktop\mysqlToPg\create_table\migrations_ultimate\V20260122133659_create_t_alarm_out_going_config.sql"

# 2. 插入测试数据
psql -U dbapp -d your_database -f "C:\Users\wcss\Desktop\mysqlToPg\test_data\AlarmOutGoingConfig_test_data.sql"
```

### 步骤2: 部署代码
1. 将 `AlarmOutGoingConfig.java` 放到项目的 `po` 包
2. 将 `AlarmOutGoingConfigMapper.java` 放到项目的 `mapper` 包
3. 将 `AlarmOutGoingConfigController.java` 放到项目的 `controller` 包
4. 确保 `AlarmOutGoingConfigMapper.xml` 在 `resources/mapper` 目录

### 步骤3: 启动应用
```bash
# 启动Spring Boot应用
mvn spring-boot:run
# 或
java -jar your-app.jar
```

### 步骤4: 导入Postman测试集合
1. 打开Postman
2. 点击 Import
3. 选择 `AlarmOutGoingConfig_Postman.json`
4. 修改变量中的 `baseUrl`（如果不是localhost:8080）

### 步骤5: 执行测试
按以下顺序执行Postman请求：

#### 测试1: 逻辑删除 (ID=1004)
```
DELETE http://localhost:8080/api/test/alarm-outgoing-config/delete/1004
```
**预期结果**:
```json
{
  "success": true,
  "method": "delById",
  "affectedRows": 1,
  "message": "逻辑删除成功",
  "testId": 1004
}
```

#### 测试2: 发送成功 (ID=1001)
```
POST http://localhost:8080/api/test/alarm-outgoing-config/update-status/success
Body: {"id": 1001}
```
**预期结果**:
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

#### 测试3: 发送失败 (ID=1002)
```
POST http://localhost:8080/api/test/alarm-outgoing-config/update-status/failure
Body: {"id": 1002, "causeOfFailure": "连接超时，无法访问目标服务器"}
```
**预期结果**:
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

#### 测试4: 完整流程 (ID=1003)
```
GET http://localhost:8080/api/test/alarm-outgoing-config/full-test/1003
```
**预期结果**:
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

## ✅ 验证SQL

执行以下SQL验证测试结果：

```sql
-- 查看所有测试数据的最终状态
SELECT 
    id,
    alarm_source,
    enable,
    is_del,
    last_send_result,
    cause_of_failure,
    send_count,
    succeed_count,
    last_send_time
FROM "t_alarm_out_going_config"
WHERE id >= 1001
ORDER BY id;

-- 预期结果：
-- ID 1001: send_count增加, succeed_count增加, last_send_result='成功'
-- ID 1002: send_count增加, succeed_count不变, last_send_result='失败', cause_of_failure有值
-- ID 1003: is_del=1, send_count增加2次
-- ID 1004: is_del=1
```

---

## 🔍 关键测试点

### PostgreSQL 特性验证

1. **CURRENT_TIMESTAMP 函数**
   - MySQL: `NOW()`
   - PostgreSQL: `CURRENT_TIMESTAMP`
   - 验证: 检查 `last_send_time` 字段是否正确更新

2. **整数类型布尔值**
   - 验证 `IS_DEL = 1` 能正常工作（不是 `IS_DEL = true`）

3. **MyBatis if 标签**
   - 验证 `<if test="'成功' == alarmOutGoingConfig.lastSendResult">` 条件判断
   - 成功时：succeed_count 应该增加
   - 失败时：succeed_count 不应该增加

4. **字段计数器**
   - 验证 `send_count = send_count + 1` 表达式
   - 验证 `succeed_count = succeed_count + 1` 表达式

---

## 📊 测试报告模板

| 测试项 | 测试方法 | 预期结果 | 实际结果 | 状态 |
|--------|----------|----------|----------|------|
| 逻辑删除 | delById | affectedRows=1, is_del=1 | | ☐ |
| 发送成功 | updateSendStatus | send_count+1, succeed_count+1 | | ☐ |
| 发送失败 | updateSendStatus | send_count+1, succeed_count不变 | | ☐ |
| 完整流程 | fullTest | 所有步骤成功 | | ☐ |

---

## 🐛 常见问题

### 问题1: 连接数据库失败
**解决**: 检查 `application.yml` 中的数据库配置，确保使用PostgreSQL驱动

### 问题2: XML 找不到
**解决**: 确保 `AlarmOutGoingConfigMapper.xml` 在 `resources/mapper` 目录，且配置了MyBatis扫描路径

### 问题3: 参数绑定错误
**解决**: 检查XML中的参数名是否为 `alarmOutGoingConfig`，与 `@Param` 注解一致

---

## 📝 下一步

1. ✅ 完成 `AlarmOutGoingConfig` 测试
2. ⬜ 继续生成其他39个XML文件的测试代码
3. ⬜ 建立自动化测试框架
4. ⬜ 生成整体测试报告

---

**生成时间**: 2026-01-22  
**工具**: MySQL to PostgreSQL 转换测试工具  
**版本**: v1.0
