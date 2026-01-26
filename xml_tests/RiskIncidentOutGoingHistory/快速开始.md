# RiskIncidentOutGoingHistory 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 9 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_risk_incident_out_going_history`

---

## 📁 文件说明

```
RiskIncidentOutGoingHistory/
├── RiskIncidentOutGoingHistoryTestController.java    # 测试 Controller (所有方法都是 GET)
├── RiskIncidentOutGoingHistoryMapper.java                  # Mapper 接口
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
cp RiskIncidentOutGoingHistoryTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp RiskIncidentOutGoingHistoryMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/riskincidentoutgoinghistory/`

---

## 📋 测试接口

1. `GET /test1_mappingFromClueSecurityEvent` - 测试 mappingFromClueSecurityEvent (select)
2. `GET /test2_mappingNormalSecurityEvent` - 测试 mappingNormalSecurityEvent (select)
3. `GET /test3_queryListByTime` - 测试 queryListByTime (select)
4. `GET /test4_queryOutGoingList` - 测试 queryOutGoingList (select)
5. `GET /test5_backUpLastTermData` - 测试 backUpLastTermData (insert)
6. `GET /test6_batchInsertOrUpdateIncident` - 测试 batchInsertOrUpdateIncident (update)
7. `GET /test7_batchUpdatePayload` - 测试 batchUpdatePayload (update)
8. `GET /test8_deleteOldIncident` - 测试 deleteOldIncident (delete)
9. `GET /test9_clearHistoryData` - 测试 clearHistoryData (delete)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
