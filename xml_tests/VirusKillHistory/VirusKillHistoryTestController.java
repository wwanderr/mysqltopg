package com.test.controller;

import com.dbapp.extension.xdr.virus.mapper.VirusKillHistoryMapper;
import com.dbapp.extension.xdr.virus.entity.VirusKillHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/test/virusKillHistory")
public class VirusKillHistoryTestController {
    @Autowired
    private VirusKillHistoryMapper mapper;

    @GetMapping("/test-batch-insert")
    public void testBatchInsert() {
        try {
            List<VirusKillHistory> historyList = new ArrayList<>();
            VirusKillHistory history = new VirusKillHistory();
            history.setHostIp("192.168.50.200");
            history.setVirusName("Test.Trojan");
            history.setVirusPath("C:\\Temp\\test.exe");
            history.setVirusType("trojan");
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
