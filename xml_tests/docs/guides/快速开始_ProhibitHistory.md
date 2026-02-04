# ProhibitHistory 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 37 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_prohibit_history`

---

## 📁 文件说明

```
ProhibitHistory/
├── ProhibitHistoryTestController.java    # 测试 Controller (所有方法都是 GET)
├── ProhibitHistoryMapper.java                  # Mapper 接口
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
cp ProhibitHistoryTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp ProhibitHistoryMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/prohibithistory/`

---

## 📋 测试接口

1. `GET /test1_sumLaunchTimesByStrategyId` - 测试 sumLaunchTimesByStrategyId (select)
2. `GET /test2_getProhibitListByCondition` - 测试 getProhibitListByCondition (select)
3. `GET /test3_listByCondition` - 测试 listByCondition (select)
4. `GET /test4_getProhibitListCount` - 测试 getProhibitListCount (select)
5. `GET /test5_getBlockIPDistribution` - 测试 getBlockIPDistribution (select)
6. `GET /test6_getTrend` - 测试 getTrend (select)
7. `GET /test7_getBlockIPCount` - 测试 getBlockIPCount (select)
8. `GET /test8_getBlockIPTodayCount` - 测试 getBlockIPTodayCount (select)
9. `GET /test9_getAutoBlockIPCount` - 测试 getAutoBlockIPCount (select)
10. `GET /test10_getAutoBlockIPTodayCount` - 测试 getAutoBlockIPTodayCount (select)
11. `GET /test11_getTriggerSubscriptionCount` - 测试 getTriggerSubscriptionCount (select)
12. `GET /test12_getStrategyCount` - 测试 getStrategyCount (select)
13. `GET /test13_getProhibitListByDeviceId` - 测试 getProhibitListByDeviceId (select)
14. `GET /test14_getPairHistories` - 测试 getPairHistories (select)
15. `GET /test15_getSingleHistories` - 测试 getSingleHistories (select)
16. `GET /test16_getHistoryByBlockList` - 测试 getHistoryByBlockList (select)
17. `GET /test17_getHistoryById` - 测试 getHistoryById (select)
18. `GET /test18_getUnsealIpTodayCount` - 测试 getUnsealIpTodayCount (select)
19. `GET /test19_findHistoriesByDomain` - 测试 findHistoriesByDomain (select)
20. `GET /test20_findEdrProhibitHistory` - 测试 findEdrProhibitHistory (select)
21. `GET /test21_findEdrProhibitHistories` - 测试 findEdrProhibitHistories (select)
22. `GET /test22_getAiGentNoDirectionHistory` - 测试 getAiGentNoDirectionHistory (select)
23. `GET /test23_getAiGentNoDirectionHistories` - 测试 getAiGentNoDirectionHistories (select)
24. `GET /test24_getAiGentDirectionHistories` - 测试 getAiGentDirectionHistories (select)
25. `GET /test25_getAiGentProhibitDomain` - 测试 getAiGentProhibitDomain (select)
26. `GET /test26_prohibitListByStrategyId` - 测试 prohibitListByStrategyId (select)
27. `GET /test27_getIdsByStrategyId` - 测试 getIdsByStrategyId (select)
28. `GET /test28_getBlockDeviceIds` - 测试 getBlockDeviceIds (select)
29. `GET /test29_getBlockDeviceIps` - 测试 getBlockDeviceIps (select)
30. `GET /test30_countEdrProhibit` - 测试 countEdrProhibit (select)
31. `GET /test31_getDomainList` - 测试 getDomainList (select)
32. `GET /test32_insertProhibitHistory` - 测试 insertProhibitHistory (insert)
33. `GET /test33_updateByBlockipAndDeviceIp` - 测试 updateByBlockipAndDeviceIp (update)
34. `GET /test34_updateStatusById` - 测试 updateStatusById (update)
35. `GET /test35_updateDeviceIpAndId` - 测试 updateDeviceIpAndId (update)
36. `GET /test36_deleteByIds` - 测试 deleteByIds (delete)
37. `GET /test37_deleteByStrategyId` - 测试 deleteByStrategyId (delete)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
