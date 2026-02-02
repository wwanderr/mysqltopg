package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentOutGoingHistoryMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentOutGoingHistory;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/**
 * RiskIncidentOutGoingHistory 测试控制器
 * 主表：t_risk_incidents_out_going_history
 * Mapper: 只继承BaseMapper，测试基本CRUD方法
 * 生成时间：2026-01-30（根据反编译接口完全修复）
 */
@RestController
@RequestMapping("/test/riskIncidentOutGoingHistory")
public class RiskIncidentOutGoingHistoryTestController {
    
    @Autowired
    private RiskIncidentOutGoingHistoryMapper mapper;

    /**
     * 测试1：selectById - BaseMapper提供
     */
    @GetMapping("/testSelectById")
    public String testSelectById() {
        try {
            System.out.println("测试: selectById - 根据ID查询");
            
            RiskIncidentOutGoingHistory result = mapper.selectById(1001L);
            System.out.println("结果: " + (result != null ? "查询成功" : "无数据"));
            return "SUCCESS: " + (result != null ? "1" : "0");
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：selectList - BaseMapper提供
     */
    @GetMapping("/testSelectList")
    public String testSelectList() {
        try {
            System.out.println("测试: selectList - 条件查询列表");
            
            QueryWrapper<RiskIncidentOutGoingHistory> wrapper = new QueryWrapper<>();
            wrapper.ge("id", 1001);  // id >= 1001
            wrapper.le("id", 1010);  // id <= 1010
            
            List<RiskIncidentOutGoingHistory> result = mapper.selectList(wrapper);
            System.out.println("结果: 查询到 " + result.size() + " 条记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：selectCount - BaseMapper提供
     */
    @GetMapping("/testSelectCount")
    public String testSelectCount() {
        try {
            System.out.println("测试: selectCount - 统计数量");
            
            QueryWrapper<RiskIncidentOutGoingHistory> wrapper = new QueryWrapper<>();
            wrapper.like("event_code", "RISK-2026");
            
            Long count = mapper.selectCount(wrapper);
            System.out.println("结果: 总数=" + count);
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：selectBatchIds - BaseMapper提供
     */
    @GetMapping("/testSelectBatchIds")
    public String testSelectBatchIds() {
        try {
            System.out.println("测试: selectBatchIds - 批量ID查询");
            
            List<RiskIncidentOutGoingHistory> result = mapper.selectBatchIds(
                Arrays.asList(1001L, 1002L, 1003L)
            );
            System.out.println("结果: 查询到 " + result.size() + " 条记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectBatchIds 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：insert - BaseMapper提供
     */
    @GetMapping("/testInsert")
    public String testInsert() {
        try {
            System.out.println("测试: insert - 插入记录");
            
            RiskIncidentOutGoingHistory history = new RiskIncidentOutGoingHistory();
            history.setEventId(99999L);
            history.setUniqCode("TEST-UNIQ-CODE-" + System.currentTimeMillis());
            history.setEventCode("RISK-2026-TEST");
            history.setName("测试外发历史记录");
            // 设置其他必要字段...
            
            int rows = mapper.insert(history);
            System.out.println("结果: 插入 " + rows + " 条记录，ID=" + history.getId());
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 testInsert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试6：updateById - BaseMapper提供
     */
    @GetMapping("/testUpdateById")
    public String testUpdateById() {
        try {
            System.out.println("测试: updateById - 根据ID更新");
            
            RiskIncidentOutGoingHistory history = new RiskIncidentOutGoingHistory();
            history.setId(1001L);
            history.setName("更新后的名称");
            
            int rows = mapper.updateById(history);
            System.out.println("结果: 更新 " + rows + " 条记录");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试7：deleteById - BaseMapper提供
     */
    @GetMapping("/testDeleteById")
    public String testDeleteById() {
        try {
            System.out.println("测试: deleteById - 根据ID删除");
            
            int rows = mapper.deleteById(9999L);  // 不存在的ID
            System.out.println("结果: 删除 " + rows + " 条记录");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 testDeleteById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试8：delete - 条件删除 - BaseMapper提供
     */
    @GetMapping("/testDelete")
    public String testDelete() {
        try {
            System.out.println("测试: delete - 条件删除");
            
            QueryWrapper<RiskIncidentOutGoingHistory> wrapper = new QueryWrapper<>();
            wrapper.eq("event_code", "RISK-2026-TEST");  // 删除测试数据
            
            int rows = mapper.delete(wrapper);
            System.out.println("结果: 删除 " + rows + " 条记录");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 testDelete 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试汇总方法 - 执行所有测试
     */
    @GetMapping("/testAll")
    public String testAll() {
        StringBuilder result = new StringBuilder("开始执行所有测试...\n\n");
        int successCount = 0;
        int failCount = 0;

        String[] testMethods = {
            "testSelectById", "testSelectList", "testSelectCount", "testSelectBatchIds",
            "testInsert", "testUpdateById", "testDeleteById", "testDelete"
        };

        for (int i = 0; i < testMethods.length; i++) {
            String methodName = testMethods[i];
            try {
                String testResult = "";
                switch (i) {
                    case 0: testResult = testSelectById(); break;
                    case 1: testResult = testSelectList(); break;
                    case 2: testResult = testSelectCount(); break;
                    case 3: testResult = testSelectBatchIds(); break;
                    case 4: testResult = testInsert(); break;
                    case 5: testResult = testUpdateById(); break;
                    case 6: testResult = testDeleteById(); break;
                    case 7: testResult = testDelete(); break;
                }

                if (testResult.startsWith("SUCCESS")) {
                    result.append("✓ ").append(methodName).append(": ").append(testResult).append("\n");
                    successCount++;
                } else {
                    result.append("✗ ").append(methodName).append(": ").append(testResult).append("\n");
                    failCount++;
                }
            } catch (Exception e) {
                result.append("✗ ").append(methodName).append(": ERROR - ").append(e.getMessage()).append("\n");
                failCount++;
            }
        }

        result.append("\n测试汇总: 成功=").append(successCount).append(", 失败=").append(failCount);
        result.append(", 总计=").append(testMethods.length).append("\n");

        return result.toString();
    }
}
