package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.entity.SecurityEvent;
import com.dbapp.extension.xdr.threatMonitor.entity.ThreadEvent;
import com.dbapp.extension.xdr.threatMonitor.mapper.SecurityEventMapper;
import com.dbapp.extension.xdr.logCorrelation.entity.AlarmInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

/**
 * SecurityEvent 测试控制器
 * 
 * 测试说明：
 * 1. 所有方法使用 GET 请求
 * 2. 参数已硬编码，无需 Postman 传参
 * 3. 测试数据参考：test_data.sql 中的场景
 * 
 * 核心测试方法（从31个方法中精选5个）：
 * - insertOrUpdate: 插入或更新安全事件
 * - getSecurityEventList: 获取安全事件列表
 * - updateStatus: 更新事件处理状态
 * - queryOverview: 查询安全态势概览
 * - selectEventAndTempById: 查询事件详情
 */
@RestController
@RequestMapping("/test/securityEvent")
public class SecurityEventTestController {

    @Autowired
    private SecurityEventMapper mapper;

    /**
     * 测试1：insertOrUpdate - 插入或更新安全事件
     * 场景：新检测到端口扫描事件
     */
    @GetMapping("/test1_insertOrUpdate")
    public String test1_insertOrUpdate() {
        try {
            System.out.println("测试: insertOrUpdate - 插入安全事件");
            SecurityEvent event = new SecurityEvent();
            event.setTemplateId(1003);
            event.setTemplateCode("SSH_BRUTE_FORCE");
            event.setEventName("大规模端口扫描");
            event.setFocusIp("185.220.101.50");
            event.setCategory("Network Attack");
            event.setSubCategory("Port Scan");
            event.setAttacker("185.220.101.50");
            event.setVictim("192.168.1.0/24");
            event.setStartTime("2026-01-28 10:00:00");
            event.setEndTime("2026-01-28 10:05:00");
            event.setCreateTime("2026-01-28 10:00:00");
            event.setCounts(1500);
            event.setAlarmStatus("unprocessed");
            event.setAttackConclusion("检测到来自185.220.101.50的大规模端口扫描，覆盖全网段");
            event.setThreatSeverity(com.dbapp.extension.xdr.util.ThreatSeverity.High);
            event.setAlarmResults(com.dbapp.extension.xdr.util.AlarmResult.UNKNOWN);
            event.setKillChain("Reconnaissance");
            event.setFocus("src_ip");
            event.setIncidentCond("port_scan_count > 100");
            event.setTagSearch("{\"tags\": [\"端口扫描\", \"侦察\", \"高风险\"]}");
            
            mapper.insertOrUpdate(event);
            System.out.println("结果: ID=" + event.getId());
            return "SUCCESS: " + event.getId();
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_insertOrUpdate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：getSecurityEventList - 获取安全事件列表
     * 场景：查询所有高级别（high/critical）且未关闭的安全事件
     */
    @GetMapping("/test2_getSecurityEventList")
    public String test2_getSecurityEventList() {
        try {
            System.out.println("测试: getSecurityEventList - 查询安全事件列表");
            List<String> subCategory = Collections.singletonList("Brute Force");
            List<String> alarmStatus = Arrays.asList("unprocessed", "processing");
            List<String> alarmResult = Arrays.asList("OK", "FAIL", "UNKNOWN");
            List<String> threatSeverity = Arrays.asList("High", "Medium", "Low");
            List<String> tagSearch = Collections.emptyList();
            List<String> killChain = Collections.emptyList();

            List<Map<String, Object>> result = mapper.getSecurityEventList(
                    "2025-01-01 00:00:00",
                    "2026-12-31 23:59:59",
                    null,
                    null,
                    subCategory,
                    alarmStatus,
                    alarmResult,
                    threatSeverity,
                    tagSearch,
                    "end_time desc",
                    killChain,
                    0L,
                    10L,
                    null
            );
            System.out.println("结果: " + result.size() + " 条");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_getSecurityEventList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：updateStatus - 更新事件状态
     * 场景：将 test_data.sql 中的 1001 号事件标记为已处理
     */
    @GetMapping("/test3_updateStatus")
    public String test3_updateStatus() {
        try {
            System.out.println("测试: updateStatus - 更新事件状态");
            SecurityEvent event = new SecurityEvent();
            event.setId("1001");
            event.setAlarmStatus("processed");
            event.setEndTime("2026-01-28 11:00:00");
            event.setAttackConclusion("已封禁攻击源IP，事件已解决");
            event.setAlarmResults(com.dbapp.extension.xdr.util.AlarmResult.OK);
            
            mapper.updateStatus(event);
            System.out.println("结果: 更新成功 ID=" + event.getId());
            return "SUCCESS: 1";
        } catch (Exception e) {
            String errorMsg = "测试方法 test3_updateStatus 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：queryOverview - 查询安全态势概览
     * 场景：获取今日安全事件统计
     */
    @GetMapping("/test4_queryOverview")
    public String test4_queryOverview() {
        try {
            System.out.println("测试: queryOverview - 查询态势概览");
            List<Map<String, Object>> overview = mapper.queryOverview(
                    "2026-01-28 00:00:00",
                    "2026-01-28 23:59:59",
                    null
            );
            System.out.println("结果: size=" + overview.size());
            return "SUCCESS: " + overview.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test4_queryOverview 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：selectEventAndTempById - 查询事件详情
     * 场景：查询 test_data.sql 中的 1002 号事件（SQL注入）详情
     */
    @GetMapping("/test5_selectEventAndTempById")
    public String test5_selectEventAndTempById() {
        try {
            System.out.println("测试: selectEventAndTempById - 查询事件详情");
            Integer[] eventIds = new Integer[]{1002};

            Map<String, Object> detail = mapper.selectEventAndTempById(eventIds);
            System.out.println("结果: " + detail.get("event_name"));
            return "SUCCESS: " + eventIds[0];
        } catch (Exception e) {
            String errorMsg = "测试方法 test5_selectEventAndTempById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试6：selectBaseInfoById - 基础信息查询
     */
    @GetMapping("/test6_selectBaseInfoById")
    public String test6_selectBaseInfoById() {
        try {
            Integer[] ids = {1001, 1002};
            List<Map<String, String>> list = mapper.selectBaseInfoById(ids);
            System.out.println("selectBaseInfoById size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test6_selectBaseInfoById 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试7：selectNewEventAndTempById - 最新事件+模板
     */
    @GetMapping("/test7_selectNewEventAndTempById")
    public String test7_selectNewEventAndTempById() {
        try {
            Map<String, Object> map = mapper.selectNewEventAndTempById(1002);
            System.out.println("selectNewEventAndTempById eventCode=" + map.get("eventCode"));
            return "SUCCESS";
        } catch (Exception e) {
            String msg = "test7_selectNewEventAndTempById 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试8：selectLogFieldsByIds - 日志字段映射
     */
    @GetMapping("/test8_selectLogFieldsByIds")
    public String test8_selectLogFieldsByIds() {
        try {
            Integer[] ids = {1001, 1002};
            Map<String, Object> map = mapper.selectLogFieldsByIds(ids);
            System.out.println("selectLogFieldsByIds netflowLogField=" + map.get("netflowLogField"));
            return "SUCCESS";
        } catch (Exception e) {
            String msg = "test8_selectLogFieldsByIds 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试9：selectEventAndTempByIds - 多ID事件+模板
     */
    @GetMapping("/test9_selectEventAndTempByIds")
    public String test9_selectEventAndTempByIds() {
        try {
            List<Integer> ids = Arrays.asList(1001, 1002, 1003);
            Map<String, Object> map = mapper.selectEventAndTempByIds(ids);
            System.out.println("selectEventAndTempByIds eventIds=" + map.get("eventIds"));
            return "SUCCESS";
        } catch (Exception e) {
            String msg = "test9_selectEventAndTempByIds 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试10：queryEventById - 根据ID列表查询event_ids
     */
    @GetMapping("/test10_queryEventById")
    public String test10_queryEventById() {
        try {
            List<String> ids = Arrays.asList("1001", "1002", "1003");
            List<String> result = mapper.queryEventById(ids);
            System.out.println("queryEventById size=" + result.size());
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String msg = "test10_queryEventById 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试11：queryTrend - 威胁趋势
     */
    @GetMapping("/test11_queryTrend")
    public String test11_queryTrend() {
        try {
            List<Map<String, Object>> list = mapper.queryTrend(
                    "2025-01-01 00:00:00",
                    "2026-12-31 23:59:59"
            );
            System.out.println("queryTrend size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test11_queryTrend 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试12：selectAllByIdList - 列表详情
     */
    @GetMapping("/test12_selectAllByIdList")
    public String test12_selectAllByIdList() {
        try {
            List<String> ids = Arrays.asList("1001", "1002", "1003");
            List<Map<String, Object>> list = mapper.selectAllByIdList(ids);
            System.out.println("selectAllByIdList size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test12_selectAllByIdList 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试13：getIncidentsTypePercent - 事件类型占比
     */
    @GetMapping("/test13_getIncidentsTypePercent")
    public String test13_getIncidentsTypePercent() {
        try {
            List<String> subCategory = Arrays.asList("Brute Force", "SQL Injection");
            List<String> alarmStatus = Arrays.asList("pending", "handled");
            List<String> alarmResult = Arrays.asList("部分失败", "已拦截", "已记录");
            List<String> threatSeverity = Arrays.asList("high", "critical", "medium");
            List<String> tagSearch = Collections.singletonList("高危");
            List<String> killChain = Arrays.asList("Reconnaissance", "Execution");

            List<Map<String, Object>> list = mapper.getIncidentsTypePercent(
                    "2025-01-01 00:00:00",
                    "2026-12-31 23:59:59",
                    null,
                    null,
                    subCategory,
                    alarmStatus,
                    alarmResult,
                    threatSeverity,
                    tagSearch,
                    killChain,
                    0,
                    null
            );
            System.out.println("getIncidentsTypePercent size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test13_getIncidentsTypePercent 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试14：getKillChain - Kill Chain 统计
     */
    @GetMapping("/test14_getKillChain")
    public String test14_getKillChain() {
        try {
            List<String> subCategory = Arrays.asList("Port Scan", "SQL Injection");
            List<String> alarmStatus = Arrays.asList("pending", "handled");
            List<String> alarmResult = Arrays.asList("部分失败", "已拦截", "已记录");
            List<String> threatSeverity = Arrays.asList("high", "critical", "medium");
            List<String> tagSearch = Collections.singletonList("高危");
            List<String> killChainList = Arrays.asList("Reconnaissance", "Command and Control");

            List<String> list = mapper.getKillChain(
                    "2025-01-01 00:00:00",
                    "2026-12-31 23:59:59",
                    null,
                    null,
                    subCategory,
                    alarmStatus,
                    alarmResult,
                    threatSeverity,
                    tagSearch,
                    killChainList,
                    null
            );
            System.out.println("getKillChain size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test14_getKillChain 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试15：getSecurityEventListByFieldMapping
     */
    @GetMapping("/test15_getSecurityEventListByFieldMapping")
    public String test15_getSecurityEventListByFieldMapping() {
        try {
            List<String> subCategory = Arrays.asList("Brute Force", "SQL Injection");
            List<String> alarmStatus = Arrays.asList("pending", "handled");
            List<String> alarmResult = Arrays.asList("部分失败", "已拦截", "已记录");
            List<String> threatSeverity = Arrays.asList("high", "critical", "medium");
            List<String> tagSearch = Collections.singletonList("高危");
            List<String> killChain = Arrays.asList("Reconnaissance", "Execution");

            List<Map<String, Object>> list = mapper.getSecurityEventListByFieldMapping(
                    "2025-01-01 00:00:00",
                    "2026-12-31 23:59:59",
                    null,
                    null,
                    subCategory,
                    alarmStatus,
                    alarmResult,
                    threatSeverity,
                    tagSearch,
                    "end_time desc",
                    killChain,
                    0L,
                    10L
            );
            System.out.println("getSecurityEventListByFieldMapping size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test15_getSecurityEventListByFieldMapping 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试16：getTotal - 总数统计
     */
    @GetMapping("/test16_getTotal")
    public String test16_getTotal() {
        try {
            List<String> subCategory = Arrays.asList("Brute Force", "SQL Injection");
            List<String> alarmStatus = Arrays.asList("pending", "handled");
            List<String> alarmResult = Arrays.asList("部分失败", "已拦截", "已记录");
            List<String> threatSeverity = Arrays.asList("high", "critical", "medium");
            List<String> tagSearch = Collections.singletonList("高危");
            List<String> killChain = Arrays.asList("Reconnaissance", "Execution");

            Long total = mapper.getTotal(
                    "2025-01-01 00:00:00",
                    "2026-12-31 23:59:59",
                    null,
                    null,
                    subCategory,
                    alarmStatus,
                    alarmResult,
                    threatSeverity,
                    tagSearch,
                    killChain,
                    null
            );
            System.out.println("getTotal=" + total);
            return "SUCCESS: " + total;
        } catch (Exception e) {
            String msg = "test16_getTotal 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试17：queryEventCount - 事件统计
     */
    @GetMapping("/test17_queryEventCount")
    public String test17_queryEventCount() {
        try {
            List<String> subCategory = Arrays.asList("Brute Force", "SQL Injection");
            List<String> alarmStatus = Arrays.asList("pending", "handled");
            List<String> alarmResult = Arrays.asList("部分失败", "已拦截", "已记录");
            List<String> threatSeverity = Arrays.asList("high", "critical", "medium");
            List<String> tagSearch = Collections.singletonList("高危");
            List<String> killChain = Arrays.asList("Reconnaissance", "Execution");

            List<Map> list = mapper.queryEventCount(
                    "2025-01-01 00:00:00",
                    "2026-12-31 23:59:59",
                    null,
                    null,
                    subCategory,
                    alarmStatus,
                    alarmResult,
                    threatSeverity,
                    tagSearch,
                    killChain,
                    null
            );
            System.out.println("queryEventCount size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test17_queryEventCount 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试18：queryByEventCode - 单条事件查询
     */
    @GetMapping("/test18_queryByEventCode")
    public String test18_queryByEventCode() {
        try {
            SecurityEvent event = mapper.queryByEventCode("EVT-SEC-2026-001");
            System.out.println("queryByEventCode id=" + (event != null ? event.getId() : "null"));
            return "SUCCESS";
        } catch (Exception e) {
            String msg = "test18_queryByEventCode 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试19：updateAlarmResultById
     */
    @GetMapping("/test19_updateAlarmResultById")
    public String test19_updateAlarmResultById() {
        try {
            mapper.updateAlarmResultById(1001, "OK");
            System.out.println("updateAlarmResultById done");
            return "SUCCESS";
        } catch (Exception e) {
            String msg = "test19_updateAlarmResultById 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试20：batchInsert
     */
    @GetMapping("/test20_batchInsert")
    public String test20_batchInsert() {
        try {
            SecurityEvent e1 = new SecurityEvent();
            e1.setTemplateId(1001);
            e1.setEventCode("EVT-SEC-TEST-001");
            e1.setEventName("批量插入事件1");
            e1.setCategory("Test");
            e1.setSubCategory("Batch");
            e1.setAttacker("10.0.0.1");
            e1.setVictim("10.0.0.2");
            e1.setStartTime("2026-01-28 12:00:00");
            e1.setEndTime("2026-01-28 12:05:00");
            e1.setCounts(1);
            e1.setAlarmStatus("pending");
            e1.setAlarmResults(com.dbapp.extension.xdr.util.AlarmResult.UNKNOWN);

            List<SecurityEvent> list = Collections.singletonList(e1);
            mapper.batchInsert(list);
            System.out.println("batchInsert done");
            return "SUCCESS";
        } catch (Exception e) {
            String msg = "test20_batchInsert 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试21：getExistThreadEvents
     */
    @GetMapping("/test21_getExistThreadEvents")
    public String test21_getExistThreadEvents() {
        try {
            List<ThreadEvent> list = mapper.getExistThreadEvents("20260128");
            System.out.println("getExistThreadEvents size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test21_getExistThreadEvents 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试22：insertBatchThreadEvents
     */
    @GetMapping("/test22_insertBatchThreadEvents")
    public String test22_insertBatchThreadEvents() {
        try {
            ThreadEvent t = new ThreadEvent();
            t.setTemplateId(1001);
            t.setIncidentName("线程事件测试");
            t.setFocus("src_ip");
            t.setFocusIp("192.168.1.50");
            t.setTimePart("20260128");
            t.setEventCode("EVT-THREAD-TEST-001");
            t.setAttacker("203.0.113.100");
            t.setVictim("192.168.1.50");
            t.setEndTime("2026-01-28 10:10:00");

            long n = mapper.insertBatchThreadEvents(Collections.singletonList(t));
            System.out.println("insertBatchThreadEvents n=" + n);
            return "SUCCESS: " + n;
        } catch (Exception e) {
            String msg = "test22_insertBatchThreadEvents 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试23：insertBatchSecurityAlarm
     */
    @GetMapping("/test23_insertBatchSecurityAlarm")
    public String test23_insertBatchSecurityAlarm() {
        try {
            AlarmInfo a = new AlarmInfo();
            a.setWindowId("WIN-TEST-SEC");
            a.setAggCondition("AGG-SEC-TEST");
            a.setEventId("1001");
            a.setSrcAddress("192.168.1.50");
            a.setDestAddress("203.0.113.100");
            a.setAttacker(new String[]{"192.168.1.50"});
            a.setVictim(new String[]{"203.0.113.100"});
            a.setSubCategory("SSH_LOGIN_FAIL");
            a.setStartTime("2026-01-28 09:00:00");
            a.setEndTime("2026-01-28 09:05:00");
            a.setAlarmResults("OK");
            a.setKillChain(1);
            a.setTagSearch("[\"SSH\",\"暴力破解\"]");
            a.setThreatSeverity("high");
            a.setFamilyId("FAM-TEST");
            a.setOrganizationId("ORG-TEST");

            long n = mapper.insertBatchSecurityAlarm(Collections.singletonList(a));
            System.out.println("insertBatchSecurityAlarm n=" + n);
            return "SUCCESS: " + n;
        } catch (Exception e) {
            String msg = "test23_insertBatchSecurityAlarm 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试24：queryThreadAlarm
     */
    @GetMapping("/test24_queryThreadAlarm")
    public String test24_queryThreadAlarm() {
        try {
            List<AlarmInfo> list = mapper.queryThreadAlarm(
                    null,
                    null,
                    null,
                    "20260128",
                    0L
            );
            System.out.println("queryThreadAlarm size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test24_queryThreadAlarm 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试25：getMinTime / getOneHourTime / deleteOneHourLeft
     */
    @GetMapping("/test25_timeAndDelete")
    public String test25_timeAndDelete() {
        try {
            LocalDateTime minTime = mapper.getMinTime("20260128");
            LocalDateTime oneHourTime = mapper.getOneHourTime();
            long deleted = mapper.deleteOneHourLeft(LocalDateTime.now().minusHours(2));
            System.out.println("getMinTime=" + minTime + ", getOneHourTime=" + oneHourTime + ", deleted=" + deleted);
            return "SUCCESS";
        } catch (Exception e) {
            String msg = "test25_timeAndDelete 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试26：updateThreadLowPriority / deleteLowPriority
     */
    @GetMapping("/test26_lowPriority")
    public String test26_lowPriority() {
        try {
            long updated = mapper.updateThreadLowPriority("20260128", "src_ip", "192.168.1.50", 5);
            long deleted = mapper.deleteLowPriority("20260128", "src_ip", "192.168.1.50", 5);
            System.out.println("updateThreadLowPriority=" + updated + ", deleteLowPriority=" + deleted);
            return "SUCCESS";
        } catch (Exception e) {
            String msg = "test26_lowPriority 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试27：getSecurityEventOutGoingTemplate / deleteTimingTask
     */
    @GetMapping("/test27_outGoingAndTimingTask")
    public String test27_outGoingAndTimingTask() {
        try {
            List<Map<String, Object>> list = mapper.getSecurityEventOutGoingTemplate(
                    "2025-01-01 00:00:00",
                    "2026-12-31 23:59:59",
                    0L,
                    10L
            );
            mapper.deleteTimingTask("20260128", "src_ip", "192.168.1.50", 5);
            System.out.println("getSecurityEventOutGoingTemplate size=" + list.size());
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String msg = "test27_outGoingAndTimingTask 执行失败";
            System.err.println(msg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + msg + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
