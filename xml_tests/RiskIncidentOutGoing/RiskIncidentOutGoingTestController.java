package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentOutGoingMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentOutGoing;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/**
 * RiskIncidentOutGoing 深度测试控制器
 * 对应15个XML方法，测试所有参数和条件分支
 * 生成时间: 2026-01-28
 */
@RestController
@RequestMapping("/test/riskIncidentOutGoing")
public class RiskIncidentOutGoingTestController {
    
    @Autowired
    private RiskIncidentOutGoingMapper mapper;

    /**
     * 测试1：mappingFromClueSecurityEvent（测试1个if条件）
     * URL: /test/riskIncidentOutGoing/mappingFromClueSecurityEvent
     */
    @GetMapping("/mappingFromClueSecurityEvent")
    public String testMappingFromClueSecurityEvent() {
        try {
            System.out.println("=== 测试: mappingFromClueSecurityEvent（线索事件映射） ===");
            
            // 场景1：eventIds有值
            Map<String, Object> params1 = new HashMap<>();
            params1.put("eventIds", Arrays.asList(1001, 1002, 1003));
            List<RiskIncidentOutGoing> result1 = mapper.mappingFromClueSecurityEvent(params1);
            System.out.println("✓ 场景1（eventIds有值）: " + result1.size() + " 条");
            
            // 场景2：eventIds为null（不过滤）
            Map<String, Object> params2 = new HashMap<>();
            List<RiskIncidentOutGoing> result2 = mapper.mappingFromClueSecurityEvent(params2);
            System.out.println("✓ 场景2（eventIds=null）: " + result2.size() + " 条");
            
            return "SUCCESS: 场景1=" + result1.size() + ", 场景2=" + result2.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 mappingFromClueSecurityEvent 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：mappingNormalSecurityEvent（测试6个if条件）
     * URL: /test/riskIncidentOutGoing/mappingNormalSecurityEvent
     */
    @GetMapping("/mappingNormalSecurityEvent")
    public String testMappingNormalSecurityEvent() {
        try {
            System.out.println("=== 测试: mappingNormalSecurityEvent（常规事件映射，6个if） ===");
            
            Map<String, Object> params = new HashMap<>();
            
            // 场景1：所有if参数都有值
            params.put("startTime", "2026-01-01 00:00:00");
            params.put("endTime", "2026-12-31 23:59:59");
            params.put("threatSeverity", Arrays.asList("High", "Medium"));
            params.put("alarmResults", Arrays.asList("OK", "Attempt"));
            params.put("topEventType", "入侵攻击");
            params.put("excludeEventIds", Arrays.asList(9999));
            
            List<RiskIncidentOutGoing> result1 = mapper.mappingNormalSecurityEvent(params);
            System.out.println("✓ 场景1（所有6个if参数）: " + result1.size() + " 条");
            
            // 场景2：仅必需参数（测试其他if不满足）
            Map<String, Object> params2 = new HashMap<>();
            List<RiskIncidentOutGoing> result2 = mapper.mappingNormalSecurityEvent(params2);
            System.out.println("✓ 场景2（仅必需参数）: " + result2.size() + " 条");
            
            return "SUCCESS: 场景1=" + result1.size() + ", 场景2=" + result2.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 mappingNormalSecurityEvent 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：backUpLastTermData（备份数据）
     * URL: /test/riskIncidentOutGoing/backUpLastTermData
     */
    @GetMapping("/backUpLastTermData")
    public String testBackUpLastTermData() {
        try {
            System.out.println("=== 测试: backUpLastTermData（备份到历史表） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("currentDate", "2026-01-28");
            params.put("timestamp", "2026-01-28");
            
            int rows = mapper.backUpLastTermData(params);
            System.out.println("✓ 备份成功: " + rows + " 条");
            
            return "SUCCESS: " + rows + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 backUpLastTermData 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：batchInsertOrUpdateIncident（27个if条件的动态upsert）
     * URL: /test/riskIncidentOutGoing/batchInsertOrUpdateIncident
     */
    @GetMapping("/batchInsertOrUpdateIncident")
    public String testBatchInsertOrUpdateIncident() {
        try {
            System.out.println("=== 测试: batchInsertOrUpdateIncident（27个if条件的upsert） ===");
            
            List<RiskIncidentOutGoing> list = new ArrayList<>();
            
            // 测试记录1：所有字段都有值（测试所有27个if）
            RiskIncidentOutGoing item1 = new RiskIncidentOutGoing();
            item1.setUniqCode("TEST-UPSERT-001-" + System.currentTimeMillis());
            item1.setEventCode("TEST-EVENT-001");
            item1.setSecurityIncidentId(1001L);
            item1.setName("测试Upsert-完整字段");
            item1.setTemplateId("TEST_TEMPLATE");
            item1.setStartTime("2026-01-28 10:00:00");
            item1.setEndTime("2026-01-28 11:00:00");
            item1.setTopEventTypeChinese("测试攻击");
            item1.setSecondEventTypeChinese("测试子类型");
            item1.setSrcGeoRegion("中国");
            item1.setSecurityZone("DMZ");
            item1.setDeviceAddress("192.168.1.1");
            item1.setDeviceSendProductName("XDR");
            item1.setSendHostAddress("10.0.0.1");
            item1.setMachineCode("MACHINE-001");
            item1.setRuleType("测试规则");
            item1.setFocusIp("192.168.10.10");
            item1.setAttacker("192.168.10.10");
            item1.setVictim("192.168.20.20");
            item1.setSeverity("7");
            item1.setCatOutcome("OK");
            item1.setPayload("{\"test\":\"payload\"}");
            item1.setMoreField("{\"test\":\"moreField\"}");
            item1.setTimePart("2026-01-28");
            item1.setKillChain("初始访问→执行");
            item1.setIsScenario(1);
            list.add(item1);
            
            // 测试记录2：部分字段有值（测试部分if）
            RiskIncidentOutGoing item2 = new RiskIncidentOutGoing();
            item2.setUniqCode("TEST-UPSERT-002-" + System.currentTimeMillis());
            item2.setEventCode("TEST-EVENT-002");
            item2.setName("测试Upsert-部分字段");
            item2.setTemplateId("TEST_TEMPLATE_2");
            item2.setStartTime("2026-01-28 12:00:00");
            item2.setEndTime("2026-01-28 13:00:00");
            item2.setDeviceAddress("192.168.2.2");
            item2.setDeviceSendProductName("XDR-2");
            item2.setSendHostAddress("10.0.0.2");
            item2.setMachineCode("MACHINE-002");
            item2.setRuleType("规则2");
            item2.setSeverity("6");
            item2.setCatOutcome("Attempt");
            list.add(item2);
            
            mapper.batchInsertOrUpdateIncident(list);
            System.out.println("✓ Upsert成功: " + list.size() + " 条（测试27个if条件）");
            
            return "SUCCESS: " + list.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 batchInsertOrUpdateIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：deleteOldIncident（测试2个if条件）
     * URL: /test/riskIncidentOutGoing/deleteOldIncident
     */
    @GetMapping("/deleteOldIncident")
    public String testDeleteOldIncident() {
        try {
            System.out.println("=== 测试: deleteOldIncident（2个if条件） ===");
            
            // 场景1：currentDate有值
            Map<String, Object> params1 = new HashMap<>();
            params1.put("currentDate", "2026-01-28");
            int rows1 = mapper.deleteOldIncident(params1);
            System.out.println("✓ 场景1（currentDate有值）: 删除 " + rows1 + " 条");
            
            // 场景2：ids有值
            Map<String, Object> params2 = new HashMap<>();
            params2.put("ids", Arrays.asList(9999L));
            int rows2 = mapper.deleteOldIncident(params2);
            System.out.println("✓ 场景2（ids有值）: 删除 " + rows2 + " 条");
            
            // 场景3：两个参数都有值
            Map<String, Object> params3 = new HashMap<>();
            params3.put("currentDate", "2026-01-28");
            params3.put("ids", Arrays.asList(9998L));
            int rows3 = mapper.deleteOldIncident(params3);
            System.out.println("✓ 场景3（两个参数都有值）: 删除 " + rows3 + " 条");
            
            return "SUCCESS: 场景1=" + rows1 + ", 场景2=" + rows2 + ", 场景3=" + rows3;
        } catch (Exception e) {
            String errorMsg = "测试方法 deleteOldIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试6：queryListByTime（测试时间范围查询+LEFT JOIN）
     * URL: /test/riskIncidentOutGoing/queryListByTime
     */
    @GetMapping("/queryListByTime")
    public String testQueryListByTime() {
        try {
            System.out.println("=== 测试: queryListByTime（时间查询+JOIN t_risk_incidents） ===");
            
            // 场景1：startTime和endTime都有值
            Map<String, Object> params1 = new HashMap<>();
            params1.put("startTime", "2026-01-01 00:00:00");
            params1.put("endTime", "2026-12-31 23:59:59");
            params1.put("size", 10);
            params1.put("offset", 0);
            List<RiskIncidentOutGoing> result1 = mapper.queryListByTime(params1);
            System.out.println("✓ 场景1（时间范围）: " + result1.size() + " 条");
            
            // 场景2：startTime和endTime为空（不过滤时间）
            Map<String, Object> params2 = new HashMap<>();
            params2.put("size", 10);
            params2.put("offset", 0);
            List<RiskIncidentOutGoing> result2 = mapper.queryListByTime(params2);
            System.out.println("✓ 场景2（无时间过滤）: " + result2.size() + " 条");
            
            return "SUCCESS: 场景1=" + result1.size() + ", 场景2=" + result2.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 queryListByTime 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试7：batchUpdatePayload（foreach批量更新）
     * URL: /test/riskIncidentOutGoing/batchUpdatePayload
     */
    @GetMapping("/batchUpdatePayload")
    public String testBatchUpdatePayload() {
        try {
            System.out.println("=== 测试: batchUpdatePayload（foreach批量更新） ===");
            
            List<RiskIncidentOutGoing> list = new ArrayList<>();
            RiskIncidentOutGoing item1 = new RiskIncidentOutGoing();
            item1.setId(1001L);
            item1.setPayload("{\"updated\":\"payload1\"}");
            item1.setMoreField("{\"updated\":\"moreField1\"}");
            list.add(item1);
            
            RiskIncidentOutGoing item2 = new RiskIncidentOutGoing();
            item2.setId(1002L);
            item2.setPayload("{\"updated\":\"payload2\"}");
            item2.setMoreField("{\"updated\":\"moreField2\"}");
            list.add(item2);
            
            mapper.batchUpdatePayload(list);
            System.out.println("✓ 批量更新成功: " + list.size() + " 条");
            
            return "SUCCESS: " + list.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 batchUpdatePayload 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试8：updateKillChain（更新攻击链）
     * URL: /test/riskIncidentOutGoing/updateKillChain
     */
    @GetMapping("/updateKillChain")
    public String testUpdateKillChain() {
        try {
            System.out.println("=== 测试: updateKillChain（JOIN t_security_incidents） ===");
            
            String beforeTime = "2026-01-01 00:00:00";
            mapper.updateKillChain(beforeTime);
            System.out.println("✓ 更新攻击链成功，时间阈值: " + beforeTime);
            
            return "SUCCESS: 更新完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 updateKillChain 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试9：clearHistoryData（清理历史数据，操作2个表）
     * URL: /test/riskIncidentOutGoing/clearHistoryData
     */
    @GetMapping("/clearHistoryData")
    public String testClearHistoryData() {
        try {
            System.out.println("=== 测试: clearHistoryData（清理2个历史表） ===");
            
            String timestamp = "2020-01-01 00:00:00";
            mapper.clearHistoryData(timestamp);
            System.out.println("✓ 清理历史数据成功，时间戳: " + timestamp);
            
            return "SUCCESS: 清理完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 clearHistoryData 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试10：queryOutGoingList（复杂查询，4个参数+子查询）
     * URL: /test/riskIncidentOutGoing/queryOutGoingList
     */
    @GetMapping("/queryOutGoingList")
    public String testQueryOutGoingList() {
        try {
            System.out.println("=== 测试: queryOutGoingList（4参数+子查询） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", "2026-01-01 00:00:00");
            params.put("endTime", "2026-12-31 23:59:59");
            params.put("lastTermTime", "2026-01-01 00:00:00");
            params.put("size", 10L);
            params.put("offset", 0L);
            
            List<Map<String, Object>> result = mapper.queryOutGoingList(params);
            System.out.println("✓ 查询外发列表: " + result.size() + " 条");
            
            return "SUCCESS: " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 queryOutGoingList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试11：selectOldIncidentByCodes（测试1个if+NOT EXISTS子查询）
     * URL: /test/riskIncidentOutGoing/selectOldIncidentByCodes
     */
    @GetMapping("/selectOldIncidentByCodes")
    public String testSelectOldIncidentByCodes() {
        try {
            System.out.println("=== 测试: selectOldIncidentByCodes（1个if+NOT EXISTS） ===");
            
            // 场景1：excludeUniqCodes有值
            Map<String, Object> params1 = new HashMap<>();
            params1.put("excludeUniqCodes", Arrays.asList("CODE-001", "CODE-002"));
            params1.put("currentDate", "2026-01-28");
            List<Long> result1 = mapper.selectOldIncidentByCodes(params1);
            System.out.println("✓ 场景1（excludeUniqCodes有值）: " + result1.size() + " 条");
            
            // 场景2：excludeUniqCodes为空
            Map<String, Object> params2 = new HashMap<>();
            params2.put("currentDate", "2026-01-28");
            List<Long> result2 = mapper.selectOldIncidentByCodes(params2);
            System.out.println("✓ 场景2（excludeUniqCodes为空）: " + result2.size() + " 条");
            
            return "SUCCESS: 场景1=" + result1.size() + ", 场景2=" + result2.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 selectOldIncidentByCodes 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试12：groupByFocusIp（测试3个if条件+GROUP BY）
     * URL: /test/riskIncidentOutGoing/groupByFocusIp
     */
    @GetMapping("/groupByFocusIp")
    public String testGroupByFocusIp() {
        try {
            System.out.println("=== 测试: groupByFocusIp（3个if+GROUP BY） ===");
            
            Map<String, Object> params = new HashMap<>();
            
            // 场景1：所有3个if参数都有值
            params.put("focusIps", Arrays.asList("192.168.10.50", "192.168.50.1"));
            params.put("startTime", "2026-01-01 00:00:00");
            params.put("endTime", "2026-12-31 23:59:59");
            params.put("top", 5);
            
            List<Map<String, Object>> result1 = mapper.groupByFocusIp(params);
            System.out.println("✓ 场景1（所有参数）: " + result1.size() + " 个IP分组");
            
            // 场景2：仅top参数
            Map<String, Object> params2 = new HashMap<>();
            params2.put("top", 10);
            List<Map<String, Object>> result2 = mapper.groupByFocusIp(params2);
            System.out.println("✓ 场景2（仅top）: " + result2.size() + " 个IP分组");
            
            return "SUCCESS: 场景1=" + result1.size() + ", 场景2=" + result2.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 groupByFocusIp 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试13：groupNameByFocusIp（测试2个if+GROUP BY name）
     * URL: /test/riskIncidentOutGoing/groupNameByFocusIp
     */
    @GetMapping("/groupNameByFocusIp")
    public String testGroupNameByFocusIp() {
        try {
            System.out.println("=== 测试: groupNameByFocusIp（2个if+GROUP BY） ===");
            
            // 场景1：所有参数
            Map<String, Object> params1 = new HashMap<>();
            params1.put("focusIps", Arrays.asList("192.168.10.50"));
            params1.put("startTime", "2026-01-01 00:00:00");
            params1.put("endTime", "2026-12-31 23:59:59");
            
            List<Map<String, Object>> result1 = mapper.groupNameByFocusIp(params1);
            System.out.println("✓ 场景1（所有参数）: " + result1.size() + " 个分组");
            
            // 场景2：无参数
            Map<String, Object> params2 = new HashMap<>();
            List<Map<String, Object>> result2 = mapper.groupNameByFocusIp(params2);
            System.out.println("✓ 场景2（无参数）: " + result2.size() + " 个分组");
            
            return "SUCCESS: 场景1=" + result1.size() + ", 场景2=" + result2.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 groupNameByFocusIp 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试14：selectOldHistoryIds（分页查询历史表ID）
     * URL: /test/riskIncidentOutGoing/selectOldHistoryIds
     */
    @GetMapping("/selectOldHistoryIds")
    public String testSelectOldHistoryIds() {
        try {
            System.out.println("=== 测试: selectOldHistoryIds（查询历史表） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("beforeTime", "2020-01-01 00:00:00");
            params.put("size", 100);
            params.put("offset", 0);
            
            List<Long> result = mapper.selectOldHistoryIds(params);
            System.out.println("✓ 查询历史表ID: " + result.size() + " 条");
            
            return "SUCCESS: " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 selectOldHistoryIds 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试15：deleteHistoryByIds（foreach批量删除）
     * URL: /test/riskIncidentOutGoing/deleteHistoryByIds
     */
    @GetMapping("/deleteHistoryByIds")
    public String testDeleteHistoryByIds() {
        try {
            System.out.println("=== 测试: deleteHistoryByIds（foreach批量删除） ===");
            
            List<Long> ids = Arrays.asList(9999L, 9998L);
            int rows = mapper.deleteHistoryByIds(ids);
            System.out.println("✓ 批量删除历史记录: " + rows + " 条");
            
            return "SUCCESS: " + rows + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 deleteHistoryByIds 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
