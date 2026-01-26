package com.test.controller;

import com.dbapp.extension.xdr.traffic.mapper.AttackerTrafficTaskMapper;
import com.dbapp.extension.xdr.traffic.entity.AttackerTrafficTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

/**
 * AttackerTrafficTask 测试控制器
 * 对应XML方法：saveOrIgnoreBatch
 */
@RestController
@RequestMapping("/test/attacker-traffic-task")
public class AttackerTrafficTaskTestController {
    @Autowired
    private AttackerTrafficTaskMapper mapper;

    @GetMapping("/test-save-batch")
    public void testSaveBatch() {
        try {
            List<AttackerTrafficTask> tasks = new ArrayList<>();
            AttackerTrafficTask task = new AttackerTrafficTask();
            task.setTaskName("测试流量捕获");
            task.setAttackerIp("203.0.113.200");
            task.setTargetIp("192.168.1.100");
            task.setTrafficType("test");
            tasks.add(task);
            
            mapper.saveOrIgnoreBatch(tasks);
            System.out.println("✅ 批量保存成功");
        } catch (Exception e) {
            System.err.println("❌ 保存失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
