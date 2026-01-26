package com.test.controller;

import com.dbapp.extension.xdr.process.mapper.KillProcessHistoryMapper;
import com.dbapp.extension.xdr.process.entity.KillProcessHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

/**
 * KillProcessHistory 测试控制器
 * 对应XML方法：batchInsert, countLaunchTimesByStrategyId
 */
@RestController
@RequestMapping("/test/kill-process-history")
public class KillProcessHistoryTestController {
    @Autowired
    private KillProcessHistoryMapper mapper;

    @GetMapping("/test-batch-insert")
    public void testBatchInsert() {
        try {
            List<KillProcessHistory> historyList = new ArrayList<>();
            KillProcessHistory history = new KillProcessHistory();
            history.setHostIp("192.168.50.200");
            history.setProcessName("test.exe");
            history.setProcessPath("C:\\Temp\\test.exe");
            history.setKillReason("测试进程");
            history.setKillStatus("success");
            historyList.add(history);
            
            mapper.batchInsert(historyList);
            System.out.println("✅ 批量插入成功");
        } catch (Exception e) {
            System.err.println("❌ 插入失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
