package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncident;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

/**
 * RiskIncident 测试控制器
 * 
 * 测试说明：
 * 1. 所有方法使用 GET 请求
 * 2. 参数已硬编码，无需 Postman 传参
 * 3. 测试数据参考：test_data.sql 中的场景
 * 
 * 核心测试方法（从30个方法中精选5个）：
 * - batchInsertOrUpdateIncident: 批量插入/更新风险事件
 * - getRiskList: 获取风险事件列表
 * - getCountByStatus: 按状态统计事件数量
 * - selectEventAndTempById: 查询单个事件详情
 * - queryKillChains: 查询攻击链信息
 */
@RestController
@RequestMapping("/test/risk-incident")
public class RiskIncidentTestController {

    @Autowired
    private RiskIncidentMapper mapper;

    /**
     * 测试1：批量插入或更新风险事件
     * 场景：批量录入检测到的多个勒索软件传播事件
     */
    @GetMapping("/test-batch-insert")
    public String testBatchInsertOrUpdateIncident() {
        try {
            List<RiskIncident> incidents = new ArrayList<>();
            
            // 场景1：勒索软件传播事件
            RiskIncident incident1 = new RiskIncident();
            incident1.setTemplateId(1002);
            incident1.setIncidentName("勒索软件大规模传播");
            incident1.setFocusIp("192.168.50.100");
            incident1.setTargetIp("192.168.0.0/16");
            incident1.setStartTime(LocalDateTime.now().minusHours(2));
            incident1.setTimePart(LocalDateTime.now().minusHours(2));
            incident1.setCount(50L);
            incident1.setStatus("open");
            incident1.setThreatLevel("critical");
            incident1.setDescription("检测到勒索软件在内网大规模传播，已感染50台主机");
            incident1.setSuggestion("立即隔离所有受感染主机，断开外网连接，启动应急响应");
            incident1.setAlarmResults("{\"infected_hosts\": 50, \"ransom_type\": \"WannaCry_variant\"}");
            incident1.setFocus("src_ip");
            incident1.setIncidentRuleType("恶意软件");
            incident1.setIncidentClassType("勒索软件");
            incident1.setIncidentSubClassType("蠕虫传播");
            incident1.setPriority(10);
            incident1.setIncidentCond("infected_count > 10");
            incident1.setConclusion("确认为勒索软件传播事件");
            incident1.setTagSearch("{\"tags\": [\"勒索软件\", \"WannaCry\", \"紧急\"]}");
            incident1.setIsScenario(1);
            incident1.setJudgeResult(1);
            incident1.setKillChain("武器化,投递,利用,安装,C&C");
            incidents.add(incident1);
            
            // 场景2：DDoS攻击事件
            RiskIncident incident2 = new RiskIncident();
            incident2.setTemplateId(1004);
            incident2.setIncidentName("大规模DDoS攻击");
            incident2.setFocusIp("multiple");
            incident2.setTargetIp("192.168.1.100");
            incident2.setStartTime(LocalDateTime.now().minusHours(1));
            incident2.setTimePart(LocalDateTime.now().minusHours(1));
            incident2.setCount(5000L);
            incident2.setStatus("monitoring");
            incident2.setThreatLevel("high");
            incident2.setDescription("检测到针对Web服务器的DDoS攻击，流量峰值达到5Gbps");
            incident2.setSuggestion("启用DDoS防护，联系ISP进行上游清洗");
            incident2.setAlarmResults("{\"peak_traffic\": \"5Gbps\", \"attack_type\": \"SYN_Flood\"}");
            incident2.setFocus("target_ip");
            incident2.setIncidentRuleType("网络攻击");
            incident2.setIncidentClassType("DDoS");
            incident2.setIncidentSubClassType("SYN洪水");
            incident2.setPriority(9);
            incident2.setIncidentCond("traffic_rate > 1Gbps");
            incident2.setConclusion("正在进行DDoS攻击，已启用防护");
            incident2.setTagSearch("{\"tags\": [\"DDoS\", \"SYN_Flood\", \"高流量\"]}");
            incident2.setIsScenario(0);
            incident2.setJudgeResult(0);
            incident2.setKillChain("侦查,武器化,投递");
            incidents.add(incident2);
            
            mapper.batchInsertOrUpdateIncident(incidents);
            
            System.out.println("✅ 批量插入成功：共 " + incidents.size() + " 个风险事件");
            for (RiskIncident inc : incidents) {
                System.out.println("  - 事件：" + inc.getIncidentName() 
                    + ", 级别：" + inc.getThreatLevel()
                    + ", 状态：" + inc.getStatus()
                    + ", 影响数：" + inc.getCount());
            }
            
            return "成功批量插入 " + incidents.size() + " 个风险事件";
        } catch (Exception e) {
            System.err.println("❌ 批量插入失败：" + e.getMessage());
            e.printStackTrace();
            return "批量插入失败：" + e.getMessage();
        }
    }

    /**
     * 测试2：获取风险事件列表
     * 场景：查询所有严重（critical）和高（high）级别的风险事件
     */
    @GetMapping("/test-query-risk-list")
    public String testGetRiskList() {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("threatLevel", "critical,high");  // 严重和高级别
            params.put("status", "open,confirmed,monitoring");  // 未关闭的
            params.put("startTime", LocalDateTime.now().minusDays(7));  // 最近7天
            params.put("endTime", LocalDateTime.now());
            params.put("start", 0);
            params.put("length", 10);
            
            List<Map<String, Object>> result = mapper.getRiskList(params);
            
            System.out.println("✅ 查询成功，共 " + result.size() + " 条风险事件：");
            for (Map<String, Object> risk : result) {
                System.out.println("  - ID=" + risk.get("id") 
                    + ", 事件名=" + risk.get("incident_name")
                    + ", 威胁级别=" + risk.get("threat_level")
                    + ", 状态=" + risk.get("status")
                    + ", 攻击链=" + risk.get("kill_chain")
                    + ", 影响数=" + risk.get("count"));
            }
            
            return "查询成功，共 " + result.size() + " 条风险事件";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试3：按状态统计事件数量
     * 场景：统计各状态的风险事件数量
     */
    @GetMapping("/test-count-by-status")
    public String testGetCountByStatus() {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", LocalDateTime.now().minusDays(30));  // 最近30天
            params.put("endTime", LocalDateTime.now());
            
            List<Map<String, Object>> result = mapper.getCountByStatus(params);
            
            System.out.println("✅ 统计成功，按状态分布：");
            long totalCount = 0;
            for (Map<String, Object> stat : result) {
                String status = (String) stat.get("status");
                Long count = (Long) stat.get("count");
                totalCount += count;
                
                String statusName = "未知";
                switch (status) {
                    case "open": statusName = "待处理"; break;
                    case "monitoring": statusName = "监控中"; break;
                    case "confirmed": statusName = "已确认"; break;
                    case "analyzing": statusName = "分析中"; break;
                    case "closed": statusName = "已关闭"; break;
                }
                
                System.out.println("  - " + statusName + "(" + status + ")：" + count + " 个");
            }
            System.out.println("  - 总计：" + totalCount + " 个");
            
            return "统计成功，总计 " + totalCount + " 个风险事件";
        } catch (Exception e) {
            System.err.println("❌ 统计失败：" + e.getMessage());
            e.printStackTrace();
            return "统计失败：" + e.getMessage();
        }
    }

    /**
     * 测试4：查询风险事件详情
     * 场景：查询 test_data.sql 中的 1001 号事件（APT攻击）详情
     */
    @GetMapping("/test-query-detail")
    public String testSelectEventAndTempById() {
        try {
            Integer eventId = 1001;  // APT攻击事件
            
            Map<String, Object> detail = mapper.selectEventAndTempById(eventId);
            
            System.out.println("✅ 风险事件详情：");
            System.out.println("  - 事件ID：" + detail.get("id"));
            System.out.println("  - 事件名称：" + detail.get("incident_name"));
            System.out.println("  - 攻击源IP：" + detail.get("focus_ip"));
            System.out.println("  - 目标IP：" + detail.get("target_ip"));
            System.out.println("  - 威胁级别：" + detail.get("threat_level"));
            System.out.println("  - 事件状态：" + detail.get("status"));
            System.out.println("  - 攻击链：" + detail.get("kill_chain"));
            System.out.println("  - 事件描述：" + detail.get("description"));
            System.out.println("  - 处理建议：" + detail.get("suggestion"));
            System.out.println("  - 研判结果：" + (detail.get("judge_result").equals(1) ? "成功攻击" : "未遂"));
            System.out.println("  - 影响范围：" + detail.get("count") + " 个");
            System.out.println("  - 事件结论：" + detail.get("conclusion"));
            
            return "事件详情：" + detail.get("incident_name") 
                + " (级别=" + detail.get("threat_level") 
                + ", 状态=" + detail.get("status") + ")";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试5：查询攻击链信息
     * 场景：查询 test_data.sql 中包含的所有攻击链类型
     */
    @GetMapping("/test-query-kill-chains")
    public String testQueryKillChains() {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", LocalDateTime.now().minusDays(30));
            params.put("endTime", LocalDateTime.now());
            
            List<String> killChains = mapper.queryKillChains(params);
            
            System.out.println("✅ 攻击链查询成功，共 " + killChains.size() + " 个攻击链：");
            
            // 统计攻击链阶段
            Map<String, Integer> stageCount = new HashMap<>();
            for (String chain : killChains) {
                if (chain != null && !chain.isEmpty()) {
                    String[] stages = chain.split(",");
                    for (String stage : stages) {
                        stage = stage.trim();
                        stageCount.put(stage, stageCount.getOrDefault(stage, 0) + 1);
                    }
                    System.out.println("  - " + chain + " (" + stages.length + "阶段)");
                }
            }
            
            System.out.println("\n攻击链阶段统计：");
            stageCount.entrySet().stream()
                .sorted((a, b) -> b.getValue().compareTo(a.getValue()))
                .forEach(entry -> System.out.println("  - " + entry.getKey() + "：" + entry.getValue() + " 次"));
            
            return "攻击链查询成功，共 " + killChains.size() + " 个攻击链";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }
}
