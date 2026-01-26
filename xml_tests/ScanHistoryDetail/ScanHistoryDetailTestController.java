package com.test.controller;

import com.dbapp.extension.xdr.scan.mapper.ScanHistoryDetailMapper;
import com.dbapp.extension.xdr.scan.entity.ScanHistoryDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/test/scan-history-detail")
public class ScanHistoryDetailTestController {
    @Autowired
    private ScanHistoryDetailMapper mapper;

    @GetMapping("/test-insert-batch")
    public void testInsertBatch() {
        try {
            List<ScanHistoryDetail> details = new ArrayList<>();
            ScanHistoryDetail detail = new ScanHistoryDetail();
            detail.setScanId(1001L);
            detail.setTargetIp("192.168.1.100");
            detail.setTargetPort(80);
            detail.setVulName("测试漏洞");
            detail.setVulLevel("medium");
            details.add(detail);
            
            mapper.insertBatch(details);
            System.out.println("✅ 批量插入成功");
        } catch (Exception e) {
            System.err.println("❌ 插入失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
