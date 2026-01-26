package com.test.controller;

import com.dbapp.extension.xdr.event.mapper.EventOutGoingMapper;
import com.dbapp.extension.xdr.outgoingData.po.EventOutGoingData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

/**
 * EventOutGoing 测试控制器
 * 对应XML方法：batchInsert
 */
@RestController
@RequestMapping("/test/event-out-going")
public class EventOutGoingTestController {
    @Autowired
    private EventOutGoingMapper mapper;

    @GetMapping("/test-batch-insert")
    public void testBatchInsert() {
        try {
            List<EventOutGoingData> dataList = new ArrayList<>();
            EventOutGoingData data = new EventOutGoingData();
            data.setEventId(1001L);
            data.setOutGoingType("test");
            data.setOutGoingAddr("http://test.com");
            dataList.add(data);
            
            mapper.batchInsert(dataList);
            System.out.println("✅ 批量插入成功");
        } catch (Exception e) {
            System.err.println("❌ 插入失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
