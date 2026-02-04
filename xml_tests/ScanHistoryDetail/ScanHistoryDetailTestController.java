package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.ScanHistoryDetailMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.ScanHistoryDetail;
import com.dbapp.extension.xdr.linkageHandle.entity.ScanHistoryDetailVO;
import com.dbapp.extension.xdr.linkageHandle.entity.ScanStrategyParam;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.sql.Timestamp;
import java.util.*;

/**
 * ScanHistoryDetail 深度测试控制器
 * 对应5个XML方法，每个方法测试所有参数
 * 生成时间: 2026-01-28
 */
@RestController
@RequestMapping("/test/scanHistoryDetail")
public class ScanHistoryDetailTestController {
    
    @Autowired
    private ScanHistoryDetailMapper mapper;

    /**
     * 测试1：countLaunchTimesByStrategyId（测试foreach）
     * URL: /test/scanHistoryDetail/countLaunchTimesByStrategyId
     */
    @GetMapping("/countLaunchTimesByStrategyId")
    public String testCountLaunchTimesByStrategyId() {
        try {
            System.out.println("=== 测试: countLaunchTimesByStrategyId（foreach批量统计） ===");
            
            List<Long> strategyIds = Arrays.asList(6001L, 6002L, 6003L);
            List<BaseHistoryVO> result = mapper.countLaunchTimesByStrategyId(strategyIds);
            
            System.out.println("✓ 查询策略ID: " + strategyIds);
            for (BaseHistoryVO vo : result) {
                System.out.println("  - 策略ID=" + vo.getStrategyId() + ", 启动次数=" + vo.getCount());
            }
            
            return "SUCCESS: " + result.size() + " 个策略";
        } catch (Exception e) {
            String errorMsg = "测试方法 countLaunchTimesByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：insertBatch（测试foreach批量插入，使用正确字段）
     * URL: /test/scanHistoryDetail/insertBatch
     */
    @GetMapping("/insertBatch")
    public String testInsertBatch() {
        try {
            System.out.println("=== 测试: insertBatch（foreach批量插入） ===");
            
            List<ScanHistoryDetail> details = new ArrayList<>();
            
            // 插入记录1
            ScanHistoryDetail detail1 = new ScanHistoryDetail();
            detail1.setStrategyId(6001L);
            detail1.setNodeIp("192.168.100.100");
            detail1.setDeviceIp("10.0.1.100");
            detail1.setScanTime(new Timestamp(System.currentTimeMillis()));
            detail1.setScanScope("full");
            detail1.setScanPath(null);
            detail1.setScanType("virus");
            detail1.setStatus("正在扫描");
            detail1.setSource("test");
            details.add(detail1);
            
            // 插入记录2
            ScanHistoryDetail detail2 = new ScanHistoryDetail();
            detail2.setStrategyId(6002L);
            detail2.setNodeIp("10.20.30.100");
            detail2.setDeviceIp("10.0.2.200");
            detail2.setScanTime(new Timestamp(System.currentTimeMillis()));
            detail2.setScanScope("custom");
            detail2.setScanPath("/var/log");
            detail2.setScanType("site");
            detail2.setStatus("扫描完成");
            detail2.setSource("test");
            details.add(detail2);
            
            int rows = mapper.insertBatch(details);
            System.out.println("✓ 插入 " + rows + " 条记录");
            
            return "SUCCESS: 插入 " + rows + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 insertBatch 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：getIdsByStrategyId（简单查询）
     * URL: /test/scanHistoryDetail/getIdsByStrategyId
     */
    @GetMapping("/getIdsByStrategyId")
    public String testGetIdsByStrategyId() {
        try {
            System.out.println("=== 测试: getIdsByStrategyId ===");
            
            List<Long> result = mapper.getIdsByStrategyId(6001L);
            System.out.println("✓ 策略ID=6001, 历史记录数: " + result.size());
            
            return "SUCCESS: " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 getIdsByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：selectByOption（测试所有6个if条件 + LEFT JOIN）
     * URL: /test/scanHistoryDetail/selectByOption
     */
    @GetMapping("/selectByOption")
    public String testSelectByOption() {
        try {
            System.out.println("=== 测试: selectByOption（综合参数+JOIN） ===");

            // 场景1：所有if参数都有值
            ScanStrategyParam param1 = new ScanStrategyParam();
            param1.setStrategyName("病毒");
            param1.setDeviceIp("10.0.1");
            param1.setNodeIp("192.168");
            param1.setScanTypeList(Arrays.asList("virus", "site"));
            param1.setSourceList(Arrays.asList("manual", "auto"));
            param1.setStartTime("2025-01-01 00:00:00");
            param1.setEndTime("2026-12-31 23:59:59");

            Page<ScanHistoryDetailVO> page1 = new Page<>(1, 20);
            Page<ScanHistoryDetailVO> result1 = (Page<ScanHistoryDetailVO>) mapper.selectByOption(page1, param1);
            System.out.println("✓ 场景1（所有参数）: " + result1.getRecords().size() + " 条，总数=" + result1.getTotal());

            // 场景2：仅必需参数
            ScanStrategyParam param2 = new ScanStrategyParam();
            param2.setStartTime("2025-01-01 00:00:00");
            param2.setEndTime("2026-12-31 23:59:59");
            Page<ScanHistoryDetailVO> page2 = new Page<>(1, 50);
            Page<ScanHistoryDetailVO> result2 = (Page<ScanHistoryDetailVO>) mapper.selectByOption(page2, param2);
            System.out.println("✓ 场景2（仅时间范围）: " + result2.getRecords().size() + " 条，总数=" + result2.getTotal());

            // 场景3：scanTypeList/sourceList为空
            ScanStrategyParam param3 = new ScanStrategyParam();
            param3.setStrategyName("策略");
            param3.setScanTypeList(new ArrayList<>());
            param3.setSourceList(new ArrayList<>());
            param3.setStartTime("2025-01-01 00:00:00");
            param3.setEndTime("2026-12-31 23:59:59");
            Page<ScanHistoryDetailVO> page3 = new Page<>(1, 50);
            Page<ScanHistoryDetailVO> result3 = (Page<ScanHistoryDetailVO>) mapper.selectByOption(page3, param3);
            System.out.println("✓ 场景3（空list测试）: " + result3.getRecords().size() + " 条，总数=" + result3.getTotal());

            return "SUCCESS: page1=" + result1.getRecords().size()
                    + ", page2=" + result2.getRecords().size()
                    + ", page3=" + result3.getRecords().size();
        } catch (Exception e) {
            String errorMsg = "测试方法 selectByOption 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：selectScanIps（测试所有6个if条件）
     * URL: /test/scanHistoryDetail/selectScanIps
     */
    @GetMapping("/selectScanIps")
    public String testSelectScanIps() {
        try {
            System.out.println("=== 测试: selectScanIps（综合参数查询IP列表） ===");

            // 场景1：所有if参数
            ScanStrategyParam param1 = new ScanStrategyParam();
            param1.setStrategyName("病毒");
            param1.setDeviceIp("10.0");
            param1.setNodeIp("192");
            param1.setScanTypeList(Arrays.asList("virus"));
            param1.setSourceList(Arrays.asList("manual"));
            param1.setStartTime("2025-01-01 00:00:00");
            param1.setEndTime("2026-12-31 23:59:59");

            List<String> result1 = mapper.selectScanIps(param1);
            System.out.println("✓ 场景1（所有参数）: " + result1.size() + " 个IP");
            for (String ip : result1) {
                System.out.println("  - " + ip);
            }
            
            // 场景2：仅必需参数
            ScanStrategyParam param2 = new ScanStrategyParam();
            param2.setStartTime("2025-01-01 00:00:00");
            param2.setEndTime("2026-12-31 23:59:59");

            List<String> result2 = mapper.selectScanIps(param2);
            System.out.println("✓ 场景2（仅时间范围）: " + result2.size() + " 个IP");
            
            return "SUCCESS: 场景1=" + result1.size() + "个IP, 场景2=" + result2.size() + "个IP";
        } catch (Exception e) {
            String errorMsg = "测试方法 selectScanIps 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
