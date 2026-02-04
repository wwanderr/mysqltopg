package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.VirusKillHistory;
import com.dbapp.extension.xdr.linkageHandle.entity.VirusKillParam;
import com.dbapp.extension.xdr.linkageHandle.mapper.VirusKillHistoryMapper;
import org.apache.commons.lang3.tuple.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * VirusKillHistory 测试控制器
 * 覆盖 Mapper 全部方法：batchInsert / selectPage(default) / delete(default) / countLaunchTimesByStrategyId
 */
@RestController
@RequestMapping("/test/virusKillHistory")
public class VirusKillHistoryTestController {
    @Autowired
    private VirusKillHistoryMapper mapper;

    /**
     * 测试1：batchInsert
     */
    @GetMapping("/test1_batchInsert")
    public String test1_batchInsert() {
        try {
            System.out.println("测试: batchInsert - 批量插入病毒查杀历史");
            List<VirusKillHistory> list = new ArrayList<>();

            VirusKillHistory h1 = new VirusKillHistory();
            h1.setStrategyId(9001L);
            h1.setStrategyName("病毒查杀策略-A");
            h1.setNodeIp("10.10.1.10");
            h1.setNodeId("node-001");
            h1.setOsStr("Windows");
            h1.setDeviceIp("192.168.10.10");
            h1.setDeviceId("dev-edr-001");
            h1.setDeviceType("edr");
            h1.setAction("病毒查杀");
            h1.setHashes("hash-aaa,hash-bbb");
            h1.setSource("manual");
            list.add(h1);

            VirusKillHistory h2 = new VirusKillHistory();
            h2.setStrategyId(9002L);
            h2.setStrategyName("病毒查杀策略-B");
            h2.setNodeIp("10.10.1.11");
            h2.setNodeId("node-002");
            h2.setOsStr("Linux");
            h2.setDeviceIp("192.168.10.11");
            h2.setDeviceId("dev-edr-002");
            h2.setDeviceType("edr");
            h2.setAction("病毒查杀");
            h2.setHashes("hash-ccc");
            h2.setSource("auto");
            list.add(h2);

            mapper.batchInsert(list);
            System.out.println("结果: 插入 " + list.size() + " 条");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "test1_batchInsert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + errorMsg + "\",\"exception\":\"" + e.getClass().getName() + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：selectPage（default）
     */
    @GetMapping("/test2_selectPage")
    public String test2_selectPage() {
        try {
            System.out.println("测试: selectPage - 分页查询");
            VirusKillParam param = new VirusKillParam();
            param.setNodeIp("10.10.1.");
            param.setDeviceIp("192.168.10.");
            param.setStrategyName("病毒查杀策略");
            param.setHash("hash-");
            param.setAction("病毒查杀");
            param.setSource("manual,auto");
            // 这里 between 用字符串，保持与反编译一致；测试数据用 CURRENT_TIMESTAMP，范围给宽一点
            param.setStartTime("2000-01-01 00:00:00");
            param.setEndTime("2099-12-31 23:59:59");

            Pair<Long, List<VirusKillHistory>> page = mapper.selectPage(param, 1, 10);
            System.out.println("结果: total=" + page.getLeft() + ", records=" + page.getRight().size());
            return "SUCCESS: total=" + page.getLeft() + ", records=" + page.getRight().size();
        } catch (Exception e) {
            String errorMsg = "test2_selectPage 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + errorMsg + "\",\"exception\":\"" + e.getClass().getName() + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：countLaunchTimesByStrategyId
     */
    @GetMapping("/test3_countLaunchTimesByStrategyId")
    public String test3_countLaunchTimesByStrategyId() {
        try {
            System.out.println("测试: countLaunchTimesByStrategyId - 按策略统计");
            List<BaseHistoryVO> list = mapper.countLaunchTimesByStrategyId(Arrays.asList(9001L, 9002L, 9999L));
            System.out.println("结果: size=" + (list == null ? 0 : list.size()));
            return "SUCCESS: " + (list == null ? 0 : list.size());
        } catch (Exception e) {
            String errorMsg = "test3_countLaunchTimesByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + errorMsg + "\",\"exception\":\"" + e.getClass().getName() + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：delete（default）
     */
    @GetMapping("/test4_delete")
    public String test4_delete() {
        try {
            System.out.println("测试: delete - 条件删除");
            VirusKillParam param = new VirusKillParam();
            // 删除 strategyId=9002 的那条：按策略名 + deviceIp + source 精确命中
            param.setStrategyName("病毒查杀策略-B");
            param.setDeviceIp("192.168.10.11");
            param.setSource("auto");
            int rows = mapper.delete(param);
            System.out.println("结果: 删除 rows=" + rows);
            return "SUCCESS: rows=" + rows;
        } catch (Exception e) {
            String errorMsg = "test4_delete 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\":\"" + errorMsg + "\",\"exception\":\"" + e.getClass().getName() + "\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
