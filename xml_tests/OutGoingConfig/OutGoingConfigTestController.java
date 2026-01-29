package com.test.controller;

import com.dbapp.extension.xdr.riskIncident.mapper.OutGoingConfigMapper;
import com.dbapp.extension.xdr.outgoingData.po.OutGoingConfig;
import com.dbapp.extension.xdr.dataSending.entity.DataSendingContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * OutGoingConfig 深度测试控制器
 * 对应7个XML方法，每个方法测试所有参数
 * 生成时间: 2026-01-28
 */
@RestController
@RequestMapping("/test/outGoingConfig")
public class OutGoingConfigTestController {

    @Autowired
    private OutGoingConfigMapper mapper;

    /**
     * 测试1：selectOutGoingConfig（测试所有if参数）
     * URL: /test/outGoingConfig/selectOutGoingConfig
     */
    @GetMapping("/selectOutGoingConfig")
    public String testSelectOutGoingConfig() {
        try {
            System.out.println("=== 测试: selectOutGoingConfig（综合参数） ===");
            
            // 场景1：type=SYSLOG, enable=true
            String type1 = "SYSLOG";
            Boolean enable1 = true;
            List<OutGoingConfig> result1 = mapper.selectOutGoingConfig(type1, enable1);
            System.out.println("✓ type=SYSLOG, enable=true: " + result1.size() + " 条");
            
            // 场景2：type=KAFKA, enable=null（不限制）
            String type2 = "KAFKA";
            Boolean enable2 = null;
            List<OutGoingConfig> result2 = mapper.selectOutGoingConfig(type2, enable2);
            System.out.println("✓ type=KAFKA, enable=null: " + result2.size() + " 条");
            
            // 场景3：type=null, enable=false（查所有禁用的）
            String type3 = null;
            Boolean enable3 = false;
            List<OutGoingConfig> result3 = mapper.selectOutGoingConfig(type3, enable3);
            System.out.println("✓ type=null, enable=false: " + result3.size() + " 条");
            
            // 场景4：type=null, enable=null（查所有）
            List<OutGoingConfig> result4 = mapper.selectOutGoingConfig(null, null);
            System.out.println("✓ type=null, enable=null（全部）: " + result4.size() + " 条");
            
            return "SUCCESS: 测试4个场景，共查询到 " + (result1.size() + result2.size() + result3.size() + result4.size()) + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 selectOutGoingConfig 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：selectConfigById（按ID查询，测试JOIN）
     * URL: /test/outGoingConfig/selectConfigById
     */
    @GetMapping("/selectConfigById")
    public String testSelectConfigById() {
        try {
            System.out.println("=== 测试: selectConfigById（测试JOIN关联表） ===");
            
            // 查询ID=1001（关联alarm_config）
            Integer id1 = 1001;
            OutGoingConfig config1 = mapper.selectConfigById(id1);
            System.out.println("✓ ID=1001: " + (config1 != null ? config1.getServerName() : "null"));
            if (config1 != null && config1.getAlarmOutGoingConfig() != null) {
                System.out.println("  - 关联告警配置ID: " + config1.getAlarmOutGoingConfig().getId());
            }
            
            // 查询ID=1002（关联event_config）
            Integer id2 = 1002;
            OutGoingConfig config2 = mapper.selectConfigById(id2);
            System.out.println("✓ ID=1002: " + (config2 != null ? config2.getServerName() : "null"));
            if (config2 != null && config2.getEventOutGoingConfig() != null) {
                System.out.println("  - 关联事件配置ID: " + config2.getEventOutGoingConfig().getId());
            }
            
            // 查询ID=1003（关联risk_config）
            Integer id3 = 1003;
            OutGoingConfig config3 = mapper.selectConfigById(id3);
            System.out.println("✓ ID=1003: " + (config3 != null ? config3.getServerName() : "null"));
            if (config3 != null && config3.getRiskOutGoingConfig() != null) {
                System.out.println("  - 关联风险配置ID: " + config3.getRiskOutGoingConfig().getId());
            }
            
            // 查询ID=1005（关联所有配置）
            Integer id4 = 1005;
            OutGoingConfig config4 = mapper.selectConfigById(id4);
            System.out.println("✓ ID=1005（综合配置）: " + (config4 != null ? config4.getServerName() : "null"));
            
            return "SUCCESS: 查询4个配置，测试所有JOIN";
        } catch (Exception e) {
            String errorMsg = "测试方法 selectConfigById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：selectOutGoingConfigCount（统计数量）
     * URL: /test/outGoingConfig/selectOutGoingConfigCount
     */
    @GetMapping("/selectOutGoingConfigCount")
    public String testSelectOutGoingConfigCount() {
        try {
            System.out.println("=== 测试: selectOutGoingConfigCount（测试所有if参数） ===");
            
            // 场景1：type=SYSLOG, enable=true
            long count1 = mapper.selectOutGoingConfigCount("SYSLOG", true);
            System.out.println("✓ SYSLOG且已启用: " + count1 + " 条");
            
            // 场景2：type=KAFKA, enable=null
            long count2 = mapper.selectOutGoingConfigCount("KAFKA", null);
            System.out.println("✓ KAFKA（不限启用状态）: " + count2 + " 条");
            
            // 场景3：type=null, enable=false
            long count3 = mapper.selectOutGoingConfigCount(null, false);
            System.out.println("✓ 所有已禁用: " + count3 + " 条");
            
            // 场景4：type=null, enable=null
            long count4 = mapper.selectOutGoingConfigCount(null, null);
            System.out.println("✓ 全部配置: " + count4 + " 条");
            
            return "SUCCESS: 共 " + count4 + " 条配置";
        } catch (Exception e) {
            String errorMsg = "测试方法 selectOutGoingConfigCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：selectOutGoingConfigByPage（分页查询）
     * URL: /test/outGoingConfig/selectOutGoingConfigByPage
     */
    @GetMapping("/selectOutGoingConfigByPage")
    public String testSelectOutGoingConfigByPage() {
        try {
            System.out.println("=== 测试: selectOutGoingConfigByPage（分页+参数） ===");
            
            // 场景1：第1页，每页2条，type=null, enable=true
            List<OutGoingConfig> page1 = mapper.selectOutGoingConfigByPage(null, true, 0, 2);
            System.out.println("✓ 第1页（已启用）: " + page1.size() + " 条");
            
            // 场景2：第2页，每页2条
            List<OutGoingConfig> page2 = mapper.selectOutGoingConfigByPage(null, true, 2, 2);
            System.out.println("✓ 第2页（已启用）: " + page2.size() + " 条");
            
            // 场景3：查询KAFKA类型，不限启用状态
            List<OutGoingConfig> kafkaList = mapper.selectOutGoingConfigByPage("KAFKA", null, 0, 10);
            System.out.println("✓ KAFKA类型: " + kafkaList.size() + " 条");
            
            return "SUCCESS: 分页测试完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 selectOutGoingConfigByPage 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：updateSwitchById（更新开关）
     * URL: /test/outGoingConfig/updateSwitchById
     */
    @GetMapping("/updateSwitchById")
    public String testUpdateSwitchById() {
        try {
            System.out.println("=== 测试: updateSwitchById ===");
            
            Integer id = 1004;
            Boolean enable = true;
            
            mapper.updateSwitchById(id, enable);
            System.out.println("✓ 更新配置ID=" + id + ", enable=" + enable);
            
            return "SUCCESS: 更新配置开关";
        } catch (Exception e) {
            String errorMsg = "测试方法 updateSwitchById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试6：selectKbrCount（查询Kerberos配置数量，测试所有if）
     * URL: /test/outGoingConfig/selectKbrCount
     */
    @GetMapping("/selectKbrCount")
    public String testSelectKbrCount() {
        try {
            System.out.println("=== 测试: selectKbrCount（测试所有if条件） ===");
            
            // 场景1：所有参数都有
            Integer id1 = 1003;
            String serverAddress1 = "192.168.2.20";
            String kdcServerName1 = "KDC-主节点";
            int count1 = mapper.selectKbrCount(id1, serverAddress1, kdcServerName1);
            System.out.println("✓ 场景1（所有参数）: " + count1 + " 条");
            
            // 场景2：id=null（不排除任何ID）
            int count2 = mapper.selectKbrCount(null, "192.168.1.10", "KDC-主节点");
            System.out.println("✓ 场景2（id=null）: " + count2 + " 条");
            
            // 场景3：kdcServerName=null
            int count3 = mapper.selectKbrCount(1003, "192.168.1.10", null);
            System.out.println("✓ 场景3（kdcServerName=null）: " + count3 + " 条");
            
            // 场景4：serverAddress=null
            int count4 = mapper.selectKbrCount(1003, null, "KDC-主节点");
            System.out.println("✓ 场景4（serverAddress=null）: " + count4 + " 条");
            
            // 场景5：所有参数都为null
            int count5 = mapper.selectKbrCount(null, null, null);
            System.out.println("✓ 场景5（全null）: " + count5 + " 条");
            
            return "SUCCESS: 测试5个场景";
        } catch (Exception e) {
            String errorMsg = "测试方法 selectKbrCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试7：closeConfig（关闭配置，测试所有if）
     * URL: /test/outGoingConfig/closeConfig
     */
    @GetMapping("/closeConfig")
    public String testCloseConfig() {
        try {
            System.out.println("=== 测试: closeConfig（测试所有if条件） ===");
            
            // 场景1：完整参数（包括所有if条件）
            DataSendingContext context1 = new DataSendingContext();
            context1.setHost("192.168.1.10");
            context1.setEncryptionType("kerberos");
            context1.setKdcServerName("KDC-主节点");
            context1.setPrincipal("kafka-producer@COMPANY.COM");
            context1.setKafkaServerName("kafka-service-1");
            
            mapper.closeConfig(context1);
            System.out.println("✓ 场景1（所有if条件都有值）: 关闭成功");
            
            // 场景2：部分参数为null（测试if判断）
            DataSendingContext context2 = new DataSendingContext();
            context2.setHost("192.168.2.20");
            context2.setEncryptionType("none");
            // kdcServerName, principal, kafkaServerName都为null
            
            mapper.closeConfig(context2);
            System.out.println("✓ 场景2（部分参数null）: 关闭成功");
            
            return "SUCCESS: 测试2个场景";
        } catch (Exception e) {
            String errorMsg = "测试方法 closeConfig 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
