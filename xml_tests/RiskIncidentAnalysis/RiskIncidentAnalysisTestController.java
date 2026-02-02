package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentAnalysis;
import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentAnalysisMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * RiskIncidentAnalysis 测试控制器
 * 仅测试BaseMapper提供的基础CRUD方法
 * 生成时间: 2026-02-02
 */
@RestController
@RequestMapping("/test/riskIncidentAnalysis")
public class RiskIncidentAnalysisTestController {
    
    @Autowired
    private RiskIncidentAnalysisMapper mapper;

    /**
     * 测试1：selectById - 根据ID查询
     * URL: /test/riskIncidentAnalysis/selectById
     */
    @GetMapping("/selectById")
    public String testSelectById() {
        try {
            System.out.println("=== 测试: selectById ===");
            
            RiskIncidentAnalysis entity = mapper.selectById(10001L);
            System.out.println("✓ 查询ID=10001: " + (entity != null ? entity.getRiskIncidentsEventCode() : "null"));
            
            return "SUCCESS: " + (entity != null ? entity.getRiskIncidentsEventCode() : "未找到");
        } catch (Exception e) {
            System.err.println("❌ selectById 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"selectById 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：insert - 插入新记录
     * URL: /test/riskIncidentAnalysis/insert
     */
    @GetMapping("/insert")
    public String testInsert() {
        try {
            System.out.println("=== 测试: insert ===");
            
            RiskIncidentAnalysis entity = new RiskIncidentAnalysis();
            entity.setRiskIncidentsEventCode("RI-TEST-2026-999");
            entity.setStatus("todo");
            entity.setCoreRisks("测试核心风险");
            entity.setPopularInterpretation("测试通俗解读");
            
            int result = mapper.insert(entity);
            System.out.println("✓ 插入结果: " + result + ", 新ID: " + entity.getId());
            
            return "SUCCESS: 插入成功, ID=" + entity.getId();
        } catch (Exception e) {
            System.err.println("❌ insert 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"insert 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：updateById - 根据ID更新
     * URL: /test/riskIncidentAnalysis/updateById
     */
    @GetMapping("/updateById")
    public String testUpdateById() {
        try {
            System.out.println("=== 测试: updateById ===");
            
            RiskIncidentAnalysis entity = new RiskIncidentAnalysis();
            entity.setId(10001L);
            entity.setStatus("doing");
            entity.setCoreRisks("更新后的核心风险");
            
            int result = mapper.updateById(entity);
            System.out.println("✓ 更新结果: " + result + " 条记录");
            
            return "SUCCESS: 更新 " + result + " 条记录";
        } catch (Exception e) {
            System.err.println("❌ updateById 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"updateById 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：deleteById - 根据ID删除
     * URL: /test/riskIncidentAnalysis/deleteById
     */
    @GetMapping("/deleteById")
    public String testDeleteById() {
        try {
            System.out.println("=== 测试: deleteById ===");
            
            int result = mapper.deleteById(10002L);
            System.out.println("✓ 删除结果: " + result + " 条记录");
            
            return "SUCCESS: 删除 " + result + " 条记录";
        } catch (Exception e) {
            System.err.println("❌ deleteById 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"deleteById 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：selectList - 查询所有记录
     * URL: /test/riskIncidentAnalysis/selectList
     */
    @GetMapping("/selectList")
    public String testSelectList() {
        try {
            System.out.println("=== 测试: selectList ===");
            
            java.util.List<RiskIncidentAnalysis> list = mapper.selectList(null);
            System.out.println("✓ 查询结果: " + list.size() + " 条记录");
            
            return "SUCCESS: 共 " + list.size() + " 条记录";
        } catch (Exception e) {
            System.err.println("❌ selectList 失败: " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"selectList 执行失败\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
