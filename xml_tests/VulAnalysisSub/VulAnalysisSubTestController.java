package com.test.controller;

import com.dbapp.extension.xdr.vulnerability.mapper.VulAnalysisSubMapper;
import com.dbapp.extension.xdr.vulnerability.entity.VulAnalysisSub;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/test/vul-analysis-sub")
public class VulAnalysisSubTestController {

    @Autowired
    private VulAnalysisSubMapper mapper;

    @GetMapping("/test-query-critical")
    public String testQueryCritical() {
        try {
            List<VulAnalysisSub> result = mapper.selectByLevel("critical");
            System.out.println("✅ 查询严重漏洞，共 " + result.size() + " 个");
            for (VulAnalysisSub vul : result) {
                System.out.println("  - " + vul.getVulName() + " | " + vul.getCveId() 
                    + " | " + vul.getFixStatus() + " | " + vul.getResponsiblePerson());
            }
            return "严重漏洞：" + result.size() + " 个";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    @GetMapping("/test-count-unfixed")
    public String testCountUnfixed() {
        try {
            Long count = mapper.countByFixStatus("fixing,pending");
            System.out.println("✅ 未修复漏洞：" + count + " 个");
            return "未修复漏洞：" + count + " 个";
        } catch (Exception e) {
            System.err.println("❌ 统计失败：" + e.getMessage());
            e.printStackTrace();
            return "统计失败：" + e.getMessage();
        }
    }
}
