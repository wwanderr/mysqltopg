# EventOutGoingConfig 快速测试指南

**生成时间**: 2026-01-26  
**测试方法数**: 1 个  
**测试数据范围**: ID 1001-1004  
**对应表**: `t_event_out_going_config`

---

## 📁 文件说明

```
EventOutGoingConfig/
├── EventOutGoingConfigTestController.java    # 测试 Controller (所有方法都是 GET)
├── EventOutGoingConfigMapper.java                  # Mapper 接口
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
cp EventOutGoingConfigTestController.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/
cp EventOutGoingConfigMapper.java <项目路径>/src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 3. 启动应用并测试

```bash
mvn spring-boot:run
```

访问：`http://localhost:8080/test/eventoutgoingconfig/`

---

## 📋 测试接口

1. `GET /test1_delById` - 测试 delById (update)

---

## 📝 注意事项

- ✅ 所有请求都是 GET
- ✅ 参数在 Controller 中写死
- ✅ UPDATE 方法无返回值
- ✅ 测试数据 ID: 1001-1004

---

完整使用说明请参考：`XML测试框架使用指南.md`
