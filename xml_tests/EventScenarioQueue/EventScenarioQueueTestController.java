package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.EventScenarioQueueMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.ScenarioWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * EventScenarioQueue 测试 Controller
 * 
 * 所有测试方法使用 GET 请求，参数在方法内部写死
 * 通过 Postman 调用 http://localhost:8080/test/eventScenarioQueue/testX_methodName
 * 
 * 测试数据：使用test_data.sql中的测试事件
 * 
 * 生成时间: 2026-01-26
 */
@RestController
@RequestMapping("/test/eventScenarioQueue")
public class EventScenarioQueueTestController {
    
    @Autowired
    private EventScenarioQueueMapper mapper;

    /**
     * 测试1：查询最新未提交的记录
     * URL: /test/eventScenarioQueue/selectLast
     */
    @GetMapping("/selectLast")
    public String testSelectLast() {
        try {
            System.out.println("测试: selectLast");
            List<ScenarioWrapper> result = mapper.selectLast();
            System.out.println("结果: 共 " + result.size() + " 条未提交记录");
            for (ScenarioWrapper wrapper : result) {
                System.out.println("  - 事件code=" + wrapper.getEventCode()
                    + ", 关注IP=" + wrapper.getFocusIp()
                    + ", 目标IP=" + wrapper.getTargetIp()
                    + ", 模板ID=" + wrapper.getScenarioTemplateId()
                    + ", 是否已提交=" + wrapper.getIsJobCommit());
            }
            return "SUCCESS: 查询到 " + result.size() + " 条未提交记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectLast 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：批量插入（忽略重复）
     * URL: /test/eventScenarioQueue/insertIgnore
     */
    @GetMapping("/insertIgnore")
    public String testInsertIgnore() {
        try {
            System.out.println("测试: insertIgnore");
            
            List<ScenarioWrapper> datas = new ArrayList<>();
            
            // 构造测试数据1 - 新数据
            ScenarioWrapper data1 = new ScenarioWrapper();
            data1.setFocusIp("192.168.100.100");
            data1.setTargetIp("192.168.100.200");
            data1.setEventCode("EVT-TEST-2001");
            data1.setScenarioTemplateId(3001L);
            data1.setSrcAddress("192.168.100.100");
            data1.setDestAddress("192.168.100.200");
            data1.setStartTime(LocalDateTime.now().minusHours(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data1.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data1.setTimePart(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            data1.setAlarmInfoList("[{\"windowId\":\"W001\",\"aggCondition\":\"test\"}]");
            datas.add(data1);
            
            // 构造测试数据2 - 与test_data.sql中的数据冲突（会被忽略）
            ScenarioWrapper data2 = new ScenarioWrapper();
            data2.setFocusIp("192.168.1.100");
            data2.setTargetIp("192.168.1.200");
            data2.setEventCode("EVT-2026-001");
            data2.setScenarioTemplateId(1001L);
            data2.setSrcAddress("192.168.1.100");
            data2.setDestAddress("192.168.1.200");
            data2.setStartTime(LocalDateTime.now().minusHours(2).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data2.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data2.setTimePart(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            data2.setAlarmInfoList("[]");
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
     * 测试3：批量更新提交状态
     * URL: /test/eventScenarioQueue/updateSyncSuccessBatch
     */
    @GetMapping("/updateSyncSuccessBatch")
    public String testUpdateSyncSuccessBatch() {
        try {
            System.out.println("测试: updateSyncSuccessBatch");
            
            List<ScenarioWrapper> datas = new ArrayList<>();
            
            // 更新test_data.sql中的未提交记录
            ScenarioWrapper data1 = new ScenarioWrapper();
            data1.setFocusIp("192.168.1.100");
            data1.setTargetIp("192.168.1.200");
            data1.setEventCode("EVT-2026-001");
            data1.setScenarioTemplateId(1001L);
            datas.add(data1);
            
            ScenarioWrapper data2 = new ScenarioWrapper();
            data2.setFocusIp("192.168.1.101");
            data2.setTargetIp("192.168.1.201");
            data2.setEventCode("EVT-2026-002");
            data2.setScenarioTemplateId(1002L);
            datas.add(data2);
            
            mapper.updateSyncSuccessBatch(datas);
            System.out.println("更新成功: 将 " + datas.size() + " 条记录标记为已提交");
            return "SUCCESS: 更新 " + datas.size() + " 条记录的提交状态";
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateSyncSuccessBatch 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：清理旧数据
     * URL: /test/eventScenarioQueue/tryClean
     */
    @GetMapping("/tryClean")
    public String testTryClean() {
        try {
            System.out.println("测试: tryClean");
            
            // 删除3天前的数据
            String time = LocalDateTime.now().minusDays(3).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            
            int rows = mapper.tryClean(time);
            System.out.println("清理完成: 删除了 " + rows + " 条旧数据（早于 " + time + "）");
            return "SUCCESS: 清理了 " + rows + " 条旧数据";
        } catch (Exception e) {
            String errorMsg = "测试方法 testTryClean 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
