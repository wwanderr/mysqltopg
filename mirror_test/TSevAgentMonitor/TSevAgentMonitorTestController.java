package com.test.controller;

import com.dbapp.xdr.mapper.TSevAgentMonitorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;

/**
 * TSevAgentMonitor 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 2 个方法：
 * - deleteByAgentCodeIn
 * - deleteAll
 *
 * 依赖表：
 * - t_sev_agent_monitor（主表）
 * - t_sev_agent_info（外键依赖：agent_code）
 * - t_sev_agent_type（外键依赖：t_sev_agent_info.agent_type）
 *
 * 测试数据：
 * - mirror_test/TSevAgentMonitor/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/tSevAgentMonitor")
public class TSevAgentMonitorTestController {

    @Autowired
    private TSevAgentMonitorMapper mapper;

    /**
     * 测试1：deleteByAgentCodeIn
     * URL: /test/mirror/tSevAgentMonitor/test1-deleteByAgentCodeIn
     */
    @GetMapping("/test1-deleteByAgentCodeIn")
    public String test1_deleteByAgentCodeIn() {
        try {
            // 删除 MON_AGENT_1 和 MON_AGENT_2 的监控记录
            int affectedRows = mapper.deleteByAgentCodeIn(
                    Arrays.asList("MON_AGENT_1", "MON_AGENT_2")
            );

            System.out.println("✅ deleteByAgentCodeIn 执行成功");
            System.out.println("  agentCodeCollection=[MON_AGENT_1, MON_AGENT_2]");
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: deleteByAgentCodeIn, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test1_deleteByAgentCodeIn 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：deleteAll
     * URL: /test/mirror/tSevAgentMonitor/test2-deleteAll
     */
    @GetMapping("/test2-deleteAll")
    public String test2_deleteAll() {
        try {
            // 先查询删除前的记录数
            long countBefore = mapper.selectCount(null);

            // 删除所有监控记录
            int affectedRows = mapper.deleteAll();

            System.out.println("✅ deleteAll 执行成功");
            System.out.println("  countBefore=" + countBefore);
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: deleteAll, countBefore=" + countBefore + ", affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test2_deleteAll 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/tSevAgentMonitor/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        String r1 = test1_deleteByAgentCodeIn();
        String r2 = test2_deleteAll();
        return "ALL DONE\n" + r1 + "\n" + r2;
    }
}
