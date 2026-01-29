package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.KillProcessHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.KillProcessHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * KillProcessHistory 测试控制器
 * 对应XML方法：batchInsert, countLaunchTimesByStrategyId
 */
@RestController
@RequestMapping("/test/killProcessHistory")
public class KillProcessHistoryTestController {
    @Autowired
    private KillProcessHistoryMapper mapper;

    /**
     * 测试1：批量插入
     * URL: /test/killProcessHistory/batchInsert
     */
    @GetMapping("/batchInsert")
    public String testBatchInsert() {
        try {
            System.out.println("测试: batchInsert");
            List<KillProcessHistory> historyList = new ArrayList<>();
            
            KillProcessHistory history = new KillProcessHistory();
            history.setStrategyId(2001);
            history.setStrategyName("进程终止策略-测试");
            history.setNodeIp("192.168.50.200");
            history.setNodeId("node-test-001");
            history.setOsStr("Windows 10");
            history.setDeviceIp("192.168.1.10");
            history.setDeviceId("device-test-001");
            history.setDeviceType("endpoint");
            history.setAction("病毒查杀");  // 枚举值：'病毒查杀', '未知'
            history.setProcessId("1234");
            history.setImage("C:\\malware\\evil.exe");
            history.setSource("auto");
            historyList.add(history);
            
            int rows = mapper.batchInsert(historyList);
            System.out.println("结果: 插入 " + rows + " 条");
            return "SUCCESS: 插入 " + rows + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 testBatchInsert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：按策略ID统计启动次数
     * URL: /test/killProcessHistory/countLaunchTimesByStrategyId
     */
    @GetMapping("/countLaunchTimesByStrategyId")
    public String testCountLaunchTimesByStrategyId() {
        try {
            System.out.println("测试: countLaunchTimesByStrategyId");
            List<Integer> strategyIds = Arrays.asList(2001, 2002, 2003);  // 使用 test_data.sql 中的策略ID
            
            List<BaseHistoryVO> result = mapper.countLaunchTimesByStrategyId(strategyIds);
            System.out.println("结果: 共 " + result.size() + " 个策略的统计");
            for (BaseHistoryVO vo : result) {
                System.out.println("  - 策略ID=" + vo.getStrategyId() + ", 次数=" + vo.getCount());
            }
            return "SUCCESS: 查询到 " + result.size() + " 个策略";
        } catch (Exception e) {
            String errorMsg = "测试方法 testCountLaunchTimesByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
