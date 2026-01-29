package com.test.controller;

import com.dbapp.extension.xdr.threatAnalysis.mapper.LoginBaselineMapper;
import com.dbapp.extension.xdr.threatAnalysis.entity.LoginBaseline;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * LoginBaseline (登录基线) 深度测试控制器
 * 主表：t_scene_login_baseline (7个字段)
 * 测试方法数：4
 * 生成时间：2026-01-28（深度修复）
 */
@RestController
@RequestMapping("/test/loginBaseline")
public class LoginBaselineTestController {
    @Autowired
    private LoginBaselineMapper mapper;

    /**
     * 方法1：cleanOvertimeData - 清理超时数据
     * 测试条件：EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - last_login_time)) / 3600 > overtimeHour
     */
    @GetMapping("/test1_cleanOvertimeData")
    public String test1_cleanOvertimeData() {
        try {
            System.out.println("测试: cleanOvertimeData - 清理超时数据");
            int overtimeHour = 720; // 清理30天前的数据
            
            int rows = mapper.cleanOvertimeData(overtimeHour);
            System.out.println("结果: 清理 " + rows + " 条");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_cleanOvertimeData 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：insertOrUpdate - 批量插入（新数据）
     * 测试条件：<foreach collection="baselineList">（批量插入2条）
     */
    @GetMapping("/test2_insertOrUpdate_new")
    public String test2_insertOrUpdate_new() {
        try {
            System.out.println("测试: insertOrUpdate - 批量插入新数据");
            
            List<LoginBaseline> list = new ArrayList<>();
            
            // 场景1：管理员登录
            LoginBaseline baseline1 = new LoginBaseline();
            baseline1.setDestAddress("192.168.200.10");
            baseline1.setSrcUserName("admin-test");
            baseline1.setLastLoginTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            baseline1.setCityCounts("{\"Beijing\": 100, \"Shanghai\": 50}");  // JSON格式
            baseline1.setCityArray("Beijing,Shanghai");
            baseline1.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            list.add(baseline1);
            
            // 场景2：普通用户登录
            LoginBaseline baseline2 = new LoginBaseline();
            baseline2.setDestAddress("192.168.200.11");
            baseline2.setSrcUserName("analyst-test");
            baseline2.setLastLoginTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            baseline2.setCityCounts("{\"Guangzhou\": 80}");  // JSON格式
            baseline2.setCityArray("Guangzhou");
            baseline2.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            list.add(baseline2);
            
            int rows = mapper.insertOrUpdate(list);
            System.out.println("结果: " + rows + " 行");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_insertOrUpdate_new 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：insertOrUpdate - ON DUPLICATE KEY UPDATE测试
     * 测试条件：重复(dest_address, src_user_name)触发UPDATE
     */
    @GetMapping("/test3_insertOrUpdate_update")
    public String test3_insertOrUpdate_update() {
        try {
            System.out.println("测试: insertOrUpdate - ON DUPLICATE KEY UPDATE");
            
            List<LoginBaseline> list = new ArrayList<>();
            
            // 使用已存在的(dest_address, src_user_name)触发更新
            LoginBaseline baseline = new LoginBaseline();
            baseline.setDestAddress("192.168.100.10");  // 已存在（从test_data.sql）
            baseline.setSrcUserName("admin");  // 已存在
            baseline.setLastLoginTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            baseline.setCityCounts("{\"Beijing\": 200, \"Shanghai\": 100, \"Shenzhen\": 50, \"Guangzhou\": 30}");  // 更新：新增城市
            baseline.setCityArray("Beijing,Shanghai,Shenzhen,Guangzhou");  // 更新：4个城市
            baseline.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            list.add(baseline);
            
            int rows = mapper.insertOrUpdate(list);
            System.out.println("结果: ON DUPLICATE KEY触发，更新 " + rows + " 行");
            return "SUCCESS: " + rows + " (ON DUPLICATE KEY UPDATE)";
        } catch (Exception e) {
            String errorMsg = "测试方法 test3_insertOrUpdate_update 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法4：queryByPrimaryKey - 批量查询
     * 测试条件：<foreach> IN查询（查询3条）
     */
    @GetMapping("/test4_queryByPrimaryKey")
    public String test4_queryByPrimaryKey() {
        try {
            System.out.println("测试: queryByPrimaryKey - 批量查询");
            
            List<LoginBaseline> queryList = new ArrayList<>();
            
            // 查询3条数据（从test_data.sql）
            LoginBaseline query1 = new LoginBaseline();
            query1.setDestAddress("192.168.100.10");
            query1.setSrcUserName("admin");
            queryList.add(query1);
            
            LoginBaseline query2 = new LoginBaseline();
            query2.setDestAddress("192.168.100.11");
            query2.setSrcUserName("analyst001");
            queryList.add(query2);
            
            LoginBaseline query3 = new LoginBaseline();
            query3.setDestAddress("192.168.100.12");
            query3.setSrcUserName("operator");
            queryList.add(query3);
            
            List<LoginBaseline> result = mapper.queryByPrimaryKey(queryList);
            System.out.println("结果: " + result.size() + " 条");
            for (LoginBaseline baseline : result) {
                System.out.println("  - " + baseline.getDestAddress() + " - " + baseline.getSrcUserName() + " (" + baseline.getCityArray() + ")");
            }
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test4_queryByPrimaryKey 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
