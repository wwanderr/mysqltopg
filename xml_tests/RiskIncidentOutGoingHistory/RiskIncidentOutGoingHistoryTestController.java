package com.test.controller;

import com.dbapp.extension.xdr.risk.mapper.RiskIncidentOutGoingHistoryMapper;
import com.dbapp.extension.xdr.risk.entity.RiskIncidentOutGoingHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/test/risk-incident-out-going-history")
public class RiskIncidentOutGoingHistoryTestController {
    @Autowired
    private RiskIncidentOutGoingHistoryMapper mapper;

    @GetMapping("/test-query-by-out-going")
    public String testQueryByOutGoing() {
        try {
            Long outGoingId = 1003L;
            List<RiskIncidentOutGoingHistory> result = mapper.selectByOutGoingId(outGoingId);
            System.out.println("✅ 查询外发重试历史，共 " + result.size() + " 条");
            return "重试历史：" + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            return "查询失败";
        }
    }
}
