# OutGoingConfig 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 7 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_out_going_config`

---

## 📁 文件说明

```
OutGoingConfig/
├── OutGoingConfigTestController.java    # 测试 Controller (所有方法都是 GET)
├── OutGoingConfigMapper.java                  # Mapper 接口
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
cp OutGoingConfigTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp OutGoingConfigMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/outgoingconfig/`

---

## 📋 测试接口

1. `GET /test1_selectOutGoingConfig` - 测试 selectOutGoingConfig (select)
2. `GET /test2_selectConfigById` - 测试 selectConfigById (select)
3. `GET /test3_selectOutGoingConfigCount` - 测试 selectOutGoingConfigCount (select)
4. `GET /test4_selectOutGoingConfigByPage` - 测试 selectOutGoingConfigByPage (select)
5. `GET /test5_selectKbrCount` - 测试 selectKbrCount (select)
6. `GET /test6_updateSwitchById` - 测试 updateSwitchById (update)
7. `GET /test7_closeConfig` - 测试 closeConfig (update)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
