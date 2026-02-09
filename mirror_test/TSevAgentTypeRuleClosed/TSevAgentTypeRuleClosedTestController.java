package com.test.controller;

import com.dbapp.entity.ValueName;
import com.dbapp.restful.entity.Page;
import com.dbapp.xdr.bean.dto.QueryInfo;
import com.dbapp.xdr.bean.dto.QueryInfoOpenApi;
import com.dbapp.xdr.bean.po.TSevAgentTypeRuleClosed;
import com.dbapp.xdr.mapper.TSevAgentTypeRuleClosedMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * TSevAgentTypeRuleClosed 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 22 个方法：
 * - deleteByPrimaryKey
 * - insertSelective
 * - selectByPrimaryKey
 * - updateByPrimaryKeySelective
 * - updateByPrimaryKey
 * - cascadeUpdateByPrimaryKey
 * - selectByAgentCode
 * - insertAgentCode
 * - selectRemarksById
 * - selectAgentNameByPrimaryKey
 * - selectByAgentTypeAndRuleId
 * - selectAgentCodeById
 * - selectQueryIfoListByAgentTypeAndRuleId
 * - selectQueryInfoByAgentTypeAndRuleId
 * - getAllAgentById
 * - updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById
 * - selectIdByRuleIdAndAgentType
 * - selectIdByRuleIdAndAgentTypePrecisely
 * - selectUpdateHistoryAlarmById
 * - tryCleanCloseRule
 * - queryRulesByCreateTime
 * - queryListOpenApi
 *
 * 依赖表：
 * - t_sev_agent_type_rule_closed（主表）
 * - t_sev_agent_type（外键依赖：agent_type）
 * - t_sev_agent_rule_closed（关联表）
 * - t_sev_agent_info（关联表）
 *
 * 测试数据：
 * - mirror_test/TSevAgentTypeRuleClosed/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/tSevAgentTypeRuleClosed")
public class TSevAgentTypeRuleClosedTestController {

    @Autowired
    private TSevAgentTypeRuleClosedMapper mapper;

    /**
     * 测试1：selectByPrimaryKey
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test1-selectByPrimaryKey
     */
    @GetMapping("/test1-selectByPrimaryKey")
    public String test1_selectByPrimaryKey() {
        try {
            Long id = 6001L;
            TSevAgentTypeRuleClosed record = mapper.selectByPrimaryKey(id);

            System.out.println("✅ selectByPrimaryKey 执行成功");
            System.out.println("  id=" + id);
            if (record != null) {
                System.out.println("  ruleId=" + record.getRuleId() + ", agentType=" + record.getAgentType());
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
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test2-insertSelective
     */
    @GetMapping("/test2-insertSelective")
    public String test2_insertSelective() {
        try {
            TSevAgentTypeRuleClosed record = new TSevAgentTypeRuleClosed();
            record.setAgentType("APT");
            record.setRuleId("RULE-TEST-NEW");
            record.setRemarks("测试规则关闭-新增");
            record.setUpdateHistoryAlarm(false);
            record.setIsDelete(false);

            int affectedRows = mapper.insertSelective(record);

            System.out.println("✅ insertSelective 执行成功");
            System.out.println("  agentType=" + record.getAgentType() + ", ruleId=" + record.getRuleId());
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
     * 测试3：updateByPrimaryKeySelective
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test3-updateSelective
     */
    @GetMapping("/test3-updateSelective")
    public String test3_updateByPrimaryKeySelective() {
        try {
            TSevAgentTypeRuleClosed record = new TSevAgentTypeRuleClosed();
            record.setId(6002L);
            record.setRemarks("测试规则关闭-更新备注");

            int affectedRows = mapper.updateByPrimaryKeySelective(record);

            System.out.println("✅ updateByPrimaryKeySelective 执行成功");
            System.out.println("  id=" + record.getId() + ", newRemarks=" + record.getRemarks());
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: updateByPrimaryKeySelective, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test3_updateByPrimaryKeySelective 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试4：updateByPrimaryKey
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test4-updateByPrimaryKey
     */
    @GetMapping("/test4-updateByPrimaryKey")
    public String test4_updateByPrimaryKey() {
        try {
            TSevAgentTypeRuleClosed record = mapper.selectByPrimaryKey(6003L);
            if (record == null) {
                return "FAIL: record with id=6003 not found";
            }

            record.setRemarks("测试规则关闭-完整更新");
            int affectedRows = mapper.updateByPrimaryKey(record);

            System.out.println("✅ updateByPrimaryKey 执行成功");
            System.out.println("  id=" + record.getId() + ", newRemarks=" + record.getRemarks());
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: updateByPrimaryKey, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test4_updateByPrimaryKey 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试5：cascadeUpdateByPrimaryKey
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test5-cascadeUpdate
     */
    @GetMapping("/test5-cascadeUpdate")
    public String test5_cascadeUpdateByPrimaryKey() {
        try {
            TSevAgentTypeRuleClosed record = new TSevAgentTypeRuleClosed();
            record.setId(6001L);
            record.setRemarks("测试规则关闭-级联更新");
            record.setUpdateHistoryAlarm(true);
            // 注意：XML 中还需要 agentCode，但实体类中没有，可能需要通过其他方式传递

            int affectedRows = mapper.cascadeUpdateByPrimaryKey(record);

            System.out.println("✅ cascadeUpdateByPrimaryKey 执行成功");
            System.out.println("  id=" + record.getId());
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: cascadeUpdateByPrimaryKey, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test5_cascadeUpdateByPrimaryKey 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试6：selectByAgentCode
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test6-selectByAgentCode
     */
    @GetMapping("/test6-selectByAgentCode")
    public String test6_selectByAgentCode() {
        try {
            String agentCode = "TRC_AGENT_1";
            TSevAgentTypeRuleClosed record = mapper.selectByAgentCode(agentCode);

            System.out.println("✅ selectByAgentCode 执行成功");
            System.out.println("  agentCode=" + agentCode);
            if (record != null) {
                System.out.println("  id=" + record.getId());
            } else {
                System.out.println("  返回为空");
            }

            return "SUCCESS: selectByAgentCode, exists=" + (record != null);
        } catch (Exception e) {
            String msg = "❌ test6_selectByAgentCode 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试7：insertAgentCode
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test7-insertAgentCode
     */
    @GetMapping("/test7-insertAgentCode")
    public String test7_insertAgentCode() {
        try {
            String agentCode = "TRC_AGENT_NEW";
            long ruleClosedId = 6001L;

            int affectedRows = mapper.insertAgentCode(agentCode, ruleClosedId);

            System.out.println("✅ insertAgentCode 执行成功");
            System.out.println("  agentCode=" + agentCode + ", ruleClosedId=" + ruleClosedId);
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: insertAgentCode, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test7_insertAgentCode 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试8：selectRemarksById
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test8-selectRemarks
     */
    @GetMapping("/test8-selectRemarks")
    public String test8_selectRemarksById() {
        try {
            Long id = 6001L;
            String remarks = mapper.selectRemarksById(id);

            System.out.println("✅ selectRemarksById 执行成功");
            System.out.println("  id=" + id + ", remarks=" + remarks);

            return "SUCCESS: selectRemarksById, remarks=" + remarks;
        } catch (Exception e) {
            String msg = "❌ test8_selectRemarksById 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试9：selectAgentNameByPrimaryKey
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test9-selectAgentName
     */
    @GetMapping("/test9-selectAgentName")
    public String test9_selectAgentNameByPrimaryKey() {
        try {
            Long id = 6001L;
            List<String> agentNames = mapper.selectAgentNameByPrimaryKey(id);

            System.out.println("✅ selectAgentNameByPrimaryKey 执行成功");
            System.out.println("  id=" + id);
            System.out.println("  agentNames.size()=" + (agentNames == null ? 0 : agentNames.size()));
            if (agentNames != null && !agentNames.isEmpty()) {
                for (String name : agentNames) {
                    System.out.println("  - " + name);
                }
            }

            return "SUCCESS: selectAgentNameByPrimaryKey, size=" + (agentNames == null ? 0 : agentNames.size());
        } catch (Exception e) {
            String msg = "❌ test9_selectAgentNameByPrimaryKey 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试10：selectByAgentTypeAndRuleId
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test10-selectByAgentTypeAndRuleId
     */
    @GetMapping("/test10-selectByAgentTypeAndRuleId")
    public String test10_selectByAgentTypeAndRuleId() {
        try {
            String agentType = "APT";
            String ruleId = "RULE-TRC-1";
            TSevAgentTypeRuleClosed record = mapper.selectByAgentTypeAndRuleId(agentType, ruleId);

            System.out.println("✅ selectByAgentTypeAndRuleId 执行成功");
            System.out.println("  agentType=" + agentType + ", ruleId=" + ruleId);
            if (record != null) {
                System.out.println("  id=" + record.getId());
            } else {
                System.out.println("  返回为空");
            }

            return "SUCCESS: selectByAgentTypeAndRuleId, exists=" + (record != null);
        } catch (Exception e) {
            String msg = "❌ test10_selectByAgentTypeAndRuleId 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试11：selectAgentCodeById
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test11-selectAgentCode
     */
    @GetMapping("/test11-selectAgentCode")
    public String test11_selectAgentCodeById() {
        try {
            long id = 6001L;
            List<String> agentCodes = mapper.selectAgentCodeById(id);

            System.out.println("✅ selectAgentCodeById 执行成功");
            System.out.println("  id=" + id);
            System.out.println("  agentCodes.size()=" + (agentCodes == null ? 0 : agentCodes.size()));
            if (agentCodes != null && !agentCodes.isEmpty()) {
                for (String code : agentCodes) {
                    System.out.println("  - " + code);
                }
            }

            return "SUCCESS: selectAgentCodeById, size=" + (agentCodes == null ? 0 : agentCodes.size());
        } catch (Exception e) {
            String msg = "❌ test11_selectAgentCodeById 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试12：selectQueryIfoListByAgentTypeAndRuleId
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test12-selectQueryInfoList
     */
    @GetMapping("/test12-selectQueryInfoList")
    public String test12_selectQueryIfoListByAgentTypeAndRuleId() {
        try {
            String agentType = "APT";
            String ruleId = "RULE-TRC";
            Page page = new Page(10, 0);

            List<QueryInfo> result = mapper.selectQueryIfoListByAgentTypeAndRuleId(agentType, ruleId, page);

            System.out.println("✅ selectQueryIfoListByAgentTypeAndRuleId 执行成功");
            System.out.println("  agentType=" + agentType + ", ruleId=" + ruleId);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));

            return "SUCCESS: selectQueryIfoListByAgentTypeAndRuleId, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test12_selectQueryIfoListByAgentTypeAndRuleId 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试13：selectQueryInfoByAgentTypeAndRuleId
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test13-selectQueryInfo
     */
    @GetMapping("/test13-selectQueryInfo")
    public String test13_selectQueryInfoByAgentTypeAndRuleId() {
        try {
            String agentType = "APT";
            String ruleId = "RULE-TRC-1";
            QueryInfo result = mapper.selectQueryInfoByAgentTypeAndRuleId(agentType, ruleId);

            System.out.println("✅ selectQueryInfoByAgentTypeAndRuleId 执行成功");
            System.out.println("  agentType=" + agentType + ", ruleId=" + ruleId);
            if (result != null) {
                System.out.println("  id=" + result.getId());
            } else {
                System.out.println("  返回为空");
            }

            return "SUCCESS: selectQueryInfoByAgentTypeAndRuleId, exists=" + (result != null);
        } catch (Exception e) {
            String msg = "❌ test13_selectQueryInfoByAgentTypeAndRuleId 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试14：getAllAgentById
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test14-getAllAgent
     */
    @GetMapping("/test14-getAllAgent")
    public String test14_getAllAgentById() {
        try {
            long id = 6001L;
            List<ValueName> result = mapper.getAllAgentById(id);

            System.out.println("✅ getAllAgentById 执行成功");
            System.out.println("  id=" + id);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null && !result.isEmpty()) {
                for (ValueName vn : result) {
                    System.out.println("  - value=" + vn.getValue() + ", name=" + vn.getName());
                }
            }

            return "SUCCESS: getAllAgentById, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test14_getAllAgentById 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试15：updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test15-updateMultipleFields
     */
    @GetMapping("/test15-updateMultipleFields")
    public String test15_updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById() {
        try {
            String ruleId = "RULE-TRC-UPDATED";
            String agentType = "APT";
            String remarks = "测试规则关闭-多字段更新";
            Boolean updateHistoryAlarm = true;
            Long id = 6004L;

            int affectedRows = mapper.updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById(
                    ruleId, agentType, remarks, updateHistoryAlarm, id
            );

            System.out.println("✅ updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById 执行成功");
            System.out.println("  id=" + id);
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test15_updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试16：selectIdByRuleIdAndAgentType
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test16-selectIdByRuleIdAndAgentType
     */
    @GetMapping("/test16-selectIdByRuleIdAndAgentType")
    public String test16_selectIdByRuleIdAndAgentType() {
        try {
            String ruleId = "RULE-TRC";
            String agentType = "APT";
            List<Long> result = mapper.selectIdByRuleIdAndAgentType(ruleId, agentType);

            System.out.println("✅ selectIdByRuleIdAndAgentType 执行成功");
            System.out.println("  ruleId=" + ruleId + ", agentType=" + agentType);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));

            return "SUCCESS: selectIdByRuleIdAndAgentType, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test16_selectIdByRuleIdAndAgentType 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试17：selectIdByRuleIdAndAgentTypePrecisely
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test17-selectIdPrecisely
     */
    @GetMapping("/test17-selectIdPrecisely")
    public String test17_selectIdByRuleIdAndAgentTypePrecisely() {
        try {
            String ruleId = "RULE-TRC-1";
            String agentType = "APT";
            Long result = mapper.selectIdByRuleIdAndAgentTypePrecisely(ruleId, agentType);

            System.out.println("✅ selectIdByRuleIdAndAgentTypePrecisely 执行成功");
            System.out.println("  ruleId=" + ruleId + ", agentType=" + agentType);
            System.out.println("  id=" + result);

            return "SUCCESS: selectIdByRuleIdAndAgentTypePrecisely, id=" + result;
        } catch (Exception e) {
            String msg = "❌ test17_selectIdByRuleIdAndAgentTypePrecisely 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试18：selectUpdateHistoryAlarmById
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test18-selectUpdateHistoryAlarm
     */
    @GetMapping("/test18-selectUpdateHistoryAlarm")
    public String test18_selectUpdateHistoryAlarmById() {
        try {
            Long id = 6001L;
            Boolean result = mapper.selectUpdateHistoryAlarmById(id);

            System.out.println("✅ selectUpdateHistoryAlarmById 执行成功");
            System.out.println("  id=" + id + ", updateHistoryAlarm=" + result);

            return "SUCCESS: selectUpdateHistoryAlarmById, updateHistoryAlarm=" + result;
        } catch (Exception e) {
            String msg = "❌ test18_selectUpdateHistoryAlarmById 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试19：tryCleanCloseRule
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test19-tryCleanCloseRule
     */
    @GetMapping("/test19-tryCleanCloseRule")
    public String test19_tryCleanCloseRule() {
        try {
            int affectedRows = mapper.tryCleanCloseRule();

            System.out.println("✅ tryCleanCloseRule 执行成功");
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: tryCleanCloseRule, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test19_tryCleanCloseRule 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试20：queryRulesByCreateTime
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test20-queryRulesByCreateTime
     */
    @GetMapping("/test20-queryRulesByCreateTime")
    public String test20_queryRulesByCreateTime() {
        try {
            String startTime = "2024-01-01 00:00:00";
            String endTime = "2024-12-31 23:59:59";
            List<Map<String, Object>> result = mapper.queryRulesByCreateTime(startTime, endTime);

            System.out.println("✅ queryRulesByCreateTime 执行成功");
            System.out.println("  startTime=" + startTime + ", endTime=" + endTime);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));

            return "SUCCESS: queryRulesByCreateTime, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test20_queryRulesByCreateTime 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试21：queryListOpenApi
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test21-queryListOpenApi
     */
    @GetMapping("/test21-queryListOpenApi")
    public String test21_queryListOpenApi() {
        try {
            String agentType = "APT";
            String ruleId = "RULE-TRC";
            Page page = new Page(10, 0);
            String sortStr = "create_time DESC";

            List<QueryInfoOpenApi> result = mapper.queryListOpenApi(agentType, ruleId, page, sortStr);

            System.out.println("✅ queryListOpenApi 执行成功");
            System.out.println("  agentType=" + agentType + ", ruleId=" + ruleId);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));

            return "SUCCESS: queryListOpenApi, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test21_queryListOpenApi 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试22：deleteByPrimaryKey
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test22-deleteByPrimaryKey
     */
    @GetMapping("/test22-deleteByPrimaryKey")
    public String test22_deleteByPrimaryKey() {
        try {
            Long id = 6005L;
            int affectedRows = mapper.deleteByPrimaryKey(id);

            System.out.println("✅ deleteByPrimaryKey 执行成功");
            System.out.println("  id=" + id);
            System.out.println("  affectedRows=" + affectedRows);

            return "SUCCESS: deleteByPrimaryKey, affectedRows=" + affectedRows;
        } catch (Exception e) {
            String msg = "❌ test22_deleteByPrimaryKey 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/tSevAgentTypeRuleClosed/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        StringBuilder sb = new StringBuilder("ALL DONE\n");
        sb.append(test1_selectByPrimaryKey()).append("\n");
        sb.append(test2_insertSelective()).append("\n");
        sb.append(test3_updateByPrimaryKeySelective()).append("\n");
        sb.append(test4_updateByPrimaryKey()).append("\n");
        sb.append(test5_cascadeUpdateByPrimaryKey()).append("\n");
        sb.append(test6_selectByAgentCode()).append("\n");
        sb.append(test7_insertAgentCode()).append("\n");
        sb.append(test8_selectRemarksById()).append("\n");
        sb.append(test9_selectAgentNameByPrimaryKey()).append("\n");
        sb.append(test10_selectByAgentTypeAndRuleId()).append("\n");
        sb.append(test11_selectAgentCodeById()).append("\n");
        sb.append(test12_selectQueryIfoListByAgentTypeAndRuleId()).append("\n");
        sb.append(test13_selectQueryInfoByAgentTypeAndRuleId()).append("\n");
        sb.append(test14_getAllAgentById()).append("\n");
        sb.append(test15_updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById()).append("\n");
        sb.append(test16_selectIdByRuleIdAndAgentType()).append("\n");
        sb.append(test17_selectIdByRuleIdAndAgentTypePrecisely()).append("\n");
        sb.append(test18_selectUpdateHistoryAlarmById()).append("\n");
        sb.append(test19_tryCleanCloseRule()).append("\n");
        sb.append(test20_queryRulesByCreateTime()).append("\n");
        sb.append(test21_queryListOpenApi()).append("\n");
        sb.append(test22_deleteByPrimaryKey()).append("\n");
        return sb.toString();
    }
}
