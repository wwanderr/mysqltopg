package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncident;
import com.dbapp.extension.xdr.entity.CommonFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.joda.time.DateTime;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * RiskIncident (风险事件) 深度测试控制器
 * 主表：t_risk_incidents
 * 关联表：t_event_template, t_query_template, t_security_incidents
 * 测试方法数：30
 * 生成时间：2026-01-30 (已根据项目反编译的真实Mapper接口完全修复)
 */
@RestController
@RequestMapping("/test/riskIncident")
public class RiskIncidentTestController {
    @Autowired
    private RiskIncidentMapper mapper;

    /**
     * 方法1：aggClueSecurityEventByName
     * 参数：startTime, endTime, topEventType, threatSeverity, alarmResults, excludeEventIds (6个)
     */
    @GetMapping("/testAggClueSecurityEventByName")
    public String testAggClueSecurityEventByName() {
        try {
            System.out.println("测试: aggClueSecurityEventByName - 聚合线索安全事件");
            
            List<RiskIncident> list = mapper.aggClueSecurityEventByName(
                "2026-01-25 00:00:00",      // var1: startTime
                "2026-01-30 23:59:59",      // var2: endTime
                "高级威胁",                  // var3: topEventType
                Arrays.asList("High", "Medium"),  // var4: threatSeverity
                Arrays.asList("OK", "FAIL"),      // var5: alarmResults
                Arrays.asList(5001L, 5002L)       // var6: excludeEventIds
            );
            
            System.out.println("结果: 查询到 " + list.size() + " 条聚合数据");
            if (!list.isEmpty()) {
                RiskIncident first = list.get(0);
                System.out.println("样例: name=" + first.getName() + ", threatSeverity=" + first.getThreatSeverity());
            }
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testAggClueSecurityEventByName 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：mappingNormalSecurityEvent
     * 参数：startTime, endTime, topEventType, threatSeverity, alarmResults, excludeEventIds (6个)
     */
    @GetMapping("/testMappingNormalSecurityEvent")
    public String testMappingNormalSecurityEvent() {
        try {
            System.out.println("测试: mappingNormalSecurityEvent - 映射普通安全事件");
            
            List<RiskIncident> list = mapper.mappingNormalSecurityEvent(
                "2026-01-25 00:00:00",   // var1: startTime
                "2026-01-30 23:59:59",   // var2: endTime
                null,                     // var3: topEventType (可选)
                Arrays.asList("High"),    // var4: threatSeverity
                Arrays.asList("OK"),      // var5: alarmResults
                null                      // var6: excludeEventIds (可选)
            );
            
            System.out.println("结果: 查询到 " + list.size() + " 条普通事件");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testMappingNormalSecurityEvent 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：backUpLastTermData
     * 参数：currentDate (String), timestamp (DateTime)
     */
    @GetMapping("/testBackUpLastTermData")
    public String testBackUpLastTermData() {
        try {
            System.out.println("测试: backUpLastTermData - 备份上一期数据");
            
            String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            DateTime timestamp = DateTime.now();
            
            mapper.backUpLastTermData(currentDate, timestamp);
            System.out.println("结果: 备份成功");
            return "SUCCESS: backup completed";
        } catch (Exception e) {
            String errorMsg = "测试方法 testBackUpLastTermData 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法4：batchInsertOrUpdateIncident
     * 参数：riskIncidentList (List<RiskIncident>)
     */
    @GetMapping("/testBatchInsertOrUpdateIncident")
    public String testBatchInsertOrUpdateIncident() {
        try {
            System.out.println("测试: batchInsertOrUpdateIncident - 批量插入或更新风险事件");
            
            List<RiskIncident> list = new ArrayList<>();
            RiskIncident incident = new RiskIncident();
            incident.setEventCode("TEST_CODE_001");
            incident.setName("测试风险事件");
            incident.setTemplateId(2001);
            incident.setThreatSeverity("High");
            incident.setStartTime("2026-01-30 10:00:00");
            incident.setEndTime("2026-01-30 11:00:00");
            incident.setAlarmStatus("unprocessed");
            incident.setAlarmResults("OK");
            list.add(incident);
            
            mapper.batchInsertOrUpdateIncident(list);
            System.out.println("结果: 批量插入/更新 " + list.size() + " 条数据");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testBatchInsertOrUpdateIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法5：selectOldIncidentByCodes
     * 参数：currentDate, excludeEventCodes
     */
    @GetMapping("/testSelectOldIncidentByCodes")
    public String testSelectOldIncidentByCodes() {
        try {
            System.out.println("测试: selectOldIncidentByCodes - 根据代码选择旧事件");
            
            String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            
            List<Long> ids = mapper.selectOldIncidentByCodes(
                currentDate,
                Arrays.asList("EXCLUDE_001", "EXCLUDE_002")
            );
            System.out.println("结果: 查询到 " + ids.size() + " 个旧事件ID");
            return "SUCCESS: " + ids.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectOldIncidentByCodes 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法6：deleteOldIncident
     * 参数：currentDate, excludeEventCodes
     */
    @GetMapping("/testDeleteOldIncident")
    public String testDeleteOldIncident() {
        try {
            System.out.println("测试: deleteOldIncident - 删除旧的风险事件");
            
            String currentDate = "2026-01-29";  // 使用昨天的日期
            
            mapper.deleteOldIncident(
                currentDate,
                Arrays.asList("KEEP_CODE_001")
            );
            System.out.println("结果: 删除成功");
            return "SUCCESS: deleted";
        } catch (Exception e) {
            String errorMsg = "测试方法 testDeleteOldIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法7：deleteOldIncidentAnalysis
     * 参数：currentDate, excludeEventCodes
     */
    @GetMapping("/testDeleteOldIncidentAnalysis")
    public String testDeleteOldIncidentAnalysis() {
        try {
            System.out.println("测试: deleteOldIncidentAnalysis - 删除旧的风险事件分析");
            
            String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            
            mapper.deleteOldIncidentAnalysis(
                currentDate,
                Arrays.asList("KEEP_CODE_001", "KEEP_CODE_002")
            );
            System.out.println("结果: 删除成功");
            return "SUCCESS: deleted";
        } catch (Exception e) {
            String errorMsg = "测试方法 testDeleteOldIncidentAnalysis 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法8：getRiskList
     * 参数：orderByStr, name, endTime, subCategory, alarmStatus, alarmResult, judgeResults, 
     *       threatSeverity, focusObject, focusIp, startTime, isScenario, size, offSet, tagSearch, killChain (16个)
     */
    @GetMapping("/testGetRiskList")
    public String testGetRiskList() {
        try {
            System.out.println("测试: getRiskList - 获取风险事件列表");
            
            List<Map<String, Object>> list = mapper.getRiskList(
                "end_time desc",              // var1: orderByStr
                "APT",                        // var2: name
                "2026-01-30 23:59:59",       // var3: endTime
                Arrays.asList("持续性威胁", "勒索软件"),  // var4: subCategory（使用实际值）
                Arrays.asList("unprocessed", "processing"),  // var5: alarmStatus
                Arrays.asList("OK"),          // var6: alarmResult
                Arrays.asList("1", "2"),      // var7: judgeResults（整数字符串）
                Arrays.asList("High", "Medium"),  // var8: threatSeverity
                "attacker",                   // var9: focusObject
                "192.168",                    // var10: focusIp
                "2026-01-25 00:00:00",       // var11: startTime
                1,                            // var12: isScenario
                10L,                          // var13: size
                0L,                           // var14: offSet
                Arrays.asList("APT", "恶意软件"),  // var15: tagSearch
                Arrays.asList("侦察", "武器化")    // var16: killChain
            );
            
            System.out.println("结果: 查询到 " + list.size() + " 条风险事件");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetRiskList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法9：getCountByStatus
     * 参数：startTime, endTime, eventName, focusIp, focusObject, secondEventTypeChinese, 
     *       alarmStatus, alarmResult, judgeResults, threatSeverity, isScenario (11个)
     */
    @GetMapping("/testGetCountByStatus")
    public String testGetCountByStatus() {
        try {
            System.out.println("测试: getCountByStatus - 按状态统计数量");
            
            List<Map> list = mapper.getCountByStatus(
                "2026-01-25 00:00:00",  // var1: startTime
                "2026-01-30 23:59:59",  // var2: endTime
                null,                   // var3: eventName（设为null以匹配更多数据）
                null,                   // var4: focusIp（设为null）
                null,                   // var5: focusObject（设为null）
                Arrays.asList("持续性威胁", "勒索软件", "Pass-the-Hash"),  // var6: secondEventTypeChinese（使用实际值）
                Arrays.asList("unprocessed", "processing"),  // var7: alarmStatus
                Arrays.asList("OK"),    // var8: alarmResult
                Arrays.asList("1", "2"),  // var9: judgeResults（整数字符串）
                Arrays.asList("High"),  // var10: threatSeverity
                1                       // var11: isScenario
            );
            
            System.out.println("结果: 统计了 " + list.size() + " 种状态");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetCountByStatus 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法10：getByEventCode
     * 参数：eventCode
     * 返回：单个Map对象（不是List）
     */
    @GetMapping("/testGetByEventCode")
    public String testGetByEventCode() {
        try {
            System.out.println("测试: getByEventCode - 根据事件代码获取");
            
            Map<String, Object> result = mapper.getByEventCode("RISK_2026_001");
            System.out.println("结果: " + (result != null ? "查询成功" : "无数据"));
            return "SUCCESS: " + (result != null ? "1" : "0");
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetByEventCode 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法11：selectEventAndTempById
     * 参数：ids (Integer[]数组，不是List)
     */
    @GetMapping("/testSelectEventAndTempById")
    public String testSelectEventAndTempById() {
        try {
            System.out.println("测试: selectEventAndTempById - 根据ID选择事件和模板");
            
            Integer[] ids = new Integer[]{1001, 1002, 1003};
            Map<String, Object> result = mapper.selectEventAndTempById(ids);
            
            System.out.println("结果: " + (result != null ? "查询成功" : "无数据"));
            if (result != null) {
                System.out.println("  eventCode: " + result.get("eventCode"));
            }
            return "SUCCESS: " + (result != null ? "1" : "0");
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectEventAndTempById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法12：selectAllByIdList
     * 参数：evenIdList (List<String>，不是List<Integer>)
     */
    @GetMapping("/testSelectAllByIdList")
    public String testSelectAllByIdList() {
        try {
            System.out.println("测试: selectAllByIdList - 根据ID列表选择所有");
            
            List<Map<String, Object>> list = mapper.selectAllByIdList(
                Arrays.asList("1001", "1002", "1003")
            );
            System.out.println("结果: 查询到 " + list.size() + " 条记录");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectAllByIdList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法13：queryEventCount
     * 参数：11个（与getCountByStatus相同）
     */
    @GetMapping("/testQueryEventCount")
    public String testQueryEventCount() {
        try {
            System.out.println("测试: queryEventCount - 查询事件数量");
            
            List<Map> list = mapper.queryEventCount(
                "2026-01-25 00:00:00",
                "2026-01-30 23:59:59",
                null,  // eventName
                null,  // focusIp
                null,  // focusObject
                Arrays.asList("持续性威胁", "勒索软件"),  // secondEventTypeChinese（使用实际值）
                null,  // alarmStatus
                null,  // alarmResult
                Arrays.asList("1", "2"),  // judgeResults（整数字符串）
                Arrays.asList("High", "Medium"),  // threatSeverity
                null   // isScenario
            );
            
            System.out.println("结果: 统计了 " + list.size() + " 种威胁等级的数量");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryEventCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法14：queryIncidentsCount
     * 参数：11个
     */
    @GetMapping("/testQueryIncidentsCount")
    public String testQueryIncidentsCount() {
        try {
            System.out.println("测试: queryIncidentsCount - 查询事件统计");
            
            List<CommonFilter> list = mapper.queryIncidentsCount(
                "2026-01-25 00:00:00",
                "2026-01-30 23:59:59",
                null,  // eventName
                null,  // focusIp
                null,  // focusObject
                Arrays.asList("邮件钓鱼", "勒索软件", "Pass-the-Hash"),  // secondEventTypeChinese（使用实际值）
                null,  // alarmStatus
                null,  // alarmResult
                Arrays.asList("1", "2", "3"),  // judgeResults（整数字符串）
                null,  // threatSeverity
                null   // isScenario
            );
            
            System.out.println("结果: 统计了 " + list.size() + " 种事件类型");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryIncidentsCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法15：queryKillChains
     * 参数：11个
     */
    @GetMapping("/testQueryKillChains")
    public String testQueryKillChains() {
        try {
            System.out.println("测试: queryKillChains - 查询攻击链");
            
            List<String> list = mapper.queryKillChains(
                "2026-01-25 00:00:00",
                "2026-01-30 23:59:59",
                null,  // eventName
                null,  // focusIp
                null,  // focusObject
                Arrays.asList("持续性威胁", "DDoS攻击"),  // secondEventTypeChinese（使用实际值）
                null,  // alarmStatus
                null,  // alarmResult
                Arrays.asList("1", "2"),  // judgeResults（整数字符串）
                Arrays.asList("High"),  // threatSeverity
                1  // isScenario = 1
            );
            
            System.out.println("结果: 查询到 " + list.size() + " 个攻击链");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryKillChains 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法16：getEventIdsById
     * 参数：id (int基本类型)
     */
    @GetMapping("/testGetEventIdsById")
    public String testGetEventIdsById() {
        try {
            System.out.println("测试: getEventIdsById - 根据ID获取事件IDs");
            
            String eventIds = mapper.getEventIdsById(1001);
            System.out.println("结果: " + (eventIds != null ? eventIds : "null"));
            return "SUCCESS: " + (eventIds != null ? eventIds : "null");
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetEventIdsById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法17：getFilterContent
     * 参数：id (Integer[]数组)
     */
    @GetMapping("/testGetFilterContent")
    public String testGetFilterContent() {
        try {
            System.out.println("测试: getFilterContent - 获取过滤内容");
            
            Integer[] ids = new Integer[]{1001};
            String content = mapper.getFilterContent(ids);
            
            System.out.println("结果: " + (content != null ? "长度=" + content.length() : "null"));
            return "SUCCESS: " + (content != null ? "存在" : "null");
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetFilterContent 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法18：getRiskListByIds
     * 参数：ids (List<Long>)
     */
    @GetMapping("/testGetRiskListByIds")
    public String testGetRiskListByIds() {
        try {
            System.out.println("测试: getRiskListByIds - 根据IDs获取风险列表");
            
            List<RiskIncident> list = mapper.getRiskListByIds(Arrays.asList(1001L, 1002L, 1003L));
            System.out.println("结果: 查询到 " + list.size() + " 条风险事件");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetRiskListByIds 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法19：FocusIpMessage
     * 参数：id, ip, size (long), offSet (long) - 注意size和offSet是基本类型long
     */
    @GetMapping("/testFocusIpMessage")
    public String testFocusIpMessage() {
        try {
            System.out.println("测试: FocusIpMessage - 获取焦点IP消息");
            
            List<Map<String, Object>> list = mapper.FocusIpMessage(
                1001,      // var1: id
                "192.168", // var2: ip
                10L,       // var3: size (long基本类型)
                0L         // var5: offSet (long基本类型)
            );
            
            System.out.println("结果: 查询到 " + list.size() + " 条IP消息");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testFocusIpMessage 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法20：getFocusObject
     * 参数：id (Integer)
     */
    @GetMapping("/testGetFocusObject")
    public String testGetFocusObject() {
        try {
            System.out.println("测试: getFocusObject - 获取焦点对象");
            
            String focusObject = mapper.getFocusObject(1001);
            System.out.println("结果: " + (focusObject != null ? focusObject : "null"));
            return "SUCCESS: " + (focusObject != null ? focusObject : "null");
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetFocusObject 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法21：getCount
     * 参数：name, endTime, subCategory, alarmStatus, alarmResult, judgeResults, 
     *       threatSeverity, focusObject, focusIp, startTime, tagSearch, killChain (12个)
     */
    @GetMapping("/testGetCount")
    public String testGetCount() {
        try {
            System.out.println("测试: getCount - 获取总数");
            
            Long count = mapper.getCount(
                "APT",                   // var1: name
                "2026-01-30 23:59:59",  // var2: endTime
                Arrays.asList("持续性威胁", "勒索软件"),  // var3: subCategory（使用实际值）
                Arrays.asList("unprocessed"),  // var4: alarmStatus
                Arrays.asList("OK"),     // var5: alarmResult
                Arrays.asList("1", "2"),  // var6: judgeResults（整数字符串）
                Arrays.asList("High", "Medium"),  // var7: threatSeverity
                "attacker",              // var8: focusObject
                "192.168",               // var9: focusIp
                "2026-01-25 00:00:00",  // var10: startTime
                Arrays.asList("APT"),    // var11: tagSearch
                Arrays.asList("侦察")    // var12: killChain
            );
            
            System.out.println("结果: 总数=" + count);
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法22：queryFocusIps
     * 参数：startTime, endTime, eventCode, ip, offset (long), size (long) - 6个参数
     */
    @GetMapping("/testQueryFocusIps")
    public String testQueryFocusIps() {
        try {
            System.out.println("测试: queryFocusIps - 查询焦点IPs");
            
            List<Map<String, String>> list = mapper.queryFocusIps(
                "2026-01-25 00:00:00",  // var1: startTime
                "2026-01-30 23:59:59",  // var2: endTime
                "RISK_2026_001",        // var3: eventCode
                "192.168",              // var4: ip
                0L,                     // var5: offset (long基本类型)
                10L                     // var7: size (long基本类型)
            );
            
            System.out.println("结果: 查询到 " + list.size() + " 个焦点IP");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryFocusIps 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法23：queryFocusIpCount
     * 参数：startTime, endTime, eventCode, ip - 4个参数
     */
    @GetMapping("/testQueryFocusIpCount")
    public String testQueryFocusIpCount() {
        try {
            System.out.println("测试: queryFocusIpCount - 统计焦点IP数量");
            
            Long count = mapper.queryFocusIpCount(
                "2026-01-25 00:00:00",  // var1: startTime
                "2026-01-30 23:59:59",  // var2: endTime
                "RISK_2026_001",        // var3: eventCode
                "192.168"               // var4: ip
            );
            
            System.out.println("结果: 焦点IP数量=" + count);
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryFocusIpCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法24：getSecurityEventIdsByCondition
     * 参数：startTime, endTime, topEventType, threatSeverity, alarmResults, excludeEventIds, eventName (7个)
     */
    @GetMapping("/testGetSecurityEventIdsByCondition")
    public String testGetSecurityEventIdsByCondition() {
        try {
            System.out.println("测试: getSecurityEventIdsByCondition - 根据条件获取安全事件IDs");
            
            List<String> ids = mapper.getSecurityEventIdsByCondition(
                "2026-01-25 00:00:00",  // var1: startTime
                "2026-01-30 23:59:59",  // var2: endTime
                "高级威胁",              // var3: topEventType
                Arrays.asList("High"),   // var4: threatSeverity
                Arrays.asList("OK"),     // var5: alarmResults
                Arrays.asList(5001L),    // var6: excludeEventIds
                "APT攻击"                // var7: eventName
            );
            
            System.out.println("结果: 查询到 " + ids.size() + " 个安全事件ID");
            return "SUCCESS: " + ids.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetSecurityEventIdsByCondition 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法25：countByDate
     * 参数：date
     */
    @GetMapping("/testCountByDate")
    public String testCountByDate() {
        try {
            System.out.println("测试: countByDate - 按日期统计");
            
            String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            Integer count = mapper.countByDate(date);
            
            System.out.println("结果: 今日事件数=" + count);
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testCountByDate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法26：selectIncidentForCheckScenario
     * 参数：无
     */
    @GetMapping("/testSelectIncidentForCheckScenario")
    public String testSelectIncidentForCheckScenario() {
        try {
            System.out.println("测试: selectIncidentForCheckScenario - 选择需要检查场景的事件");
            
            List<RiskIncident> list = mapper.selectIncidentForCheckScenario();
            System.out.println("结果: 查询到 " + list.size() + " 条需要检查的事件");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectIncidentForCheckScenario 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法27：updateStatus
     * 参数：RiskIncident对象（不是独立参数）
     */
    @GetMapping("/testUpdateStatus")
    public String testUpdateStatus() {
        try {
            System.out.println("测试: updateStatus - 更新状态");
            
            RiskIncident incident = new RiskIncident();
            incident.setEventCode("TEST_CODE_001");
            incident.setAlarmStatus("processed");
            
            mapper.updateStatus(incident);
            System.out.println("结果: 状态更新成功");
            return "SUCCESS: updated";
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateStatus 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法28：isHandled
     * 参数：eventCodes (List<String>)
     * 返回：int基本类型
     */
    @GetMapping("/testIsHandled")
    public String testIsHandled() {
        try {
            System.out.println("测试: isHandled - 检查是否已处理");
            
            int count = mapper.isHandled(Arrays.asList("RISK_2026_001", "RISK_2026_002"));
            System.out.println("结果: 已处理数量=" + count);
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testIsHandled 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法29：updateJudgeResults
     * 参数：id (Long), judgeResult (Integer)
     */
    @GetMapping("/testUpdateJudgeResults")
    public String testUpdateJudgeResults() {
        try {
            System.out.println("测试: updateJudgeResults - 更新判断结果");
            
            mapper.updateJudgeResults(1001L, 1);
            System.out.println("结果: 判断结果更新成功");
            return "SUCCESS: updated";
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateJudgeResults 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法30：updateJudgeStatus
     * 参数：id (Long), judgeStatus (String)
     */
    @GetMapping("/testUpdateJudgeStatus")
    public String testUpdateJudgeStatus() {
        try {
            System.out.println("测试: updateJudgeStatus - 更新判断状态");
            
            mapper.updateJudgeStatus(1001L, "completed");
            System.out.println("结果: 判断状态更新成功");
            return "SUCCESS: updated";
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateJudgeStatus 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试汇总方法 - 执行所有测试
     */
    @GetMapping("/testAll")
    public String testAll() {
        StringBuilder result = new StringBuilder("开始执行所有测试...\n\n");
        int successCount = 0;
        int failCount = 0;

        String[] testMethods = {
            "testAggClueSecurityEventByName", "testMappingNormalSecurityEvent", "testBackUpLastTermData",
            "testBatchInsertOrUpdateIncident", "testSelectOldIncidentByCodes", "testDeleteOldIncident",
            "testDeleteOldIncidentAnalysis", "testGetRiskList", "testGetCountByStatus",
            "testGetByEventCode", "testSelectEventAndTempById", "testSelectAllByIdList",
            "testQueryEventCount", "testQueryIncidentsCount", "testQueryKillChains",
            "testGetEventIdsById", "testGetFilterContent", "testGetRiskListByIds",
            "testFocusIpMessage", "testGetFocusObject", "testGetCount",
            "testQueryFocusIps", "testQueryFocusIpCount", "testGetSecurityEventIdsByCondition",
            "testCountByDate", "testSelectIncidentForCheckScenario", "testUpdateStatus",
            "testIsHandled", "testUpdateJudgeResults", "testUpdateJudgeStatus"
        };

        for (int i = 0; i < testMethods.length; i++) {
            String methodName = testMethods[i];
            try {
                String testResult = "";
                switch (i) {
                    case 0: testResult = testAggClueSecurityEventByName(); break;
                    case 1: testResult = testMappingNormalSecurityEvent(); break;
                    case 2: testResult = testBackUpLastTermData(); break;
                    case 3: testResult = testBatchInsertOrUpdateIncident(); break;
                    case 4: testResult = testSelectOldIncidentByCodes(); break;
                    case 5: testResult = testDeleteOldIncident(); break;
                    case 6: testResult = testDeleteOldIncidentAnalysis(); break;
                    case 7: testResult = testGetRiskList(); break;
                    case 8: testResult = testGetCountByStatus(); break;
                    case 9: testResult = testGetByEventCode(); break;
                    case 10: testResult = testSelectEventAndTempById(); break;
                    case 11: testResult = testSelectAllByIdList(); break;
                    case 12: testResult = testQueryEventCount(); break;
                    case 13: testResult = testQueryIncidentsCount(); break;
                    case 14: testResult = testQueryKillChains(); break;
                    case 15: testResult = testGetEventIdsById(); break;
                    case 16: testResult = testGetFilterContent(); break;
                    case 17: testResult = testGetRiskListByIds(); break;
                    case 18: testResult = testFocusIpMessage(); break;
                    case 19: testResult = testGetFocusObject(); break;
                    case 20: testResult = testGetCount(); break;
                    case 21: testResult = testQueryFocusIps(); break;
                    case 22: testResult = testQueryFocusIpCount(); break;
                    case 23: testResult = testGetSecurityEventIdsByCondition(); break;
                    case 24: testResult = testCountByDate(); break;
                    case 25: testResult = testSelectIncidentForCheckScenario(); break;
                    case 26: testResult = testUpdateStatus(); break;
                    case 27: testResult = testIsHandled(); break;
                    case 28: testResult = testUpdateJudgeResults(); break;
                    case 29: testResult = testUpdateJudgeStatus(); break;
                }

                if (testResult.startsWith("SUCCESS")) {
                    result.append("✓ ").append(methodName).append(": ").append(testResult).append("\n");
                    successCount++;
                } else {
                    result.append("✗ ").append(methodName).append(": ").append(testResult).append("\n");
                    failCount++;
                }
            } catch (Exception e) {
                result.append("✗ ").append(methodName).append(": ERROR - ").append(e.getMessage()).append("\n");
                failCount++;
            }
        }

        result.append("\n测试汇总: 成功=").append(successCount).append(", 失败=").append(failCount);
        result.append(", 总计=").append(testMethods.length).append("\n");

        return result.toString();
    }
}
