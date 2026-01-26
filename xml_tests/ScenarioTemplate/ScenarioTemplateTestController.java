package com.test.controller;

import com.dbapp.extension.xdr.scenario.mapper.ScenarioTemplateMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.ScenarioTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/test/scenario-template")
public class ScenarioTemplateTestController {
    @Autowired
    private ScenarioTemplateMapper mapper;

    @GetMapping("/test-batch-insert")
    public void testBatchInsert() {
        try {
            List<ScenarioTemplate> templates = new ArrayList<>();
            ScenarioTemplate template = new ScenarioTemplate();
            template.setTemplateName("测试场景模板");
            template.setScenarioType("test");
            template.setIsEnable(true);
            templates.add(template);
            
            mapper.batchInsert(templates);
            System.out.println("✅ 批量插入成功");
        } catch (Exception e) {
            System.err.println("❌ 插入失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
