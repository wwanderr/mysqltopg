package com.test.controller;

import com.dbapp.extension.xdr.auth.mapper.ThirdAuthMapper;
import com.dbapp.extension.xdr.auth.entity.ThirdAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/test/third-auth")
public class ThirdAuthTestController {

    @Autowired
    private ThirdAuthMapper mapper;

    @GetMapping("/test-query-enabled")
    public String testQueryEnabled() {
        try {
            List<ThirdAuth> result = mapper.selectByEnable(true);
            System.out.println("✅ 查询已启用的第三方认证，共 " + result.size() + " 个");
            return "已启用认证：" + result.size() + " 个";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            return "查询失败";
        }
    }
}
