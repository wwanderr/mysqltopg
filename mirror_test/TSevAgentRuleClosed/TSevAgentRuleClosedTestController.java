package com.test.controller;

import com.dbapp.xdr.bean.po.TSevAgentRuleClosed;
import com.dbapp.xdr.mapper.TSevAgentRuleClosedMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

/**
 * TSevAgentRuleClosed 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 12 个方法：
 * - deleteByPrimaryKey
 * - insertBatch
 * - insertSelective
 * - selectByPrimaryKey
 * - updateByPrimaryKeySelective
 * - updateByPrimaryKey
 * - updateAgentCodeByRuleClosedId
 * - deleteByAgentCodesNotIn
 * - isExistNull
 * - deleteByRuleClosedId
 * - selectAgentCodeByRuleClosedId
 * - selectCountNullByRuleClosedId
 *
 * 依赖表：
 * - t_sev_agent_rule_closed（主表）
 * - t_sev_agent_type_rule_closed（外键依赖：rule_closed_id）
 * - t_sev_agent_info（外键依赖：agent_code，可为 NULL）
 * - t_sev_agent_type（外键依赖：t_sev_agent_type_rule_closed.agent_type）
 *
 * 测试数据：
 * - mirror_test/TSevAgentRuleClosed/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/tSevAgentRuleClosed")
public class TSevAgentRuleClosedTestController {

    @Autowired
    private TSevAgentRuleClosedMapper mapper;

    /**
     * 测试1：selectByPrimaryKey
     * URL: /test/mirror/tSevAgentRuleClosed/test1-selectByPrimaryKey
     */
    @GetMapping("/test1-selectByPrimaryKey")
    public String test1_selectByPrimaryKey() {
        try {
            Long id = 7501L;
            TSevAgentRuleClosed record = mapper.selectByPrimaryKey(id);

            System.out.println("✅ selectByPrimaryKey 执行成功");
            System.out.println("  id=" + id);
            if (record != null) {
                System.out.println("  ruleClosedId=" + record.getRuleClosedId() + ", agentCode=" + record.getAgentCode());
            } else {
                System.out.println("  返回为空");
            }

            return "SUCCESS: selectByPrimaryKey, exists=" + (record != null);
        } catch (Exception e) {
            String msg = "❌ test1_selectByPrimaryKey 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：insertSelective
     * URL: /test/mirror/tSevAgentRuleClosed/test2-insertSelective
     */
    @GetMapping("/test2-insertSelective")
    public String test2_insertSelective() {
        try {
            TSevAgentRuleClosed record = new TSevAgentRuleClosed();
            record.setRuleClosedId(5001L);
            record.setAgentCode("TEST_AGENT_NEW");
            record.setConfigVersion(System.currentTimeMillis());
            record.setDelete(false);

            int affectedRows = mapper.insertSelective(record);

            System.out.println("✅ insertSelective 执行成功");
            System.out.println("  ruleClosedId=" + record.getRuleClosedId() + ", agentCode=" + record.getAgentCode());
            System.out.println("  affectedRows=" + affectedRows + ", generatedId=" + record.getId());

            return "SUCCESS: insertSelective, id=" + record.getId();
        } catch (Exception e) {
            String msg = "❌ test2_insertSelective 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试3：insertBatch
     * URL: /test/mirror/tSevAgentRuleClosed/test3-insertBatch
     */
    @GetMapping("/test3-insertBatch")
    public String test3_insertBatch() {
        try {
            TSevAgentRuleClosed record1 = new TSevAgentRuleClosed();
            record1.setRuleClosedId(5001L);
            record1.setAgentCode("TEST_AGENT_BATCH_1");
            record1.setConfigVersion(System.currentTimeMillis());

            TSevAgentRuleClosed record2 = new TSevAgentRuleClosed();
            record2.setRuleClosedId(5001L);
            record2.setAgentCode("TEST_AGENT_BATCH_2");
            record2.setConfigVersion(System.currentTimeMillis());

            int affectedRows = mapper.insertBatch(Arrays.asList(record1, record2));

            System.out.println("✅ insertBatch 执行成功");
            System.out.println("  batchSize=2, affectedRows=" + affectedRows);

            return "SUCCESS: insertBatch, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test3_insertBatch 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试4：updateByPrimaryKeySelective
     * URL: /test/mirror/tSevAgentRuleClosed/test4-updateSelective
     */
    @GetMapping("/test4-updateSelective")
    public String test4_updateByPrimaryKeySelective() {
        try {
            TSevAgentRuleClosed record = new TSevAgentRuleClosed();
            record.setId(7502L);
            record.setAgentCode("TEST_AGENT_UPDATED");

            int affectedRows = mapper.updateByPrimaryKeySelective(record);

            System.out.println("✅ updateByPrimaryKeySelective 执行成功");
            System.out.println("  id=" + record.getId() + ", newAgentCode=" + record.getAgentCode());
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: updateByPrimaryKeySelective, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test4_updateByPrimaryKeySelective 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试5：updateByPrimaryKey
     * URL: /test/mirror/tSevAgentRuleClosed/test5-updateByPrimaryKey
     */
    @GetMapping("/test5-updateByPrimaryKey")
    public String test5_updateByPrimaryKey() {
        try {
            TSevAgentRuleClosed record = mapper.selectByPrimaryKey(7503L);
            if (record == null) {
                return "FAIL: record with id=7503 not found";
            }

            record.setAgentCode("TEST_AGENT_FULL_UPDATE");
            int affectedRows = mapper.updateByPrimaryKey(record);

            System.out.println("✅ updateByPrimaryKey 执行成功");
            System.out.println("  id=" + record.getId() + ", newAgentCode=" + record.getAgentCode());
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: updateByPrimaryKey, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test5_updateByPrimaryKey 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试6：updateAgentCodeByRuleClosedId
     * URL: /test/mirror/tSevAgentRuleClosed/test6-updateAgentCode
     */
    @GetMapping("/test6-updateAgentCode")
    public String test6_updateAgentCodeByRuleClosedId() {
        try {
            Long ruleClosedId = 5001L;
            String newAgentCode = "TEST_AGENT_UPDATED_BY_RULE";

            int affectedRows = mapper.updateAgentCodeByRuleClosedId(newAgentCode, ruleClosedId);

            System.out.println("✅ updateAgentCodeByRuleClosedId 执行成功");
            System.out.println("  ruleClosedId=" + ruleClosedId + ", newAgentCode=" + newAgentCode);
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: updateAgentCodeByRuleClosedId, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test6_updateAgentCodeByRuleClosedId 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试7：deleteByAgentCodesNotIn
     * URL: /test/mirror/tSevAgentRuleClosed/test7-deleteByAgentCodesNotIn
     */
    @GetMapping("/test7-deleteByAgentCodesNotIn")
    public String test7_deleteByAgentCodesNotIn() {
        try {
            long mainId = 5001L;
            List<String> agentCodes = Arrays.asList("RCL_AGENT_1", "RCL_AGENT_2");

            int affectedRows = mapper.deleteByAgentCodesNotIn(mainId, agentCodes);

            System.out.println("✅ deleteByAgentCodesNotIn 执行成功");
            System.out.println("  mainId=" + mainId + ", agentCodes=" + agentCodes);
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: deleteByAgentCodesNotIn, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test7_deleteByAgentCodesNotIn 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试8：isExistNull
     * URL: /test/mirror/tSevAgentRuleClosed/test8-isExistNull
     */
    @GetMapping("/test8-isExistNull")
    public String test8_isExistNull() {
        try {
            Long id = 7501L; // 这个参数在 SQL 中似乎没有使用，但保留以匹配接口
            int count = mapper.isExistNull(id);

            System.out.println("✅ isExistNull 执行成功");
            System.out.println("  count of records with agent_code IS NULL=" + count);

            return "SUCCESS: isExistNull, count=" + count;
        } catch (Exception e) {
            String msg = "❌ test8_isExistNull 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试9：deleteByRuleClosedId
     * URL: /test/mirror/tSevAgentRuleClosed/test9-deleteByRuleClosedId
     */
    @GetMapping("/test9-deleteByRuleClosedId")
    public String test9_deleteByRuleClosedId() {
        try {
            Long ruleClosedId = 5002L;
            int affectedRows = mapper.deleteByRuleClosedId(ruleClosedId);

            System.out.println("✅ deleteByRuleClosedId 执行成功");
            System.out.println("  ruleClosedId=" + ruleClosedId);
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: deleteByRuleClosedId, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test9_deleteByRuleClosedId 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试10：selectAgentCodeByRuleClosedId
     * URL: /test/mirror/tSevAgentRuleClosed/test10-selectAgentCode
     */
    @GetMapping("/test10-selectAgentCode")
    public String test10_selectAgentCodeByRuleClosedId() {
        try {
            Long ruleClosedId = 5001L;
            List<TSevAgentRuleClosed> result = mapper.selectAgentCodeByRuleClosedId(ruleClosedId);

            System.out.println("✅ selectAgentCodeByRuleClosedId 执行成功");
            System.out.println("  ruleClosedId=" + ruleClosedId);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null && !result.isEmpty()) {
                for (TSevAgentRuleClosed record : result) {
                    System.out.println("  - agentCode=" + record.getAgentCode());
                }
            }

            return "SUCCESS: selectAgentCodeByRuleClosedId, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test10_selectAgentCodeByRuleClosedId 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试11：selectCountNullByRuleClosedId
     * URL: /test/mirror/tSevAgentRuleClosed/test11-selectCountNull
     */
    @GetMapping("/test11-selectCountNull")
    public String test11_selectCountNullByRuleClosedId() {
        try {
            Long ruleClosedId = 5001L;
            int count = mapper.selectCountNullByRuleClosedId(ruleClosedId);

            System.out.println("✅ selectCountNullByRuleClosedId 执行成功");
            System.out.println("  ruleClosedId=" + ruleClosedId);
            System.out.println("  count of records with agent_code IS NULL=" + count);

            return "SUCCESS: selectCountNullByRuleClosedId, count=" + count;
        } catch (Exception e) {
            String msg = "❌ test11_selectCountNullByRuleClosedId 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试12：deleteByPrimaryKey
     * URL: /test/mirror/tSevAgentRuleClosed/test12-deleteByPrimaryKey
     */
    @GetMapping("/test12-deleteByPrimaryKey")
    public String test12_deleteByPrimaryKey() {
        try {
            Long id = 7504L;
            int affectedRows = mapper.deleteByPrimaryKey(id);

            System.out.println("✅ deleteByPrimaryKey 执行成功");
            System.out.println("  id=" + id);
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: deleteByPrimaryKey, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test12_deleteByPrimaryKey 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/tSevAgentRuleClosed/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        StringBuilder sb = new StringBuilder("ALL DONE\n");
        sb.append(test1_selectByPrimaryKey()).append("\n");
        sb.append(test2_insertSelective()).append("\n");
        sb.append(test3_insertBatch()).append("\n");
        sb.append(test4_updateByPrimaryKeySelective()).append("\n");
        sb.append(test5_updateByPrimaryKey()).append("\n");
        sb.append(test6_updateAgentCodeByRuleClosedId()).append("\n");
        sb.append(test7_deleteByAgentCodesNotIn()).append("\n");
        sb.append(test8_isExistNull()).append("\n");
        sb.append(test9_deleteByRuleClosedId()).append("\n");
        sb.append(test10_selectAgentCodeByRuleClosedId()).append("\n");
        sb.append(test11_selectCountNullByRuleClosedId()).append("\n");
        sb.append(test12_deleteByPrimaryKey()).append("\n");
        return sb.toString();
    }
}
