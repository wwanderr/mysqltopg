package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentHistory;
import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentHistoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/**
 * RiskIncidentHistory 深度测试控制器
 * 对应10个自定义方法 + BaseMapper方法
 * 生成时间: 2026-02-02
 */
@RestController
@RequestMapping("/test/riskIncidentHistory")
public class RiskIncidentHistoryTestController {
    
    @Autowired
    private RiskIncidentHistoryMapper mapper;

    /**
     * 测试1：getRiskHistoryList - 11个参数
     * URL: /test/riskIncidentHistory/getRiskHistoryList
     */
    @GetMapping("/getRiskHistoryList")
    public String testGetRiskHistoryList() {
        try {
            System.out.println("=== 测试: getRiskHistoryList ===");
            
            // 场景1：所有参数
            List<Map<String, Object>> result1 = mapper.getRiskHistoryList(
                "end_time desc",                    // orderByStr
                "攻击",                              // name
                Arrays.asList("High", "Medium"),    // threatSeverity
                "2026-12-31 23:59:59",             // endTime
                Arrays.asList("横向移动", "SQL注入"), // subCategory
                "attacker",                         // focusObject
                "203.0",                            // focusIp
                Arrays.asList("OK", "FAIL"),       // alarmResult
                "2025-11-01 00:00:00",             // startTime
                10L,                                // size
                0L                                  // offSet
            );
            System.out.println("✓ 场景1（所有参数）: " + result1.size() + " 条");
            
            // 场景2：默认排序（orderByStr=null）
            List<Map<String, Object>> result2 = mapper.getRiskHistoryList(
                null,                               // orderByStr - 默认排序
                null,                               // name
                null,                               // threatSeverity
                "2026-12-31 23:59:59",             // endTime
                null,                               // subCategory
                null,                               // focusObject
                null,                               // focusIp
                null,                               // alarmResult
                "2025-01-01 00:00:00",             // startTime
                100L,                               // size
                0L                                  // offSet
            );
            System.out.println("✓ 场景2（默认排序）: " + result2.size() + " 条");
            
            return "SUCCESS: 共 " + (result1.size() + result2.size()) + " 条";
        } catch (Exception e) {
            System.err.println("❌ getRiskHistoryList 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"getRiskHistoryList 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：queryEventCount - 8个参数
     * URL: /test/riskIncidentHistory/queryEventCount
     */
    @GetMapping("/queryEventCount")
    public String testQueryEventCount() {
        try {
            System.out.println("=== 测试: queryEventCount ===");
            
            // 场景1：所有参数
            List<Map> result1 = mapper.queryEventCount(
                "2025-01-01 00:00:00",             // startTime
                "2026-12-31 23:59:59",             // endTime
                "攻击",                             // eventName
                "192.168",                          // focusIp
                "attacker",                         // focusObject
                Arrays.asList("横向移动", "C&C通信"), // subCategory
                Arrays.asList("OK", "FAIL"),       // alarmResult
                Arrays.asList("High", "Medium")    // threatSeverity
            );
            System.out.println("✓ 场景1（所有参数）: " + result1.size() + " 组统计");
            
            // 场景2：仅必需参数
            List<Map> result2 = mapper.queryEventCount(
                "2025-01-01 00:00:00",             // startTime
                "2026-12-31 23:59:59",             // endTime
                null,                               // eventName
                null,                               // focusIp
                null,                               // focusObject
                null,                               // subCategory
                null,                               // alarmResult
                null                                // threatSeverity
            );
            System.out.println("✓ 场景2（仅时间范围）: " + result2.size() + " 组统计");
            
            return "SUCCESS: 统计结果 " + (result1.size() + result2.size()) + " 组";
        } catch (Exception e) {
            System.err.println("❌ queryEventCount 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"queryEventCount 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：getFocusObject - 单个参数，返回String
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
            System.err.println("❌ getFocusObject 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"getFocusObject 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：FocusIpMessage - 4个参数（需要关联表数据）
     * URL: /test/riskIncidentHistory/FocusIpMessage
     */
    @GetMapping("/FocusIpMessage")
    public String testFocusIpMessage() {
        try {
            System.out.println("=== 测试: FocusIpMessage ===");
            
            // 场景1：包含ip过滤
            List<Map<String, Object>> result1 = mapper.FocusIpMessage(
                9001,                               // id
                "192.168",                          // ip
                10L,                                // size
                0L                                  // offSet
            );
            System.out.println("✓ 场景1（含ip过滤）: " + result1.size() + " 条");
            
            // 场景2：不过滤ip
            List<Map<String, Object>> result2 = mapper.FocusIpMessage(
                9001,                               // id
                null,                               // ip
                10L,                                // size
                0L                                  // offSet
            );
            System.out.println("✓ 场景2（不过滤ip）: " + result2.size() + " 条");
            
            return "SUCCESS: 共 " + (result1.size() + result2.size()) + " 条";
        } catch (Exception e) {
            System.err.println("❌ FocusIpMessage 失败（可能缺少关联表数据）: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"FocusIpMessage 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：selectAllByIdList - List<String>参数（注意是String类型）
     * URL: /test/riskIncidentHistory/selectAllByIdList
     */
    @GetMapping("/selectAllByIdList")
    public String testSelectAllByIdList() {
        try {
            System.out.println("=== 测试: selectAllByIdList ===");
            
            // 注意：参数类型是List<String>，不是List<Integer>
            List<String> idList = Arrays.asList("9001", "9002", "9003");
            List<Map<String, Object>> result = mapper.selectAllByIdList(idList);
            System.out.println("✓ 查询ID列表: " + idList + ", 结果: " + result.size() + " 条");
            
            return "SUCCESS: " + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ selectAllByIdList 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"selectAllByIdList 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试6：getCount - 8个参数
     * URL: /test/riskIncidentHistory/getCount
     */
    @GetMapping("/getCount")
    public String testGetCount() {
        try {
            System.out.println("=== 测试: getCount ===");
            
            // 场景1：所有参数
            Long count1 = mapper.getCount(
                "攻击",                              // name
                "2026-12-31 23:59:59",             // endTime
                Arrays.asList("横向移动"),          // subCategory
                Arrays.asList("OK"),                // alarmResult
                Arrays.asList("High", "Medium"),   // threatSeverity
                "attacker",                         // focusObject
                "192",                              // focusIp
                "2025-01-01 00:00:00"              // startTime
            );
            System.out.println("✓ 场景1（所有参数）: " + count1 + " 条");
            
            // 场景2：仅必需参数
            Long count2 = mapper.getCount(
                null,                               // name
                "2026-12-31 23:59:59",             // endTime
                null,                               // subCategory
                null,                               // alarmResult
                null,                               // threatSeverity
                null,                               // focusObject
                null,                               // focusIp
                "2025-01-01 00:00:00"              // startTime
            );
            System.out.println("✓ 场景2（仅时间范围）: " + count2 + " 条");
            
            return "SUCCESS: count1=" + count1 + ", count2=" + count2;
        } catch (Exception e) {
            System.err.println("❌ getCount 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"getCount 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试7：getFocusIpCount - 2个参数（需要关联表数据）
     * URL: /test/riskIncidentHistory/getFocusIpCount
     */
    @GetMapping("/getFocusIpCount")
    public String testGetFocusIpCount() {
        try {
            System.out.println("=== 测试: getFocusIpCount ===");
            
            // 场景1：包含ip过滤
            Long count1 = mapper.getFocusIpCount(9001, "192.168");
            System.out.println("✓ 场景1（含ip过滤）: " + count1 + " 条");
            
            // 场景2：不过滤ip
            Long count2 = mapper.getFocusIpCount(9001, null);
            System.out.println("✓ 场景2（不过滤ip）: " + count2 + " 条");
            
            return "SUCCESS: count1=" + count1 + ", count2=" + count2;
        } catch (Exception e) {
            System.err.println("❌ getFocusIpCount 失败（需关联表数据）: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"getFocusIpCount 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试8：queryFocusIps - 5个参数
     * URL: /test/riskIncidentHistory/queryFocusIps
     */
    @GetMapping("/queryFocusIps")
    public String testQueryFocusIps() {
        try {
            System.out.println("=== 测试: queryFocusIps ===");
            
            // 场景1：包含ip过滤
            List<Map<String, String>> result1 = mapper.queryFocusIps(
                "2026-01",                          // timePart
                "RH-2026-001",                      // eventCode
                "192",                              // ip
                0L,                                 // offset
                10L                                 // size
            );
            System.out.println("✓ 场景1（含ip过滤）: " + result1.size() + " 条");
            
            // 场景2：不过滤ip
            List<Map<String, String>> result2 = mapper.queryFocusIps(
                "2026-01",                          // timePart
                "RH-2026-001",                      // eventCode
                null,                               // ip
                0L,                                 // offset
                10L                                 // size
            );
            System.out.println("✓ 场景2（不过滤ip）: " + result2.size() + " 条");
            
            return "SUCCESS: 共 " + (result1.size() + result2.size()) + " 条";
        } catch (Exception e) {
            System.err.println("❌ queryFocusIps 失败（需关联表数据）: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"queryFocusIps 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试9：queryFocusIpCount - 3个参数
     * URL: /test/riskIncidentHistory/queryFocusIpCount
     */
    @GetMapping("/queryFocusIpCount")
    public String testQueryFocusIpCount() {
        try {
            System.out.println("=== 测试: queryFocusIpCount ===");
            
            // 场景1：包含ip过滤
            Long count1 = mapper.queryFocusIpCount(
                "2026-01",                          // timePart
                "RH-2026-001",                      // eventCode
                "192"                               // ip
            );
            System.out.println("✓ 场景1（含ip过滤）: " + count1 + " 条");
            
            // 场景2：不过滤ip
            Long count2 = mapper.queryFocusIpCount(
                "2026-01",                          // timePart
                "RH-2026-001",                      // eventCode
                null                                // ip
            );
            System.out.println("✓ 场景2（不过滤ip）: " + count2 + " 条");
            
            return "SUCCESS: count1=" + count1 + ", count2=" + count2;
        } catch (Exception e) {
            System.err.println("❌ queryFocusIpCount 失败（需关联表数据）: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"queryFocusIpCount 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试10：countByDate - 2个参数
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
            System.err.println("❌ countByDate 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"countByDate 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试11：BaseMapper - selectById
     * URL: /test/riskIncidentHistory/selectById
     */
    @GetMapping("/selectById")
    public String testSelectById() {
        try {
            System.out.println("=== 测试: BaseMapper.selectById ===");
            
            RiskIncidentHistory entity = mapper.selectById(9001L);
            System.out.println("✓ 查询ID=9001: " + (entity != null ? entity.getName() : "null"));
            
            return "SUCCESS: " + (entity != null ? entity.getName() : "未找到");
        } catch (Exception e) {
            System.err.println("❌ selectById 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"selectById 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
