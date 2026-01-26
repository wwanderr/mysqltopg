package com.test.controller;

import com.dbapp.extension.xdr.security.mapper.SecurityZoneSyncMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/test/security-zone-sync")
public class SecurityZoneSyncTestController {
    @Autowired
    private SecurityZoneSyncMapper mapper;

    @GetMapping("/test-query-zones")
    public String testQueryZones() {
        try {
            Map<String, Object> params = new HashMap<>();
            List<Map<String, Object>> result = mapper.querySecurityZone(params);
            System.out.println("✅ 查询安全域，共 " + result.size() + " 个");
            return "安全域：" + result.size() + " 个";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败";
        }
    }
}
