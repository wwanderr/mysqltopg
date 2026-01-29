package com.test.controller;

import com.dbapp.extension.xdr.shared.mapper.SharedDataMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * SharedData (共享数据) 深度测试控制器
 * 主表：t_security_incidents（使用此表的update_ip_information字段）
 * 测试方法数：1 (queryTodayUpdateIpInformation)
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/sharedData")
public class SharedDataTestController {
    @Autowired
    private SharedDataMapper mapper;

    /**
     * 方法1：queryTodayUpdateIpInformation - 查询今日IP更新信息
     * 测试条件：
     * - WHERE start_time::DATE = CURRENT_DATE
     * - 返回 event_code 和 update_ip_information
     */
    @GetMapping("/test1_queryTodayUpdateIpInformation")
    public String test1_queryTodayUpdateIpInformation() {
        try {
            System.out.println("测试: queryTodayUpdateIpInformation - 查询今日IP更新信息");
            List<Map<String, Object>> result = mapper.queryTodayUpdateIpInformation();
            System.out.println("结果: " + result.size() + " 条今日更新");
            
            if (!result.isEmpty()) {
                System.out.println("详情：");
                for (Map<String, Object> row : result) {
                    System.out.println("  - event_code: " + row.get("event_code") 
                        + ", update_ip_information: " + row.get("update_ip_information"));
                }
            }
            
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_queryTodayUpdateIpInformation 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
