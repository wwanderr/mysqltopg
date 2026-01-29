package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentOutGoingHistoryMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentOutGoing;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.*;

/**
 * RiskIncidentOutGoingHistory (风险事件外发历史) 深度测试控制器
 * 主表：t_risk_incidents_out_going_history (26个字段)
 * 测试方法数：9
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/riskIncidentOutGoingHistory")
public class RiskIncidentOutGoingHistoryTestController {
    @Autowired
    private RiskIncidentOutGoingHistoryMapper mapper;

    /**
     * 方法1：mappingFromClueSecurityEvent
     * 测试条件：使用 <include refid="timeByParam"/> 和 eventIds 参数
     */
    @GetMapping("/test1_mappingFromClueSecurityEvent")
    public String test1_mappingFromClueSecurityEvent() {
        try {
            System.out.println("测试: mappingFromClueSecurityEvent - 从线索安全事件映射");
            Map<String, Object> params = new HashMap<>();
            params.put("endTime", System.currentTimeMillis());
            params.put("startTime", System.currentTimeMillis() - (7 * 24 * 3600 * 1000L));
            params.put("eventIds", Arrays.asList("EVT-001", "EVT-002"));
            
            List<RiskIncidentOutGoing> result = mapper.mappingFromClueSecurityEvent(params);
            System.out.println("结果: " + result.size() + " 条");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_mappingFromClueSecurityEvent 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：mappingNormalSecurityEvent
     * 测试条件：使用 <include refid="timeByParam"/> 和 queryParamCondition
     */
    @GetMapping("/test2_mappingNormalSecurityEvent")
    public String test2_mappingNormalSecurityEvent() {
        try {
            System.out.println("测试: mappingNormalSecurityEvent - 从普通安全事件映射");
            Map<String, Object> params = new HashMap<>();
            params.put("endTime", System.currentTimeMillis());
            params.put("startTime", System.currentTimeMillis() - (24 * 3600 * 1000L));
            params.put("sourceList", Arrays.asList("syslog", "agent"));
            params.put("threatSeverityList", Arrays.asList("high", "critical"));
            
            List<RiskIncidentOutGoing> result = mapper.mappingNormalSecurityEvent(params);
            System.out.println("结果: " + result.size() + " 条");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_mappingNormalSecurityEvent 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：backUpLastTermData
     * 测试条件：按时间备份数据
     */
    @GetMapping("/test3_backUpLastTermData")
    public String test3_backUpLastTermData() {
        try {
            System.out.println("测试: backUpLastTermData - 备份上一周期数据");
            Map<String, Object> params = new HashMap<>();
            params.put("lastTimePart", new Timestamp(System.currentTimeMillis() - (7 * 24 * 3600 * 1000L)));
            
            int count = mapper.backUpLastTermData(params);
            System.out.println("结果: 备份 " + count + " 条数据");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 test3_backUpLastTermData 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法4：batchInsertOrUpdateIncident
     * 测试条件：批量插入或更新（ON CONFLICT）
     */
    @GetMapping("/test4_batchInsertOrUpdateIncident")
    public String test4_batchInsertOrUpdateIncident() {
        try {
            System.out.println("测试: batchInsertOrUpdateIncident - 批量插入/更新外发历史");
            List<RiskIncidentOutGoing> dataList = new ArrayList<>();
            
            RiskIncidentOutGoing data1 = new RiskIncidentOutGoing();
            data1.setEventId(20001L);
            data1.setUniqCode("20260128-test-v1.0-10.0.0.1-001");
            data1.setEventCode("RISK-TEST-001");
            data1.setSecurityIncidentId(2001L);
            data1.setName("测试攻击事件");
            data1.setTemplateId("TEST_ATTACK");
            data1.setStartTime(new Timestamp(System.currentTimeMillis()));
            data1.setEndTime(new Timestamp(System.currentTimeMillis()));
            data1.setTopEventTypeChinese("测试类型");
            data1.setSecondEventTypeChinese("子类型");
            data1.setDeviceAddress("192.168.100.100");
            data1.setDeviceSendProductName("XDR测试");
            data1.setSendHostAddress("10.0.0.1");
            data1.setMachineCode("TEST-MACHINE-001");
            data1.setRuleType("测试规则");
            data1.setFocusIp("10.0.0.1");
            data1.setAttacker("10.0.0.1");
            data1.setVictim("10.0.0.2");
            data1.setSeverity("5");
            data1.setCatOutcome("OK");
            data1.setPayload("{\"test\": \"data\"}");
            data1.setMoreField("{\"status\": \"success\"}");
            data1.setTimePart(new Timestamp(System.currentTimeMillis()));
            dataList.add(data1);
            
            mapper.batchInsertOrUpdateIncident(dataList);
            System.out.println("结果: 插入/更新 " + dataList.size() + " 条");
            return "SUCCESS: " + dataList.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test4_batchInsertOrUpdateIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法5：deleteOldIncident
     * 测试条件：删除30天前的历史数据
     */
    @GetMapping("/test5_deleteOldIncident")
    public String test5_deleteOldIncident() {
        try {
            System.out.println("测试: deleteOldIncident - 删除旧数据（30天前）");
            int count = mapper.deleteOldIncident(30);
            System.out.println("结果: 删除 " + count + " 条");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 test5_deleteOldIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法6：queryListByTime
     * 测试条件：按时间范围查询
     */
    @GetMapping("/test6_queryListByTime")
    public String test6_queryListByTime() {
        try {
            System.out.println("测试: queryListByTime - 按时间范围查询");
            String startTime = "2026-01-01 00:00:00";
            String endTime = "2026-01-28 23:59:59";
            
            List<RiskIncidentOutGoing> result = mapper.queryListByTime(startTime, endTime);
            System.out.println("结果: " + result.size() + " 条");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test6_queryListByTime 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法7：batchUpdatePayload
     * 测试条件：批量更新payload字段
     */
    @GetMapping("/test7_batchUpdatePayload")
    public String test7_batchUpdatePayload() {
        try {
            System.out.println("测试: batchUpdatePayload - 批量更新payload");
            List<RiskIncidentOutGoing> dataList = new ArrayList<>();
            
            RiskIncidentOutGoing data1 = new RiskIncidentOutGoing();
            data1.setUniqCode("20260128-apt-v1.0-192.168.10.50-history-001");  // test_data.sql中的数据
            data1.setPayload("{\"batch\": 1, \"send_time\": \"2026-01-25 10:00:00\", \"updated\": true}");
            dataList.add(data1);
            
            mapper.batchUpdatePayload(dataList);
            System.out.println("结果: 更新 " + dataList.size() + " 条payload");
            return "SUCCESS: " + dataList.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test7_batchUpdatePayload 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法8：clearHistoryData
     * 测试条件：清理60天前的历史数据
     */
    @GetMapping("/test8_clearHistoryData")
    public String test8_clearHistoryData() {
        try {
            System.out.println("测试: clearHistoryData - 清理历史数据（60天前）");
            int count = mapper.clearHistoryData(60);
            System.out.println("结果: 清理 " + count + " 条");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 test8_clearHistoryData 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法9：queryOutGoingList
     * 测试条件：复杂查询（LEFT JOIN + 多条件）
     */
    @GetMapping("/test9_queryOutGoingList")
    public String test9_queryOutGoingList() {
        try {
            System.out.println("测试: queryOutGoingList - 复杂查询外发列表");
            Map<String, Object> params = new HashMap<>();
            params.put("eventCode", "RISK-2026-002");  // 勒索软件（3条历史记录）
            params.put("startTime", "2026-01-27 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("catOutcome", "OK");
            params.put("severity", "7");
            
            List<Map<String, Object>> result = mapper.queryOutGoingList(params);
            System.out.println("结果: " + result.size() + " 条");
            if (!result.isEmpty()) {
                Map<String, Object> first = result.get(0);
                System.out.println("  - 事件Code: " + first.get("event_code"));
                System.out.println("  - 事件名称: " + first.get("name"));
                System.out.println("  - 结果: " + first.get("cat_outcome"));
            }
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test9_queryOutGoingList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
