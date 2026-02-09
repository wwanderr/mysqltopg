package com.test.controller;

import com.dbapp.xdr.bean.po.TSevAgentConfig;
import com.dbapp.xdr.mapper.TSevAgentConfigMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * TSevAgentConfig 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 4 个方法：
 * - selectOneByAgentTypeAndConfigKey
 * - getLastVersion
 * - getLastRuleClosedVersion
 * - getAllClosedRuleIds
 *
 * 依赖表：
 * - t_sev_agent_config
 * - t_sev_agent_rule_closed
 * - t_sev_agent_type_rule_closed
 *
 * 测试数据：
 * - mirror_test/TSevAgentConfig/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/tSevAgentConfig")
public class TSevAgentConfigTestController {

    @Autowired
    private TSevAgentConfigMapper mapper;

    /**
     * 测试1：selectOneByAgentTypeAndConfigKey
     * URL: /test/mirror/tSevAgentConfig/test1-selectOne
     */
    @GetMapping("/test1-selectOne")
    public String test1_selectOneByAgentTypeAndConfigKey() {
        try {
            String agentType = "APT";
            String configKey = "demo.config.key";

            TSevAgentConfig config = mapper.selectOneByAgentTypeAndConfigKey(agentType, configKey);

            System.out.println("✅ selectOneByAgentTypeAndConfigKey 执行成功");
            System.out.println("  agentType=" + agentType + ", configKey=" + configKey);
            if (config != null) {
                System.out.println("  id=" + config.getId() + ", version=" + config.getConfigVersion()
                        + ", content=" + config.getConfigContent());
            } else {
                System.out.println("  返回为空");
            }

            return "SUCCESS: selectOne, exists=" + (config != null);
        } catch (Exception e) {
            String msg = "❌ test1_selectOneByAgentTypeAndConfigKey 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：getLastVersion
     * URL: /test/mirror/tSevAgentConfig/test2-getLastVersion
     */
    @GetMapping("/test2-getLastVersion")
    public String test2_getLastVersion() {
        try {
            String agentType = "APT";
            Long version = mapper.getLastVersion(agentType);

            System.out.println("✅ getLastVersion 执行成功");
            System.out.println("  agentType=" + agentType + ", lastVersion=" + version);

            return "SUCCESS: getLastVersion=" + version;
        } catch (Exception e) {
            String msg = "❌ test2_getLastVersion 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试3：getLastRuleClosedVersion
     * URL: /test/mirror/tSevAgentConfig/test3-getLastRuleClosedVersion
     */
    @GetMapping("/test3-getLastRuleClosedVersion")
    public String test3_getLastRuleClosedVersion() {
        try {
            String agentCode = "AGENT001";
            Long version = mapper.getLastRuleClosedVersion(agentCode);

            System.out.println("✅ getLastRuleClosedVersion 执行成功");
            System.out.println("  agentCode=" + agentCode + ", lastRuleClosedVersion=" + version);

            return "SUCCESS: getLastRuleClosedVersion=" + version;
        } catch (Exception e) {
            String msg = "❌ test3_getLastRuleClosedVersion 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试4：getAllClosedRuleIds
     * URL: /test/mirror/tSevAgentConfig/test4-getAllClosedRuleIds
     */
    @GetMapping("/test4-getAllClosedRuleIds")
    public String test4_getAllClosedRuleIds() {
        try {
            String agentCode = "AGENT001";
            String agentType = "APT";

            List<String> ruleIds = mapper.getAllClosedRuleIds(agentCode, agentType);

            System.out.println("✅ getAllClosedRuleIds 执行成功");
            System.out.println("  agentCode=" + agentCode + ", agentType=" + agentType);
            System.out.println("  ruleIds=" + ruleIds);

            return "SUCCESS: getAllClosedRuleIds size=" + (ruleIds == null ? 0 : ruleIds.size());
        } catch (Exception e) {
            String msg = "❌ test4_getAllClosedRuleIds 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/tSevAgentConfig/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        String r1 = test1_selectOneByAgentTypeAndConfigKey();
        String r2 = test2_getLastVersion();
        String r3 = test3_getLastRuleClosedVersion();
        String r4 = test4_getAllClosedRuleIds();
        return "ALL DONE\n" + r1 + "\n" + r2 + "\n" + r3 + "\n" + r4;
    }
}

