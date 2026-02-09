package com.test.controller;

import com.dbapp.entity.ValueName;
import com.dbapp.xdr.bean.po.TSevAgentInfo;
import com.dbapp.xdr.mapper.TSevAgentInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * TSevAgentInfo 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的所有方法，包含多表关联查询：
 * - t_sev_agent_info
 * - t_sev_agent_monitor
 * - updateinfo（可为空，左连接）
 *
 * 测试数据：
 * - mirror_test/TSevAgentInfo/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/tSevAgentInfo")
public class TSevAgentInfoTestController {

    @Autowired
    private TSevAgentInfoMapper mapper;

    @GetMapping("/test1-deleteByAgentCodeIn")
    public String test1_deleteByAgentCodeIn() {
        try {
            Collection<String> codes = Arrays.asList("AGENT_INFO_1", "AGENT_INFO_2");
            int affected = mapper.deleteByAgentCodeIn(codes);
            System.out.println("✅ deleteByAgentCodeIn 执行成功, affectedRows=" + affected);
            return "SUCCESS: deleteByAgentCodeIn, affectedRows=" + affected;
        } catch (Exception e) {
            String msg = "❌ test1_deleteByAgentCodeIn 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test2-selectStatusByAgentCode")
    public String test2_selectStatusByAgentCode() {
        try {
            String agentCode = "AGENT_INFO_3";
            List<String> statuses = mapper.selectStatusByAgentCode(agentCode);
            System.out.println("✅ selectStatusByAgentCode 执行成功, statuses=" + statuses);
            return "SUCCESS: selectStatusByAgentCode, size=" + (statuses == null ? 0 : statuses.size());
        } catch (Exception e) {
            String msg = "❌ test2_selectStatusByAgentCode 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test3-deleteAll")
    public String test3_deleteAll() {
        try {
            int affected = mapper.deleteAll();
            System.out.println("✅ deleteAll 执行成功, affectedRows=" + affected);
            return "SUCCESS: deleteAll, affectedRows=" + affected;
        } catch (Exception e) {
            String msg = "❌ test3_deleteAll 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test4-updateOrgId")
    public String test4_updateOrgId() {
        try {
            String newOrgId = "ORG-UPDATED-ALL";
            int affected = mapper.updateOrgId(newOrgId);
            System.out.println("✅ updateOrgId 执行成功, affectedRows=" + affected);
            return "SUCCESS: updateOrgId, affectedRows=" + affected;
        } catch (Exception e) {
            String msg = "❌ test4_updateOrgId 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test5-updateOrgIdByAgentCodeIn")
    public String test5_updateOrgIdByAgentCodeIn() {
        try {
            String newOrgId = "ORG-UPDATED-PART";
            Collection<String> codes = Arrays.asList("AGENT_INFO_1", "AGENT_INFO_3");
            int affected = mapper.updateOrgIdByAgentCodeIn(newOrgId, codes);
            System.out.println("✅ updateOrgIdByAgentCodeIn 执行成功, affectedRows=" + affected);
            return "SUCCESS: updateOrgIdByAgentCodeIn, affectedRows=" + affected;
        } catch (Exception e) {
            String msg = "❌ test5_updateOrgIdByAgentCodeIn 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test6-updateAgentNameByAgentCode")
    public String test6_updateAgentNameByAgentCode() {
        try {
            String agentCode = "AGENT_INFO_2";
            String newName = "Agent 2 Updated";
            int affected = mapper.updateAgentNameByAgentCode(newName, agentCode);
            System.out.println("✅ updateAgentNameByAgentCode 执行成功, affectedRows=" + affected);
            return "SUCCESS: updateAgentNameByAgentCode, affectedRows=" + affected;
        } catch (Exception e) {
            String msg = "❌ test6_updateAgentNameByAgentCode 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test7-selectOneMachineCodeByAgentCode")
    public String test7_selectOneMachineCodeByAgentCode() {
        try {
            String agentCode = "AGENT_INFO_1";
            String machineCode = mapper.selectOneMachineCodeByAgentCode(agentCode);
            System.out.println("✅ selectOneMachineCodeByAgentCode 执行成功, machineCode=" + machineCode);
            return "SUCCESS: selectOneMachineCodeByAgentCode=" + machineCode;
        } catch (Exception e) {
            String msg = "❌ test7_selectOneMachineCodeByAgentCode 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test8-selectOneStatusByAgentCode")
    public String test8_selectOneStatusByAgentCode() {
        try {
            String agentCode = "AGENT_INFO_1";
            String status = mapper.selectOneStatusByAgentCode(agentCode);
            System.out.println("✅ selectOneStatusByAgentCode 执行成功, status=" + status);
            return "SUCCESS: selectOneStatusByAgentCode=" + status;
        } catch (Exception e) {
            String msg = "❌ test8_selectOneStatusByAgentCode 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test9-selectAgentCodeAndAgentNameByAgentType")
    public String test9_selectAgentCodeAndAgentNameByAgentType() {
        try {
            String agentType = "APT";
            List<ValueName> list = mapper.selectAgentCodeAndAgentNameByAgentType(agentType);
            System.out.println("✅ selectAgentCodeAndAgentNameByAgentType 执行成功, size=" + (list == null ? 0 : list.size()));
            if (list != null) {
                for (ValueName vn : list) {
                    System.out.println("  value=" + vn.getValue() + ", name=" + vn.getName());
                }
            }
            return "SUCCESS: selectAgentCodeAndAgentNameByAgentType, size=" + (list == null ? 0 : list.size());
        } catch (Exception e) {
            String msg = "❌ test9_selectAgentCodeAndAgentNameByAgentType 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test10-selectOneByMetric2Mix")
    public String test10_selectOneByMetric2Mix() {
        try {
            TSevAgentInfo info = mapper.selectOneByMetric2Mix();
            System.out.println("✅ selectOneByMetric2Mix 执行成功");
            if (info != null) {
                System.out.println("  agentCode=" + info.getAgentCode()
                        + ", monitorId=" + info.getMonitorId()
                        + ", status=" + info.getStatus());
            } else {
                System.out.println("  返回为空");
            }
            return "SUCCESS: selectOneByMetric2Mix, exists=" + (info != null);
        } catch (Exception e) {
            String msg = "❌ test10_selectOneByMetric2Mix 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test11-getAllHeartBeatTimeOnline")
    public String test11_getAllHeartBeatTimeOnline() {
        try {
            List<Map<String, Object>> list = mapper.getAllHeartBeatTimeOnline();
            System.out.println("✅ getAllHeartBeatTimeOnline 执行成功, size=" + (list == null ? 0 : list.size()));
            if (list != null) {
                for (Map<String, Object> m : list) {
                    System.out.println("  row=" + m);
                }
            }
            return "SUCCESS: getAllHeartBeatTimeOnline, size=" + (list == null ? 0 : list.size());
        } catch (Exception e) {
            String msg = "❌ test11_getAllHeartBeatTimeOnline 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test12-getAllUpgrading")
    public String test12_getAllUpgrading() {
        try {
            List<Map<String, Object>> list = mapper.getAllUpgrading();
            System.out.println("✅ getAllUpgrading 执行成功, size=" + (list == null ? 0 : list.size()));
            if (list != null) {
                for (Map<String, Object> m : list) {
                    System.out.println("  row=" + m);
                }
            }
            return "SUCCESS: getAllUpgrading, size=" + (list == null ? 0 : list.size());
        } catch (Exception e) {
            String msg = "❌ test12_getAllUpgrading 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    @GetMapping("/test13-updateAgentIp")
    public String test13_updateAgentIp() {
        try {
            String oldIp = "10.0.0.1";
            String newIp = "10.0.0.100";
            String agentType = "APT";
            mapper.updateAgentIp(oldIp, newIp, agentType);

            // 简单验证：重新查询其中一个探针
            TSevAgentInfo info = mapper.selectById(1L);
            System.out.println("✅ updateAgentIp 执行成功, info=" + (info == null ? "null" : info.getAgentIp()));
            return "SUCCESS: updateAgentIp";
        } catch (Exception e) {
            String msg = "❌ test13_updateAgentIp 执行失败: " + e.getMessage();
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * 使用方式：每次执行前，先在数据库中执行 test_data.sql 恢复初始数据
     */
    @GetMapping("/test-all")
    public String testAll() {
        StringBuilder sb = new StringBuilder("ALL DONE\n");
        sb.append(test1_deleteByAgentCodeIn()).append("\n");
        sb.append(test2_selectStatusByAgentCode()).append("\n");
        sb.append(test3_deleteAll()).append("\n");
        sb.append(test4_updateOrgId()).append("\n");
        sb.append(test5_updateOrgIdByAgentCodeIn()).append("\n");
        sb.append(test6_updateAgentNameByAgentCode()).append("\n");
        sb.append(test7_selectOneMachineCodeByAgentCode()).append("\n");
        sb.append(test8_selectOneStatusByAgentCode()).append("\n");
        sb.append(test9_selectAgentCodeAndAgentNameByAgentType()).append("\n");
        sb.append(test10_selectOneByMetric2Mix()).append("\n");
        sb.append(test11_getAllHeartBeatTimeOnline()).append("\n");
        sb.append(test12_getAllUpgrading()).append("\n");
        sb.append(test13_updateAgentIp());
        return sb.toString();
    }
}

