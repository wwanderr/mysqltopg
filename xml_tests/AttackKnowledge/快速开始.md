# AttackKnowledge 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 9 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_attack_knowledge`

---

## 📁 文件说明

```
AttackKnowledge/
├── AttackKnowledgeTestController.java    # 测试 Controller (所有方法都是 GET)
├── AttackKnowledgeMapper.java                  # Mapper 接口
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
cp AttackKnowledgeTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp AttackKnowledgeMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/attackknowledge/`

---

## 📋 测试接口

1. `GET /test1_selectListByParams` - 测试 selectListByParams (select)
2. `GET /test2_selectByparentCode` - 测试 selectByparentCode (select)
3. `GET /test3_queryIdBytacticName` - 测试 queryIdBytacticName (select)
4. `GET /test4_queryNameByCode` - 测试 queryNameByCode (select)
5. `GET /test5_queryParentId` - 测试 queryParentId (select)
6. `GET /test6_selectTactic` - 测试 selectTactic (select)
7. `GET /test7_truncateTable` - 测试 truncateTable (select)
8. `GET /test8_batchInsert` - 测试 batchInsert (insert)
9. `GET /test9_updateByCode` - 测试 updateByCode (update)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
