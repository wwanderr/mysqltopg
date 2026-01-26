package com.test.controller;

import com.dbapp.extension.xdr.risk.mapper.RiskIncidentHistoryMapper;
import com.dbapp.extension.xdr.risk.entity.RiskIncidentHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/test/risk-incident-history")
public class RiskIncidentHistoryTestController {
    @Autowired
    private RiskIncidentHistoryMapper mapper;

    @GetMapping("/test-query-by-incident")
    public String testQueryByIncident() {
        try {
            Long incidentId = 1001L;
            List<RiskIncidentHistory> result = mapper.selectByIncidentId(incidentId);
            System.out.println("✅ 查询事件历史，共 " + result.size() + " 条");
            return "事件历史：" + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            return "查询失败";
        }
    }
}
