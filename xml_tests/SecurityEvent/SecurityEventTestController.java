package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.SecurityEvent;
import com.dbapp.extension.xdr.threatMonitor.entity.SecurityEvent;
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
    private com.dbapp.extension.xdr.threatMonitor.mapper.SecurityEvent mapper;

    /**
     * 测试1：insertOrUpdate - 插入或更新安全事件
     * 场景：新检测到端口扫描事件
     */
    @GetMapping("/test1_insertOrUpdate")
    public String test1_insertOrUpdate() {
        try {
            System.out.println("测试: insertOrUpdate - 插入安全事件");
            SecurityEvent event = new SecurityEvent();
            event.setTemplateId(1003);  // 端口扫描模板
            event.setIncidentName("大规模端口扫描");
            event.setFocusIp("185.220.101.50");  // 新的扫描源
            event.setTargetIp("192.168.1.0/24");  // 扫描整个内网段
            event.setStartTime(LocalDateTime.now().minusMinutes(5));
            event.setTimePart(LocalDateTime.now().minusMinutes(5));
            event.setCount(1500L);  // 扫描了1500个端口
            event.setStatus("open");
            event.setLevel("high");
            event.setDescription("检测到来自185.220.101.50的大规模端口扫描，覆盖全网段");
            event.setSuggestion("建议立即封禁攻击源，审查网络防火墙规则");
            event.setAlarmResults("{\"action\": \"auto_block\", \"block_duration\": 86400}");
            event.setThreatLevel("high");
            event.setFocus("src_ip");
            event.setIncidentRuleType("网络扫描");
            event.setIncidentClassType("侦察行为");
            event.setIncidentSubClassType("端口扫描");
            event.setPriority(8);
            event.setIncidentCond("port_scan_count > 100");
            event.setConclusion("确认为恶意扫描行为");
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
            Map<String, Object> params = new HashMap<>();
            params.put("level", "high,critical");
            params.put("status", "open,monitoring");
            params.put("startTime", LocalDateTime.now().minusDays(7));
            params.put("endTime", LocalDateTime.now());
            params.put("start", 0);
            params.put("length", 10);
            
            List<Map<String, Object>> result = mapper.getSecurityEventList(params);
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
            event.setId(1001);
            event.setStatus("closed");
            event.setEndTime(LocalDateTime.now());
            event.setConclusion("已封禁攻击源IP，事件已解决");
            event.setAlarmResults("{\"action\": \"blocked\"}");
            
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
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", LocalDateTime.now().withHour(0).withMinute(0).withSecond(0));
            params.put("endTime", LocalDateTime.now());
            
            Map<String, Object> overview = mapper.queryOverview(params);
            System.out.println("结果: total=" + overview.get("total"));
            return "SUCCESS: " + overview.get("total");
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
            Integer eventId = 1002;
            
            Map<String, Object> detail = mapper.selectEventAndTempById(eventId);
            System.out.println("结果: " + detail.get("event_name"));
            return "SUCCESS: " + eventId;
        } catch (Exception e) {
            String errorMsg = "测试方法 test5_selectEventAndTempById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
