# RiskIncident 模块参数修复报告（基于反编译真实接口）

## 修复时间
2026-01-30

## 修复依据
**根据项目反编译的`RiskIncidentMapper`真实接口定义进行修复**

## 关键发现与修复

### 1. aggClueSecurityEventByName - 6个参数
**真实接口定义：**
```java
List<RiskIncident> aggClueSecurityEventByName(
    @Param("startTime") String var1, 
    @Param("endTime") String var2, 
    @Param("topEventType") String var3,      // 注意：topEventType在第3位
    @Param("threatSeverity") List<String> var4, 
    @Param("alarmResults") List<String> var5, 
    @Param("excludeEventIds") List<Long> var6
);
```

**修复点：**
- ✓ 参数顺序：topEventType在threatSeverity之前
- ✓ 所有6个参数类型正确

### 2. mappingNormalSecurityEvent - 6个参数
同方法1，参数顺序和类型完全一致

### 3. backUpLastTermData - 2个参数
**真实接口定义：**
```java
void backUpLastTermData(
    @Param("currentDate") String var1, 
    @Param("timestamp") DateTime var2   // 注意：DateTime类型，不是String！
);
```

**修复点：**
- ✓ 第二个参数类型改为`org.joda.time.DateTime`
- ✓ 返回类型为`void`

### 4. getRiskList - 16个参数（重要！）
**真实接口定义：**
```java
List<Map<String, Object>> getRiskList(
    @Param("orderByStr") String var1,        // 参数1：排序字段
    @Param("name") String var2,              // 参数2：名称
    @Param("endTime") String var3,           // 参数3：结束时间
    @Param("subCategory") List<String> var4, // 参数4：子分类
    @Param("alarmStatus") List<String> var5, // 参数5：告警状态
    @Param("alarmResult") List<String> var6, // 参数6：告警结果
    @Param("judgeResults") List<String> var7,// 参数7：判断结果
    @Param("threatSeverity") List<String> var8, // 参数8：威胁等级
    @Param("focusObject") String var9,       // 参数9：焦点对象
    @Param("focusIp") String var10,          // 参数10：焦点IP
    @Param("startTime") String var11,        // 参数11：开始时间
    @Param("isScenario") Integer var12,      // 参数12：是否场景
    @Param("size") Long var13,               // 参数13：分页大小
    @Param("offSet") Long var14,             // 参数14：分页偏移
    @Param("tagSearch") List<String> var15,  // 参数15：标签搜索（新增）
    @Param("killChain") List<String> var16   // 参数16：攻击链（新增）
);
```

**修复点：**
- ✓ 从14个参数增加到16个参数
- ✓ 新增`tagSearch`和`killChain`参数
- ✓ 参数顺序完全按照反编译定义

### 5. getByEventCode
**真实接口定义：**
```java
Map<String, Object> getByEventCode(@Param("eventCode") String var1);
```

**修复点：**
- ✓ 返回类型从`List<Map>`改为单个`Map<String, Object>`

### 6. selectEventAndTempById
**真实接口定义：**
```java
Map<String, Object> selectEventAndTempById(@Param("ids") Integer[] var1);
```

**修复点：**
- ✓ 参数类型从`List<Integer>`改为`Integer[]`数组

### 7. selectAllByIdList
**真实接口定义：**
```java
List<Map<String, Object>> selectAllByIdList(@Param("evenIdList") List<String> var1);
```

**修复点：**
- ✓ 参数类型从`List<Integer>`改为`List<String>`

### 8. getFilterContent
**真实接口定义：**
```java
String getFilterContent(@Param("id") Integer[] var1);
```

**修复点：**
- ✓ 参数类型从`Integer`改为`Integer[]`数组

### 9. getCount - 12个参数（重要！）
**真实接口定义：**
```java
Long getCount(
    @Param("name") String var1, 
    @Param("endTime") String var2,           // 注意：endTime在第2位
    @Param("subCategory") List<String> var3, 
    @Param("alarmStatus") List<String> var4, 
    @Param("alarmResult") List<String> var5, 
    @Param("judgeResults") List<String> var6, 
    @Param("threatSeverity") List<String> var7, 
    @Param("focusObject") String var8, 
    @Param("focusIp") String var9, 
    @Param("startTime") String var10,        // 注意：startTime在第10位
    @Param("tagSearch") List<String> var11,  // 新增
    @Param("killChain") List<String> var12   // 新增
);
```

**修复点：**
- ✓ 从11个参数增加到12个参数
- ✓ 新增`tagSearch`和`killChain`参数
- ✓ 参数顺序：endTime在前，startTime在后

### 10. queryFocusIps - 6个参数（重要！）
**真实接口定义：**
```java
List<Map<String, String>> queryFocusIps(
    @Param("startTime") String var1,   // 新增
    @Param("endTime") String var2,     // 新增
    @Param("eventCode") String var3, 
    @Param("ip") String var4, 
    @Param("offset") long var5,        // 注意：offset，不是offSet
    @Param("size") long var7
);
```

**修复点：**
- ✓ 从4个参数增加到6个参数
- ✓ 新增`startTime`和`endTime`参数
- ✓ 参数类型为`long`基本类型
- ✓ 返回类型为`List<Map<String, String>>`

### 11. queryFocusIpCount - 4个参数
**真实接口定义：**
```java
Long queryFocusIpCount(
    @Param("startTime") String var1,   // 新增
    @Param("endTime") String var2,     // 新增
    @Param("eventCode") String var3, 
    @Param("ip") String var4
);
```

**修复点：**
- ✓ 从2个参数增加到4个参数
- ✓ 新增`startTime`和`endTime`参数

### 12. updateStatus
**真实接口定义：**
```java
void updateStatus(RiskIncident var1);
```

**修复点：**
- ✓ 参数从独立的`alarmStatus`和`eventCode`改为整个`RiskIncident`对象

### 13. updateJudgeResults
**真实接口定义：**
```java
void updateJudgeResults(
    @Param("id") Long var1,              // Long类型
    @Param("judgeResult") Integer var2   // Integer类型
);
```

**修复点：**
- ✓ `judgeResult`类型从`String`改为`Integer`

### 14. updateJudgeStatus
**真实接口定义：**
```java
void updateJudgeStatus(
    @Param("id") Long var1,           // Long类型
    @Param("judgeStatus") String var2
);
```

**修复点：**
- ✓ `id`类型从`Integer`改为`Long`

### 15. FocusIpMessage
**真实接口定义：**
```java
List<Map<String, Object>> FocusIpMessage(
    @Param("id") Integer var1, 
    @Param("ip") String var2, 
    @Param("size") long var3,     // long基本类型
    @Param("offSet") long var5    // long基本类型
);
```

**修复点：**
- ✓ size和offSet类型从`Long`改为`long`基本类型

### 16. getEventIdsById
**真实接口定义：**
```java
String getEventIdsById(@Param("id") int var1);  // int基本类型
```

**修复点：**
- ✓ 参数类型从`Integer`改为`int`基本类型

### 17. isHandled
**真实接口定义：**
```java
int isHandled(@Param("eventCodes") List<String> var1);  // 返回int
```

**修复点：**
- ✓ 返回类型从`Integer`改为`int`基本类型

## 完整方法列表（30个）

| 序号 | 方法名 | 参数数量 | 关键修复点 |
|-----|--------|---------|-----------|
| 1 | aggClueSecurityEventByName | 6 | topEventType顺序调整 |
| 2 | mappingNormalSecurityEvent | 6 | 同上 |
| 3 | backUpLastTermData | 2 | timestamp改为DateTime |
| 4 | batchInsertOrUpdateIncident | 1 | List参数 |
| 5 | selectOldIncidentByCodes | 2 | - |
| 6 | deleteOldIncident | 2 | 返回void |
| 7 | deleteOldIncidentAnalysis | 2 | 返回void |
| 8 | getRiskList | 16 | 增加tagSearch、killChain |
| 9 | getCountByStatus | 11 | - |
| 10 | getByEventCode | 1 | 返回单个Map |
| 11 | selectEventAndTempById | 1 | Integer[]数组 |
| 12 | selectAllByIdList | 1 | List<String> |
| 13 | queryEventCount | 11 | - |
| 14 | queryIncidentsCount | 11 | - |
| 15 | queryKillChains | 11 | - |
| 16 | getEventIdsById | 1 | int基本类型 |
| 17 | getFilterContent | 1 | Integer[]数组 |
| 18 | getRiskListByIds | 1 | - |
| 19 | FocusIpMessage | 4 | long基本类型 |
| 20 | getFocusObject | 1 | - |
| 21 | getCount | 12 | 增加tagSearch、killChain |
| 22 | queryFocusIps | 6 | 增加startTime、endTime |
| 23 | queryFocusIpCount | 4 | 增加startTime、endTime |
| 24 | getSecurityEventIdsByCondition | 7 | - |
| 25 | countByDate | 1 | - |
| 26 | selectIncidentForCheckScenario | 0 | 无参数 |
| 27 | updateStatus | 1 | RiskIncident对象 |
| 28 | isHandled | 1 | 返回int |
| 29 | updateJudgeResults | 2 | Long+Integer |
| 30 | updateJudgeStatus | 2 | Long+String |

## 需要的依赖

```xml
<!-- pom.xml 需要添加 Joda-Time 依赖 -->
<dependency>
    <groupId>joda-time</groupId>
    <artifactId>joda-time</artifactId>
    <version>2.10.14</version>
</dependency>
```

## TestController调用示例对比

### 修复前（错误）
```java
Map<String, Object> params = new HashMap<>();
params.put("startTime", "2026-01-25 00:00:00");
params.put("endTime", "2026-01-30 23:59:59");
// ...
List<RiskIncident> list = mapper.aggClueSecurityEventByName(params);
```

### 修复后（正确）
```java
List<RiskIncident> list = mapper.aggClueSecurityEventByName(
    "2026-01-25 00:00:00",      // startTime
    "2026-01-30 23:59:59",      // endTime
    "高级威胁",                  // topEventType
    Arrays.asList("High", "Medium"),  // threatSeverity
    Arrays.asList("OK", "FAIL"),      // alarmResults
    Arrays.asList(5001L, 5002L)       // excludeEventIds
);
```

## 核心差异总结

### 参数类型差异
1. **DateTime vs String**：`backUpLastTermData`的timestamp参数
2. **int vs Integer**：`getEventIdsById`、`isHandled`使用基本类型
3. **long vs Long**：`FocusIpMessage`、`queryFocusIps`的分页参数
4. **Integer[] vs List**：`selectEventAndTempById`、`getFilterContent`
5. **List<String> vs List<Integer>**：`selectAllByIdList`
6. **RiskIncident对象 vs 独立参数**：`updateStatus`

### 参数数量差异
1. **getRiskList**：16个参数（增加tagSearch、killChain）
2. **getCount**：12个参数（增加tagSearch、killChain）
3. **queryFocusIps**：6个参数（增加startTime、endTime）
4. **queryFocusIpCount**：4个参数（增加startTime、endTime）

### 返回类型差异
1. **getByEventCode**：返回单个`Map<String, Object>`，不是`List`
2. **多个方法返回void**：`backUpLastTermData`、`deleteOldIncident`、`deleteOldIncidentAnalysis`
3. **isHandled**：返回`int`基本类型

## 验证方法

1. 确保项目中包含Joda-Time依赖
2. 启动Spring Boot应用
3. 访问测试端点：
   ```
   GET http://localhost:8080/test/riskIncident/testAll
   ```
4. 查看每个方法的测试结果

## 修复文件清单

1. ✅ `xml_tests/RiskIncident/RiskIncidentMapper.java` - 完全按照反编译接口定义
2. ✅ `xml_tests/RiskIncident/RiskIncidentTestController.java` - 所有调用与接口匹配

## 总结

本次修复完全基于项目反编译的真实接口定义，确保了：
- ✅ 所有30个方法的参数类型、数量、顺序完全正确
- ✅ 所有返回类型与真实接口一致
- ✅ TestController的所有调用与Mapper接口完全匹配
- ✅ 类型安全，编译期可检查错误

特别是用户关注的`aggClueSecurityEventByName`方法，现在使用正确的6个独立参数，参数顺序也完全正确。
