package com.test.controller;

import com.dbapp.extension.xdr.scan.mapper.ScanHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.ScanHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * ScanHistory (扫描历史) 深度测试控制器
 * 主表：t_scan_history (16个字段，3个ENUM类型)
 * 测试方法数：1 (upsertBatch)
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/scanHistory")
public class ScanHistoryTestController {
    @Autowired
    private ScanHistoryMapper mapper;

    /**
     * 方法1：upsertBatch
     * 测试条件：
     * - INSERT ... ON CONFLICT (node_ip) DO UPDATE
     * - 3个ENUM类型: node_os, virus_status, site_status, vulnerability_status
     * - <foreach collection="list">
     */
    @GetMapping("/testUpsertBatch")
    public String testUpsertBatch() {
        try {
            System.out.println("测试: upsertBatch - 批量插入或更新扫描历史");
            List<ScanHistory> historyList = new ArrayList<>();
            
            // 测试数据1：Windows终端，所有扫描完成
            ScanHistory history1 = new ScanHistory();
            history1.setNodeIp("192.168.100.100");
            history1.setNodeId("NODE-TEST-001");
            history1.setNodeOs("Windows");
            history1.setDeviceId("DEV-TEST-001");
            history1.setDeviceIp("192.168.1.10");
            history1.setDeviceType("EDR");
            history1.setLastScanTime(new Timestamp(System.currentTimeMillis()));
            history1.setScanTimes(1);
            history1.setVirusStatus("扫描完成");
            history1.setSiteStatus("扫描完成");
            history1.setVulnerabilityStatus("扫描完成");
            history1.setVirusResultNum(5);
            history1.setSiteResultNum(3);
            history1.setVulnerabilityResultNum(10);
            history1.setTotalResultNum(18);
            historyList.add(history1);
            
            // 测试数据2：Linux终端，正在扫描
            ScanHistory history2 = new ScanHistory();
            history2.setNodeIp("192.168.100.200");
            history2.setNodeId("NODE-TEST-002");
            history2.setNodeOs("Linux");
            history2.setDeviceId("DEV-TEST-002");
            history2.setDeviceIp("192.168.1.11");
            history2.setDeviceType("Scanner");
            history2.setLastScanTime(new Timestamp(System.currentTimeMillis()));
            history2.setScanTimes(1);
            history2.setVirusStatus("正在扫描");
            history2.setSiteStatus("正在扫描");
            history2.setVulnerabilityStatus("无下发记录");
            history2.setVirusResultNum(0);
            history2.setSiteResultNum(0);
            history2.setVulnerabilityResultNum(0);
            history2.setTotalResultNum(0);
            historyList.add(history2);
            
            // 测试数据3：更新已存在的记录（测试ON CONFLICT）
            ScanHistory history3 = new ScanHistory();
            history3.setNodeIp("192.168.10.100");  // test_data.sql中已存在
            history3.setNodeId("NODE-WIN-001");
            history3.setNodeOs("Windows");
            history3.setDeviceId("DEV-001");
            history3.setDeviceIp("192.168.1.1");
            history3.setDeviceType("EDR");
            history3.setLastScanTime(new Timestamp(System.currentTimeMillis()));
            history3.setScanTimes(6);  // 更新scan_times从5到6
            history3.setVirusStatus("扫描完成");
            history3.setSiteStatus("扫描完成");
            history3.setVulnerabilityStatus("扫描完成");
            history3.setVirusResultNum(4);  // 更新结果数
            history3.setSiteResultNum(3);
            history3.setVulnerabilityResultNum(20);
            history3.setTotalResultNum(27);
            historyList.add(history3);
            
            mapper.upsertBatch(historyList);
            System.out.println("结果: 成功批量插入/更新 " + historyList.size() + " 条扫描历史记录");
            System.out.println("  - 新插入: 2条（Windows+Linux）");
            System.out.println("  - 更新: 1条（node_ip=192.168.10.100，scan_times 5→6）");
            return "SUCCESS: " + historyList.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpsertBatch 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
