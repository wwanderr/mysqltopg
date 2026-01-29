# BlockHistory 测试快速开始

## 📋 测试概览

- **表名**: `t_block_history`
- **Mapper**: `BlockHistoryMapper.java`
- **Controller**: `BlockHistoryTestController.java`
- **测试数据**: `test_data.sql`
- **测试方法数**: 11个
- **测试数据ID范围**: 1001-1010

## 🚀 快速开始步骤

### 步骤1：插入测试数据

连接到 PostgreSQL 数据库，执行 `test_data.sql`：

```bash
psql -U dbapp -d your_database -f test_data.sql
```

或在 pgAdmin/DBeaver 中直接执行 `test_data.sql` 的内容。

**预期结果**：插入 10 条测试数据（ID: 1001-1010）

### 步骤2：验证数据

```sql
-- 查看测试数据
SELECT id, strategy_id, link_device_ip, src_address, dest_address, launch_times
FROM t_block_history
WHERE id >= 1001 AND id <= 1010
ORDER BY id;

-- 预期：返回 10 条记录
```

### 步骤3：启动应用

```bash
mvn spring-boot:run
```

### 步骤4：测试接口

使用 Postman 或浏览器访问以下 URL（全部使用 **GET** 请求）：

## 📡 测试接口清单

### 1. 按策略ID汇总启动次数
```
GET http://localhost:8080/test/blockHistory/sumLaunchTimesByStrategyId
```
**说明**: 汇总策略ID 5001、5002、5003 的启动次数  
**预期**: 返回 3-5 条策略统计数据

---

### 2. 插入封堵历史记录
```
GET http://localhost:8080/test/blockHistory/insertBlockHistory
```
**说明**: 插入一条新的封堵历史记录（策略ID: 5001）  
**预期**: 返回 "SUCCESS: 插入 1 条记录"

---

### 3. 查询封堵列表数量
```
GET http://localhost:8080/test/blockHistory/getBlockListCount
```
**说明**: 查询策略ID=5001 且设备IP=192.168.1.10 的记录数量  
**预期**: 返回 4 条（1001, 1002, 1005, 1008）

---

### 4. 查询封堵历史列表（分页）
```
GET http://localhost:8080/test/blockHistory/getBlockHistory
```
**说明**: 分页查询策略ID=5001 的封堵历史（按启动时间降序）  
**预期**: 返回 4 条记录，包含详细信息

---

### 5. 按IP查询历史记录
```
GET http://localhost:8080/test/blockHistory/getHistoryByIp
```
**说明**: 查询设备IP=192.168.1.10，源地址=203.0.113.100，目标地址=192.168.10.50  
**预期**: 返回 1 条记录（ID: 1001）

---

### 6. 按条件查询封堵历史
```
GET http://localhost:8080/test/blockHistory/getBlockHistoryByCondition
```
**说明**: 查询策略ID=5001 且设备IP=192.168.1.10  
**预期**: 返回 4 条记录

---

### 7. 按策略ID查询历史记录
```
GET http://localhost:8080/test/blockHistory/getHistoryByStrategyId
```
**说明**: 查询策略ID=5001 的所有历史记录  
**预期**: 返回 4 条记录

---

### 8. 按ID列表查询历史记录
```
GET http://localhost:8080/test/blockHistory/getHistoryByIds
```
**说明**: 查询 ID=1001, 1002, 1003 的记录  
**预期**: 返回 3 条记录

---

### 9. 按ID删除历史记录
```
GET http://localhost:8080/test/blockHistory/deleteHistoryById
```
**说明**: 删除 ID=1005 的记录  
**预期**: 返回 "SUCCESS: 删除了 1 条记录"  
**注意**: 再次调用会返回 0（记录已删除）

---

### 10. 更新设备IP和ID
```
GET http://localhost:8080/test/blockHistory/updateDeviceIpAndId
```
**说明**: 将 device_id 从 'old-device-001' 更新为 'new-device-001'  
**预期**: 返回 "SUCCESS: 更新完成"  
**影响**: ID=1010 的记录

---

### 11. 按策略ID查询ID列表
```
GET http://localhost:8080/test/blockHistory/getIdsByStrategyId
```
**说明**: 查询策略ID=5001 的所有记录ID  
**预期**: 返回 [1001, 1002, 1005, 1008]

---

## 📊 测试数据说明

### 策略分布
- **策略 5001**: 4条记录（1001, 1002, 1005, 1008），主要设备IP: 192.168.1.10
- **策略 5002**: 2条记录（1003, 1006），设备IP: 192.168.1.20
- **策略 5003**: 2条记录（1004, 1007），设备IP: 192.168.1.30, 192.168.1.100
- **策略 5004**: 1条记录（1009），设备IP: 192.168.1.40
- **策略 5005**: 1条记录（1010），设备IP: 192.168.1.50

### 特殊测试场景
1. **记录 1001**: DDoS攻击源，launch_times=3，用于测试多次下发
2. **记录 1002**: APT攻击，手动创建（create_type='manual'）
3. **记录 1003**: IP段扫描，ACL封堵
4. **记录 1004**: 勒索软件，IPS联动，launch_times=5
5. **记录 1005**: 双向封堵（src和dest与1001互换），用于测试删除
6. **记录 1006**: 持续攻击，launch_times=8（最多下发次数）
7. **记录 1007**: DNS恶意域名，域名格式测试
8. **记录 1008**: Web攻击，update_time与create_time不同
9. **记录 1009**: WAF检测，OWASP Top10
10. **记录 1010**: device_id='old-device-001'，用于测试设备迁移更新

## 🔍 常见问题

### Q1: 返回 0 条数据
**原因**: 测试数据未插入  
**解决**: 执行 `test_data.sql`

### Q2: 删除测试（接口9）第二次调用返回 0
**原因**: 正常现象，记录已被第一次调用删除  
**解决**: 重新执行 `test_data.sql` 恢复数据

### Q3: 更新测试（接口10）没有影响
**原因**: device_id='old-device-001' 的记录可能已更新过  
**解决**: 重新执行 `test_data.sql` 恢复数据

### Q4: Mapper 注入失败
**原因**: Mapper 扫描路径配置问题  
**解决**: 在 `application.yml` 中配置：
```yaml
mybatis:
  mapper-locations: classpath*:**/*Mapper.xml
  type-aliases-package: com.dbapp.extension.xdr.**.entity

# 确保启动类有 @MapperScan 注解
@MapperScan("com.dbapp.extension.xdr.**.mapper")
```

## 📝 字段映射说明

### 数据库字段 → Java 实体类（驼峰自动映射）

| 数据库字段 | Java字段 | 类型 | 说明 |
|-----------|---------|------|------|
| id | id | Long | 主键 |
| strategy_id | strategyId | Integer | 策略ID |
| link_device_ip | linkDeviceIp | String | 联动设备IP |
| link_device_type | linkDeviceType | String | 设备类型 |
| device_id | deviceId | String | 设备编号 |
| src_address | srcAddress | String | 源地址 |
| dest_address | destAddress | String | 目标地址 |
| content | content | String | 命中内容 |
| create_type | createType | String | 创建方式 |
| launch_times | launchTimes | Integer | 下发次数 |
| nta_name | ntaName | String | NTA名称 |
| create_time | createTime | Timestamp | 创建时间 |
| update_time | updateTime | Timestamp | 更新时间 |

**注意**: 确保 MyBatis 配置了下划线转驼峰：
```yaml
mybatis:
  configuration:
    map-underscore-to-camel-case: true
```

## 🎯 覆盖率

本测试套件覆盖了 BlockHistoryMapper 的**所有 11 个方法**：
- ✅ sumLaunchTimesByStrategyId
- ✅ insertBlockHistory
- ✅ getBlockListCount
- ✅ getBlockHistory
- ✅ getHistoryByIp
- ✅ getBlockHistoryByCondition
- ✅ getHistoryByStrategyId
- ✅ getHistoryByIds
- ✅ deleteHistoryById
- ✅ updateDeviceIpAndId
- ✅ getIdsByStrategyId

## 📌 注意事项

1. **参数已硬编码**: 所有测试方法的参数都在代码中写死，无需 Postman 传参
2. **GET 请求**: 所有接口都使用 GET 请求，方便浏览器直接测试
3. **控制台输出**: 每个方法都会在控制台输出详细的测试信息
4. **幂等性**: 除了删除和插入操作，其他查询操作可多次执行
5. **数据恢复**: 如需重置测试数据，重新执行 `test_data.sql` 即可

生成时间：2026-01-26
