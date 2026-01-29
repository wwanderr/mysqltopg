package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.LinkedStrategyMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.LinkedStrategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * LinkedStrategy 测试 Controller
 * 
 * 所有测试方法使用 GET 请求，参数在方法内部写死
 * 基于test_data.sql中的测试数据（ID: 1001-1005）
 * 
 * 表结构字段：
 * - id, strategy_name, auto_handle, threat_type, threat_type_config
 * - threat_level, alarm_results, status, source, template_id
 * - link_device_config, alarm_names, create_time, update_time
 * 
 * 生成时间: 2026-01-28
 */
@RestController
@RequestMapping("/test/linkedStrategy")
public class LinkedStrategyTestController {
    
    @Autowired
    private LinkedStrategyMapper mapper;

    /**
     * 测试1：插入或更新策略
     * URL: http://localhost:8080/test/linkedStrategy/insertOrUpdate
     */
    @GetMapping("/insertOrUpdate")
    public String testInsertOrUpdate() {
        try {
            System.out.println("=== 测试: insertOrUpdate ===");
            
            LinkedStrategy strategy = new LinkedStrategy();
            strategy.setStrategyName("测试新增策略-自动挖矿检测");
            strategy.setAutoHandle(true);
            strategy.setThreatType("alarmType");
            strategy.setThreatTypeConfig("/Malware/Miner,/Malware/Botnet");
            strategy.setThreatLevel("High");
            strategy.setAlarmResults("OK");
            strategy.setStatus(true);
            strategy.setSource("custom");
            strategy.setLinkDeviceConfig("[{\"linkDeviceType\":\"IDS\",\"checked\":true}]");
            strategy.setAlarmNames("挖矿告警,僵尸网络");
            
            int rows = mapper.insertOrUpdate(strategy);
            System.out.println("✓ 插入成功 " + rows + " 行，ID=" + strategy.getId());
            return "SUCCESS: 插入 " + rows + " 行，ID=" + strategy.getId();
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试2：启用/禁用策略
     * URL: http://localhost:8080/test/linkedStrategy/enableLinkStrategy
     */
    @GetMapping("/enableLinkStrategy")
    public String testEnableLinkStrategy() {
        try {
            System.out.println("=== 测试: enableLinkStrategy ===");
            
            Long strategyId = 1001L;  // test_data.sql中的ID
            Boolean newStatus = true;
            
            LinkedStrategy strategy = new LinkedStrategy();
            strategy.setId(strategyId);
            strategy.setStatus(newStatus);
            
            mapper.enableLinkStrategy(strategy);
            System.out.println("✓ 启用策略成功 ID=" + strategyId);
            return "SUCCESS: 启用策略 " + strategyId;
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试3：更新策略
     * URL: http://localhost:8080/test/linkedStrategy/update
     */
    @GetMapping("/update")
    public String testUpdate() {
        try {
            System.out.println("=== 测试: update ===");
            
            LinkedStrategy strategy = new LinkedStrategy();
            strategy.setId(1002L);  // test_data.sql中的ID
            strategy.setStrategyName("勒索软件检测与隔离-已更新");
            strategy.setThreatLevel("High,Critical");  // 提升威胁等级
            strategy.setAutoHandle(true);  // 改为自动处置
            
            mapper.update(strategy);
            System.out.println("✓ 更新策略成功 ID=1002");
            return "SUCCESS: 更新策略 1002";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试4：删除策略
     * URL: http://localhost:8080/test/linkedStrategy/deleteLinkStrategy
     */
    @GetMapping("/deleteLinkStrategy")
    public String testDeleteLinkStrategy() {
        try {
            System.out.println("=== 测试: deleteLinkStrategy ===");
            
            Long strategyId = 1003L;  // test_data.sql中已禁用的策略
            int rows = mapper.deleteLinkStrategy(strategyId);
            System.out.println("✓ 删除策略 " + rows + " 行");
            return "SUCCESS: 删除 " + rows + " 行";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试5：根据ID获取策略
     * URL: http://localhost:8080/test/linkedStrategy/getLinkStrategyById
     */
    @GetMapping("/getLinkStrategyById")
    public String testGetLinkStrategyById() {
        try {
            System.out.println("=== 测试: getLinkStrategyById ===");
            
            Long strategyId = 1001L;
            LinkedStrategy result = mapper.getLinkStrategyById(strategyId);
            
            if (result != null) {
                System.out.println("✓ 查询成功: " + result.getStrategyName());
                System.out.println("  威胁类型: " + result.getThreatTypeConfig());
                System.out.println("  威胁等级: " + result.getThreatLevel());
                System.out.println("  自动处置: " + result.getAutoHandle());
                System.out.println("  状态: " + (result.getStatus() ? "已启用" : "已禁用"));
                return "SUCCESS: " + result.getStrategyName();
            } else {
                return "未找到数据 ID=" + strategyId;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试6：根据ID列表获取策略
     * URL: http://localhost:8080/test/linkedStrategy/getLinkStrategyByIds
     */
    @GetMapping("/getLinkStrategyByIds")
    public String testGetLinkStrategyByIds() {
        try {
            System.out.println("=== 测试: getLinkStrategyByIds ===");
            
            List<Long> ids = Arrays.asList(1001L, 1002L, 1004L, 1005L);
            List<LinkedStrategy> result = mapper.getLinkStrategyByIds(ids);
            
            System.out.println("✓ 查询到 " + result.size() + " 条策略");
            for (LinkedStrategy strategy : result) {
                System.out.println("  - " + strategy.getId() + ": " + strategy.getStrategyName());
            }
            return "SUCCESS: 查询到 " + result.size() + " 条";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试7：获取列表总数（测试所有查询参数）
     * URL: http://localhost:8080/test/linkedStrategy/getLinkStrategyListTotal
     * 
     * 测试参数：source, linkDeviceType, linkDeviceIp, action, startTime, endTime
     */
    @GetMapping("/getLinkStrategyListTotal")
    public String testGetLinkStrategyListTotal() {
        try {
            System.out.println("=== 测试: getLinkStrategyListTotal（所有参数） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("source", "custom");  // 来源：自定义
            params.put("linkDeviceType", "IDS");  // 设备类型：IDS
            params.put("linkDeviceIp", "192.168.100");  // 设备IP：192.168.100.*
            params.put("action", "prohibit");  // 动作：阻断
            params.put("startTime", java.time.LocalDateTime.now().minusDays(40).format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            
            Long count = mapper.getLinkStrategyListTotal(params);
            System.out.println("✓ 符合条件的策略总数: " + count);
            return "SUCCESS: 查询结果 " + count + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 getLinkStrategyListTotal 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试8：获取列表（测试所有查询参数）
     * URL: http://localhost:8080/test/linkedStrategy/getLinkStrategyList
     * 
     * 测试参数：source, linkDeviceType, linkDeviceIp, action, startTime, endTime, limit, offset
     */
    @GetMapping("/getLinkStrategyList")
    public String testGetLinkStrategyList() {
        try {
            System.out.println("=== 测试: getLinkStrategyList（所有参数） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("source", "custom");  // 来源：自定义
            params.put("linkDeviceType", "IDS");  // 设备类型：IDS（正则匹配）
            params.put("linkDeviceIp", "192.168.100");  // 设备IP：192.168.100.*（模糊匹配）
            params.put("action", "prohibit");  // 动作：阻断（数组查询）
            params.put("startTime", java.time.LocalDateTime.now().minusDays(40).format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("offset", 0);
            params.put("limit", 10);
            
            List<LinkedStrategy> result = mapper.getLinkStrategyList(params);
            System.out.println("✓ 查询到 " + result.size() + " 条策略");
            for (LinkedStrategy strategy : result) {
                System.out.println("  - " + strategy.getId() + ": " + strategy.getStrategyName());
            }
            return "SUCCESS: 查询到 " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 getLinkStrategyList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试9：根据名称和ID获取数量（唯一性校验）
     * URL: http://localhost:8080/test/linkedStrategy/getLinkStrategyCountByNameAndId
     */
    @GetMapping("/getLinkStrategyCountByNameAndId")
    public String testGetLinkStrategyCountByNameAndId() {
        try {
            System.out.println("=== 测试: getLinkStrategyCountByNameAndId ===");
            
            String strategyName = "自动封禁挖矿活动";
            Long excludeId = 1001L;  // 排除自己
            
            Integer count = mapper.getLinkStrategyCountByNameAndId(strategyName, excludeId);
            System.out.println("✓ 同名策略数量: " + count + " (排除ID=" + excludeId + ")");
            return "SUCCESS: 同名策略 " + count + " 条";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试10：根据参数查找策略（测试所有查询参数）
     * URL: http://localhost:8080/test/linkedStrategy/findLinkStrategyByParam
     * 
     * 测试参数：source, linkDeviceType, linkDeviceIp, strategyIds, action, startTime, endTime
     */
    @GetMapping("/findLinkStrategyByParam")
    public String testFindLinkStrategyByParam() {
        try {
            System.out.println("=== 测试: findLinkStrategyByParam（所有参数） ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("source", "custom");  // 来源：自定义
            params.put("linkDeviceType", "IDS,EDR");  // 设备类型：IDS或EDR（IN查询）
            params.put("linkDeviceIp", "192.168.100");  // 设备IP：192.168.100.*（模糊匹配）
            List<Long> strategyIds = Arrays.asList(1001L, 1004L, 1005L);  // 策略ID列表
            params.put("strategyIds", strategyIds);
            params.put("action", "prohibit");  // 动作：阻断（数组查询）
            params.put("startTime", java.time.LocalDateTime.now().minusDays(40).format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            
            List<LinkedStrategy> result = mapper.findLinkStrategyByParam(params);
            System.out.println("✓ 查询到 " + result.size() + " 条策略");
            for (LinkedStrategy strategy : result) {
                System.out.println("  - " + strategy.getId() + ": " + strategy.getStrategyName());
            }
            return "SUCCESS: 查询到 " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 findLinkStrategyByParam 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试11：获取所有模板策略ID
     * URL: http://localhost:8080/test/linkedStrategy/getAllTemplateStrategyIds
     */
    @GetMapping("/getAllTemplateStrategyIds")
    public String testGetAllTemplateStrategyIds() {
        try {
            System.out.println("=== 测试: getAllTemplateStrategyIds ===");
            
            List<LinkedStrategy> result = mapper.getAllTemplateStrategyIds();
            System.out.println("✓ 模板策略数量: " + result.size());
            for (LinkedStrategy strategy : result) {
                System.out.println("  - ID=" + strategy.getId() + ", TemplateID=" + strategy.getTemplateId());
            }
            return "SUCCESS: " + result.size() + " 个模板策略";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试12：批量更新联动设备配置
     * URL: http://localhost:8080/test/linkedStrategy/batchUpdateLinkDeviceConfig
     */
    @GetMapping("/batchUpdateLinkDeviceConfig")
    public String testBatchUpdateLinkDeviceConfig() {
        try {
            System.out.println("=== 测试: batchUpdateLinkDeviceConfig ===");
            
            LinkedStrategy strategy = new LinkedStrategy();
            // strategy.setThirdAuthId(100L);  // 根据实际需要设置
            
            mapper.batchUpdateLinkDeviceConfig(strategy);
            System.out.println("✓ 批量更新完成");
            return "SUCCESS: 批量更新完成";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试13：获取所有策略
     * URL: http://localhost:8080/test/linkedStrategy/getAllStrategys
     */
    @GetMapping("/getAllStrategys")
    public String testGetAllStrategys() {
        try {
            System.out.println("=== 测试: getAllStrategys ===");
            
            List<LinkedStrategy> result = mapper.getAllStrategys();
            System.out.println("✓ 查询到 " + result.size() + " 条策略");
            
            // 按来源统计
            long customCount = result.stream().filter(s -> "custom".equals(s.getSource())).count();
            long templateCount = result.stream().filter(s -> "template".equals(s.getSource())).count();
            System.out.println("  自定义策略: " + customCount + ", 模板策略: " + templateCount);
            
            return "SUCCESS: " + result.size() + " 条 (自定义:" + customCount + ", 模板:" + templateCount + ")";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试14：更新AppId
     * URL: http://localhost:8080/test/linkedStrategy/updateAppId
     */
    @GetMapping("/updateAppId")
    public String testUpdateAppId() {
        try {
            System.out.println("=== 测试: updateAppId ===");
            
            LinkedStrategy strategy = new LinkedStrategy();
            strategy.setId(1001L);
            // strategy.setAppId("dasca-dbappsecurity-test-001");  // 根据实际Entity字段设置
            
            mapper.updateAppId(strategy);
            System.out.println("✓ 更新AppId完成");
            return "SUCCESS: 更新AppId完成";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }
}
