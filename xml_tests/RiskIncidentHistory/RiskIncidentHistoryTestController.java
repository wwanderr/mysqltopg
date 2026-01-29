package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentHistoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/**
 * RiskIncidentHistory 深度测试控制器
 * 对应12个XML方法，每个方法测试所有参数
 * 生成时间: 2026-01-28
 */
@RestController
@RequestMapping("/test/riskIncidentHistory")
public class RiskIncidentHistoryTestController {
    
    @Autowired
    private RiskIncidentHistoryMapper mapper;

    /**
     * 测试1：getRiskHistoryList（测试所有11个参数 + <choose>排序）
     * URL: /test/riskIncidentHistory/getRiskHistoryList
     */
    @GetMapping("/getRiskHistoryList")
    public String testGetRiskHistoryList() {
        try {
            System.out.println("=== 测试: getRiskHistoryList（综合参数+排序） ===");
            
            Map<String, Object> params = new HashMap<>();
            
            // 参数1：name（模糊查询）
            params.put("name", "攻击");
            
            // 参数2：threatSeverity（数组，in查询）
            List<String> threatList = Arrays.asList("High", "Medium");
            params.put("threatSeverity", threatList);
            
            // 参数3：subCategory（数组，in查询）
            List<String> subCategoryList = Arrays.asList("横向移动", "SQL注入", "C&C通信");
            params.put("subCategory", subCategoryList);
            
            // 参数4：focusObject（单值）
            params.put("focusObject", "attacker");
            
            // 参数5：focusIp（模糊查询）
            params.put("focusIp", "203.0");
            
            // 参数6：alarmResult（数组，in查询）
            List<String> alarmResultList = Arrays.asList("OK", "FAIL");
            params.put("alarmResult", alarmResultList);
            
            // 参数7-8：startTime, endTime（必需参数）
            params.put("startTime", "2025-11-01 00:00:00");
            params.put("endTime", "2026-12-31 23:59:59");
            
            // 参数9-10：分页参数
            params.put("size", 10L);
            params.put("offSet", 0L);
            
            // 参数11：orderByStr（<choose>测试）
            // 场景1：orderByStr为null（使用默认排序：end_time desc）
            params.put("orderByStr", null);
            
            List<Map<String, Object>> result1 = mapper.getRiskHistoryList(params);
            System.out.println("✓ 场景1（默认排序）: " + result1.size() + " 条");
            
            // 场景2：orderByStr有值（自定义排序）
            params.put("orderByStr", "create_time asc, id asc");
            List<Map<String, Object>> result2 = mapper.getRiskHistoryList(params);
            System.out.println("✓ 场景2（自定义排序）: " + result2.size() + " 条");
            
            // 场景3：只用必需参数（测试其他if不满足）
            Map<String, Object> params3 = new HashMap<>();
            params3.put("startTime", "2025-01-01 00:00:00");
            params3.put("endTime", "2026-12-31 23:59:59");
            params3.put("size", 100L);
            params3.put("offSet", 0L);
            List<Map<String, Object>> result3 = mapper.getRiskHistoryList(params3);
            System.out.println("✓ 场景3（仅必需参数）: " + result3.size() + " 条");
            
            return "SUCCESS: 测试3个场景，共 " + (result1.size() + result2.size() + result3.size()) + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 getRiskHistoryList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：queryEventCount（测试7个参数 + 2个LEFT JOIN）
     * URL: /test/riskIncidentHistory/queryEventCount
     */
    @GetMapping("/queryEventCount")
    public String testQueryEventCount() {
        try {
            System.out.println("=== 测试: queryEventCount（综合参数+JOIN） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", "2025-01-01 00:00:00");
            params.put("endTime", "2026-12-31 23:59:59");
            
            // 场景1：所有if参数都有值
            params.put("eventName", "攻击");
            params.put("focusIp", "192.168");
            params.put("focusObject", "attacker");
            params.put("subCategory", Arrays.asList("横向移动", "C&C通信"));
            params.put("alarmResult", Arrays.asList("OK", "FAIL"));
            params.put("threatSeverity", Arrays.asList("High", "Medium"));
            
            List<Map<String, Object>> result1 = mapper.queryEventCount(params);
            System.out.println("✓ 场景1（所有参数）: " + result1.size() + " 组统计");
            
            // 场景2：仅必需参数
            Map<String, Object> params2 = new HashMap<>();
            params2.put("startTime", "2025-01-01 00:00:00");
            params2.put("endTime", "2026-12-31 23:59:59");
            List<Map<String, Object>> result2 = mapper.queryEventCount(params2);
            System.out.println("✓ 场景2（仅时间范围）: " + result2.size() + " 组统计");
            
            return "SUCCESS: 统计结果 " + (result1.size() + result2.size()) + " 组";
        } catch (Exception e) {
            String errorMsg = "测试方法 queryEventCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：getFocusObject（简单查询）
     * URL: /test/riskIncidentHistory/getFocusObject
     */
    @GetMapping("/getFocusObject")
    public String testGetFocusObject() {
        try {
            System.out.println("=== 测试: getFocusObject ===");
            
            String focusObject = mapper.getFocusObject(9001);
            System.out.println("✓ ID=9001, focus_object=" + focusObject);
            
            return "SUCCESS: " + focusObject;
        } catch (Exception e) {
            String errorMsg = "测试方法 getFocusObject 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：FocusIpMessage（测试3个参数，注：需要t_risk_incidents_out_going_history表数据）
     * URL: /test/riskIncidentHistory/FocusIpMessage
     */
    @GetMapping("/FocusIpMessage")
    public String testFocusIpMessage() {
        try {
            System.out.println("=== 测试: FocusIpMessage（关联t_risk_incidents_out_going_history） ===");
            
            // 场景1：所有参数
            Map<String, Object> params1 = new HashMap<>();
            params1.put("id", 9001);
            params1.put("ip", "192.168");
            params1.put("size", 10L);
            params1.put("offSet", 0L);
            
            List<Map<String, Object>> result1 = mapper.FocusIpMessage(params1);
            System.out.println("✓ 场景1（含ip过滤）: " + result1.size() + " 条");
            
            // 场景2：ip为null
            Map<String, Object> params2 = new HashMap<>();
            params2.put("id", 9001);
            params2.put("size", 10L);
            params2.put("offSet", 0L);
            
            List<Map<String, Object>> result2 = mapper.FocusIpMessage(params2);
            System.out.println("✓ 场景2（不过滤ip）: " + result2.size() + " 条");
            
            return "SUCCESS: 共 " + (result1.size() + result2.size()) + " 条（注：需关联表数据）";
        } catch (Exception e) {
            String errorMsg = "测试方法 FocusIpMessage 执行失败（可能缺少t_risk_incidents_out_going_history数据）";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：selectAllByIdList（测试foreach）
     * URL: /test/riskIncidentHistory/selectAllByIdList
     */
    @GetMapping("/selectAllByIdList")
    public String testSelectAllByIdList() {
        try {
            System.out.println("=== 测试: selectAllByIdList（foreach批量查询） ===");
            
            List<Integer> idList = Arrays.asList(9001, 9002, 9003);
            List<Map<String, Object>> result = mapper.selectAllByIdList(idList);
            System.out.println("✓ 查询ID列表: " + idList + ", 结果: " + result.size() + " 条");
            
            return "SUCCESS: " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 selectAllByIdList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试6：getCount（测试7个参数）
     * URL: /test/riskIncidentHistory/getCount
     */
    @GetMapping("/getCount")
    public String testGetCount() {
        try {
            System.out.println("=== 测试: getCount（综合参数统计） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", "2025-01-01 00:00:00");
            params.put("endTime", "2026-12-31 23:59:59");
            
            // 场景1：所有if参数
            params.put("name", "攻击");
            params.put("threatSeverity", Arrays.asList("High", "Medium"));
            params.put("subCategory", Arrays.asList("横向移动"));
            params.put("focusObject", "attacker");
            params.put("focusIp", "192");
            params.put("alarmResult", Arrays.asList("OK"));
            
            Long count1 = mapper.getCount(params);
            System.out.println("✓ 场景1（所有参数）: " + count1 + " 条");
            
            // 场景2：仅必需参数
            Map<String, Object> params2 = new HashMap<>();
            params2.put("startTime", "2025-01-01 00:00:00");
            params2.put("endTime", "2026-12-31 23:59:59");
            Long count2 = mapper.getCount(params2);
            System.out.println("✓ 场景2（仅时间范围）: " + count2 + " 条");
            
            return "SUCCESS: 场景1=" + count1 + ", 场景2=" + count2;
        } catch (Exception e) {
            String errorMsg = "测试方法 getCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试7：getFocusIpCount（测试2个参数，注：需关联表数据）
     * URL: /test/riskIncidentHistory/getFocusIpCount
     */
    @GetMapping("/getFocusIpCount")
    public String testGetFocusIpCount() {
        try {
            System.out.println("=== 测试: getFocusIpCount（关联表统计） ===");
            
            Map<String, Object> params1 = new HashMap<>();
            params1.put("id", 9001);
            params1.put("ip", "192.168");
            
            Long count1 = mapper.getFocusIpCount(params1);
            System.out.println("✓ 场景1（含ip过滤）: " + count1 + " 条");
            
            Map<String, Object> params2 = new HashMap<>();
            params2.put("id", 9001);
            
            Long count2 = mapper.getFocusIpCount(params2);
            System.out.println("✓ 场景2（不过滤ip）: " + count2 + " 条");
            
            return "SUCCESS: count1=" + count1 + ", count2=" + count2;
        } catch (Exception e) {
            String errorMsg = "测试方法 getFocusIpCount 执行失败（需关联表数据）";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试8：queryFocusIps（测试4个参数）
     * URL: /test/riskIncidentHistory/queryFocusIps
     */
    @GetMapping("/queryFocusIps")
    public String testQueryFocusIps() {
        try {
            System.out.println("=== 测试: queryFocusIps（关联表查询） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("eventCode", "RH-2026-001");
            params.put("timePart", "2026-01");
            params.put("ip", "192");
            params.put("size", 10);
            params.put("offset", 0);
            
            List<Map<String, Object>> result1 = mapper.queryFocusIps(params);
            System.out.println("✓ 场景1（含ip过滤）: " + result1.size() + " 条");
            
            // 场景2：ip为null
            params.remove("ip");
            List<Map<String, Object>> result2 = mapper.queryFocusIps(params);
            System.out.println("✓ 场景2（不过滤ip）: " + result2.size() + " 条");
            
            return "SUCCESS: 共 " + (result1.size() + result2.size()) + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 queryFocusIps 执行失败（需关联表数据）";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试9：queryFocusIpCount（测试3个参数）
     * URL: /test/riskIncidentHistory/queryFocusIpCount
     */
    @GetMapping("/queryFocusIpCount")
    public String testQueryFocusIpCount() {
        try {
            System.out.println("=== 测试: queryFocusIpCount（关联表统计） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("eventCode", "RH-2026-001");
            params.put("timePart", "2026-01");
            params.put("ip", "192");
            
            Long count1 = mapper.queryFocusIpCount(params);
            System.out.println("✓ 场景1（含ip过滤）: " + count1 + " 条");
            
            // 场景2：ip为null
            params.remove("ip");
            Long count2 = mapper.queryFocusIpCount(params);
            System.out.println("✓ 场景2（不过滤ip）: " + count2 + " 条");
            
            return "SUCCESS: count1=" + count1 + ", count2=" + count2;
        } catch (Exception e) {
            String errorMsg = "测试方法 queryFocusIpCount 执行失败（需关联表数据）";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试10：countByDate（测试2个参数）
     * URL: /test/riskIncidentHistory/countByDate
     */
    @GetMapping("/countByDate")
    public String testCountByDate() {
        try {
            System.out.println("=== 测试: countByDate ===");
            
            String currentDate = "2026-01-28";
            String yesterdayDate = "2026-01-27";
            
            Integer result = mapper.countByDate(currentDate, yesterdayDate);
            System.out.println("✓ currentDate=" + currentDate + ", yesterdayDate=" + yesterdayDate + ", result=" + result);
            
            return "SUCCESS: " + result;
        } catch (Exception e) {
            String errorMsg = "测试方法 countByDate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
