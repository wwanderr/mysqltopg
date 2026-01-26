package com.test.controller;

import com.dbapp.extension.xdr.risk.mapper.RiskIncidentOutGoingMapper;
import com.dbapp.extension.xdr.risk.entity.RiskIncidentOutGoing;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/test/risk-incident-out-going")
public class RiskIncidentOutGoingTestController {
    @Autowired
    private RiskIncidentOutGoingMapper mapper;

    @GetMapping("/test-query-failed")
    public String testQueryFailed() {
        try {
            List<RiskIncidentOutGoing> result = mapper.selectByStatus("failed");
            System.out.println("✅ 查询外发失败记录，共 " + result.size() + " 条");
            return "外发失败：" + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            return "查询失败";
        }
    }
}
