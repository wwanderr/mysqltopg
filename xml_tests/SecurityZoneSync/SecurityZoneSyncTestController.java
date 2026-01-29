package com.test.controller;

import com.dbapp.extension.xdr.security.mapper.SecurityZoneSyncMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * SecurityZoneSync (安全域同步) 深度测试控制器
 * 关联表：t_asset_info, t_ailpha_network_segment, t_ailpha_security_zone
 * 测试方法数：1 (querySecurityZone)
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/securityZoneSync")
public class SecurityZoneSyncTestController {
    @Autowired
    private SecurityZoneSyncMapper mapper;

    /**
     * 方法1：querySecurityZone - 查询安全域及其资产
     * 测试条件：
     * - RIGHT JOIN t_ailpha_network_segment (网段表)
     * - LEFT JOIN t_ailpha_security_zone (安全域表)
     * - WHERE f.id is not null（过滤条件）
     */
    @GetMapping("/test1_querySecurityZone")
    public String test1_querySecurityZone() {
        try {
            System.out.println("测试: querySecurityZone - 查询安全域及其资产");
            Map<String, Object> params = new HashMap<>();
            
            List<Map<String, Object>> result = mapper.querySecurityZone(params);
            System.out.println("结果: " + result.size() + " 条资产-安全域映射");
            
            if (!result.isEmpty()) {
                System.out.println("详情：");
                for (Map<String, Object> row : result) {
                    System.out.println("  - 安全域: " + row.get("name") 
                        + " (ID=" + row.get("id") + "), 资产IP: " + row.get("assetIp"));
                }
            }
            
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_querySecurityZone 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
