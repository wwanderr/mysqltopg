# XML Boolean类型转换修复说明

## 🔴 问题背景

MySQL迁移到PostgreSQL时，`tinyint`字段被转换为`bool`类型，但Java代码中仍使用Integer类型（0/1），导致类型不匹配。

---

## 📋 问题详情

### 表：t_event_template

#### PostgreSQL建表DDL
```sql
CREATE TABLE "t_event_template" (
  ...
  "incident_type" bool,        -- MySQL中是 tinyint
  "enable" bool,               -- MySQL中是 tinyint
  ...
);
```

#### Java实体类（未修改）
```java
public class EventTemplate {
    private Integer incidentType;  // Java中仍是Integer (0/1)
    private Integer enable;        // Java中仍是Integer (0/1)
}
```

#### 问题XML（修复前）
```xml
<!-- 插入时使用INTEGER，但数据库字段是bool -->
#{eventList.incidentType,jdbcType=VARCHAR}   ❌ 类型错误
#{eventList.enable,jdbcType=INTEGER}         ❌ 类型错误

<!-- 查询条件使用整数 -->
WHERE (ENABLE = 1)                           ❌ bool字段不能直接用整数比较
```

---

## ✅ 修复方案

### 方案选择
- ❌ **方案A**: 修改Java代码，将Integer改为Boolean
  - 缺点：影响范围大，需要修改所有业务代码
  
- ✅ **方案B**: 在XML中做类型转换（推荐）
  - 优点：不影响Java代码，只修改SQL
  - 使用PostgreSQL的类型转换：`(#{value,jdbcType=INTEGER}::int)::boolean`

### PostgreSQL类型转换语法
```sql
-- 将Integer参数转为boolean
(#{enable,jdbcType=INTEGER}::int)::boolean

-- 说明：
-- 1. #{enable,jdbcType=INTEGER} - MyBatis参数，Java是Integer
-- 2. ::int                       - 确保是整数类型
-- 3. ::boolean                   - 转换为boolean类型
-- 4. PostgreSQL会自动识别: 0=false, 1=true, 其他值报错
```

---

## 🔧 具体修改

### 文件：EventTemplateMapper.xml

#### 修改1: batchInsert - 批量插入

**修复前**:
```xml
<foreach collection="list" item="eventList" separator=",">
    (...,#{eventList.incidentType,jdbcType=VARCHAR},...,
     #{eventList.enable,jdbcType=INTEGER},...)
</foreach>
```

**修复后**:
```xml
<foreach collection="list" item="eventList" separator=",">
    (...,(#{eventList.incidentType,jdbcType=INTEGER}::int)::boolean,...,
     (#{eventList.enable,jdbcType=INTEGER}::int)::boolean,...)
</foreach>
```

#### 修改2: selectAllTemplate - 查询启用的模板

**修复前**:
```xml
WHERE (ENABLE = 1)
```

**修复后**:
```xml
WHERE (ENABLE = true)
```

#### 修改3: updateByUniqCode - 根据唯一码更新

**修复前**:
```xml
VALUES (...,#{incidentType,jdbcType=VARCHAR},...,
        #{enable,jdbcType=INTEGER},...)
```

**修复后**:
```xml
VALUES (...,(#{incidentType,jdbcType=INTEGER}::int)::boolean,...,
        (#{enable,jdbcType=INTEGER}::int)::boolean,...)
```

#### 修改4: updateByIncidentName - 根据事件名称更新

**修复前**:
```xml
UPDATE t_event_template SET
    incident_type = #{incidentType,jdbcType=VARCHAR},
    enable = #{enable,jdbcType=INTEGER},
    ...
```

**修复后**:
```xml
UPDATE t_event_template SET
    incident_type = (#{incidentType,jdbcType=INTEGER}::int)::boolean,
    enable = (#{enable,jdbcType=INTEGER}::int)::boolean,
    ...
```

---

## 📊 修改汇总

| 方法 | 修改内容 | 影响字段 |
|------|----------|----------|
| batchInsert | 2处类型转换 | incident_type, enable |
| selectAllTemplate | WHERE条件改为true | enable |
| updateByUniqCode | 2处类型转换 | incident_type, enable |
| updateByIncidentName | 2处类型转换 | incident_type, enable |

---

## ✅ 测试验证

### 测试1: 插入数据
```java
EventTemplate template = new EventTemplate();
template.setEnable(1);           // Java中使用Integer
template.setIncidentType(1);     // Java中使用Integer
mapper.batchInsert(Arrays.asList(template));
```

**预期SQL**:
```sql
INSERT INTO t_event_template (..., incident_type, ..., enable, ...)
VALUES (..., (1::int)::boolean, ..., (1::int)::boolean, ...)
-- PostgreSQL执行后: incident_type=true, enable=true
```

### 测试2: 查询启用的模板
```java
List<EventTemplate> list = mapper.selectAllTemplate();
```

**预期SQL**:
```sql
SELECT * FROM t_event_template WHERE (ENABLE = true)
```

### 测试3: 更新数据
```java
EventTemplate template = new EventTemplate();
template.setIncidentName("测试事件");
template.setEnable(0);           // 禁用
template.setIncidentType(0);
mapper.updateByIncidentName(template);
```

**预期SQL**:
```sql
UPDATE t_event_template SET
    incident_type = (0::int)::boolean,  -- false
    enable = (0::int)::boolean,         -- false
    ...
WHERE incident_name = '测试事件'
```

---

## 🔍 其他可能受影响的表

需要检查以下表是否也有类似问题：

```bash
# 搜索所有使用bool类型的表
grep -r "bool" migrations_ultimate/*.sql

# 检查XML中是否有类似的整数赋值给bool字段
grep -r "jdbcType=INTEGER" postgresql_xml_manual/*.xml
```

### 可能需要修复的表（示例）
- t_alarm_out_going_config (is_del字段)
- t_event_out_going_config (is_del字段)
- 其他包含is_del、enable、status等bool字段的表

---

## 📝 最佳实践建议

### 未来迁移建议

1. **保持数据类型一致性**
   ```sql
   -- 推荐：使用int4而不是bool
   CREATE TABLE t_event_template (
       enable int4 NOT NULL DEFAULT 0,  -- 0/1 表示 false/true
       ...
   );
   ```

2. **统一类型转换规范**
   - 如果数据库是bool，XML统一使用类型转换
   - 如果Java是Integer，数据库统一使用int4

3. **添加注释说明**
   ```xml
   <!-- PostgreSQL类型转换：Integer(0/1) -> boolean(false/true) -->
   (#{enable,jdbcType=INTEGER}::int)::boolean
   ```

---

## ⚠️ 注意事项

1. **类型转换性能**
   - PostgreSQL的类型转换开销很小，可以放心使用
   - 索引字段的类型转换可能影响索引使用

2. **值范围限制**
   - PostgreSQL中，只有0和1能转换为boolean
   - 其他值（如2、-1等）会报错

3. **NULL值处理**
   - `NULL::boolean` 结果仍是NULL
   - 需要在Java层面处理NULL的情况

---

## 🎯 验证清单

- [x] EventTemplateMapper.xml - incident_type字段转换
- [x] EventTemplateMapper.xml - enable字段转换
- [x] EventTemplateMapper.xml - WHERE条件修改
- [ ] 其他XML文件中的bool字段转换
- [ ] 端到端测试验证
- [ ] 性能测试

---

**修复日期**: 2026-01-22  
**修复文件**: EventTemplateMapper.xml  
**涉及字段**: incident_type (bool), enable (bool)  
**修复方法**: PostgreSQL类型转换 `(value::int)::boolean`
