# XML 测试框架使用指南

**生成时间**: 2026-01-26  
**测试套件数量**: 39 个

---

## 🎯 设计理念

### 最简单、最快速的测试方式

1. ✅ **所有请求都用 GET** - 不需要传参数，不需要 Body
2. ✅ **参数在 Controller 中写死** - 直接在代码里设置测试参数
3. ✅ **每个 XML 独立测试** - 互不干扰
4. ✅ **UPDATE 无返回值** - 符合实际使用
5. ✅ **一个目录一个功能** - 清晰明了

---

## 📁 目录结构

```
xml_tests/
├── README.md                           # 总体说明
│
├── AlarmOutGoingConfig/                # 每个 XML 一个独立目录
│   ├── AlarmOutGoingConfigTestController.java   # Controller (GET 请求)
│   ├── AlarmOutGoingConfigMapper.java           # Mapper 接口
│   ├── test_data.sql                            # 测试数据
│   └── 快速开始.md                              # 使用说明
│
├── EventTemplate/
│   ├── EventTemplateTestController.java
│   ├── EventTemplateMapper.java
│   ├── test_data.sql
│   └── 快速开始.md
│
├── ... (共 39 个目录)
```

---

## 🚀 快速开始

### 1. 选择要测试的功能

比如测试 `EventTemplate`：

```bash
cd xml_tests/EventTemplate
```

### 2. 准备测试数据

```bash
# 在数据库中执行测试数据
psql -U postgres -d xdr22 -f test_data.sql
```

### 3. 将文件复制到项目中

```
EventTemplateTestController.java  →  src/main/java/com/dbapp/extension/xdr/test/
EventTemplateMapper.java           →  src/main/java/com/dbapp/extension/xdr/test/mapper/
```

### 4. 配置 MyBatis 扫描路径

在 `application.yml` 或 `application.properties` 中添加：

```yaml
mybatis:
  mapper-locations: 
    - classpath:mapper/*.xml
    - classpath:postgresql_xml_manual/*.xml  # ← 添加测试 XML 路径
```

### 5. 启动应用

```bash
mvn spring-boot:run
```

### 6. 使用 Postman 测试

#### 查看接口列表

```
GET http://localhost:8080/test/eventtemplate/
```

返回：

```
EventTemplate 测试接口 - 共 5 个测试方法
```

#### 测试每个方法

```
GET http://localhost:8080/test/eventtemplate/test1_queryCodeCount
GET http://localhost:8080/test/eventtemplate/test2_selectAllTemplate
GET http://localhost:8080/test/eventtemplate/test3_batchInsert
GET http://localhost:8080/test/eventtemplate/test4_updateByUniqCode
GET http://localhost:8080/test/eventtemplate/test5_updateByIncidentName
```

---

## 📝 Controller 代码示例

### SELECT 方法（有返回值）

```java
@GetMapping("/test1_selectAll")
public Object test1_selectAll() {
    System.out.println("测试: selectAll");
    try {
        // 参数在这里写死
        String param1 = "test";
        Integer param2 = 100;
        
        // 调用 Mapper
        Object result = mapper.selectAll(param1, param2);
        System.out.println("结果: " + result);
        return result;
    } catch (Exception e) {
        e.printStackTrace();
        return "ERROR: " + e.getMessage();
    }
}
```

### INSERT 方法（有返回值）

```java
@GetMapping("/test2_insert")
public String test2_insert() {
    System.out.println("测试: insert");
    try {
        // 构造测试数据
        EventTemplate entity = new EventTemplate();
        entity.setIncidentName("测试事件");
        entity.setEnable(true);
        entity.setIncidentType(false);
        entity.setCreateTime(LocalDateTime.now());
        
        int result = mapper.insert(entity);
        System.out.println("插入成功，影响行数: " + result);
        return "SUCCESS: " + result;
    } catch (Exception e) {
        e.printStackTrace();
        return "ERROR: " + e.getMessage();
    }
}
```

### UPDATE 方法（无返回值）⭐

```java
@GetMapping("/test3_update")
public String test3_update() {
    System.out.println("测试: update");
    try {
        // 构造测试数据
        EventTemplate entity = new EventTemplate();
        entity.setId(1);
        entity.setIncidentName("更新的事件");
        entity.setUpdateTime(LocalDateTime.now());
        
        mapper.update(entity);  // ← void，无返回值
        System.out.println("更新成功");
        return "SUCCESS";
    } catch (Exception e) {
        e.printStackTrace();
        return "ERROR: " + e.getMessage();
    }
}
```

### DELETE 方法（有返回值）

```java
@GetMapping("/test4_delete")
public String test4_delete() {
    System.out.println("测试: delete");
    try {
        int id = 1;  // 测试ID
        
        int result = mapper.deleteById(id);
        System.out.println("删除成功，影响行数: " + result);
        return "SUCCESS: " + result;
    } catch (Exception e) {
        e.printStackTrace();
        return "ERROR: " + e.getMessage();
    }
}
```

---

## 🎯 Mapper 接口示例

```java
package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EventTemplateMapper {

    // SELECT - 返回 Object（根据实际情况修改为具体类型）
    Object queryCodeCount();
    
    // INSERT - 返回 int（影响行数）
    int insert(EventTemplate entity);
    
    // UPDATE - void（无返回值）⭐
    void updateById(EventTemplate entity);
    
    // DELETE - 返回 int（影响行数）
    int deleteById(Integer id);

}
```

---

## ⚙️ 重要约定

### 1. UPDATE 方法无返回值

```java
// Mapper 接口定义
void updateById(EventTemplate entity);  // ← void

// Controller 调用
mapper.updateById(entity);  // ← 没有返回值
System.out.println("更新成功");
```

### 2. 参数都在 Controller 中写死

```java
// ✅ 正确做法：参数在方法内部设置
@GetMapping("/test1_select")
public Object test1_select() {
    String name = "测试";  // ← 写死参数
    Integer id = 1;
    return mapper.selectByName(name, id);
}

// ❌ 错误做法：需要从外部传参
@GetMapping("/test1_select")
public Object test1_select(@RequestParam String name) {
    // 这样就需要在 Postman 中传参数了
    return mapper.selectByName(name);
}
```

### 3. 所有请求都用 GET

```java
// ✅ 正确
@GetMapping("/test1_xxx")

// ❌ 错误
@PostMapping("/test1_xxx")
@PutMapping("/test1_xxx")
```

---

## 📊 测试套件统计

| 功能模块 | 方法数 | 说明 |
|---------|-------|------|
| **ProhibitHistory** | 37 | 封禁历史（最多） |
| **SecurityEvent** | 31 | 安全事件 |
| **RiskIncident** | 30 | 风险事件 |
| **RiskIncidentOutGoing** | 15 | 风险事件外发 |
| **Intelligence** | 14 | 情报订阅 |
| **LinkedStrategy** | 14 | 联动策略 |
| **StrategyDeviceRel** | 12 | 策略设备关联 |
| **BlockHistory** | 11 | 封堵历史 |
| **VulAnalysisSub** | 11 | 漏洞分析订阅 |
| **RiskIncidentHistory** | 10 | 风险事件历史 |
| ... | ... | ... |

共 **39 个测试套件，279 个测试方法**

---

## 🧪 测试流程

### 完整测试一个 Mapper 的步骤

#### 1. EventTemplate 为例

```bash
# 1. 进入目录
cd xml_tests/EventTemplate

# 2. 查看快速开始文档
cat 快速开始.md

# 3. 执行测试数据
psql -U postgres -d xdr22 -f test_data.sql

# 4. 复制文件到项目
cp EventTemplateTestController.java ../../../src/main/java/.../test/
cp EventTemplateMapper.java ../../../src/main/java/.../test/mapper/

# 5. 启动应用
cd ../../../
mvn spring-boot:run

# 6. Postman 测试
# GET http://localhost:8080/test/eventtemplate/test1_queryCodeCount
# GET http://localhost:8080/test/eventtemplate/test2_selectAllTemplate
# ...
```

### 批量测试多个 Mapper

可以将多个 Mapper 的文件都复制到项目中，然后逐个测试：

```bash
# 复制多个测试套件
cp EventTemplate/* ../src/.../
cp AlarmOutGoingConfig/* ../src/.../
cp SecurityEvent/* ../src/.../
```

---

## 🎨 Postman 使用技巧

### 创建集合

1. 在 Postman 中创建一个新集合 `XML Mapper Tests`
2. 为每个 Mapper 创建一个文件夹
3. 在文件夹下添加所有测试接口

### 示例：EventTemplate 集合

```
XML Mapper Tests/
└── EventTemplate/
    ├── GET 接口列表            /test/eventtemplate/
    ├── GET test1_queryCodeCount     /test/eventtemplate/test1_queryCodeCount
    ├── GET test2_selectAllTemplate  /test/eventtemplate/test2_selectAllTemplate
    ├── GET test3_batchInsert        /test/eventtemplate/test3_batchInsert
    ├── GET test4_updateByUniqCode   /test/eventtemplate/test4_updateByUniqCode
    └── GET test5_updateByIncidentName /test/eventtemplate/test5_updateByIncidentName
```

### 环境变量

设置基础 URL：

```
{{baseUrl}} = http://localhost:8080
```

然后请求写成：

```
{{baseUrl}}/test/eventtemplate/test1_queryCodeCount
```

---

## ✅ 测试检查清单

测试每个接口时，检查以下内容：

### SQL 语法

- [ ] 接口能否正常访问（200 状态码）
- [ ] 没有 SQL 语法错误
- [ ] 没有类型转换错误

### Bool 字段

- [ ] Bool 字段使用 `true`/`false` 而不是 `1`/`0`
- [ ] Bool 字段查询正常
- [ ] Bool 字段插入/更新正常

### 时间字段

- [ ] 时间字段格式正确（`2026-01-22 15:30:00`）
- [ ] 没有时区问题（不应该有 `+08`）
- [ ] `CAST(#{field} AS timestamp)` 正常工作

### 特殊函数

- [ ] `STRING_AGG` 正常工作
- [ ] `EXTRACT` 正常工作
- [ ] `ILIKE` 模糊查询正常
- [ ] 其他 PostgreSQL 特定函数正常

### 数据准确性

- [ ] 返回的数据符合预期
- [ ] 插入的数据能正常查询到
- [ ] 更新操作真的更新了数据
- [ ] 删除操作真的删除了数据

---

## 🎊 总结

### ✅ 测试框架优势

1. **极简设计** - 只需要 Controller + Mapper + SQL
2. **快速测试** - 所有请求都是 GET，一键测试
3. **参数写死** - 不需要在 Postman 中传参数
4. **独立隔离** - 每个 Mapper 独立测试，互不影响
5. **易于调试** - 控制台输出清晰，错误信息明确

### 📈 使用统计

- **39 个测试套件**
- **279 个测试方法**
- **覆盖所有 XML Mapper**

### 🚀 下一步

1. 选择要测试的 Mapper
2. 查看对应目录的 `快速开始.md`
3. 准备测试数据
4. 复制文件到项目
5. 启动应用
6. Postman 测试

**简单、快速、高效！** 🎯
