package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.LinkedStrategyValidtimeMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.EndTimeEntity;
import com.dbapp.extension.xdr.linkageHandle.entity.ProhibitHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * LinkedStrategyValidtime (联动策略有效期) 深度测试控制器
 * 主表：t_linkage_strategy_validtime (8个字段)
 * 关联表：t_prohibit_history, t_prohibit_domain_history
 * 测试方法数：6
 * 生成时间：2026-01-28（深度修复）
 */
@RestController
@RequestMapping("/test/linkedStrategyValidtime")
public class LinkedStrategyValidtimeTestController {
    
    @Autowired
    private LinkedStrategyValidtimeMapper mapper;

    /**
     * 方法1：insertValidtime - 插入IP封禁
     * 测试条件：blockDomain == null or blockDomain == ''（插入block_ip）
     */
    @GetMapping("/test1_insertValidtime_blockIp")
    public String test1_insertValidtime_blockIp() {
        try {
            System.out.println("测试: insertValidtime - 插入IP封禁");
            
            ProhibitHistory history = new ProhibitHistory();
            history.setLinkDeviceIp("192.168.1.10");
            history.setBlockIp("10.0.0.200");
            history.setBlockDomain(null);  // 测试if条件：blockDomain == null
            history.setNodeId("node-test-001");
            history.setDirection(1L);
            history.setEffectTime("3600");
            String endTime = LocalDateTime.now().plusHours(12).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            
            int rows = mapper.insertValidtime(history, endTime);
            System.out.println("结果: " + rows + " 行");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_insertValidtime_blockIp 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：insertValidtime - 插入域名封禁
     * 测试条件：blockDomain != null and blockDomain != ''（插入block_domain）
     */
    @GetMapping("/test2_insertValidtime_blockDomain")
    public String test2_insertValidtime_blockDomain() {
        try {
            System.out.println("测试: insertValidtime - 插入域名封禁");
            
            ProhibitHistory history = new ProhibitHistory();
            history.setLinkDeviceIp("192.168.1.20");
            history.setBlockIp(null);
            history.setBlockDomain("test.malware.com");  // 测试if条件：blockDomain != null
            history.setNodeId("node-test-002");
            history.setDirection(2L);
            history.setEffectTime("86400");
            String endTime = LocalDateTime.now().plusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            
            int rows = mapper.insertValidtime(history, endTime);
            System.out.println("结果: " + rows + " 行");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_insertValidtime_blockDomain 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：insertValidtime - ON CONFLICT DO UPDATE测试
     * 测试条件：冲突时触发UPDATE end_time
     */
    @GetMapping("/test3_insertValidtime_conflict")
    public String test3_insertValidtime_conflict() {
        try {
            System.out.println("测试: insertValidtime - ON CONFLICT DO UPDATE");
            
            // 使用已存在的记录（从test_data.sql）触发冲突
            ProhibitHistory history = new ProhibitHistory();
            history.setLinkDeviceIp("192.168.1.101");
            history.setBlockIp("10.0.0.100");
            history.setBlockDomain("");
            history.setNodeId("node-2001");
            history.setDirection(1L);
            history.setEffectTime("3600");
            String newEndTime = LocalDateTime.now().plusHours(48).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            
            int rows = mapper.insertValidtime(history, newEndTime);
            System.out.println("结果: ON CONFLICT触发，更新 " + rows + " 行");
            return "SUCCESS: " + rows + " (ON CONFLICT DO UPDATE)";
        } catch (Exception e) {
            String errorMsg = "测试方法 test3_insertValidtime_conflict 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法4：deleteEndtime - 删除IP封禁（覆盖所有if条件）
     * 测试参数：linkDeviceIp, blockIp, nodeId, direction, effectTime
     */
    @GetMapping("/test4_deleteEndtime_allParams")
    public String test4_deleteEndtime_allParams() {
        try {
            System.out.println("测试: deleteEndtime - 删除IP封禁（所有参数）");
            
            Map<String, Object> params = new HashMap<>();
            params.put("linkDeviceIp", "192.168.1.102");  // 必选
            params.put("blockIp", "10.0.0.102");          // 可选（测试if条件）
            params.put("nodeId", "node-2002");            // 可选（测试if条件）
            params.put("direction", 2);                   // 可选（测试if条件）
            params.put("effectTime", "86400");            // 可选（测试if条件）
            
            int rows = mapper.deleteEndtime(params);
            System.out.println("结果: 删除 " + rows + " 条");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test4_deleteEndtime_allParams 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法5：deleteEndtime - 删除域名封禁（测试blockDomain条件）
     * 测试参数：linkDeviceIp, blockDomain
     */
    @GetMapping("/test5_deleteEndtime_blockDomain")
    public String test5_deleteEndtime_blockDomain() {
        try {
            System.out.println("测试: deleteEndtime - 删除域名封禁");
            
            Map<String, Object> params = new HashMap<>();
            params.put("linkDeviceIp", "192.168.1.105");
            params.put("blockDomain", "phishing2.com");  // 测试if条件：blockDomain != null
            
            int rows = mapper.deleteEndtime(params);
            System.out.println("结果: 删除 " + rows + " 条");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test5_deleteEndtime_blockDomain 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法6：selectEndTime - 查询过期记录（UNION ALL + LEFT JOIN）
     * 测试条件：b.end_time < nowTime AND status = true
     */
    @GetMapping("/test6_selectEndTime")
    public String test6_selectEndTime() {
        try {
            System.out.println("测试: selectEndTime - 查询过期的有效期记录");
            
            String nowTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            List<EndTimeEntity> result = mapper.selectEndTime(nowTime);
            
            System.out.println("结果: " + result.size() + " 条过期记录");
            for (EndTimeEntity entity : result) {
                if (entity.getBlockIp() != null) {
                    System.out.println("  - IP封禁: " + entity.getBlockIp() + " (ID=" + entity.getId() + ", direction=" + entity.getDirection() + ")");
                } else if (entity.getBlockDomain() != null) {
                    System.out.println("  - 域名封禁: " + entity.getBlockDomain() + " (ID=" + entity.getId() + ", direction=" + entity.getDirection() + ")");
                }
            }
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test6_selectEndTime 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
