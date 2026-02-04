package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.SecurityAlarmHandleMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.SecurityAlarmHandle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

/**
 * SecurityAlarmHandle (安全告警处理) 深度测试控制器
 * 主表：t_security_alarm_handle (6个字段)
 * 测试方法数：2 (insertOrUpdate, updateStatusById)
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/securityAlarmHandle")
public class SecurityAlarmHandleTestController {
    @Autowired
    private SecurityAlarmHandleMapper mapper;

    /**
     * 方法1：insertOrUpdate
     * 测试条件：
     * - INSERT ... ON CONFLICT (agg_condition, window_id) DO UPDATE
     * - 完整6个字段
     */
    @GetMapping("/test1_insertOrUpdate")
    public String test1_insertOrUpdate() {
        try {
            System.out.println("测试: insertOrUpdate - 插入或更新告警处理记录");

            String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            String nowPlus1h = LocalDateTime.now().plusHours(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            
            // 测试数据1：新插入
            SecurityAlarmHandle handle1 = new SecurityAlarmHandle();
            handle1.setAggCondition("AGG-COND-TEST-001");
            handle1.setWindowId("WIN-TEST-001");
            handle1.setExecuteTime(nowPlus1h);
            handle1.setHandleStatus("pending");
            handle1.setResult(0);
            
            mapper.insertOrUpdate(handle1);
            System.out.println("  - 新插入: AGG-COND-TEST-001 + WIN-TEST-001");
            
            // 测试数据2：更新已存在的记录（测试ON CONFLICT）
            SecurityAlarmHandle handle2 = new SecurityAlarmHandle();
            handle2.setAggCondition("AGG-COND-001");  // test_data.sql中已存在
            handle2.setWindowId("WIN-2026-001");       // test_data.sql中已存在
            handle2.setExecuteTime(now);
            handle2.setHandleStatus("completed");
            handle2.setResult(1);  // 更新为已处置

            List<SecurityAlarmHandle> list1 = Arrays.asList(handle1);
            mapper.insertOrUpdate(list1);
            List<SecurityAlarmHandle> list2 = Arrays.asList(handle2);
            mapper.insertOrUpdate(list2);
            System.out.println("  - 更新: AGG-COND-001 + WIN-2026-001 (result false→true)");
            
            System.out.println("结果: 成功插入/更新 2 条");
            return "SUCCESS: 2条（1新插入+1更新）";
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_insertOrUpdate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：updateStatusById
     * 测试条件：
     * - 更新handle_status和result字段
     */
    @GetMapping("/test2_updateStatusById")
    public String test2_updateStatusById() {
        try {
            System.out.println("测试: updateStatusById - 更新处置状态");
            
            // 测试数据：更新test_data.sql中的记录（ID: 1003, status: processing→completed）
            SecurityAlarmHandle handle = new SecurityAlarmHandle();
            handle.setId(1003);  // test_data.sql中的数据
            handle.setHandleStatus("completed");
            handle.setResult(1);  // 标记为已完成
            
            mapper.updateStatusById(handle);
            System.out.println("  - 更新ID=1003: processing→completed, result=false→true");
            
            System.out.println("结果: 成功更新 1 条");
            return "SUCCESS: 1条（ID=1003状态更新）";
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_updateStatusById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
