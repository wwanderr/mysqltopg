package com.test.controller;

import com.dbapp.extension.xdr.shared.mapper.SharedDataMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/test/shared-data")
public class SharedDataTestController {
    @Autowired
    private SharedDataMapper mapper;

    @GetMapping("/test-query-today-update")
    public String testQueryTodayUpdate() {
        try {
            List<Map<String, Object>> result = mapper.queryTodayUpdateIpInformation();
            System.out.println("✅ 查询今日更新数据，共 " + result.size() + " 条");
            return "今日更新：" + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败";
        }
    }
}
