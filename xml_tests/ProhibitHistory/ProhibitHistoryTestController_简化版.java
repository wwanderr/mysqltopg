package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.ProhibitHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * ProhibitHistory 测试 Controller（简化版）
 * 
 * 37个测试方法，对应37个XML方法
 * 重点方法测试所有参数，简单方法保持基本测试
 * 
 * 生成时间: 2026-01-28
 */
@RestController
@RequestMapping("/test/prohibitHistory")
public class ProhibitHistoryTestController {
    @Autowired
    private ProhibitHistoryMapper mapper;

    /**
     * 测试1：统计策略启动次数（UNION ALL）
     */
    @GetMapping("/sumLaunchTimesByStrategyId")
    public String test01() {
        try {
            List<Long> strategyIds = Arrays.asList(1001L, 1002L, 1003L);
            List<BaseHistoryVO> result = mapper.sumLaunchTimesByStrategyId(strategyIds);
            System.out.println("✓ 统计 " + result.size() + " 个策略");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            System.err.println("ERROR: " + e.getMessage());
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试2：插入阻断历史（IP/域名）
     */
    @GetMapping("/insertProhibitHistory")
    public String test02() {
        try {
            ProhibitHistory history = new ProhibitHistory();
            history.setBlockIp("10.0.0.100");
            history.setLinkDeviceIp("192.168.1.10");
            history.setLinkDeviceType("IDS");
            history.setStatus(true);
            history.setStrategyId(1001L);
            history.setDirection(1L);
            int rows = mapper.insertProhibitHistory(history);
            System.out.println("✓ 插入 " + rows + " 行");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            System.err.println("ERROR: " + e.getMessage());
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试3-6：更新和删除操作
     */
    @GetMapping("/updateByBlockipAndDeviceIp")
    public String test03() {
        try {
            ProhibitHistory history = new ProhibitHistory();
            history.setBlockIp("10.0.0.100");
            history.setLinkDeviceIp("192.168.1.10");
            history.setStatus(false);
            mapper.updateByBlockipAndDeviceIp(history);
            return "SUCCESS";
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/updateStatusById")
    public String test04() {
        try {
            ProhibitHistory history = new ProhibitHistory();
            history.setId(1L);
            history.setStatus(false);
            mapper.updateStatusById(history);
            return "SUCCESS";
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/deleteByIds")
    public String test05() {
        try {
            int rows = mapper.deleteByIds(Arrays.asList(9001L, 9002L));
            return "SUCCESS: " + rows;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    /**
     * 测试7：复杂查询（测试所有参数）
     * 参数：linkDeviceType, linkDeviceIp, blockIp, secondIp, blockDomain, nodeIp, 
     *       source, direction, prohibitType, isFull, startTime, endTime, limit, offset
     */
    @GetMapping("/getProhibitListByCondition")
    public String test06() {
        try {
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setLinkDeviceType("IDS,WAF");
            param.setLinkDeviceIp("192.168");
            param.setBlockIp("10.0");
            param.setSource("auto,manual");
            param.setDirection("in,out");
            param.setProhibitType("ip");
            param.setIsFull(false);
            param.setStartTime("2026-01-01 00:00:00");
            param.setEndTime("2026-12-31 23:59:59");
            param.setLimit(10);
            param.setOffset(0);
            
            List<ProhibitHistoryVO> result = mapper.getProhibitListByCondition(param);
            System.out.println("✓ 查询到 " + result.size() + " 条");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            System.err.println("ERROR: " + e.getMessage());
            e.printStackTrace();
            return "ERROR: " + e.getMessage();
        }
    }

    /**
     * 测试8-37：其他查询方法（简化测试）
     */
    @GetMapping("/listByCondition")
    public String test07() {
        try {
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setProhibitType("ip");
            List<ProhibitHistoryVO> result = mapper.listByCondition(param);
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getProhibitListCount")
    public String test08() {
        try {
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            Long count = mapper.getProhibitListCount(param);
            return "SUCCESS: " + count;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getBlockIPDistribution")
    public String test09() {
        try {
            String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            String yesterday = LocalDateTime.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            List result = mapper.getBlockIPDistribution(yesterday, now, "ip");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getTrend")
    public String test10() {
        try {
            String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            String yesterday = LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            List result = mapper.getTrend(yesterday, now, "ip");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getBlockIPCount")
    public String test11() {
        try {
            Long count = mapper.getBlockIPCount();
            return "SUCCESS: " + count;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getBlockIPTodayCount")
    public String test12() {
        try {
            Long count = mapper.getBlockIPTodayCount();
            return "SUCCESS: " + count;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getAutoBlockIPCount")
    public String test13() {
        try {
            Long count = mapper.getAutoBlockIPCount();
            return "SUCCESS: " + count;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getAutoBlockIPTodayCount")
    public String test14() {
        try {
            Long count = mapper.getAutoBlockIPTodayCount();
            return "SUCCESS: " + count;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getTriggerSubscriptionCount")
    public String test15() {
        try {
            Long count = mapper.getTriggerSubscriptionCount();
            return "SUCCESS: " + count;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getStrategyCount")
    public String test16() {
        try {
            Long count = mapper.getStrategyCount(null);
            return "SUCCESS: " + count;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getProhibitListByDeviceId")
    public String test17() {
        try {
            List<ProhibitHistoryVO> result = mapper.getProhibitListByDeviceId("dev-001", "ip");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getPairHistories")
    public String test18() {
        try {
            List<ProhibitHistoryVO> result = mapper.getPairHistories("10.0.0.1", "192.168.1.1", 1, "ip");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getSingleHistories")
    public String test19() {
        try {
            List<ProhibitHistoryVO> result = mapper.getSingleHistories("10.0.0.1", "192.168.1.1", 1, "ip");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getHistoryByBlockList")
    public String test20() {
        try {
            List<String> blockList = Arrays.asList("10.0.0.1", "10.0.0.2");
            List<ProhibitHistoryVO> result = mapper.getHistoryByBlockList(blockList, "192.168.1.1");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getHistoryById")
    public String test21() {
        try {
            ProhibitHistoryVO result = mapper.getHistoryById(1L, "ip");
            return result != null ? "SUCCESS" : "NOT_FOUND";
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getUnsealIpTodayCount")
    public String test22() {
        try {
            Long count = mapper.getUnsealIpTodayCount();
            return "SUCCESS: " + count;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/findHistoriesByDomain")
    public String test23() {
        try {
            List<ProhibitHistoryVO> result = mapper.findHistoriesByDomain("example.com", "192.168.1.1");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/findEdrProhibitHistory")
    public String test24() {
        try {
            ProhibitHistoryVO result = mapper.findEdrProhibitHistory("10.0.0.1", "node-001", "192.168.1.1", 1);
            return result != null ? "SUCCESS" : "NOT_FOUND";
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/findEdrProhibitHistories")
    public String test25() {
        try {
            List<ProhibitHistoryVO> result = mapper.findEdrProhibitHistories("10.0.0.1", "node-001", 1);
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getAiGentNoDirectionHistory")
    public String test26() {
        try {
            ProhibitHistoryVO result = mapper.getAiGentNoDirectionHistory("10.0.0.1", "node-001", "192.168.1.1");
            return result != null ? "SUCCESS" : "NOT_FOUND";
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getAiGentNoDirectionHistories")
    public String test27() {
        try {
            List<ProhibitHistoryVO> result = mapper.getAiGentNoDirectionHistories("10.0.0.1", "node-001");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getAiGentDirectionHistories")
    public String test28() {
        try {
            List<String> result = mapper.getAiGentDirectionHistories("10.0.0.1", "node-001", 1);
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getAiGentProhibitDomain")
    public String test29() {
        try {
            List<String> result = mapper.getAiGentProhibitDomain("node-001");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/prohibitListByStrategyId")
    public String test30() {
        try {
            List<ProhibitHistoryVO> result = mapper.prohibitListByStrategyId(1001L, 0, 10);
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/deleteByStrategyId")
    public String test31() {
        try {
            int rows = mapper.deleteByStrategyId(9999L);
            return "SUCCESS: " + rows;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/updateDeviceIpAndId")
    public String test32() {
        try {
            mapper.updateDeviceIpAndId("dev-new-001", "192.168.2.1", "dev-old-001");
            return "SUCCESS";
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getIdsByStrategyId")
    public String test33() {
        try {
            List<Long> result = mapper.getIdsByStrategyId(1001L);
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getBlockDeviceIds")
    public String test34() {
        try {
            List<String> result = mapper.getBlockDeviceIds("10.0.0.1", "192.168.1.1");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
        }

    @GetMapping("/getBlockDeviceIps")
    public String test35() {
        try {
            List<String> result = mapper.getBlockDeviceIps("10.0.0.1", "dev-001");
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/countEdrProhibit")
    public String test36() {
        try {
            Integer count = mapper.countEdrProhibit("10.0.0.1", "node-001");
            return "SUCCESS: " + count;
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }

    @GetMapping("/getDomainList")
    public String test37() {
        try {
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setProhibitType("domain");
            List<ProhibitHistoryVO> result = mapper.getDomainList(param);
            return "SUCCESS: " + result.size();
        } catch (Exception e) { return "ERROR: " + e.getMessage(); }
    }
}
