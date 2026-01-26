package com.test.controller;

import com.dbapp.extension.xdr.intelligence.mapper.IntelligenceMapper;
import com.dbapp.extension.xdr.intelligence.entity.Intelligence;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/test/intelligence")
public class IntelligenceTestController {

    @Autowired
    private IntelligenceMapper mapper;

    @GetMapping("/test-query-all")
    public String testQueryAll() {
        try {
            List<Intelligence> result = mapper.selectAll();
            System.out.println("✅ 查询成功，共 " + result.size() + " 条情报");
            return "查询成功，共 " + result.size() + " 条情报";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    @GetMapping("/test-query-active")
    public String testQueryActive() {
        try {
            List<Intelligence> result = mapper.selectByStatus("active");
            System.out.println("✅ 查询活跃情报成功，共 " + result.size() + " 条");
            for (Intelligence intel : result) {
                System.out.println("  - " + intel.getThreatIp() + " | " + intel.getThreatType() 
                    + " | " + intel.getThreatLevel() + " | 置信度:" + intel.getConfidence() + "%");
            }
            return "活跃情报：" + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }
}
