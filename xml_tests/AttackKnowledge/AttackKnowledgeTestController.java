package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.AttackKnowledgeMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.AttackKnowledge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * AttackKnowledge (攻击知识) 深度测试控制器
 * 主表：t_attack_knowledge (10个字段)
 * 测试方法数：9
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/attackKnowledge")
public class AttackKnowledgeTestController {
    @Autowired
    private AttackKnowledgeMapper mapper;

    /**
     * 方法1：selectListByParams - 按参数查询列表
     * 测试条件：3个if条件（os, perspective, type）
     */
    @GetMapping("/test1_selectListByParams")
    public String test1_selectListByParams() {
        try {
            System.out.println("测试: selectListByParams - 按参数查询攻击知识");
            String os = "Windows";
            String perspective = "enterprise";
            String type = "endpoint";
            
            List<AttackKnowledge> result = mapper.selectListByParams(os, perspective, type);
            System.out.println("结果: " + result.size() + " 条");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_selectListByParams 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：selectByparentCode - 按父代码查询
     */
    @GetMapping("/test2_selectByparentCode")
    public String test2_selectByparentCode() {
        try {
            System.out.println("测试: selectByparentCode - 按父代码查询");
            String parentCode = "TA0001";  // 初始访问战术
            
            List<AttackKnowledge> result = mapper.selectByparentCode(parentCode);
            System.out.println("结果: " + result.size() + " 条子技术");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_selectByparentCode 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：queryIdBytacticName - 按战术名称查询ID
     */
    @GetMapping("/test3_queryIdBytacticName")
    public String test3_queryIdBytacticName() {
        try {
            System.out.println("测试: queryIdBytacticName - 按战术名称查询ID");
            String tacticName = "Initial Access";
            
            String techniqueCode = mapper.queryIdBytacticName(tacticName);
            System.out.println("结果: " + techniqueCode);
            return "SUCCESS: " + techniqueCode;
        } catch (Exception e) {
            String errorMsg = "测试方法 test3_queryIdBytacticName 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法4：queryNameByCode - 按代码查询名称
     */
    @GetMapping("/test4_queryNameByCode")
    public String test4_queryNameByCode() {
        try {
            System.out.println("测试: queryNameByCode - 按代码查询名称");
            String tacticCode = "TA0001";
            
            String techniqueName = mapper.queryNameByCode(tacticCode);
            System.out.println("结果: " + techniqueName);
            return "SUCCESS: " + techniqueName;
        } catch (Exception e) {
            String errorMsg = "测试方法 test4_queryNameByCode 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法5：queryParentId - 查询父ID
     */
    @GetMapping("/test5_queryParentId")
    public String test5_queryParentId() {
        try {
            System.out.println("测试: queryParentId - 查询父ID");
            String techniquesId = "T1190";
            
            String parentCode = mapper.queryParentId(techniquesId);
            System.out.println("结果: " + parentCode);
            return "SUCCESS: " + parentCode;
        } catch (Exception e) {
            String errorMsg = "测试方法 test5_queryParentId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法6：selectTactic - 查询所有战术
     */
    @GetMapping("/test6_selectTactic")
    public String test6_selectTactic() {
        try {
            System.out.println("测试: selectTactic - 查询所有战术");
            
            List<String> tactics = mapper.selectTactic();
            System.out.println("结果: " + tactics.size() + " 个战术");
            return "SUCCESS: " + tactics.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test6_selectTactic 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法7：updateByCode - 按代码更新
     */
    @GetMapping("/test7_updateByCode")
    public String test7_updateByCode() {
        try {
            System.out.println("测试: updateByCode - 按代码更新");
            String techniqueCode = "T1190";
            String os = "Windows,Linux";
            String perspective = "enterprise";
            String deviceType = "endpoint,server";
            
            mapper.updateByCode(techniqueCode, os, perspective, deviceType);
            System.out.println("结果: 更新成功");
            return "SUCCESS: 1";
        } catch (Exception e) {
            String errorMsg = "测试方法 test7_updateByCode 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法8：batchInsert - 批量插入
     * 测试条件：<foreach collection="attackUpdateList">
     */
    @GetMapping("/test8_batchInsert")
    public String test8_batchInsert() {
        try {
            System.out.println("测试: batchInsert - 批量插入攻击知识");
            List<AttackKnowledge> attackUpdateList = new ArrayList<>();
            
            AttackKnowledge knowledge1 = new AttackKnowledge();
            knowledge1.setTechniqueCode("TEST001");
            knowledge1.setTechniqueName("Test Attack Technique 1");
            knowledge1.setTechniqueNameCh("测试攻击技术1");
            knowledge1.setParentCode("TA0001");
            knowledge1.setLevel("technique");
            knowledge1.setOs("Windows");
            knowledge1.setPerspective("enterprise");
            knowledge1.setDeviceType("endpoint");
            knowledge1.setSort(1);
            attackUpdateList.add(knowledge1);
            
            AttackKnowledge knowledge2 = new AttackKnowledge();
            knowledge2.setTechniqueCode("TEST002");
            knowledge2.setTechniqueName("Test Attack Technique 2");
            knowledge2.setTechniqueNameCh("测试攻击技术2");
            knowledge2.setParentCode("TA0002");
            knowledge2.setLevel("technique");
            knowledge2.setOs("Linux");
            knowledge2.setPerspective("enterprise");
            knowledge2.setDeviceType("server");
            knowledge2.setSort(2);
            attackUpdateList.add(knowledge2);
            
            mapper.batchInsert(attackUpdateList);
            System.out.println("结果: 插入 " + attackUpdateList.size() + " 条");
            return "SUCCESS: " + attackUpdateList.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test8_batchInsert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法9：truncateTable - 清空表（已禁用）
     */
    @GetMapping("/test9_truncateTable")
    public String test9_truncateTable() {
        try {
            System.out.println("测试: truncateTable - 清空表");
            System.out.println("⚠️  警告：此操作会删除表中所有数据！");
            System.out.println("⚠️  测试环境专用，生产环境禁用！");
            
            // 取消注释以执行清空操作
            // mapper.truncateTable();
            
            System.out.println("✓ TRUNCATE操作已禁用（已注释）");
            return "SKIPPED: TRUNCATE操作已禁用";
        } catch (Exception e) {
            String errorMsg = "测试方法 test9_truncateTable 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
