package com.test.controller;

import com.dbapp.extension.xdr.isolation.mapper.IsolationHistoryMapper;
import com.dbapp.extension.xdr.isolation.entity.IsolationHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

/**
 * IsolationHistory 测试控制器
 * 对应XML方法：batchInsert, countLaunchTimesByStrategyId
 */
@RestController
@RequestMapping("/test/isolation-history")
public class IsolationHistoryTestController {
    @Autowired
    private IsolationHistoryMapper mapper;

    @GetMapping("/test-batch-insert")
    public void testBatchInsert() {
        try {
            List<IsolationHistory> historyList = new ArrayList<>();
            IsolationHistory history = new IsolationHistory();
            history.setIsolatedIp("192.168.50.200");
            history.setIsolatedReason("测试隔离");
            history.setIsolationMethod("network_isolation");
            history.setIsolationStatus("active");
            historyList.add(history);
            
            mapper.batchInsert(historyList);
            System.out.println("✅ 批量插入成功");
        } catch (Exception e) {
            System.err.println("❌ 插入失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
