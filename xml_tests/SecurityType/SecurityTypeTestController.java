package com.test.controller;

import com.dbapp.extension.xdr.security.mapper.SecurityTypeMapper;
import com.dbapp.extension.xdr.security.entity.SecurityType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/test/security-type")
public class SecurityTypeTestController {

    @Autowired
    private SecurityTypeMapper mapper;

    @GetMapping("/test-query-all")
    public String testQueryAll() {
        try {
            List<SecurityType> result = mapper.selectAll();
            System.out.println("✅ 查询所有安全类型，共 " + result.size() + " 个");
            return "查询成功，共 " + result.size() + " 个安全类型";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            return "查询失败";
        }
    }
}
