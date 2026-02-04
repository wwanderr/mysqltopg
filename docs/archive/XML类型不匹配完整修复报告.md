# PostgreSQL XML 类型不匹配完整修复报告

## 修复时间：2026-01-30

## 问题概述
在MySQL到PostgreSQL的迁移过程中，发现多处SQL查询存在类型不匹配问题，导致运行时错误：
```
ERROR: operator does not exist: integer = character varying
```

PostgreSQL对类型检查更严格，不允许不同类型之间的隐式转换。

---

## 问题1：`judge_result` 字段类型不匹配

### 错误信息
```
ERROR: operator does not exist: integer = character varying
建议: No operator matches the given name and argument types. You might need to add explicit type casts.
位置: 2872
```

### 问题分析
**DDL定义：**
```sql
-- t_risk_incidents 表
"judge_result" int4 DEFAULT 0
```

**XML查询（错误）：**
```xml
<if test="judgeResults != null and judgeResults.size != null">
    and judge_result in
    <foreach collection="judgeResults" separator=","  open="(" close=")" item="sub">
        #{sub}  <!-- 传入的是字符串 "1", "2" -->
    </foreach>
</if>
```

**TestController传参（字符串）：**
```java
Arrays.asList("1", "2")  // 字符串类型
```

### 问题原因
- `judge_result` 在数据库中是 `int4` (INTEGER) 类型
- 但从Java传入的是字符串 `"1"`, `"2"`
- PostgreSQL不允许 `int4 = varchar` 的直接比较

### 修复方案
在XML中添加类型转换，将字符串参数转换为INTEGER：

**修复后的XML：**
```xml
<if test="judgeResults != null and judgeResults.size != null">
    and judge_result in
    <foreach collection="judgeResults" separator=","  open="(" close=")" item="sub">
        CAST(#{sub} AS INTEGER)  <!-- 显式转换为整数 -->
    </foreach>
</if>
```

### 影响范围
**文件：** `postgresql_xml_manual/RiskIncidentMapper.xml` 和 `postgresql_xml/RiskIncidentMapper.xml`

**受影响的方法（共6处）：**
1. `getRiskList` - 第453-458行
2. `getCountByStatus` - 第515-520行
3. `queryEventCount` - 第684-689行
4. `queryIncidentsCount` - 第741-746行
5. `queryKillChains` - 第797-802行
6. `getCount` - 第902-907行

---

## 问题2：`ri.id` 与 `associated_field` 类型不匹配

### 问题分析
**DDL定义：**
```sql
-- t_risk_incidents 表
"id" int8 NOT NULL  -- BIGINT类型

-- t_alarm_status_timing_task 表
"associated_field" varchar(100)  -- VARCHAR类型
```

**XML查询（错误）：**
```xml
left join t_alarm_status_timing_task tt 
on ri.id = tt.associated_field  <!-- int8 = varchar 类型不匹配 -->
and task_type = 'RiskIncident'
```

### 修复方案
将 `ri.id` 转换为VARCHAR类型：

**修复后的XML：**
```xml
left join t_alarm_status_timing_task tt 
on CAST(ri.id AS VARCHAR) = tt.associated_field  <!-- 显式转换为VARCHAR -->
and task_type = 'RiskIncident'
```

### 影响范围
**文件：** 
- `postgresql_xml_manual/RiskIncidentMapper.xml` - 第417行
- `postgresql_xml/RiskIncidentMapper.xml` - 第427行

**受影响的方法：**
- `getRiskList` - RiskIncident模块

---

## 问题3：`ti.id` 与 `associated_field` 类型不匹配（SecurityEvent模块）

### 问题分析
**DDL定义：**
```sql
-- t_security_incidents 表
"id" int8 NOT NULL  -- BIGINT类型

-- t_alarm_status_timing_task 表
"associated_field" varchar(100)  -- VARCHAR类型
```

**XML查询（错误）：**
```xml
<!-- 场景1 -->
LEFT JOIN t_alarm_status_timing_task tk 
ON a.eventId = tk.associated_field  <!-- int8 = varchar -->

<!-- 场景2 -->
LEFT JOIN t_alarm_status_timing_task tk 
ON a.eventId = tk.associated_field and task_type = 'SecurityEvent'

<!-- 场景3 -->
delete from t_alarm_status_timing_task where associated_field in(
    select id from t_security_incidents where event_code in (...)
)
```

### 修复方案
**修复后的XML：**
```xml
<!-- 场景1 -->
LEFT JOIN t_alarm_status_timing_task tk 
ON CAST(a.eventId AS VARCHAR) = tk.associated_field

<!-- 场景2 -->
LEFT JOIN t_alarm_status_timing_task tk 
ON CAST(a.eventId AS VARCHAR) = tk.associated_field and task_type = 'SecurityEvent'

<!-- 场景3 -->
delete from t_alarm_status_timing_task where associated_field in(
    select CAST(id AS VARCHAR) from t_security_incidents where event_code in (...)
)
```

### 影响范围
**文件：** 
- `postgresql_xml_manual/SecurityEvent.xml`
- `postgresql_xml/SecurityEvent.xml`

**受影响的方法（共3处）：**
1. `selectAllByIdList` - 第215行
2. `queryListByCondition` - 第451行
3. `deleteTimingTask` - 第952行

---

## 修复总结

### 修复文件清单
| 文件 | 修复类型 | 修复数量 | 说明 |
|------|---------|---------|------|
| `postgresql_xml_manual/RiskIncidentMapper.xml` | judge_result类型转换 | 6处 | CAST(#{sub} AS INTEGER) |
| `postgresql_xml/RiskIncidentMapper.xml` | judge_result类型转换 | 6处 | CAST(#{sub} AS INTEGER) |
| `postgresql_xml_manual/RiskIncidentMapper.xml` | ri.id类型转换 | 1处 | CAST(ri.id AS VARCHAR) |
| `postgresql_xml/RiskIncidentMapper.xml` | ri.id类型转换 | 1处 | CAST(ri.id AS VARCHAR) |
| `postgresql_xml_manual/SecurityEvent.xml` | ti.id类型转换 | 3处 | CAST(id/eventId AS VARCHAR) |
| `postgresql_xml/SecurityEvent.xml` | ti.id类型转换 | 3处 | CAST(id/eventId AS VARCHAR) |
| **总计** | | **20处** | |

### 类型转换规则

#### 1. INTEGER字段与VARCHAR参数比较
**规则：** 将VARCHAR参数转换为INTEGER
```xml
<!-- 错误 -->
field_name in (#{param1}, #{param2})

<!-- 正确 -->
field_name in (CAST(#{param1} AS INTEGER), CAST(#{param2} AS INTEGER))
```

**适用场景：**
- `judge_result` (int4) 字段
- 所有integer类型字段与字符串参数的比较

#### 2. BIGINT字段与VARCHAR字段比较
**规则：** 将BIGINT字段转换为VARCHAR
```xml
<!-- 错误 -->
table1.id = table2.varchar_field

<!-- 正确 -->
CAST(table1.id AS VARCHAR) = table2.varchar_field
```

**适用场景：**
- `t_risk_incidents.id` (int8) 与 `t_alarm_status_timing_task.associated_field` (varchar)
- `t_security_incidents.id` (int8) 与 `t_alarm_status_timing_task.associated_field` (varchar)

---

## 验证步骤

### 1. 重新启动应用
```bash
mvn clean package
java -jar target/your-application.jar
```

### 2. 运行测试
```bash
# RiskIncident模块测试
GET http://localhost:8080/test/riskIncident/testGetRiskList
GET http://localhost:8080/test/riskIncident/testGetCountByStatus
GET http://localhost:8080/test/riskIncident/testQueryEventCount
GET http://localhost:8080/test/riskIncident/testQueryIncidentsCount
GET http://localhost:8080/test/riskIncident/testQueryKillChains
GET http://localhost:8080/test/riskIncident/testGetCount
```

### 3. 预期结果
所有测试应返回 `SUCCESS`，不再出现类型不匹配错误。

---

## 最佳实践建议

### 1. 数据库设计
- ✅ **推荐：** 保持关联字段的类型一致
  ```sql
  -- 推荐：两边都用BIGINT
  "id" int8
  "associated_field" int8
  ```
- ⚠️ **当前状态：** 如果无法修改DDL，必须在SQL中显式转换

### 2. Java代码
- ✅ **推荐：** 传递与数据库字段类型匹配的参数
  ```java
  // judge_result是int4，应传递Integer
  Arrays.asList(1, 2)  // 推荐
  
  // 不推荐
  Arrays.asList("1", "2")  // 需要XML中转换
  ```

### 3. MyBatis XML
- ✅ **强制：** 在PostgreSQL中，所有类型不匹配的地方必须显式转换
  ```xml
  <!-- 整数字段与字符串参数 -->
  CAST(#{param} AS INTEGER)
  
  <!-- 整数字段与VARCHAR字段 -->
  CAST(int_field AS VARCHAR)
  
  <!-- 日期时间字段 -->
  CAST(#{param} AS TIMESTAMP)
  ```

### 4. 全局搜索建议
定期检查以下模式，确保没有遗漏的类型不匹配：
```bash
# 检查integer字段与参数的比较
grep -r "judge_result.*in" *.xml
grep -r "is_scenario.*=" *.xml

# 检查BIGINT字段与VARCHAR字段的JOIN
grep -r "\.id.*=.*associated_field" *.xml
grep -r "associated_field.*=.*\.id" *.xml
```

---

## 遗留风险检查

### 需要检查的其他字段
以下字段可能也存在类似问题，建议逐一排查：

1. **`is_scenario` 字段**
   - DDL: `int4` 或 `bool`
   - 使用场景: 条件判断 `is_scenario = #{isScenario}`
   - 建议: 检查所有使用该字段的XML

2. **`template_id` 字段**
   - 在不同表中类型不同：
     - `t_risk_incidents.template_id`: varchar(128)
     - `t_security_incidents.template_id`: int8
   - 建议: 检查JOIN和比较操作

3. **所有ID字段的关联**
   - 检查所有 `table1.id = table2.xxx_id` 的JOIN
   - 确保类型一致或添加CAST

---

## 总结

✅ **已修复：**
- `judge_result` 字段的6处类型不匹配（RiskIncident模块）
- `ri.id` 与 `associated_field` 的1处类型不匹配（RiskIncident模块）
- `ti.id` 与 `associated_field` 的3处类型不匹配（SecurityEvent模块）

✅ **修复方案：**
- 在XML中使用 `CAST()` 函数进行显式类型转换
- 保持代码的向后兼容性（允许前端传递字符串或整数）

✅ **影响范围：**
- 2个XML文件（RiskIncidentMapper.xml, SecurityEvent.xml）
- 2个目录（postgresql_xml_manual, postgresql_xml）
- 共20处修复点

⚠️ **注意事项：**
- PostgreSQL对类型检查严格，必须显式转换
- 建议后续优化数据库设计，保持关联字段类型一致
- 定期检查是否有其他类似问题
