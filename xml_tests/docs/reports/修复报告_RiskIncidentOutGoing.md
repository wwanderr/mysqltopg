# RiskIncidentOutGoing & RiskIncidentOutGoingHistory 完整修复报告

## 修复时间：2026-01-30

## 修复依据
根据项目反编译的真实Mapper接口定义进行完整修复

---

## 一、RiskIncidentOutGoing修复

### 1.1 Mapper接口修复

#### 关键变化总结
| 序号 | 方法名 | 修复前参数 | 修复后参数 | 变化说明 |
|------|--------|-----------|-----------|----------|
| 1 | mappingFromClueSecurityEvent | Map params | List<Long> eventIds | Map改为具体参数 |
| 2 | backUpLastTermData | Map params | String currentDate, DateTime timestamp | Map改为2个参数 |
| 3 | batchInsertOrUpdateIncident | List list | List riskIncidentList | 参数名修正 |
| 4 | deleteOldIncident | Integer saveDays | String currentDate, List<Long> ids | 完全不同的参数 |
| 5 | queryListByTime | 2个参数 | 4个参数（增加offset, size） | 增加分页参数 |
| 6 | batchUpdatePayload | List list | List（无@Param） | 去除@Param注解 |
| 7 | updateKillChain | Long id, String killChain | String beforeTime | 完全不同的参数 |
| 8 | clearHistoryData | Integer saveDays | DateTime timestamp | 参数类型变化 |
| 9 | queryOutGoingList | Map params | 5个独立参数 | Map改为5个参数 |
| 10 | selectOldIncidentByCodes | List codes, Integer saveDays | String currentDate, List excludeUniqCodes | 参数名和类型变化 |
| 11 | groupByFocusIp | List focusIps | 4个参数（增加startTime, endTime, top） | 增加3个参数 |
| 12 | groupNameByFocusIp | List focusIps | 3个参数（增加startTime, endTime） | 增加2个参数 |
| 13 | selectOldHistoryIds | Integer saveDays | 3个参数（beforeTime, lastId, size） | 完全不同的参数 |
| 14 | deleteHistoryByIds | @Param List | @Param List | 返回类型从int改为void |

#### 详细修复内容

**修复前（错误）：**
```java
@Mapper
public interface RiskIncidentOutGoingMapper {
    List<RiskIncidentOutGoing> mappingFromClueSecurityEvent(@Param("params") Map<String, Object> params);
    int backUpLastTermData(@Param("params") Map<String, Object> params);
    int deleteOldIncident(@Param("saveDays") Integer saveDays);
    List<RiskIncidentOutGoing> queryListByTime(@Param("startTime") String startTime, @Param("endTime") String endTime);
    void updateKillChain(@Param("id") Long id, @Param("killChain") String killChain);
    // ... 等等
}
```

**修复后（正确）：**
```java
@Mapper
public interface RiskIncidentOutGoingMapper extends BaseMapper<RiskIncidentOutGoing> {
    // 方法1: 参数改为List<Long> eventIds
    List<RiskIncidentOutGoing> mappingFromClueSecurityEvent(@Param("eventIds") List<Long> var1);
    
    // 方法2: 参数改为currentDate和DateTime timestamp
    void backUpLastTermData(
        @Param("currentDate") String var1,
        @Param("timestamp") DateTime var2
    );
    
    // 方法4: 参数改为currentDate和ids
    void deleteOldIncident(
        @Param("currentDate") String var1,
        @Param("ids") List<Long> var2
    );
    
    // 方法5: 增加offset和size参数
    List<RiskIncidentOutGoing> queryListByTime(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("offset") long var3,
        @Param("size") long var5
    );
    
    // 方法7: 参数改为只有beforeTime
    void updateKillChain(@Param("beforeTime") String var1);
    
    // 方法8: 参数改为queryOutGoingList的5个独立参数
    List<Map<String, Object>> queryOutGoingList(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("lastTermTime") String var3,
        @Param("offset") long var4,
        @Param("size") long var6
    );
    
    // 方法11: 增加startTime, endTime, top参数
    List<Map<String, Object>> groupByFocusIp(
        @Param("focusIps") List<String> var1,
        @Param("startTime") String var2,
        @Param("endTime") String var3,
        @Param("top") Integer var4
    );
    
    // ... 其他方法
}
```

### 1.2 TestController修复

#### 主要变化
1. **删除了不存在的方法**：mappingNormalSecurityEvent（反编译接口中没有）
2. **所有方法改用独立参数**：不再使用Map传参
3. **方法数量**：从15个（包含错误方法）改为14个（与反编译接口一致）

#### 修复示例

**修复前（错误）：**
```java
@GetMapping("/mappingFromClueSecurityEvent")
public String testMappingFromClueSecurityEvent() {
    Map<String, Object> params1 = new HashMap<>();
    params1.put("eventIds", Arrays.asList(1001, 1002, 1003));
    List<RiskIncidentOutGoing> result1 = mapper.mappingFromClueSecurityEvent(params1);
    // ...
}
```

**修复后（正确）：**
```java
@GetMapping("/testMappingFromClueSecurityEvent")
public String testMappingFromClueSecurityEvent() {
    List<RiskIncidentOutGoing> result = mapper.mappingFromClueSecurityEvent(
        Arrays.asList(1001L, 1002L, 1003L)  // 直接传List参数
    );
    // ...
}
```

### 1.3 test_data.sql检查

#### 检查结果：✅ 无需修改
- template_id使用varchar类型，数据为字符串`'APT_ATTACK'` ✓
- security_incident_id使用整数类型 ✓
- 所有时间字段使用动态时间`CURRENT_TIMESTAMP - INTERVAL` ✓
- 字段类型与DDL定义一致 ✓

---

## 二、RiskIncidentOutGoingHistory修复

### 2.1 Mapper接口修复

#### 关键变化
**修复前（错误）：**
```java
@Mapper
public interface RiskIncidentOutGoingHistoryMapper {
    List<RiskIncidentOutGoing> mappingFromClueSecurityEvent(@Param("params") Map<String, Object> params);
    List<RiskIncidentOutGoing> mappingNormalSecurityEvent(@Param("params") Map<String, Object> params);
    // ... 9个自定义方法
}
```

**修复后（正确）：**
```java
@Mapper
public interface RiskIncidentOutGoingHistoryMapper extends BaseMapper<RiskIncidentOutGoingHistory> {
    // 空接口，所有CRUD方法继承自BaseMapper
}
```

#### 说明
根据反编译接口，RiskIncidentOutGoingHistoryMapper只继承BaseMapper，没有任何自定义方法。所有CRUD操作通过MyBatis-Plus的BaseMapper提供。

### 2.2 TestController修复

#### 主要变化
1. **删除所有自定义方法测试**：mappingFromClueSecurityEvent等
2. **改为测试BaseMapper方法**：
   - selectById
   - selectList
   - selectCount
   - selectBatchIds
   - insert
   - updateById
   - deleteById
   - delete

#### 修复示例

**修复后（正确）：**
```java
@GetMapping("/testSelectById")
public String testSelectById() {
    RiskIncidentOutGoingHistory result = mapper.selectById(1001L);
    // BaseMapper的标准方法
}

@GetMapping("/testSelectList")
public String testSelectList() {
    QueryWrapper<RiskIncidentOutGoingHistory> wrapper = new QueryWrapper<>();
    wrapper.ge("id", 1001).le("id", 1010);
    List<RiskIncidentOutGoingHistory> result = mapper.selectList(wrapper);
    // 使用MyBatis-Plus的QueryWrapper
}
```

### 2.3 test_data.sql检查

#### 检查结果：✅ 无需修改
- 字段类型与DDL一致 ✓
- 26个字段完整 ✓
- 数据格式正确 ✓

---

## 三、需要的依赖

```xml
<!-- pom.xml需要确保包含以下依赖 -->
<dependencies>
    <!-- Joda-Time (用于DateTime参数) -->
    <dependency>
        <groupId>joda-time</groupId>
        <artifactId>joda-time</artifactId>
        <version>2.10.14</version>
    </dependency>
    
    <!-- MyBatis-Plus (RiskIncidentOutGoingHistoryMapper需要) -->
    <dependency>
        <groupId>com.baomidou</groupId>
        <artifactId>mybatis-plus-boot-starter</artifactId>
        <version>3.5.3.1</version>
    </dependency>
</dependencies>
```

---

## 四、测试验证步骤

### 4.1 RiskIncidentOutGoing测试
```bash
# 1. 导入测试数据
psql -U postgres -d your_database -f C:\Users\wcss\Desktop\mysqlToPg\xml_tests\RiskIncidentOutGoing\test_data.sql

# 2. 启动应用

# 3. 运行测试
GET http://localhost:8080/test/riskIncidentOutGoing/testAll
```

**预期输出：**
```
✓ testMappingFromClueSecurityEvent: SUCCESS: X
✓ testBackUpLastTermData: SUCCESS: backup completed
✓ testBatchInsertOrUpdateIncident: SUCCESS: 1
✓ testDeleteOldIncident: SUCCESS: deleted
✓ testQueryListByTime: SUCCESS: X
✓ testBatchUpdatePayload: SUCCESS: 1
✓ testClearHistoryData: SUCCESS: cleared
✓ testQueryOutGoingList: SUCCESS: X
✓ testSelectOldIncidentByCodes: SUCCESS: X
✓ testUpdateKillChain: SUCCESS: updated
✓ testGroupByFocusIp: SUCCESS: X
✓ testGroupNameByFocusIp: SUCCESS: X
✓ testSelectOldHistoryIds: SUCCESS: X
✓ testDeleteHistoryByIds: SUCCESS: deleted

测试汇总: 成功=14, 失败=0, 总计=14
```

### 4.2 RiskIncidentOutGoingHistory测试
```bash
# 1. 导入测试数据
psql -U postgres -d your_database -f C:\Users\wcss\Desktop\mysqlToPg\xml_tests\RiskIncidentOutGoingHistory\test_data.sql

# 2. 运行测试
GET http://localhost:8080/test/riskIncidentOutGoingHistory/testAll
```

**预期输出：**
```
✓ testSelectById: SUCCESS: 1
✓ testSelectList: SUCCESS: X
✓ testSelectCount: SUCCESS: X
✓ testSelectBatchIds: SUCCESS: 3
✓ testInsert: SUCCESS: 1
✓ testUpdateById: SUCCESS: 1
✓ testDeleteById: SUCCESS: 0
✓ testDelete: SUCCESS: X

测试汇总: 成功=8, 失败=0, 总计=8
```

---

## 五、修复文件清单

### RiskIncidentOutGoing
1. ✅ `RiskIncidentOutGoingMapper.java` - 14个方法完全按反编译定义修复
2. ✅ `RiskIncidentOutGoingTestController.java` - 14个测试方法，使用正确参数
3. ✅ `test_data.sql` - 检查通过，无需修改
4. ✅ `修复报告.md` - 本报告

### RiskIncidentOutGoingHistory
1. ✅ `RiskIncidentOutGoingHistoryMapper.java` - 空接口，只继承BaseMapper
2. ✅ `RiskIncidentOutGoingHistoryTestController.java` - 8个BaseMapper方法测试
3. ✅ `test_data.sql` - 检查通过，无需修改

---

## 六、关键修复点总结

### 🔴 高优先级修复
1. ✅ Mapper接口参数从Map改为独立参数
2. ✅ RiskIncidentOutGoingHistoryMapper改为空接口
3. ✅ TestController所有调用改用正确参数
4. ✅ 删除不存在的mappingNormalSecurityEvent方法

### 🟡 中优先级修复
5. ✅ 返回类型修正（int改为void等）
6. ✅ 参数名修正（list改为riskIncidentList等）
7. ✅ 增加缺失的参数（offset、size、startTime、endTime等）

### 🟢 低优先级优化
8. ✅ 添加Mapper继承BaseMapper
9. ✅ 使用var1、var2等变量名（与反编译一致）
10. ✅ 统一异常处理

---

## 七、与RiskIncident修复的对比

| 项目 | RiskIncident | RiskIncidentOutGoing | RiskIncidentOutGoingHistory |
|------|-------------|----------------------|----------------------------|
| Mapper方法数 | 30个 | 14个 | 0个（只继承BaseMapper） |
| test_data问题 | template_id类型错误 | 无问题 | 无问题 |
| 参数修复 | Map改独立参数 | Map改独立参数 | 不适用 |
| 查询条件问题 | judgeResults类型错误 | 无问题 | 不适用 |
| TestController | 30个测试方法 | 14个测试方法 | 8个BaseMapper测试 |

---

## 八、总结

✅ **两个模块全部修复完成**

**RiskIncidentOutGoing：**
- 14个方法全部按照反编译接口定义修复
- 所有参数类型、数量、顺序完全正确
- TestController使用正确的调用方式
- test_data.sql无需修改

**RiskIncidentOutGoingHistory：**
- Mapper改为空接口，只继承BaseMapper
- TestController测试MyBatis-Plus的基本CRUD方法
- test_data.sql无需修改

**建议：**
- 重新启动应用
- 运行testAll方法验证所有测试用例
- 如有问题，检查Joda-Time和MyBatis-Plus依赖是否正确引入
