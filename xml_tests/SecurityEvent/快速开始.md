# SecurityEvent 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 31 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_security_event`

---

## 📁 文件说明

```
SecurityEvent/
├── SecurityEventTestController.java    # 测试 Controller (所有方法都是 GET)
├── SecurityEvent.java                  # Mapper 接口
├── test_data.sql                       # 测试数据 SQL
└── 快速开始.md                         # 本文档
```

**注意**：实体类从项目中引用，不需要额外创建。

---

## 🚀 快速开始

### 1. 准备测试数据

```bash
psql -U postgres -d xdr22 -f test_data.sql
```

### 2. 复制文件到项目

```bash
cp SecurityEventTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp SecurityEvent.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/securityevent/`

---

## 📋 测试接口

1. `GET /test1_selectBaseInfoById` - 测试 selectBaseInfoById (select)
2. `GET /test2_selectEventAndTempById` - 测试 selectEventAndTempById (select)
3. `GET /test3_selectNewEventAndTempById` - 测试 selectNewEventAndTempById (select)
4. `GET /test4_queryEventById` - 测试 queryEventById (select)
5. `GET /test5_queryTrend` - 测试 queryTrend (select)
6. `GET /test6_selectAllByIdList` - 测试 selectAllByIdList (select)
7. `GET /test7_queryOverview` - 测试 queryOverview (select)
8. `GET /test8_selectEventAndTempByIds` - 测试 selectEventAndTempByIds (select)
9. `GET /test9_selectLogFieldsByIds` - 测试 selectLogFieldsByIds (select)
10. `GET /test10_getIncidentsTypePercent` - 测试 getIncidentsTypePercent (select)
11. `GET /test11_getSecurityEventList` - 测试 getSecurityEventList (select)
12. `GET /test12_getKillChain` - 测试 getKillChain (select)
13. `GET /test13_getSecurityEventListByFieldMapping` - 测试 getSecurityEventListByFieldMapping (select)
14. `GET /test14_getTotal` - 测试 getTotal (select)
15. `GET /test15_queryEventCount` - 测试 queryEventCount (select)
16. `GET /test16_queryByEventCode` - 测试 queryByEventCode (select)
17. `GET /test17_getExistThreadEvents` - 测试 getExistThreadEvents (select)
18. `GET /test18_queryThreadAlarm` - 测试 queryThreadAlarm (select)
19. `GET /test19_getMinTime` - 测试 getMinTime (select)
20. `GET /test20_getOneHourTime` - 测试 getOneHourTime (select)
21. `GET /test21_getSecurityEventOutGoingTemplate` - 测试 getSecurityEventOutGoingTemplate (select)
22. `GET /test22_insertOrUpdate` - 测试 insertOrUpdate (insert)
23. `GET /test23_updateStatus` - 测试 updateStatus (insert)
24. `GET /test24_batchInsert` - 测试 batchInsert (insert)
25. `GET /test25_insertBatchThreadEvents` - 测试 insertBatchThreadEvents (insert)
26. `GET /test26_insertBatchSecurityAlarm` - 测试 insertBatchSecurityAlarm (insert)
27. `GET /test27_updateAlarmResultById` - 测试 updateAlarmResultById (update)
28. `GET /test28_updateThreadLowPriority` - 测试 updateThreadLowPriority (update)
29. `GET /test29_deleteLowPriority` - 测试 deleteLowPriority (delete)
30. `GET /test30_deleteOneHourLeft` - 测试 deleteOneHourLeft (delete)
31. `GET /test31_deleteTimingTask` - 测试 deleteTimingTask (delete)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
