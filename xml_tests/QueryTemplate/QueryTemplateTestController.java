package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.QueryTemplateMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.SecurityEventTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * QueryTemplate 测试 Controller
 * 
 * 所有测试方法使用 GET 请求，参数在方法内部写死
 * 通过 Postman 调用 http://localhost:8080/test/queryTemplate/testX_methodName
 * 
 * 生成时间: 2026-01-26
 */
@RestController
@RequestMapping("/test/queryTemplate")
public class QueryTemplateTestController {

    @Autowired
    private QueryTemplateMapper mapper;

    /**
     * 测试1：查询所有模板
     * URL: /test/queryTemplate/queryAllTemplate
     */
    @GetMapping("/queryAllTemplate")
    public String testQueryAllTemplate() {
        try {
            System.out.println("测试: queryAllTemplate");
            List<SecurityEventTemplate> result = mapper.queryAllTemplate();
            System.out.println("结果: 查询到 " + result.size() + " 条");
            return "SUCCESS: " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryAllTemplate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：根据ID更新模板
     * URL: /test/queryTemplate/updateById
     */
    @GetMapping("/updateById")
    public String testUpdateById() {
        try {
            System.out.println("测试: updateById");
            SecurityEventTemplate template = new SecurityEventTemplate();
            template.setId("template-001");
            template.setTemplateName("更新后的模板");
            
            mapper.updateById(template);
            System.out.println("更新成功");
            return "SUCCESS: 更新完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：根据ID查询模板
     * URL: /test/queryTemplate/queryTemplateById
     */
    @GetMapping("/queryTemplateById")
    public String testQueryTemplateById() {
        try {
            System.out.println("测试: queryTemplateById");
            SecurityEventTemplate result = mapper.queryTemplateById("template-001");
            if (result != null) {
                System.out.println("结果: " + result.getTemplateName());
                return "SUCCESS: " + result.getTemplateName();
            } else {
                return "未找到模板";
            }
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryTemplateById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
