# AlarmOutGoingConfig 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 2 个  
**测试数据范围**: ID 1001-1005  
**对应表**: `t_alarm_out_going_config`

---

## 📁 文件说明

```
AlarmOutGoingConfig/
├── AlarmOutGoingConfigTestController.java  # 测试 Controller (所有方法都是 GET)
├── AlarmOutGoingConfigMapper.java          # Mapper 接口
├── test_data.sql                           # 测试数据 SQL (5条丰富数据)
└── 快速开始.md                             # 本文档
```

**注意**：实体类从项目中引用，不需要额外创建。

---

## 🚀 快速开始

### 1. 准备测试数据

```bash
psql -U postgres -d xdr22 -f test_data.sql
```

**测试数据包含**：
- ✅ 5 条测试记录（ID: 1001-1005）
- ✅ 字段非常丰富，包含 JSON 数组
- ✅ 多种场景：成功、失败、禁用、待删除、新配置

### 2. 复制文件到项目

```bash
cp AlarmOutGoingConfigTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp AlarmOutGoingConfigMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/alarmoutgoingconfig/`

---

## 📋 测试接口

### 接口列表

```
GET http://localhost:8080/test/alarmoutgoingconfig/
```

### 测试方法

1. `GET /test1_delById` - 删除告警外发配置（逻辑删除）
2. `GET /test2_updateSendStatus` - 更新发送状态

---

## 📝 测试详情

### 测试1：delById

**URL**: `http://localhost:8080/test/alarmoutgoingconfig/test1_delById`

**场景**: 删除 ID=1004 的配置  
**预期**: `is_del` 从 0 变为 1

**验证 SQL**:
```sql
SELECT id, is_del FROM t_alarm_out_going_config WHERE id = 1004;
-- 预期：is_del = 1
```

---

### 测试2：updateSendStatus

**URL**: `http://localhost:8080/test/alarmoutgoingconfig/test2_updateSendStatus`

**场景**: ID=1001 发送成功  
**预期**:
- `last_send_time` 更新为当前时间
- `send_count` +1
- `last_send_result` = "成功"
- `succeed_count` +1（因为成功）

**验证 SQL**:
```sql
SELECT 
    id, 
    send_count, 
    succeed_count, 
    last_send_result,
    last_send_time
FROM t_alarm_out_going_config 
WHERE id = 1001;
```

---

## 📊 测试数据说明

| ID | 场景 | 状态 | 说明 |
|----|------|------|------|
| 1001 | 正常配置 | 启用 | 用于测试成功发送 |
| 1002 | 发送失败 | 启用 | 连接超时 |
| 1003 | 已禁用 | 禁用 | enable=0 |
| 1004 | 待删除 | 启用 | 用于测试删除操作 |
| 1005 | 全新配置 | 启用 | send_count=0，从未发送 |

---

## 🔍 XML 方法说明

### delById

```xml
<update id="delById">
    UPDATE t_alarm_out_going_config 
    SET IS_DEL = 1 
    WHERE id = #{alarmOutGoingConfig.id}
</update>
```

- 逻辑删除，不是物理删除
- 使用嵌套参数：`#{alarmOutGoingConfig.id}`

---

### updateSendStatus

```xml
<update id="updateSendStatus">
    UPDATE t_alarm_out_going_config
    SET last_send_time = CURRENT_TIMESTAMP,
        send_count = send_count + 1,
        last_send_result = #{alarmOutGoingConfig.lastSendResult},
        cause_of_failure = #{alarmOutGoingConfig.causeOfFailure}
    <if test="'成功' == alarmOutGoingConfig.lastSendResult">
        ,succeed_count = succeed_count +1
    </if>
    WHERE id = #{alarmOutGoingConfig.id}
</update>
```

- 自动更新时间和计数器
- 根据发送结果决定是否增加成功次数
- 使用动态 SQL

---

## ✅ 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1005

---

完整使用说明请参考：`XML测试框架使用指南.md`
