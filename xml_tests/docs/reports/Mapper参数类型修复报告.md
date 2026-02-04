# Mapper参数类型修复报告

生成时间：2026-01-26

## 一、问题说明

在MyBatis XML中，如果使用`#{paramName}`这种形式的参数引用，Mapper接口应该：

1. **独立参数**：如果有多个独立参数（如`#{os}`, `#{perspective}`, `#{type}`），Mapper方法应该定义为：
   ```java
   List<Result> selectListByParams(String os, String perspective, String type);
   ```

2. **实体对象**：如果参数很多（>=10个）且像是实体属性，应该使用实体对象：
   ```java
   void insertEntity(Entity entity);
   ```

3. **集合参数**：如果XML中有`collection="xxxList"`，参数名必须匹配：
   ```java
   void batchInsert(List<Entity> xxxList);  // 参数名必须是xxxList
   ```

## 二、已修复的Mapper（3个）

### 1. ✅ AttackKnowledgeMapper
**修复内容：**
- `selectListByParams(String os, String perspective, String type)` - 从Map改为3个独立参数
- `updateByCode(String techniqueCode, String os, String perspective, String deviceType)` - 从Map改为4个独立参数
- `batchInsert(List<AttackKnowledge> attackUpdateList)` - 从Map改为List参数

**对应Controller：** `xml_tests/AttackKnowledge/AttackKnowledgeTestController.java` ✅ 已同步修复

### 2. ✅ AssetInfoMapper
**修复内容：**
- `queryAssets(int offset, int size)` - 添加了2个分页参数

**对应Controller：** `xml_tests/AssetInfo/AssetInfoTestController.java` ✅ 已同步修复

### 3. ✅ OutGoingConfigMapper
**修复内容：**
- `selectOutGoingConfig(String type, Boolean enable)` - 2个独立参数
- `selectOutGoingConfigCount(String type, Boolean enable)` - 2个独立参数
- `selectOutGoingConfigByPage(String type, Boolean enable, int offset, int size)` - 4个独立参数
- `updateSwitchById(Integer id, Boolean enable)` - 2个独立参数
- `selectKbrCount(Integer id, String serverAddress, String kdcServerName)` - 3个独立参数

**对应Controller：** `xml_tests/OutGoingConfig/OutGoingConfigTestController.java` ✅ 已同步修复

## 三、需要修复的Mapper（高优先级）

### 4. BlockHistoryMapper（需要修复）
**位置：** `xml_tests/BlockHistory/`

**需要修复的方法：**
```java
// 当前（错误）
Object getHistoryByIp();

// 应该改为（正确）
List<BlockHistory> getHistoryByIp(String srcAddress, String destAddress, String linkDeviceIp);
```

```java
// 当前（错误）
Object getBlockHistoryByCondition();

// 应该改为（正确）
List<BlockHistory> getBlockHistoryByCondition(Integer strategyId, String linkDeviceIp);
```

```java
// 当前（错误）
void updateDeviceIpAndId(BlockHistory entity);

// 应该改为（正确）
void updateDeviceIpAndId(String previousDeviceId, String currentDeviceId, String linkDeviceType, String masterHost);
```

### 5. IntelligenceMapper（需要修复）
**位置：** `xml_tests/Intelligence/`

**需要修复的方法：**
```java
List<Intelligence> subListCount(String ioC, String startTime, String endTime);
void updateTag(String ioC, String tag, String eventTime);
void updateAssetTag(String ioC, String tag, String assetIp, String eventTime);
```

### 6. LinkedStrategyMapper（需要修复）
**位置：** `xml_tests/LinkedStrategy/`

**需要修复的方法：**
```java
void enableLinkStrategy(Integer strategyId, Boolean status);
void updateAppId(String oldAppId, String appId);
```

### 7. LinkedStrategyValidtimeMapper（需要修复）
**位置：** `xml_tests/LinkedStrategyValidtime/`

**需要修复的方法：**
```java
void deleteEndtime(String blockIp, String blockDomain, String direction, String linkDeviceIp, Integer nodeId, String effectTime);
```

### 8. ProhibitHistoryMapper（需要修复）⚠️ 重要
**位置：** `xml_tests/ProhibitHistory/`

**需要修复的方法：**
```java
void updateByBlockipAndDeviceIp(String blockIp, String blockDomain, String direction, String effectTime, String linkDeviceIp, Integer nodeId);
List<ProhibitHistory> getProhibitListByDeviceId(Integer deviceId, Integer strategyId);
List<ProhibitHistory> findEdrProhibitHistory(String blockIp, String blockDomain, String secondIp, String terminalId);
List<ProhibitHistory> getAiGentNoDirectionHistory(String agentId, String localIp, String remoteIp);
List<ProhibitHistory> getAiGentProhibitDomain(String agentId, String requestDomain);
void updateDeviceIpAndId(String previousDeviceId, String currentDeviceId, String linkDeviceType, String masterHost);
int countEdrProhibit(String blockIp, String direction, String effectTime, String linkDeviceIp, String nodeIp);
```

### 9. QueryTemplateMapper（需要修复）
**位置：** `xml_tests/QueryTemplate/`

**需要修复的方法：**
```java
void updateById(Integer id, String lastExecuteTime);
```

### 10. RiskIncidentMapper（需要修复）⚠️ 重要
**位置：** `xml_tests/RiskIncident/`

**需要修复的方法：**
```java
void backUpLastTermData(String currentDate, String timestamp);
List<RiskIncident> FocusIpMessage(Integer id, String ip, int offSet, int size);
List<String> queryFocusIps(String eventCode, String ip, int size);
int queryFocusIpCount(String eventCode, String ip);
void updateStatus(String eventCode, Integer alarmStatus);
void updateJudgeResults(Integer id, String judgeResult);
void updateJudgeStatus(Integer id, String judgeStatus);
```

### 11. RiskIncidentHistoryMapper（需要修复）
**位置：** `xml_tests/RiskIncidentHistory/`

**需要修复的方法：**
```java
List<RiskIncidentHistory> FocusIpMessage(Integer id, String ip, int offSet, int size);
int getFocusIpCount(Integer id, String ip);
List<String> queryFocusIps(String eventCode, String ip, int size, String timePart);
int queryFocusIpCount(String eventCode, String ip, String timePart);
int countByDate(String yesterdayDate, String currentDate);
```

### 12. RiskIncidentOutGoingMapper（需要修复）
**位置：** `xml_tests/RiskIncidentOutGoing/`

**需要修复的方法：**
```java
void backUpLastTermData(String currentDate, String timestamp);
List<RiskIncidentOutGoing> queryOutGoingList(String startTime, String endTime, String lastTermTime, int offset, int size);
List<Integer> selectOldHistoryIds(String beforeTime, int offset, int size);
```

### 13. RiskIncidentOutGoingHistoryMapper（需要修复）
**位置：** `xml_tests/RiskIncidentOutGoingHistory/`

**需要修复的方法：**
```java
List<RiskIncidentOutGoingHistory> queryOutGoingList(String startTime, String endTime, int offset, int size);
```

### 14. SecurityEventMapper（需要修复）⚠️ 重要
**位置：** `xml_tests/SecurityEvent/`

**需要修复的方法：**
```java
List<SecurityEvent> queryTrend(String startTime, String endTime);
List<SecurityEvent> queryOverview(String startTime, String endTime, String keyword);
void updateStatus(String eventCode, Integer alarmStatus);
void updateAlarmResultById(Integer eventId, String alarmResults);
void updateThreadLowPriority(String focusIp, Integer focus, Integer priority, String timePart);
void deleteLowPriority(String focusIp, Integer focus, Integer priority, String timePart);
List<SecurityEvent> queryThreadAlarm(String timePart, String subCategory, String attacker, String victim, int offset);
void deleteTimingTask(String focusIp, Integer focus, Integer priority, String timePart);
List<SecurityEvent> getSecurityEventOutGoingTemplate(String startTime, String endTime);
```

### 15. StrategyDeviceRelMapper（需要修复）
**位置：** `xml_tests/StrategyDeviceRel/`

**需要修复的方法：**
```java
void deleteRelByStrategyIdAndDeviceId(Integer strategyId, Integer deviceId);
void updateDeviceIpAndId(String previousDeviceId, String currentDeviceId, String masterHost);
```

### 16. ThirdAuthMapper（需要修复）
**位置：** `xml_tests/ThirdAuth/`

**需要修复的方法：**
```java
ThirdAuth getThirdAuth(String ip, String machineCode);
```

## 四、不需要修复的Mapper（实体对象参数）

以下Mapper的方法参数过多（>=10个），应该使用实体对象，当前实现是正确的：

1. **EventTemplateMapper**
   - `updateByUniqCode(EventTemplate entity)` - 18个参数
   - `updateByIncidentName(EventTemplate entity)` - 16个参数

2. **VulAnalysisSubMapper**
   - `insertOrUpdate(VulAnalysisSub entity)` - 27个参数

3. **SecurityEventMapper** (部分方法)
   - `insertOrUpdate(SecurityEvent entity)` - 26个参数

4. **ScenarioDataMapper**
   - `insertOrUpdate(ScenarioData entity)` - 9个参数

## 五、修复建议

### 方法1：手动逐个修复（推荐）
针对您的xml_tests目录中已生成的Controller，逐个检查并修复对应的Mapper和Controller。

**优点：** 质量可控，可以根据实际业务调整参数类型
**缺点：** 工作量较大

### 方法2：使用脚本批量修复
我已经创建了`batch_fix_mapper_params.py`脚本，可以批量分析并生成修复建议。

**使用方法：**
```bash
python batch_fix_mapper_params.py
```

### 方法3：增量修复
只修复测试时发现问题的Mapper，其他的暂时保留。

## 六、修复checklist

优先级从高到低：

- [x] AttackKnowledgeMapper ✅
- [x] AssetInfoMapper ✅
- [x] OutGoingConfigMapper ✅
- [ ] ProhibitHistoryMapper ⚠️ 重要（7个方法）
- [ ] SecurityEventMapper ⚠️ 重要（9个方法）
- [ ] RiskIncidentMapper ⚠️ 重要（7个方法）
- [ ] BlockHistoryMapper（3个方法）
- [ ] IntelligenceMapper（3个方法）
- [ ] LinkedStrategyMapper（2个方法）
- [ ] LinkedStrategyValidtimeMapper（1个方法）
- [ ] QueryTemplateMapper（1个方法）
- [ ] RiskIncidentHistoryMapper（5个方法）
- [ ] RiskIncidentOutGoingMapper（3个方法）
- [ ] RiskIncidentOutGoingHistoryMapper（1个方法）
- [ ] StrategyDeviceRelMapper（2个方法）
- [ ] ThirdAuthMapper（1个方法）

## 七、后续工作

1. **测试验证**：每修复一个Mapper，都应该执行对应的Controller测试，确保参数传递正确
2. **文档更新**：更新快速开始.md，说明正确的参数类型
3. **代码审查**：对修复的代码进行审查，确保没有遗漏

## 八、常见问题

### Q1: 如何判断应该用独立参数还是Map？
**A:** 查看XML中的test条件：
- 如果是 `test="xxx != null and xxx != ''"` → 独立参数
- 如果参数很多（>=10个）→ 实体对象
- 如果有`collection="xxx"` → List参数，且参数名必须匹配

### Q2: 参数类型如何确定？
**A:** 根据参数名推断：
- 以`Id`结尾 → `Integer`
- `enable`, `is开头` → `Boolean`
- `offset`, `size`, `count`, `limit` → `int`
- `time`, `date`, `code`, `name`, `address`, `ip` → `String`

### Q3: Controller中如何调用修复后的Mapper方法？
**A:** 直接传递独立参数，不要用Map：
```java
// 错误❌
Map<String, Object> params = new HashMap<>();
params.put("os", "Windows");
mapper.selectListByParams(params);

// 正确✅
String os = "Windows";
String perspective = "all";
String type = "endpoint";
mapper.selectListByParams(os, perspective, type);
```
