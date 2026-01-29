package com.test.controller;

import com.dbapp.extension.xdr.scenario.mapper.ScenarioDataMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.ScenarioData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.time.LocalDate;

/**
 * ScenarioData (场景数据) 深度测试控制器
 * 主表：t_event_scenario_data (12个字段)
 * 测试方法数：1 (insertOrUpdate)
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/scenarioData")
public class ScenarioDataTestController {
    @Autowired
    private ScenarioDataMapper mapper;

    /**
     * 方法1：insertOrUpdate
     * 测试条件：
     * - INSERT ... ON CONFLICT (log_session_id) DO UPDATE
     * - 完整12个字段
     * - JSON格式的result和trace_graph
     */
    @GetMapping("/testInsertOrUpdate")
    public String testInsertOrUpdate() {
        try {
            System.out.println("测试: insertOrUpdate - 插入或更新场景溯源数据");
            
            // 测试数据1：新插入
            ScenarioData data1 = new ScenarioData();
            data1.setResult("{\"status\": \"success\", \"confidence\": 0.88, \"attack_chain\": [\"initial_access\", \"execution\"]}");
            data1.setLogSessionId("LOG-SESSION-TEST-001");
            data1.setIncidentId(2001L);
            data1.setScenarioId(201L);
            data1.setEventTime(LocalDate.now());
            data1.setUpdateTime(new Timestamp(System.currentTimeMillis()));
            data1.setFocusIp("192.168.100.100");
            data1.setTargetIp("192.168.100.200");
            data1.setConclusion("测试攻击链溯源：攻击者通过钓鱼邮件获取初始访问权限");
            data1.setTraceGraphVersion("v2.1.0");
            data1.setTraceGraph("{\"nodes\": [{\"id\": \"N1\", \"type\": \"attacker\"}, {\"id\": \"N2\", \"type\": \"victim\"}], \"edges\": [{\"from\": \"N1\", \"to\": \"N2\"}]}");
            data1.setRiskId(2001L);
            
            mapper.insertOrUpdate(data1);
            System.out.println("  - 新插入：log_session_id=" + data1.getLogSessionId());
            
            // 测试数据2：更新已存在的记录（测试ON CONFLICT）
            ScenarioData data2 = new ScenarioData();
            data2.setResult("{\"status\": \"success\", \"confidence\": 0.98, \"attack_chain\": [\"reconnaissance\", \"initial_access\", \"execution\", \"persistence\", \"exfiltration\", \"impact\"]}");
            data2.setLogSessionId("LOG-SESSION-2026-001");  // test_data.sql中已存在
            data2.setIncidentId(1001L);
            data2.setScenarioId(101L);
            data2.setEventTime(LocalDate.now());
            data2.setUpdateTime(new Timestamp(System.currentTimeMillis()));
            data2.setFocusIp("192.168.10.50");
            data2.setTargetIp("192.168.10.100");
            data2.setConclusion("APT攻击完整溯源：攻击链已完整还原，置信度从0.95提升至0.98");
            data2.setTraceGraphVersion("v2.1.1");  // 更新版本
            data2.setTraceGraph("{\"nodes\": [{\"id\": \"N1\", \"type\": \"attacker\", \"ip\": \"203.0.113.88\"}, {\"id\": \"N2\", \"type\": \"victim\", \"ip\": \"192.168.10.50\"}, {\"id\": \"N3\", \"type\": \"c2_server\", \"ip\": \"198.51.100.1\"}], \"edges\": [{\"from\": \"N1\", \"to\": \"N2\", \"action\": \"phishing\"}, {\"from\": \"N2\", \"to\": \"N3\", \"action\": \"c2_communication\"}]}");
            data2.setRiskId(1001L);
            
            mapper.insertOrUpdate(data2);
            System.out.println("  - 更新：log_session_id=" + data2.getLogSessionId() + " (置信度提升至0.98)");
            
            System.out.println("结果: 成功插入/更新 2 条场景溯源数据");
            return "SUCCESS: 2条数据（1新插入+1更新）";
        } catch (Exception e) {
            String errorMsg = "测试方法 testInsertOrUpdate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
