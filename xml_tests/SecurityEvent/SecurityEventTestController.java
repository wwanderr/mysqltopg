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
@RequestMapping("/test/security-event")
public class SecurityEventTestController {

    @Autowired
    private com.dbapp.extension.xdr.threatMonitor.mapper.SecurityEvent mapper;

    /**
     * 测试1：插入或更新安全事件
     * 场景：新检测到端口扫描事件
     */
    @GetMapping("/test-insert-or-update")
    public String testInsertOrUpdate() {
        try {
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
            
            System.out.println("✅ 插入成功：事件ID=" + event.getId() 
                + ", 事件名=" + event.getIncidentName()
                + ", 攻击源=" + event.getFocusIp()
                + ", 目标=" + event.getTargetIp()
                + ", 扫描次数=" + event.getCount());
            
            return "成功插入安全事件：" + event.getIncidentName() + " (ID=" + event.getId() + ")";
        } catch (Exception e) {
            System.err.println("❌ 插入失败：" + e.getMessage());
            e.printStackTrace();
            return "插入失败：" + e.getMessage();
        }
    }

    /**
     * 测试2：获取安全事件列表
     * 场景：查询所有高级别（high/critical）且未关闭的安全事件
     */
    @GetMapping("/test-query-event-list")
    public String testGetSecurityEventList() {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("level", "high,critical");  // 高危和严重级别
            params.put("status", "open,monitoring");  // 未关闭的
            params.put("startTime", LocalDateTime.now().minusDays(7));  // 最近7天
            params.put("endTime", LocalDateTime.now());
            params.put("start", 0);
            params.put("length", 10);
            
            List<Map<String, Object>> result = mapper.getSecurityEventList(params);
            
            System.out.println("✅ 查询成功，共 " + result.size() + " 条高危事件：");
            for (Map<String, Object> event : result) {
                System.out.println("  - ID=" + event.get("id") 
                    + ", 事件名=" + event.get("incident_name")
                    + ", 级别=" + event.get("level")
                    + ", 状态=" + event.get("status")
                    + ", 攻击源=" + event.get("focus_ip")
                    + ", 次数=" + event.get("count"));
            }
            
            return "查询成功，共 " + result.size() + " 条高危事件";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试3：更新事件状态
     * 场景：将 test_data.sql 中的 1001 号事件标记为已处理
     */
    @GetMapping("/test-update-status")
    public void testUpdateStatus() {
        try {
            SecurityEvent event = new SecurityEvent();
            event.setId(1001);  // SSH暴力破解事件
            event.setStatus("closed");  // 标记为已关闭
            event.setEndTime(LocalDateTime.now());  // 设置结束时间
            event.setConclusion("已封禁攻击源IP，事件已解决");
            event.setAlarmResults("{\"action\": \"blocked\", \"block_time\": \"2026-01-26 10:30\"}");
            
            mapper.updateStatus(event);
            
            System.out.println("✅ 更新成功：事件ID=" + event.getId() 
                + ", 新状态=" + event.getStatus()
                + ", 结论=" + event.getConclusion());
        } catch (Exception e) {
            System.err.println("❌ 更新失败：" + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 测试4：查询安全态势概览
     * 场景：获取今日安全事件统计
     */
    @GetMapping("/test-query-overview")
    public String testQueryOverview() {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", LocalDateTime.now().withHour(0).withMinute(0).withSecond(0));
            params.put("endTime", LocalDateTime.now());
            
            Map<String, Object> overview = mapper.queryOverview(params);
            
            System.out.println("✅ 安全态势概览：");
            System.out.println("  - 总事件数：" + overview.get("total"));
            System.out.println("  - 待处理数：" + overview.get("open"));
            System.out.println("  - 监控中：" + overview.get("monitoring"));
            System.out.println("  - 已关闭：" + overview.get("closed"));
            System.out.println("  - 严重级别：" + overview.get("critical"));
            System.out.println("  - 高级别：" + overview.get("high"));
            System.out.println("  - 中级别：" + overview.get("medium"));
            
            return "安全态势概览：总事件数=" + overview.get("total") 
                + ", 待处理=" + overview.get("open")
                + ", 严重=" + overview.get("critical");
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试5：查询事件详情
     * 场景：查询 test_data.sql 中的 1002 号事件（SQL注入）详情
     */
    @GetMapping("/test-query-detail")
    public String testSelectEventAndTempById() {
        try {
            Integer eventId = 1002;  // SQL注入攻击事件
            
            Map<String, Object> detail = mapper.selectEventAndTempById(eventId);
            
            System.out.println("✅ 事件详情：");
            System.out.println("  - 事件ID：" + detail.get("id"));
            System.out.println("  - 事件名称：" + detail.get("incident_name"));
            System.out.println("  - 攻击源IP：" + detail.get("focus_ip"));
            System.out.println("  - 目标IP：" + detail.get("target_ip"));
            System.out.println("  - 威胁级别：" + detail.get("level"));
            System.out.println("  - 事件状态：" + detail.get("status"));
            System.out.println("  - 事件描述：" + detail.get("description"));
            System.out.println("  - 处理建议：" + detail.get("suggestion"));
            System.out.println("  - 事件次数：" + detail.get("count"));
            System.out.println("  - 事件分类：" + detail.get("incident_class_type"));
            System.out.println("  - 子分类：" + detail.get("incident_sub_class_type"));
            
            return "事件详情：" + detail.get("incident_name") 
                + " (级别=" + detail.get("level") 
                + ", 状态=" + detail.get("status") + ")";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }
}
