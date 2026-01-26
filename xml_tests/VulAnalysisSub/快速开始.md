# VulAnalysisSub 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 11 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_vul_analysis_sub`

---

## 📁 文件说明

```
VulAnalysisSub/
├── VulAnalysisSubTestController.java    # 测试 Controller (所有方法都是 GET)
├── VulAnalysisSubMapper.java                  # Mapper 接口
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
cp VulAnalysisSubTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp VulAnalysisSubMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/vulanalysissub/`

---

## 📋 测试接口

1. `GET /test1_queryListCount` - 测试 queryListCount (select)
2. `GET /test2_queryList` - 测试 queryList (select)
3. `GET /test3_querySubListCount` - 测试 querySubListCount (select)
4. `GET /test4_querySubListCveCount` - 测试 querySubListCveCount (select)
5. `GET /test5_querySubList` - 测试 querySubList (select)
6. `GET /test6_querySubListById` - 测试 querySubListById (select)
7. `GET /test7_queryTop10` - 测试 queryTop10 (select)
8. `GET /test8_queryProportion` - 测试 queryProportion (select)
9. `GET /test9_insertOrUpdate` - 测试 insertOrUpdate (insert)
10. `GET /test10_updateByParams` - 测试 updateByParams (update)
11. `GET /test11_updateByIds` - 测试 updateByIds (update)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
