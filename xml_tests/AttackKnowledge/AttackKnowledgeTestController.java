package com.test.controller;

import com.dbapp.extension.xdr.knowledge.mapper.AttackKnowledgeMapper;
import com.dbapp.extension.xdr.knowledge.entity.AttackKnowledge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AttackKnowledge 测试控制器
 * 对应XML方法：selectListByParams, selectByparentCode, batchInsert等
 */
@RestController
@RequestMapping("/test/attack-knowledge")
public class AttackKnowledgeTestController {
    @Autowired
    private AttackKnowledgeMapper mapper;

    @GetMapping("/test-query-list")
    public String testQueryList() {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("severity", "critical");
            List<AttackKnowledge> result = mapper.selectListByParams(params);
            System.out.println("✅ 查询攻击知识，共 " + result.size() + " 条");
            return "攻击知识：" + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败";
        }
    }
}
