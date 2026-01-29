package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.AlarmStatusTimingTaskMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.AlarmStatusTimingTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/test/alarmStatusTimingTask")
public class AlarmStatusTimingTaskTestController {
    @Autowired
    private AlarmStatusTimingTaskMapper mapper;

    /**
     * 测试：插入或更新定时任务
     * 使用 test_data.sql 中的场景数据
     */
    @GetMapping("/test-insert-or-update")
    public void testInsertOrUpdate() {
        try {
            AlarmStatusTimingTask task = new AlarmStatusTimingTask();
            task.setTaskType("auto_close");
            task.setAlarmStatus("open");
            task.setRemarks("自动关闭30天前的已处理告警");
            task.setOperator("system");
            task.setCondition("{\"days\": 30, \"handled\": true}");
            task.setCreateTime(LocalDateTime.now());
            task.setTaskEndTime(null);
            task.setAssociatedField("{\"field\": \"create_time\"}");
            
            mapper.insertOrUpdate(task);
            
            System.out.println("✅ 插入/更新成功：任务类型=" + task.getTaskType() 
                + ", 状态=" + task.getAlarmStatus()
                + ", 操作人=" + task.getOperator());
        } catch (Exception e) {
            System.err.println("❌ 插入/更新失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
