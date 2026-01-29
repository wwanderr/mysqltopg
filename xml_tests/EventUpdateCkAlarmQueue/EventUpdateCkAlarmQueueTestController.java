package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.EventUpdateCkAlarmQueueMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.TEventUpdateCkAlarmQueue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * EventUpdateCkAlarmQueue 测试 Controller
 * 
 * 所有测试方法使用 GET 请求，参数在方法内部写死
 * 通过 Postman 调用 http://localhost:8080/test/eventUpdateCkAlarmQueue/testX_methodName
 * 
 * 测试数据：使用test_data.sql中的测试数据
 * 
 * 生成时间: 2026-01-26
 */
@RestController
@RequestMapping("/test/eventUpdateCkAlarmQueue")
public class EventUpdateCkAlarmQueueTestController {
    
    @Autowired
    private EventUpdateCkAlarmQueueMapper mapper;

    /**
     * 测试1：查询最新未同步的记录
     * URL: /test/eventUpdateCkAlarmQueue/selectLast
     */
    @GetMapping("/selectLast")
    public String testSelectLast() {
        try {
            System.out.println("测试: selectLast");
            List<Map<String, Object>> result = mapper.selectLast();
            System.out.println("结果: 共 " + result.size() + " 条未同步记录");
            for (Map<String, Object> record : result) {
                System.out.println("  - windowId=" + record.get("windowId")
                    + ", aggCondition=" + record.get("aggCondition")
                    + ", eventId=" + record.get("eventId")
                    + ", timePart=" + record.get("timePart"));
            }
            return "SUCCESS: 查询到 " + result.size() + " 条未同步记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectLast 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：批量插入（忽略重复）
     * URL: /test/eventUpdateCkAlarmQueue/insertIgnore
     */
    @GetMapping("/insertIgnore")
    public String testInsertIgnore() {
        try {
            System.out.println("测试: insertIgnore");
            
            List<TEventUpdateCkAlarmQueue> datas = new ArrayList<>();
            
            // 构造测试数据1 - 新数据
            TEventUpdateCkAlarmQueue data1 = new TEventUpdateCkAlarmQueue();
            data1.setWindowId("WIN-TEST-2001");
            data1.setAggCondition("cond-test-2001");
            data1.setTimePart(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            data1.setEventId("EVT-TEST-2001");
            data1.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            datas.add(data1);
            
            // 构造测试数据2 - 与test_data.sql中的数据冲突（会被忽略）
            TEventUpdateCkAlarmQueue data2 = new TEventUpdateCkAlarmQueue();
            data2.setWindowId("WIN-2026-001");
            data2.setAggCondition("cond-2026-001");
            data2.setTimePart(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            data2.setEventId("EVT-001");
            data2.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            datas.add(data2);
            
            int rows = mapper.insertIgnore(datas);
            System.out.println("插入结果: 影响 " + rows + " 行（冲突的记录被忽略）");
            return "SUCCESS: 插入/忽略 " + rows + " 条记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 testInsertIgnore 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：批量更新同步状态
     * URL: /test/eventUpdateCkAlarmQueue/updateSyncSuccessBatch
     */
    @GetMapping("/updateSyncSuccessBatch")
    public String testUpdateSyncSuccessBatch() {
        try {
            System.out.println("测试: updateSyncSuccessBatch");
            
            List<TEventUpdateCkAlarmQueue> datas = new ArrayList<>();
            
            // 更新test_data.sql中的未同步记录
            TEventUpdateCkAlarmQueue data1 = new TEventUpdateCkAlarmQueue();
            data1.setWindowId("WIN-2026-001");
            data1.setAggCondition("cond-2026-001");
            datas.add(data1);
            
            TEventUpdateCkAlarmQueue data2 = new TEventUpdateCkAlarmQueue();
            data2.setWindowId("WIN-2026-002");
            data2.setAggCondition("cond-2026-002");
        datas.add(data2);
        
        mapper.updateSyncSuccessBatch(datas);
        System.out.println("更新成功: 将 " + datas.size() + " 条记录标记为已同步");
        return "SUCCESS: 更新 " + datas.size() + " 条记录的同步状态";
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateSyncSuccessBatch 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
