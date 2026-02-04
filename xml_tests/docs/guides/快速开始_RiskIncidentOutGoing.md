# RiskIncidentOutGoing 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 15 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_risk_incident_out_going`

---

## 📁 文件说明

```
RiskIncidentOutGoing/
├── RiskIncidentOutGoingTestController.java    # 测试 Controller (所有方法都是 GET)
├── RiskIncidentOutGoingMapper.java                  # Mapper 接口
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
cp RiskIncidentOutGoingTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp RiskIncidentOutGoingMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/riskincidentoutgoing/`

---

## 📋 测试接口

1. `GET /test1_mappingFromClueSecurityEvent` - 测试 mappingFromClueSecurityEvent (select)
2. `GET /test2_mappingNormalSecurityEvent` - 测试 mappingNormalSecurityEvent (select)
3. `GET /test3_queryListByTime` - 测试 queryListByTime (select)
4. `GET /test4_queryOutGoingList` - 测试 queryOutGoingList (select)
5. `GET /test5_selectOldIncidentByCodes` - 测试 selectOldIncidentByCodes (select)
6. `GET /test6_groupByFocusIp` - 测试 groupByFocusIp (select)
7. `GET /test7_groupNameByFocusIp` - 测试 groupNameByFocusIp (select)
8. `GET /test8_selectOldHistoryIds` - 测试 selectOldHistoryIds (select)
9. `GET /test9_backUpLastTermData` - 测试 backUpLastTermData (insert)
10. `GET /test10_batchInsertOrUpdateIncident` - 测试 batchInsertOrUpdateIncident (update)
11. `GET /test11_batchUpdatePayload` - 测试 batchUpdatePayload (update)
12. `GET /test12_updateKillChain` - 测试 updateKillChain (update)
13. `GET /test13_deleteOldIncident` - 测试 deleteOldIncident (delete)
14. `GET /test14_clearHistoryData` - 测试 clearHistoryData (delete)
15. `GET /test15_deleteHistoryByIds` - 测试 deleteHistoryByIds (delete)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
