package com.test.controller;

import com.dbapp.extension.xdr.strategy.mapper.LinkedStrategyValidtimeMapper;
import com.dbapp.extension.xdr.strategy.entity.LinkedStrategyValidtime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/test/linked-strategy-validtime")
public class LinkedStrategyValidtimeTestController {
    @Autowired
    private LinkedStrategyValidtimeMapper mapper;

    @GetMapping("/test-query-active")
    public String testQueryActive() {
        try {
            List<LinkedStrategyValidtime> result = mapper.selectActive();
            System.out.println("✅ 查询活跃策略有效期，共 " + result.size() + " 条");
            return "活跃有效期：" + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            return "查询失败";
        }
    }
}
