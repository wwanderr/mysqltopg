package com.test.controller;

import com.dbapp.extension.xdr.scenario.mapper.ScenarioTemplateMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.ScenarioTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * ScenarioTemplate (场景模板) 深度测试控制器
 * 主表：t_event_scenario_template (15个字段)
 * 测试方法数：2 (batchInsert, truncate)
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/scenarioTemplate")
public class ScenarioTemplateTestController {
    @Autowired
    private ScenarioTemplateMapper mapper;

    /**
     * 方法1：batchInsert
     * 测试条件：
     * - <foreach collection="list">
     * - 批量插入完整15个字段
     */
    @GetMapping("/testBatchInsert")
    public String testBatchInsert() {
        try {
            System.out.println("测试: batchInsert - 批量插入场景模板");
            List<ScenarioTemplate> templates = new ArrayList<>();
            
            // 测试数据1：Web攻击场景模板
            ScenarioTemplate template1 = new ScenarioTemplate();
            template1.setScenarioName("Web应用攻击链检测");
            template1.setScenarioCode("WEB_ATTACK_CHAIN");
            template1.setSource("system");
            template1.setRequestUrl("/api/scenario/web/analyze");
            template1.setCondition("{\"attack_types\": [\"sql_injection\", \"xss\", \"command_injection\"], \"target_type\": \"web_application\"}");
            template1.setEventName("Web应用攻击事件");
            template1.setParameter("{\"target_url\": \"url\", \"attack_vector\": \"payload\", \"time_range\": \"6h\"}");
            template1.setResult("{\"status\": \"detected\", \"attack_chain\": [\"reconnaissance\", \"exploitation\", \"data_access\"]}");
            template1.setExecutorClassName("com.dbapp.extension.xdr.scenario.executor.WebAttackExecutor");
            template1.setDrillDown(1);
            template1.setUpdateTime(new Timestamp(System.currentTimeMillis()));
            template1.setConclusion("检测到针对Web应用的完整攻击链，建议立即修复漏洞");
            template1.setLogAiql("category=\"web_attack\" AND attack_type IN (\"sql_injection\", \"xss\")");
            template1.setAlarmAiql("alarm_type=\"web_attack\" AND severity=\"high\"");
            templates.add(template1);
            
            // 测试数据2：IoC关联分析场景模板
            ScenarioTemplate template2 = new ScenarioTemplate();
            template2.setScenarioName("威胁情报IoC关联分析");
            template2.setScenarioCode("IOC_CORRELATION");
            template2.setSource("custom");
            template2.setRequestUrl("/api/scenario/ioc/correlate");
            template2.setCondition("{\"ioc_types\": [\"ip\", \"domain\", \"hash\"], \"threat_level\": [\"high\", \"critical\"]}");
            template2.setEventName("威胁情报匹配事件");
            template2.setParameter("{\"ioc_value\": \"indicator\", \"ioc_type\": \"type\", \"lookback_days\": 30}");
            template2.setResult("{\"status\": \"matched\", \"threat_actor\": \"APT-32\", \"confidence\": 0.92}");
            template2.setExecutorClassName("com.dbapp.extension.xdr.scenario.executor.IocCorrelationExecutor");
            template2.setDrillDown(1);
            template2.setUpdateTime(new Timestamp(System.currentTimeMillis()));
            template2.setConclusion("内网资产与已知威胁情报IoC匹配，建议立即溯源分析");
            template2.setLogAiql("category=\"threat_intel\" AND ioc_matched=true");
            template2.setAlarmAiql("alarm_type=\"ioc_match\" AND threat_level IN (\"high\", \"critical\")");
            templates.add(template2);
            
            // 测试数据3：行为基线异常检测
            ScenarioTemplate template3 = new ScenarioTemplate();
            template3.setScenarioName("用户行为基线异常");
            template3.setScenarioCode("UEB_ANOMALY");
            template3.setSource("system");
            template3.setRequestUrl("/api/scenario/ueb/detect");
            template3.setCondition("{\"anomaly_types\": [\"time_anomaly\", \"volume_anomaly\", \"geo_anomaly\"], \"threshold\": 3}");
            template3.setEventName("用户异常行为事件");
            template3.setParameter("{\"user_id\": \"username\", \"behavior_type\": \"action\", \"baseline_days\": 30}");
            template3.setResult("{\"status\": \"anomaly\", \"anomaly_score\": 85, \"deviation\": \"3_sigma\"}");
            template3.setExecutorClassName("com.dbapp.extension.xdr.scenario.executor.UebAnomalyExecutor");
            template3.setDrillDown(0);
            template3.setUpdateTime(new Timestamp(System.currentTimeMillis()));
            template3.setConclusion("用户行为严重偏离基线，疑似账户被盗用");
            template3.setLogAiql("category=\"user_behavior\" AND anomaly_score>80");
            template3.setAlarmAiql("alarm_type=\"ueba_anomaly\" AND deviation>=\"3_sigma\"");
            templates.add(template3);
            
            mapper.batchInsert(templates);
            System.out.println("结果: 成功批量插入 " + templates.size() + " 个场景模板");
            for (int i = 0; i < templates.size(); i++) {
                System.out.println("  - " + (i+1) + ". " + templates.get(i).getScenarioName());
            }
            return "SUCCESS: " + templates.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testBatchInsert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：truncate
     * 测试条件：
     * - TRUNCATE TABLE t_event_scenario_template
     * - 清空表数据（谨慎使用）
     */
    @GetMapping("/testTruncate")
    public String testTruncate() {
        try {
            System.out.println("测试: truncate - 清空场景模板表");
            System.out.println("⚠️  警告：此操作会删除表中所有数据！");
            System.out.println("⚠️  测试环境专用，生产环境禁用！");
            
            // 取消注释以执行清空操作
            // mapper.truncate();
            
            System.out.println("✓ TRUNCATE操作已禁用（已注释）");
            return "SKIPPED: TRUNCATE操作已禁用，如需测试请取消注释";
        } catch (Exception e) {
            String errorMsg = "测试方法 testTruncate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
