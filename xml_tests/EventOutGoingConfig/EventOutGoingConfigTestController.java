package com.test.controller;

import com.dbapp.extension.xdr.event.mapper.EventOutGoingConfigMapper;
import com.dbapp.extension.xdr.outgoingData.po.EventOutGoingConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * EventOutGoingConfig 测试控制器
 * 对应XML方法：delById
 */
@RestController
@RequestMapping("/test/event-out-going-config")
public class EventOutGoingConfigTestController {
    @Autowired
    private EventOutGoingConfigMapper mapper;

    @GetMapping("/test-delete")
    public void testDelete() {
        try {
            EventOutGoingConfig config = new EventOutGoingConfig();
            config.setId(1003L);  // test_data.sql 中的测试配置
            
            mapper.delById(config);
            System.out.println("✅ 删除成功：ID=" + config.getId());
        } catch (Exception e) {
            System.err.println("❌ 删除失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
