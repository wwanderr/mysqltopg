# LinkedStrategy 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 14 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_linked_strategy`

---

## 📁 文件说明

```
LinkedStrategy/
├── LinkedStrategyTestController.java    # 测试 Controller (所有方法都是 GET)
├── LinkedStrategyMapper.java                  # Mapper 接口
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
cp LinkedStrategyTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp LinkedStrategyMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/linkedstrategy/`

---

## 📋 测试接口

1. `GET /test1_getLinkStrategyById` - 测试 getLinkStrategyById (select)
2. `GET /test2_getLinkStrategyByIds` - 测试 getLinkStrategyByIds (select)
3. `GET /test3_getLinkStrategyListTotal` - 测试 getLinkStrategyListTotal (select)
4. `GET /test4_getLinkStrategyList` - 测试 getLinkStrategyList (select)
5. `GET /test5_getLinkStrategyCountByNameAndId` - 测试 getLinkStrategyCountByNameAndId (select)
6. `GET /test6_findLinkStrategyByParam` - 测试 findLinkStrategyByParam (select)
7. `GET /test7_getAllTemplateStrategyIds` - 测试 getAllTemplateStrategyIds (select)
8. `GET /test8_getAllStrategys` - 测试 getAllStrategys (select)
9. `GET /test9_insertOrUpdate` - 测试 insertOrUpdate (insert)
10. `GET /test10_enableLinkStrategy` - 测试 enableLinkStrategy (update)
11. `GET /test11_update` - 测试 update (update)
12. `GET /test12_batchUpdateLinkDeviceConfig` - 测试 batchUpdateLinkDeviceConfig (update)
13. `GET /test13_updateAppId` - 测试 updateAppId (update)
14. `GET /test14_deleteLinkStrategy` - 测试 deleteLinkStrategy (delete)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
