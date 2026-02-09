package com.test.controller;

import com.dbapp.xdr.mapper.TSevAgentEventsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.Collection;

/**
 * TSevAgentEvents 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 2 个方法：
 * - deleteByAgentCodeIn
 * - deleteAll
 *
 * 依赖表：
 * - t_sev_agent_events
 *
 * 测试数据：
 * - mirror_test/TSevAgentEvents/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/tSevAgentEvents")
public class TSevAgentEventsTestController {

    @Autowired
    private TSevAgentEventsMapper mapper;

    /**
     * 测试1：deleteByAgentCodeIn
     * URL: /test/mirror/tSevAgentEvents/test1-deleteByAgentCodeIn
     *
     * 预期：
     * - 删除 agent_code IN ('EVT_AGENT_1','EVT_AGENT_2') 的所有记录
     * - 返回受影响行数 = 插入的两类 agent 的行数总和
     */
    @GetMapping("/test1-deleteByAgentCodeIn")
    public String test1_deleteByAgentCodeIn() {
        try {
            Collection<String> codes = Arrays.asList("EVT_AGENT_1", "EVT_AGENT_2");

            int affected = mapper.deleteByAgentCodeIn(codes);

            System.out.println("✅ deleteByAgentCodeIn 执行成功");
            System.out.println("  agentCodeCollection=" + codes);
            System.out.println("  affectedRows=" + affected);

            return "SUCCESS: deleteByAgentCodeIn, affectedRows=" + affected;
        } catch (Exception e) {
            String msg = "❌ test1_deleteByAgentCodeIn 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：deleteAll
     * URL: /test/mirror/tSevAgentEvents/test2-deleteAll
     *
     * 预期：
     * - 删除 t_sev_agent_events 表中的所有记录
     * - 返回受影响行数 = 删除前表中的记录数
     */
    @GetMapping("/test2-deleteAll")
    public String test2_deleteAll() {
        try {
            int affected = mapper.deleteAll();

            System.out.println("✅ deleteAll 执行成功");
            System.out.println("  affectedRows=" + affected);

            return "SUCCESS: deleteAll, affectedRows=" + affected;
        } catch (Exception e) {
            String msg = "❌ test2_deleteAll 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/tSevAgentEvents/test-all
     *
     * 使用方式：
     * - 每次执行前先在数据库中跑一遍 test_data.sql 以恢复初始数据
     */
    @GetMapping("/test-all")
    public String testAll() {
        String r1 = test1_deleteByAgentCodeIn();
        String r2 = test2_deleteAll();
        return "ALL DONE\n" + r1 + "\n" + r2;
    }
}

