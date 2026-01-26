package com.test.controller;

import com.dbapp.extension.xdr.login.mapper.LoginBaselineMapper;
import com.dbapp.extension.xdr.threatAnalysis.entity.LoginBaseline;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/test/login-baseline")
public class LoginBaselineTestController {
    @Autowired
    private LoginBaselineMapper mapper;

    @GetMapping("/test-query-by-key")
    public String testQueryByKey() {
        try {
            String userId = "user001";  // test_data.sql中的用户
            LoginBaseline result = mapper.queryByPrimaryKey(userId);
            if (result != null) {
                System.out.println("✅ 查询成功：用户=" + result.getUsername() + ", 状态=" + result.getStatus());
                return "查询成功：" + result.getUsername();
            }
            return "未找到用户";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败";
        }
    }
}
