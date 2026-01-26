package com.test.controller;

import com.dbapp.extension.xdr.query.mapper.QueryTemplateMapper;
import com.dbapp.extension.xdr.query.entity.QueryTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/test/query-template")
public class QueryTemplateTestController {

    @Autowired
    private QueryTemplateMapper mapper;

    @GetMapping("/test-query-enabled")
    public String testQueryEnabled() {
        try {
            List<QueryTemplate> result = mapper.selectByEnable(true);
            System.out.println("✅ 查询已启用模板，共 " + result.size() + " 个");
            for (QueryTemplate template : result) {
                System.out.println("  - " + template.getTemplateName() + " (" + template.getTemplateType() 
                    + ") | " + (template.getIsDefault() ? "默认" : "普通") + " | " + template.getCreator());
            }
            return "已启用模板：" + result.size() + " 个";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    @GetMapping("/test-query-default")
    public String testQueryDefault() {
        try {
            QueryTemplate result = mapper.selectDefault();
            if (result != null) {
                System.out.println("✅ 默认模板：" + result.getTemplateName());
                return "默认模板：" + result.getTemplateName();
            } else {
                return "未找到默认模板";
            }
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }
}
