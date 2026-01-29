package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncident;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/**
 * RiskIncident (风险事件) 深度测试控制器
 * 主表：t_risk_incidents
 * 关联表：t_event_template, t_query_template, t_security_incidents
 * 测试方法数：30
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/riskIncident")
public class RiskIncidentTestController {
    @Autowired
    private RiskIncidentMapper mapper;

    /**
     * 方法1：aggClueSecurityEventByName
     * 测试条件：
     * - <include refid="timeByParam"/>（时间参数）
     * - <include refid="queryParamCondition"/>（查询条件）
     * - JOIN t_event_template (tet.incident_type = true)
     * - JOIN t_security_incidents
     * - GROUP BY event_name, t.focus
     */
    @GetMapping("/testAggClueSecurityEventByName")
    public String testAggClueSecurityEventByName() {
        try {
            System.out.println("测试: aggClueSecurityEventByName - 聚合线索安全事件");
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("threatSeverity", Arrays.asList("High", "Medium"));
            params.put("subCategory", Arrays.asList("持续性威胁", "勒索软件"));
            
            List<RiskIncident> list = mapper.aggClueSecurityEventByName(params);
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
     * 测试条件：
     * - <include refid="timeByParam"/>（时间参数）
     * - <include refid="queryParamCondition"/>（查询条件）
     * - JOIN t_event_template (tet.incident_type = false)
     * - JOIN t_security_incidents
     */
    @GetMapping("/testMappingNormalSecurityEvent")
    public String testMappingNormalSecurityEvent() {
        try {
            System.out.println("测试: mappingNormalSecurityEvent - 映射普通安全事件");
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("threatSeverity", Arrays.asList("High"));
            params.put("focusIp", "192.168.10.50");
            
            List<RiskIncident> list = mapper.mappingNormalSecurityEvent(params);
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
     * 测试条件：
     * - 插入历史数据到 t_risk_incidents_history
     * - 根据 currentDate 筛选
     */
    @GetMapping("/testBackUpLastTermData")
    public String testBackUpLastTermData() {
        try {
            System.out.println("测试: backUpLastTermData - 备份上一期数据");
            Map<String, Object> params = new HashMap<>();
            params.put("timestamp", new Date());
            params.put("currentDate", "2026-01-28");
            
            int count = mapper.backUpLastTermData(params);
            System.out.println("结果: 备份了 " + count + " 条数据");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testBackUpLastTermData 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法4：batchInsertOrUpdateIncident
     * 测试条件：
     * - <foreach collection="riskIncidentList">
     * - ON CONFLICT (event_code) DO UPDATE
     * - 批量插入或更新风险事件
     */
    @GetMapping("/testBatchInsertOrUpdateIncident")
    public String testBatchInsertOrUpdateIncident() {
        try {
            System.out.println("测试: batchInsertOrUpdateIncident - 批量插入或更新");
            List<RiskIncident> list = new ArrayList<>();
            
            RiskIncident incident1 = new RiskIncident();
            incident1.setEventCode("RISK-TEST-001");
            incident1.setName("测试APT攻击");
            incident1.setTemplateId("2001");
            incident1.setThreatSeverity("High");
            incident1.setTopEventTypeChinese("高级威胁");
            incident1.setSecondEventTypeChinese("APT攻击");
            incident1.setFocusIp("192.168.1.100");
            incident1.setFocusObject("victim");
            incident1.setCounts(5);
            incident1.setAlarmStatus("unprocessed");
            incident1.setAlarmResults("OK");
            incident1.setDataSource("alert");
            incident1.setIsScenario(1);
            list.add(incident1);
            
            RiskIncident incident2 = new RiskIncident();
            incident2.setEventCode("RISK-TEST-002");
            incident2.setName("测试勒索软件");
            incident2.setTemplateId("2002");
            incident2.setThreatSeverity("High");
            incident2.setTopEventTypeChinese("恶意软件");
            incident2.setSecondEventTypeChinese("勒索软件");
            incident2.setFocusIp("192.168.2.200");
            incident2.setFocusObject("victim");
            incident2.setCounts(3);
            incident2.setAlarmStatus("processing");
            incident2.setAlarmResults("FAIL");
            incident2.setDataSource("incident");
            incident2.setIsScenario(0);
            list.add(incident2);
            
            mapper.batchInsertOrUpdateIncident(list);
            System.out.println("结果: 成功批量插入/更新 " + list.size() + " 条数据");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testBatchInsertOrUpdateIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法5：deleteOldIncidentAnalysis
     * 测试条件：
     * - DELETE FROM t_risk_incidents_analysis
     * - create_time < CURRENT_TIMESTAMP - INTERVAL 'days'
     */
    @GetMapping("/testDeleteOldIncidentAnalysis")
    public String testDeleteOldIncidentAnalysis() {
        try {
            System.out.println("测试: deleteOldIncidentAnalysis - 删除旧分析数据");
            int days = 30;
            int count = mapper.deleteOldIncidentAnalysis(days);
            System.out.println("结果: 删除了 " + count + " 条分析数据 (超过 " + days + " 天)");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testDeleteOldIncidentAnalysis 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法6：deleteOldIncident
     * 测试条件：
     * - DELETE FROM t_risk_incidents
     * - create_time < CURRENT_TIMESTAMP - INTERVAL 'days'
     */
    @GetMapping("/testDeleteOldIncident")
    public String testDeleteOldIncident() {
        try {
            System.out.println("测试: deleteOldIncident - 删除旧风险事件");
            int days = 30;
            int count = mapper.deleteOldIncident(days);
            System.out.println("结果: 删除了 " + count + " 条风险事件 (超过 " + days + " 天)");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testDeleteOldIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法7：selectOldIncidentByCodes
     * 测试条件：
     * - <foreach collection="list" item="code">
     * - event_code in (codes)
     * - create_time < CURRENT_TIMESTAMP - INTERVAL 'days'
     */
    @GetMapping("/testSelectOldIncidentByCodes")
    public String testSelectOldIncidentByCodes() {
        try {
            System.out.println("测试: selectOldIncidentByCodes - 根据event_code查询旧事件");
            List<String> codes = Arrays.asList("RISK-2026-001", "RISK-2026-002", "RISK-2026-003");
            List<Long> ids = mapper.selectOldIncidentByCodes(codes);
            System.out.println("结果: 查询到 " + ids.size() + " 条旧事件ID");
            return "SUCCESS: " + ids.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectOldIncidentByCodes 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法8：getRiskList - 最复杂查询方法
     * 测试条件：
     * - <if test="name != null and name != ''">（名称模糊查询）
     * - <if test="threatSeverity != null and threatSeverity.size() != null">（威胁等级）
     * - <if test="subCategory != null and subCategory.size() != null">（子类别）
     * - <if test="focusObject != null and focusObject != ''">（关注对象）
     * - <if test="isScenario != null">（是否符合追溯条件）
     * - <if test="focusIp != null and focusIp != ''">（关注IP）
     * - <if test="alarmResult != null and alarmResult.size() != null">（攻击结果）
     * - <if test="alarmStatus != null and alarmStatus.size() != null">（处置状态）
     * - <if test="startTime != null and startTime != ''">（开始时间）
     * - <if test="endTime != null and endTime != ''">（结束时间）
     * - <if test="topCategory != null and topCategory.size() != null">（一级类别）
     * - <choose><when orderByStr == null>（排序选择）
     * - LEFT JOIN t_alarm_status_timing_task
     * - LEFT JOIN t_risk_incidents_analysis
     */
    @GetMapping("/testGetRiskList")
    public String testGetRiskList() {
        try {
            System.out.println("测试: getRiskList - 综合查询所有条件");
            Map<String, Object> params = new HashMap<>();
            
            // 测试所有11个条件参数
            params.put("name", "APT");
            params.put("threatSeverity", Arrays.asList("High", "Medium"));
            params.put("subCategory", Arrays.asList("持续性威胁", "勒索软件"));
            params.put("focusObject", "victim");
            params.put("isScenario", 1);
            params.put("focusIp", "192.168");
            params.put("alarmResult", Arrays.asList("OK", "FAIL"));
            params.put("alarmStatus", Arrays.asList("unprocessed", "processing"));
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("topCategory", Arrays.asList("高级威胁", "恶意软件"));
            
            // 测试自定义排序
            params.put("orderByStr", "ri.create_time DESC");
            
            // 分页参数
            params.put("pageNum", 1);
            params.put("pageSize", 10);
            
            List<Map<String, Object>> list = mapper.getRiskList(params);
            System.out.println("结果: 查询到 " + list.size() + " 条风险事件");
            if (!list.isEmpty()) {
                Map<String, Object> first = list.get(0);
                System.out.println("样例: name=" + first.get("name") + ", threatSeverity=" + first.get("threatSeverity"));
            }
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
     * 测试条件：
     * - GROUP BY alarm_status
     * - <if test="startTime">
     * - <if test="endTime">
     */
    @GetMapping("/testGetCountByStatus")
    public String testGetCountByStatus() {
        try {
            System.out.println("测试: getCountByStatus - 按状态统计数量");
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            
            List<Map<String, Object>> list = mapper.getCountByStatus(params);
            System.out.println("结果: 统计到 " + list.size() + " 种状态");
            for (Map<String, Object> item : list) {
                System.out.println("状态: " + item.get("alarmStatus") + " = " + item.get("count"));
            }
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
     * 测试条件：
     * - WHERE event_code = #{eventCode}
     */
    @GetMapping("/testGetByEventCode")
    public String testGetByEventCode() {
        try {
            System.out.println("测试: getByEventCode - 根据事件编号查询");
            String eventCode = "RISK-2026-001";
            List<Map<String, Object>> list = mapper.getByEventCode(eventCode);
            System.out.println("结果: 查询到 " + list.size() + " 条数据 (eventCode=" + eventCode + ")");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetByEventCode 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法11：selectEventAndTempById
     * 测试条件：
     * - LEFT JOIN t_query_template ON template_id = qt.template_code
     * - WHERE id = #{id}
     */
    @GetMapping("/testSelectEventAndTempById")
    public String testSelectEventAndTempById() {
        try {
            System.out.println("测试: selectEventAndTempById - 根据ID查询事件及模板");
            int id = 1001;
            Map<String, Object> result = mapper.selectEventAndTempById(id);
            System.out.println("结果: 查询成功, name=" + (result != null ? result.get("name") : "null"));
            return "SUCCESS: " + (result != null ? "查到数据" : "未找到");
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectEventAndTempById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法12：selectAllByIdList
     * 测试条件：
     * - <foreach collection="list" item="id">
     * - LEFT JOIN t_query_template
     * - LEFT JOIN t_event_template
     * - id in (ids)
     */
    @GetMapping("/testSelectAllByIdList")
    public String testSelectAllByIdList() {
        try {
            System.out.println("测试: selectAllByIdList - 根据ID列表查询详情");
            List<Integer> ids = Arrays.asList(1001, 1002, 1003, 1004, 1005);
            List<Map<String, Object>> list = mapper.selectAllByIdList(ids);
            System.out.println("结果: 查询到 " + list.size() + " 条详情数据");
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
     * 测试条件：
     * - <if test="threatSeverity != null">
     * - <if test="subCategory != null">
     * - <if test="focusIp != null">
     * - <if test="startTime != null">
     * - <if test="endTime != null">
     * - GROUP BY top_event_type_chinese, second_event_type_chinese
     */
    @GetMapping("/testQueryEventCount")
    public String testQueryEventCount() {
        try {
            System.out.println("测试: queryEventCount - 查询事件统计");
            Map<String, Object> params = new HashMap<>();
            params.put("threatSeverity", Arrays.asList("High", "Medium"));
            params.put("subCategory", Arrays.asList("持续性威胁", "勒索软件"));
            params.put("focusIp", "192.168");
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            
            List<Map<String, Object>> list = mapper.queryEventCount(params);
            System.out.println("结果: 统计到 " + list.size() + " 组事件类型");
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
     * 测试条件：
     * - <if test="topCategory != null">
     * - <if test="subCategory != null">
     * - <if test="startTime != null">
     * - <if test="endTime != null">
     */
    @GetMapping("/testQueryIncidentsCount")
    public String testQueryIncidentsCount() {
        try {
            System.out.println("测试: queryIncidentsCount - 查询事件数量统计");
            Map<String, Object> params = new HashMap<>();
            params.put("topCategory", Arrays.asList("高级威胁", "恶意软件"));
            params.put("subCategory", Arrays.asList("持续性威胁", "勒索软件"));
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            
            List<Map<String, Object>> list = mapper.queryIncidentsCount(params);
            System.out.println("结果: 统计数据 " + list.size() + " 条");
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
     * 测试条件：
     * - DISTINCT kill_chain
     * - <if test="startTime">
     * - <if test="endTime">
     * - kill_chain != '' and kill_chain is not null
     */
    @GetMapping("/testQueryKillChains")
    public String testQueryKillChains() {
        try {
            System.out.println("测试: queryKillChains - 查询所有杀伤链");
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            
            List<String> list = mapper.queryKillChains(params);
            System.out.println("结果: 查询到 " + list.size() + " 条杀伤链");
            for (String killChain : list) {
                System.out.println("杀伤链: " + killChain);
            }
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
     * 测试条件：
     * - SELECT event_ids FROM t_risk_incidents WHERE id = #{id}
     */
    @GetMapping("/testGetEventIdsById")
    public String testGetEventIdsById() {
        try {
            System.out.println("测试: getEventIdsById - 根据ID获取事件ID列表");
            int id = 1001;
            String eventIds = mapper.getEventIdsById(id);
            System.out.println("结果: eventIds=" + eventIds);
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
     * 测试条件：
     * - SELECT filter_content FROM t_risk_incidents WHERE id = #{id}
     */
    @GetMapping("/testGetFilterContent")
    public String testGetFilterContent() {
        try {
            System.out.println("测试: getFilterContent - 根据ID获取过滤条件");
            int id = 1001;
            String filterContent = mapper.getFilterContent(id);
            System.out.println("结果: filterContent=" + filterContent);
            return "SUCCESS: " + (filterContent != null ? filterContent : "null");
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetFilterContent 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法18：FocusIpMessage
     * 测试条件：
     * - <foreach collection="list" item="ip">
     * - focus_ip in (ips)
     * - GROUP BY focus_ip, alarm_status
     */
    @GetMapping("/testFocusIpMessage")
    public String testFocusIpMessage() {
        try {
            System.out.println("测试: FocusIpMessage - 根据IP列表查询消息");
            List<String> ips = Arrays.asList("192.168.10.50", "192.168.50.1", "192.168.20.88");
            List<Map<String, Object>> list = mapper.FocusIpMessage(ips);
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
     * 方法19：getFocusObject
     * 测试条件：
     * - SELECT DISTINCT focus_object FROM t_risk_incidents
     * - WHERE focus_object is not null
     */
    @GetMapping("/testGetFocusObject")
    public String testGetFocusObject() {
        try {
            System.out.println("测试: getFocusObject - 获取所有关注对象");
            List<String> list = mapper.getFocusObject();
            System.out.println("结果: 查询到 " + list.size() + " 种关注对象");
            for (String obj : list) {
                System.out.println("关注对象: " + obj);
            }
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetFocusObject 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法20：getRiskListByIds
     * 测试条件：
     * - <foreach collection="list" item="id">
     * - id in (ids)
     */
    @GetMapping("/testGetRiskListByIds")
    public String testGetRiskListByIds() {
        try {
            System.out.println("测试: getRiskListByIds - 根据ID列表查询风险事件");
            List<Integer> ids = Arrays.asList(1001, 1002, 1003);
            List<RiskIncident> list = mapper.getRiskListByIds(ids);
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
     * 方法21：getCount
     * 测试条件：
     * - <if test="name != null">（名称）
     * - <if test="threatSeverity != null">（威胁等级）
     * - <if test="subCategory != null">（子类别）
     * - <if test="focusObject != null">（关注对象）
     * - <if test="isScenario != null">（是否追溯）
     * - <if test="focusIp != null">（关注IP）
     * - <if test="alarmResult != null">（攻击结果）
     * - <if test="alarmStatus != null">（处置状态）
     * - <if test="startTime != null">（开始时间）
     * - <if test="endTime != null">（结束时间）
     * - <if test="topCategory != null">（一级类别）
     */
    @GetMapping("/testGetCount")
    public String testGetCount() {
        try {
            System.out.println("测试: getCount - 查询总数（包含所有过滤条件）");
            Map<String, Object> params = new HashMap<>();
            params.put("name", "攻击");
            params.put("threatSeverity", Arrays.asList("High", "Medium"));
            params.put("subCategory", Arrays.asList("持续性威胁", "勒索软件"));
            params.put("focusObject", "victim");
            params.put("isScenario", 1);
            params.put("focusIp", "192.168");
            params.put("alarmResult", Arrays.asList("OK", "FAIL"));
            params.put("alarmStatus", Arrays.asList("unprocessed", "processing"));
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("topCategory", Arrays.asList("高级威胁", "恶意软件"));
            
            Long count = mapper.getCount(params);
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
     * 测试条件：
     * - <if test="startTime">
     * - <if test="endTime">
     * - DISTINCT focus_ip
     * - LIMIT #{pageSize} OFFSET (pageNum-1)*pageSize
     */
    @GetMapping("/testQueryFocusIps")
    public String testQueryFocusIps() {
        try {
            System.out.println("测试: queryFocusIps - 查询关注IP列表（分页）");
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("pageNum", 1);
            params.put("pageSize", 10);
            
            List<Map<String, Object>> list = mapper.queryFocusIps(params);
            System.out.println("结果: 查询到 " + list.size() + " 个关注IP");
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
     * 测试条件：
     * - COUNT(DISTINCT focus_ip)
     * - <if test="startTime">
     * - <if test="endTime">
     */
    @GetMapping("/testQueryFocusIpCount")
    public String testQueryFocusIpCount() {
        try {
            System.out.println("测试: queryFocusIpCount - 统计关注IP总数");
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", "2026-01-25 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            
            Long count = mapper.queryFocusIpCount(params);
            System.out.println("结果: 关注IP总数=" + count);
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
     * 测试条件：
     * - <foreach collection="list" item="id">
     * - id in (ids)
     * - SELECT event_ids
     */
    @GetMapping("/testGetSecurityEventIdsByCondition")
    public String testGetSecurityEventIdsByCondition() {
        try {
            System.out.println("测试: getSecurityEventIdsByCondition - 根据ID列表获取安全事件ID");
            List<Integer> ids = Arrays.asList(1001, 1002, 1003);
            List<String> eventIdsList = mapper.getSecurityEventIdsByCondition(ids);
            System.out.println("结果: 查询到 " + eventIdsList.size() + " 条安全事件ID");
            return "SUCCESS: " + eventIdsList.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetSecurityEventIdsByCondition 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法25：countByDate
     * 测试条件：
     * - COUNT(*) WHERE DATE(create_time) = CAST(date AS date)
     */
    @GetMapping("/testCountByDate")
    public String testCountByDate() {
        try {
            System.out.println("测试: countByDate - 根据日期统计数量");
            String date = "2026-01-28";
            Integer count = mapper.countByDate(date);
            System.out.println("结果: " + date + " 的事件数=" + count);
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
     * 测试条件：
     * - <if test="focusIp != null">
     * - <if test="eventCode != null">
     * - WHERE alarm_status = 'unprocessed'
     */
    @GetMapping("/testSelectIncidentForCheckScenario")
    public String testSelectIncidentForCheckScenario() {
        try {
            System.out.println("测试: selectIncidentForCheckScenario - 查询待检查的追溯事件");
            Map<String, Object> params = new HashMap<>();
            params.put("focusIp", "192.168.10.50");
            params.put("eventCode", "RISK-2026-001");
            
            List<RiskIncident> list = mapper.selectIncidentForCheckScenario(params);
            System.out.println("结果: 查询到 " + list.size() + " 条待检查事件");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectIncidentForCheckScenario 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法27：isHandled
     * 测试条件：
     * - COUNT(*) WHERE event_code = #{eventCode}
     * - AND alarm_status IN ('processed', 'falsePositives', 'ignore')
     */
    @GetMapping("/testIsHandled")
    public String testIsHandled() {
        try {
            System.out.println("测试: isHandled - 检查事件是否已处置");
            String eventCode = "RISK-2026-004";
            Integer count = mapper.isHandled(eventCode);
            System.out.println("结果: 事件 " + eventCode + " 已处置数量=" + count);
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testIsHandled 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法28：updateStatus
     * 测试条件：
     * - UPDATE t_risk_incidents
     * - SET alarm_status = #{alarmStatus}
     * - WHERE id = #{id}
     */
    @GetMapping("/testUpdateStatus")
    public String testUpdateStatus() {
        try {
            System.out.println("测试: updateStatus - 更新事件状态");
            RiskIncident incident = new RiskIncident();
            incident.setId(1003);
            incident.setAlarmStatus("processed");
            
            int count = mapper.updateStatus(incident);
            System.out.println("结果: 更新了 " + count + " 条记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateStatus 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法29：updateJudgeResults
     * 测试条件：
     * - UPDATE t_risk_incidents
     * - SET judge_result = #{judgeResult}
     * - WHERE event_code = #{eventCode}
     */
    @GetMapping("/testUpdateJudgeResults")
    public String testUpdateJudgeResults() {
        try {
            System.out.println("测试: updateJudgeResults - 更新研判结果");
            Map<String, Object> params = new HashMap<>();
            params.put("eventCode", "RISK-2026-003");
            params.put("judgeResult", 1);
            
            int count = mapper.updateJudgeResults(params);
            System.out.println("结果: 更新了 " + count + " 条记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateJudgeResults 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法30：updateJudgeStatus
     * 测试条件：
     * - UPDATE t_risk_incidents
     * - SET judge_status = #{judgeStatus}
     * - WHERE event_code = #{eventCode}
     */
    @GetMapping("/testUpdateJudgeStatus")
    public String testUpdateJudgeStatus() {
        try {
            System.out.println("测试: updateJudgeStatus - 更新研判方式");
            Map<String, Object> params = new HashMap<>();
            params.put("eventCode", "RISK-2026-005");
            params.put("judgeStatus", "人工研判");
            
            int count = mapper.updateJudgeStatus(params);
            System.out.println("结果: 更新了 " + count + " 条记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateJudgeStatus 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
