package com.test.controller;

import com.dbapp.extension.xdr.outgoingData.mapper.EventOutGoingConfigMapper;
import com.dbapp.extension.xdr.outgoingData.po.EventOutGoingConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * EventOutGoingConfig 测试 Controller
 * 
 * 所有测试方法使用 GET 请求，参数在方法内部写死
 * 通过 Postman 调用 http://localhost:8080/test/eventOutGoingConfig/testX_methodName
 * 
 * 测试数据ID范围：1001-1005
 * 
 * 生成时间: 2026-01-26
 */
@RestController
@RequestMapping("/test/eventOutGoingConfig")
public class EventOutGoingConfigTestController {
    @Autowired
    private EventOutGoingConfigMapper mapper;

    /**
     * 测试：软删除配置（标记为已删除）
     * URL: /test/eventOutGoingConfig/delById
     */
    @GetMapping("/delById")
    public String testDelById() {
        try {
            System.out.println("=== 测试: delById - 软删除外发配置 ===");
            
            EventOutGoingConfig config = new EventOutGoingConfig();
            config.setId(1005L);  // 使用 test_data.sql 中ID=1005的待删除配置
            
            mapper.delById(config);
            System.out.println("✓ 配置 " + config.getId() + " 已标记为删除（is_del=1）");
            return "SUCCESS: 配置 " + config.getId() + " 已软删除";
        } catch (Exception e) {
            String errorMsg = "测试方法 delById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
