package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.KillProcessHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.KillProcessHistory;
import com.dbapp.extension.xdr.linkageHandle.entity.KillProcessParam;
import org.apache.commons.lang3.tuple.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * KillProcessHistory 测试控制器
 * 对应XML方法：batchInsert, countLaunchTimesByStrategyId, selectPage, delete
 */
@RestController
@RequestMapping("/test/killProcessHistory")
public class KillProcessHistoryTestController {
    @Autowired
    private KillProcessHistoryMapper mapper;

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

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
            List<Long> strategyIds = Arrays.asList(2001L, 2002L, 2003L);  // 使用 test_data.sql 中的策略ID
            
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

    /**
     * 测试3：selectPage - 分页查询进程终止历史
     * URL: /test/killProcessHistory/test3-selectPage
     * 
     * 测试场景：
     * - 测试各种查询条件（nodeIp, deviceIp, strategyName, image, processId, action, source, 时间范围）
     */
    @GetMapping("/test3-selectPage")
    public String testSelectPage() {
        try {
            System.out.println("✅ 测试: selectPage");
            
            KillProcessParam param = new KillProcessParam();
            // 设置查询条件（可以根据 test_data.sql 中的数据调整）
            param.setNodeIp("192.168.50");  // LIKE 查询
            param.setDeviceIp("192.168.1");  // LIKE 查询
            param.setStrategyName("进程终止策略");  // LIKE 查询
            param.setImage("malware");  // LIKE 查询
            param.setProcessId("1234");  // LIKE 查询
            param.setAction("病毒查杀");  // IN 查询（枚举值）
            param.setSource("auto");  // IN 查询
            
            // 设置时间范围（最近7天）
            LocalDateTime endTime = LocalDateTime.now();
            LocalDateTime startTime = endTime.minusDays(7);
            param.setStartTime(startTime.format(FORMATTER));
            param.setEndTime(endTime.format(FORMATTER));
            
            long page = 1L;
            long size = 10L;
            
            Pair<Long, List<KillProcessHistory>> result = mapper.selectPage(param, page, size);
            Long total = result.getLeft();
            List<KillProcessHistory> records = result.getRight();
            
            System.out.println("✅ selectPage 执行成功");
            System.out.println("  总记录数: " + total);
            System.out.println("  当前页记录数: " + records.size());
            System.out.println("  页码: " + page + ", 每页大小: " + size);
            
            for (int i = 0; i < Math.min(records.size(), 5); i++) {
                KillProcessHistory history = records.get(i);
                System.out.println(String.format("  记录[%d]: id=%d, nodeIp=%s, deviceIp=%s, strategyName=%s, action=%s",
                    i + 1, history.getId(), history.getNodeIp(), history.getDeviceIp(), 
                    history.getStrategyName(), history.getAction()));
            }
            
            return String.format("SUCCESS: 总记录数=%d, 当前页记录数=%d (页码=%d, 每页大小=%d)", 
                total, records.size(), page, size);
        } catch (Exception e) {
            String msg = "❌ testSelectPage 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试4：delete - 根据条件删除进程终止历史
     * URL: /test/killProcessHistory/test4-delete
     * 
     * 测试场景：
     * - 测试各种删除条件（nodeIp, deviceIp, strategyName, image, processId, action, source, id, ids）
     * - 注意：此操作会实际删除数据，建议在测试环境使用
     */
    @GetMapping("/test4-delete")
    public String testDelete() {
        try {
            System.out.println("⚠️  测试: delete（将实际删除数据）");
            
            KillProcessParam param = new KillProcessParam();
            // 设置删除条件（使用测试数据中的值）
            param.setNodeIp("192.168.50.200");  // 精确匹配特定节点
            param.setAction("病毒查杀");  // 枚举值
            param.setSource("auto");  // 来源
            
            // 或者使用 ID 删除
            // param.setId(4001L);
            // param.setIds("4001,4002,4003");
            
            int deletedRows = mapper.delete(param);
            
            System.out.println("✅ delete 执行成功");
            System.out.println("  删除条件: nodeIp=" + param.getNodeIp() + ", action=" + param.getAction() + ", source=" + param.getSource());
            System.out.println("  删除记录数: " + deletedRows);
            
            return String.format("SUCCESS: 删除记录数=%d (删除条件: nodeIp=%s, action=%s, source=%s)", 
                deletedRows, param.getNodeIp(), param.getAction(), param.getSource());
        } catch (Exception e) {
            String msg = "❌ testDelete 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试5：delete - 根据ID删除（精确删除）
     * URL: /test/killProcessHistory/test5-deleteById
     */
    @GetMapping("/test5-deleteById")
    public String testDeleteById() {
        try {
            System.out.println("⚠️  测试: delete by ID（将实际删除数据）");
            
            KillProcessParam param = new KillProcessParam();
            // 使用 ID 删除（精确删除）
            param.setId(4001L);  // 删除指定ID的记录
            
            int deletedRows = mapper.delete(param);
            
            System.out.println("✅ delete by ID 执行成功");
            System.out.println("  删除ID: " + param.getId());
            System.out.println("  删除记录数: " + deletedRows);
            
            return String.format("SUCCESS: 删除记录数=%d (删除ID=%d)", deletedRows, param.getId());
        } catch (Exception e) {
            String msg = "❌ testDeleteById 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试6：delete - 根据多个ID删除
     * URL: /test/killProcessHistory/test6-deleteByIds
     */
    @GetMapping("/test6-deleteByIds")
    public String testDeleteByIds() {
        try {
            System.out.println("⚠️  测试: delete by IDs（将实际删除数据）");
            
            KillProcessParam param = new KillProcessParam();
            // 使用多个 ID 删除（逗号分隔）
            param.setIds("4002,4003,4004");  // 删除多个ID的记录
            
            int deletedRows = mapper.delete(param);
            
            System.out.println("✅ delete by IDs 执行成功");
            System.out.println("  删除IDs: " + param.getIds());
            System.out.println("  删除记录数: " + deletedRows);
            
            return String.format("SUCCESS: 删除记录数=%d (删除IDs=%s)", deletedRows, param.getIds());
        } catch (Exception e) {
            String msg = "❌ testDeleteByIds 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }
}
