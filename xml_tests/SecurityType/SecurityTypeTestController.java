package com.test.controller;

import com.dbapp.extension.xdr.security.mapper.SecurityTypeMapper;
import com.dbapp.extension.xdr.security.entity.SecurityType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * SecurityType (安全类型) 深度测试控制器
 * 主表：t_security_types (8个字段)
 * 测试方法数：3 (queryTypes, branchInsert, truncate)
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/securityType")
public class SecurityTypeTestController {
    @Autowired
    private SecurityTypeMapper mapper;

    /**
     * 方法1：queryTypes - 查询所有安全类型
     */
    @GetMapping("/test1_queryTypes")
    public String test1_queryTypes() {
        try {
            System.out.println("测试: queryTypes - 查询所有安全类型");
            List<SecurityType> result = mapper.queryTypes();
            System.out.println("结果: " + result.size() + " 个");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_queryTypes 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：branchInsert - 批量插入安全类型
     * 测试条件：<foreach collection="list">
     */
    @GetMapping("/test2_branchInsert")
    public String test2_branchInsert() {
        try {
            System.out.println("测试: branchInsert - 批量插入安全类型");
            List<SecurityType> typeList = new ArrayList<>();
            
            // 测试数据1：Web攻击类型
            SecurityType type1 = new SecurityType();
            type1.setSubCategory("/webAttackIncident/sqlInjection");
            type1.setCategory("/webAttackIncident");
            type1.setMirrorSubCategory("sql_injection");
            type1.setMirrorCategory("web_attack");
            type1.setSubCategoryName("SQL注入");
            type1.setCategoryName("Web攻击");
            type1.setIsEnable(true);
            typeList.add(type1);
            
            // 测试数据2：XSS攻击类型
            SecurityType type2 = new SecurityType();
            type2.setSubCategory("/webAttackIncident/xss");
            type2.setCategory("/webAttackIncident");
            type2.setMirrorSubCategory("xss_attack");
            type2.setMirrorCategory("web_attack");
            type2.setSubCategoryName("XSS跨站脚本");
            type2.setCategoryName("Web攻击");
            type2.setIsEnable(true);
            typeList.add(type2);
            
            mapper.branchInsert(typeList);
            System.out.println("结果: 插入 " + typeList.size() + " 个类型");
            return "SUCCESS: " + typeList.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_branchInsert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：truncate - 清空表数据（仅测试，已禁用）
     */
    @GetMapping("/test3_truncate")
    public String test3_truncate() {
        try {
            System.out.println("测试: truncate - 清空安全类型表");
            System.out.println("⚠️  警告：此操作会删除表中所有数据！");
            System.out.println("⚠️  测试环境专用，生产环境禁用！");
            
            // 取消注释以执行清空操作
            // mapper.truncate();
            
            System.out.println("✓ TRUNCATE操作已禁用（已注释）");
            return "SKIPPED: TRUNCATE操作已禁用";
        } catch (Exception e) {
            String errorMsg = "测试方法 test3_truncate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
