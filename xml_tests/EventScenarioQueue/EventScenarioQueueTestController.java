package com.test.controller;

import com.dbapp.extension.xdr.event.mapper.EventScenarioQueueMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.ScenarioWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/test/event-scenario-queue")
public class EventScenarioQueueTestController {
    @Autowired
    private EventScenarioQueueMapper mapper;

    @GetMapping("/test-select-last")
    public String testSelectLast() {
        try {
            ScenarioWrapper result = mapper.selectLast();
            if (result != null) {
                System.out.println("✅ 查询最新记录成功");
                return "查询成功";
            }
            return "无记录";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败";
        }
    }
}
