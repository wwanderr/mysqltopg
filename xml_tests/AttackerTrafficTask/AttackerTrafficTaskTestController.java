package com.test.controller;

import com.dbapp.extension.xdr.traffic.mapper.AttackerTrafficTaskMapper;
import com.dbapp.extension.xdr.traffic.entity.AttackerTrafficTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

/**
 * AttackerTrafficTask 测试控制器
 * 
 * 对应XML方法：saveOrIgnoreBatch
 * 
 * 表结构字段：
 * - ip: 攻击者IP
 * - date_part: 日期分区
 * - start_time: 首次计算时间
 * - time_offset: 当前计算时间
 * - history_time_offset: 历史时间偏移
 * - is_init: 是否计算当天开始时间前数据
 */
@RestController
@RequestMapping("/test/attackerTrafficTask")
public class AttackerTrafficTaskTestController {
    @Autowired
    private AttackerTrafficTaskMapper mapper;

    /**
     * 测试：批量保存或忽略攻击流量任务
     * 使用 test_data.sql 中的数据结构
     */
    @GetMapping("/test-save-batch")
    public void testSaveBatch() {
        try {
            List<AttackerTrafficTask> tasks = new ArrayList<>();
            
            // 构造符合实际表结构的数据
            AttackerTrafficTask task = new AttackerTrafficTask();
            task.setIp("192.0.2.100");  // 攻击者IP
            task.setDatePart("2026-01-26");  // 日期分区
            task.setStartTime("2026-01-26 13:00:00");  // 首次计算时间
            task.setTimeOffset("2026-01-26 13:15:00");  // 当前计算时间
            task.setHistoryTimeOffset("2026-01-26 12:00:00");  // 历史时间偏移
            task.setIsInit(false);  // 未初始化
            
            tasks.add(task);
            
            mapper.saveOrIgnoreBatch(tasks);
            
            System.out.println("✅ 批量保存成功：IP=" + task.getIp() 
                + ", 日期分区=" + task.getDatePart()
                + ", 是否初始化=" + task.getIsInit());
        } catch (Exception e) {
            System.err.println("❌ 保存失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
