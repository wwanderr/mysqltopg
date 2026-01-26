package com.test.controller;

import com.dbapp.extension.xdr.scan.mapper.ScanHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.ScanHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ScanHistory 测试控制器
 * 对应XML方法：upsertBatch
 */
@RestController
@RequestMapping("/test/scan-history")
public class ScanHistoryTestController {
    @Autowired
    private ScanHistoryMapper mapper;

    @GetMapping("/test-upsert-batch")
    public void testUpsertBatch() {
        try {
            List<ScanHistory> historyList = new ArrayList<>();
            ScanHistory history = new ScanHistory();
            history.setScanType("test_scan");
            history.setScanTarget("192.168.1.0/24");
            history.setScanStatus("completed");
            historyList.add(history);
            
            mapper.upsertBatch(historyList);
            System.out.println("✅ 批量插入/更新成功");
        } catch (Exception e) {
            System.err.println("❌ 操作失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
