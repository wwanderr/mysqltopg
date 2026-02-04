# StrategyDeviceRel 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 12 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_strategy_device_rel`

---

## 📁 文件说明

```
StrategyDeviceRel/
├── StrategyDeviceRelTestController.java    # 测试 Controller (所有方法都是 GET)
├── StrategyDeviceRelMapper.java                  # Mapper 接口
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
cp StrategyDeviceRelTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp StrategyDeviceRelMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/strategydevicerel/`

---

## 📋 测试接口

1. `GET /test1_selectById` - 测试 selectById (select)
2. `GET /test2_getAlarmStrategyList` - 测试 getAlarmStrategyList (select)
3. `GET /test3_findDeviceByStrateId` - 测试 findDeviceByStrateId (select)
4. `GET /test4_findStrategyIdByDeviceId` - 测试 findStrategyIdByDeviceId (select)
5. `GET /test5_getDeviceCount` - 测试 getDeviceCount (select)
6. `GET /test6_insert` - 测试 insert (insert)
7. `GET /test7_batchInsert` - 测试 batchInsert (insert)
8. `GET /test8_update` - 测试 update (update)
9. `GET /test9_batchInsertOrUpdate` - 测试 batchInsertOrUpdate (update)
10. `GET /test10_updateDeviceIpAndId` - 测试 updateDeviceIpAndId (update)
11. `GET /test11_deleteRelByStrategyId` - 测试 deleteRelByStrategyId (delete)
12. `GET /test12_deleteRelByStrategyIdAndDeviceId` - 测试 deleteRelByStrategyIdAndDeviceId (delete)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
