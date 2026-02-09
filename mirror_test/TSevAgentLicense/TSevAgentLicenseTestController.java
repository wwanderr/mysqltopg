package com.test.controller;

import com.dbapp.xdr.bean.po.TSevAgentLicense;
import com.dbapp.xdr.mapper.TSevAgentLicenseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.Collection;

/**
 * TSevAgentLicense 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 3 个方法：
 * - selectOneByAgentCode
 * - deleteByAgentCodeIn
 * - deleteAll
 *
 * 依赖表：
 * - t_sev_agent_license
 *
 * 测试数据：
 * - mirror_test/TSevAgentLicense/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/tSevAgentLicense")
public class TSevAgentLicenseTestController {

    @Autowired
    private TSevAgentLicenseMapper mapper;

    /**
     * 测试1：selectOneByAgentCode
     * URL: /test/mirror/tSevAgentLicense/test1-selectOneByAgentCode
     */
    @GetMapping("/test1-selectOneByAgentCode")
    public String test1_selectOneByAgentCode() {
        try {
            String agentCode = "LIC_AGENT_1";
            TSevAgentLicense license = mapper.selectOneByAgentCode(agentCode);

            System.out.println("✅ selectOneByAgentCode 执行成功");
            if (license != null) {
                System.out.println("  id=" + license.getId()
                        + ", agentCode=" + license.getAgentCode()
                        + ", version=" + license.getVersion()
                        + ", expireTime=" + license.getExpireTime());
            } else {
                System.out.println("  返回为空");
            }

            return "SUCCESS: selectOneByAgentCode, exists=" + (license != null);
        } catch (Exception e) {
            String msg = "❌ test1_selectOneByAgentCode 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：deleteByAgentCodeIn
     * URL: /test/mirror/tSevAgentLicense/test2-deleteByAgentCodeIn
     */
    @GetMapping("/test2-deleteByAgentCodeIn")
    public String test2_deleteByAgentCodeIn() {
        try {
            Collection<String> codes = Arrays.asList("LIC_AGENT_1", "LIC_AGENT_2");
            int affected = mapper.deleteByAgentCodeIn(codes);

            System.out.println("✅ deleteByAgentCodeIn 执行成功");
            System.out.println("  agentCodeCollection=" + codes);
            System.out.println("  affectedRows=" + affected);

            return "SUCCESS: deleteByAgentCodeIn, affectedRows=" + affected;
        } catch (Exception e) {
            String msg = "❌ test2_deleteByAgentCodeIn 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试3：deleteAll
     * URL: /test/mirror/tSevAgentLicense/test3-deleteAll
     */
    @GetMapping("/test3-deleteAll")
    public String test3_deleteAll() {
        try {
            int affected = mapper.deleteAll();

            System.out.println("✅ deleteAll 执行成功");
            System.out.println("  affectedRows=" + affected);

            return "SUCCESS: deleteAll, affectedRows=" + affected;
        } catch (Exception e) {
            String msg = "❌ test3_deleteAll 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/tSevAgentLicense/test-all
     *
     * 使用方式：
     * - 每次执行前先在数据库中跑一遍 test_data.sql 以恢复初始数据
     */
    @GetMapping("/test-all")
    public String testAll() {
        String r1 = test1_selectOneByAgentCode();
        String r2 = test2_deleteByAgentCodeIn();
        String r3 = test3_deleteAll();
        return "ALL DONE\n" + r1 + "\n" + r2 + "\n" + r3;
    }
}

