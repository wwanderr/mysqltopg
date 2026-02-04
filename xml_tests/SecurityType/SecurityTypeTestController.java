package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.SecurityTypeMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.SecurityType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * SecurityType (安全类型) 测试控制器
 * 主表：t_security_types (8个字段)
 * 关联表：t_event_template (queryTypes 查询此表)
 * 测试方法数：3 (queryTypes, branchInsert, truncate)
 * 根据反编译接口修复：2026-01-28
 */
@RestController
@RequestMapping("/test/securityType")
public class SecurityTypeTestController {
    @Autowired
    private SecurityTypeMapper mapper;

    /**
     * 方法1：queryTypes - 查询所有安全类型
     * 说明：从 t_event_template 表查询 DISTINCT incident_sub_class_type 和 incident_class_type
     */
    @GetMapping("/test1_queryTypes")
    public String test1_queryTypes() {
        try {
            System.out.println("测试: queryTypes - 查询所有安全类型（从 t_event_template 表）");
            List<SecurityType> result = mapper.queryTypes();
            System.out.println("结果: " + result.size() + " 个类型");
            if (result.size() > 0) {
                System.out.println("示例: " + result.get(0).getCategory() + " / " + result.get(0).getSubCategory());
            }
            return "SUCCESS: " + result.size() + " 个类型";
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_queryTypes 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：branchInsert - 批量插入安全类型
     * 说明：使用 ON CONFLICT (mirror_sub_category, mirror_category) 处理冲突
     * 注意：isEnable 使用 Integer 类型（1=启用, 0=禁用）
     */
    @GetMapping("/test2_branchInsert")
    public String test2_branchInsert() {
        try {
            System.out.println("测试: branchInsert - 批量插入安全类型");
            List<SecurityType> typeList = new ArrayList<>();
            
            // 测试数据1：Web攻击类型 - SQL注入
            SecurityType type1 = new SecurityType();
            type1.setSubCategory("/webAttackIncident/sqlInjection");
            type1.setCategory("/webAttackIncident");
            type1.setMirrorSubCategory("sql_injection");
            type1.setMirrorCategory("web_attack");
            type1.setSubCategoryName("SQL注入");
            type1.setCategoryName("Web攻击");
            type1.setIsEnable(1);  // Integer 类型：1=启用
            typeList.add(type1);
            
            // 测试数据2：Web攻击类型 - XSS
            SecurityType type2 = new SecurityType();
            type2.setSubCategory("/webAttackIncident/xss");
            type2.setCategory("/webAttackIncident");
            type2.setMirrorSubCategory("xss_attack");
            type2.setMirrorCategory("web_attack");
            type2.setSubCategoryName("XSS跨站脚本");
            type2.setCategoryName("Web攻击");
            type2.setIsEnable(1);
            typeList.add(type2);
            
            // 测试数据3：恶意软件类型 - 木马
            SecurityType type3 = new SecurityType();
            type3.setSubCategory("/malwareIncident/trojan");
            type3.setCategory("/malwareIncident");
            type3.setMirrorSubCategory("trojan_detection");
            type3.setMirrorCategory("malware");
            type3.setSubCategoryName("木马检测");
            type3.setCategoryName("恶意软件");
            type3.setIsEnable(1);
            typeList.add(type3);
            
            mapper.branchInsert(typeList);
            System.out.println("结果: 插入/更新 " + typeList.size() + " 个类型");
            return "SUCCESS: " + typeList.size() + " 个类型";
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_branchInsert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：truncate - 清空表数据（仅测试，已禁用）
     * 说明：清空 t_security_types 表的所有数据
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
