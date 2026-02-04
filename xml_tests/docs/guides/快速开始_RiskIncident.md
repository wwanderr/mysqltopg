# RiskIncident 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 30 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_risk_incident`

---

## 📁 文件说明

```
RiskIncident/
├── RiskIncidentTestController.java    # 测试 Controller (所有方法都是 GET)
├── RiskIncidentMapper.java                  # Mapper 接口
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
cp RiskIncidentTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp RiskIncidentMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/riskincident/`

---

## 📋 测试接口

1. `GET /test1_aggClueSecurityEventByName` - 测试 aggClueSecurityEventByName (select)
2. `GET /test2_mappingNormalSecurityEvent` - 测试 mappingNormalSecurityEvent (select)
3. `GET /test3_selectOldIncidentByCodes` - 测试 selectOldIncidentByCodes (select)
4. `GET /test4_getRiskList` - 测试 getRiskList (select)
5. `GET /test5_getCountByStatus` - 测试 getCountByStatus (select)
6. `GET /test6_getByEventCode` - 测试 getByEventCode (select)
7. `GET /test7_selectEventAndTempById` - 测试 selectEventAndTempById (select)
8. `GET /test8_selectAllByIdList` - 测试 selectAllByIdList (select)
9. `GET /test9_queryEventCount` - 测试 queryEventCount (select)
10. `GET /test10_queryIncidentsCount` - 测试 queryIncidentsCount (select)
11. `GET /test11_queryKillChains` - 测试 queryKillChains (select)
12. `GET /test12_getEventIdsById` - 测试 getEventIdsById (select)
13. `GET /test13_getFilterContent` - 测试 getFilterContent (select)
14. `GET /test14_FocusIpMessage` - 测试 FocusIpMessage (select)
15. `GET /test15_getFocusObject` - 测试 getFocusObject (select)
16. `GET /test16_getRiskListByIds` - 测试 getRiskListByIds (select)
17. `GET /test17_getCount` - 测试 getCount (select)
18. `GET /test18_queryFocusIps` - 测试 queryFocusIps (select)
19. `GET /test19_queryFocusIpCount` - 测试 queryFocusIpCount (select)
20. `GET /test20_getSecurityEventIdsByCondition` - 测试 getSecurityEventIdsByCondition (select)
21. `GET /test21_countByDate` - 测试 countByDate (select)
22. `GET /test22_selectIncidentForCheckScenario` - 测试 selectIncidentForCheckScenario (select)
23. `GET /test23_isHandled` - 测试 isHandled (select)
24. `GET /test24_backUpLastTermData` - 测试 backUpLastTermData (insert)
25. `GET /test25_batchInsertOrUpdateIncident` - 测试 batchInsertOrUpdateIncident (update)
26. `GET /test26_updateStatus` - 测试 updateStatus (update)
27. `GET /test27_updateJudgeResults` - 测试 updateJudgeResults (update)
28. `GET /test28_updateJudgeStatus` - 测试 updateJudgeStatus (update)
29. `GET /test29_deleteOldIncidentAnalysis` - 测试 deleteOldIncidentAnalysis (delete)
30. `GET /test30_deleteOldIncident` - 测试 deleteOldIncident (delete)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
