package com.test.controller;

import com.dbapp.extension.xdr.auth.mapper.ThirdAuthMapper;
import com.dbapp.extension.xdr.auth.entity.ThirdAuth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/test/thirdAuth")
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

    /**
     * 测试1：获取第三方认证票据 - 按机器码查询
     * 条件分支测试：<when test="machineCode != null and machineCode != ''">
     * 预期：使用 machine_code 进行精确匹配
     */
    @GetMapping("/testGetThirdAuthByMachineCode")
    public String testGetThirdAuth_ByMachineCode() {
        try {
            System.out.println("测试: getThirdAuth - 按机器码查询");
            
            String machineCode = "MACHINE-001";  // 测试机器码
            String result = mapper.getThirdAuth(machineCode, null);
            
            if (result != null) {
                System.out.println("结果: 找到票据 " + result.substring(0, Math.min(20, result.length())) + "...");
                return "SUCCESS: 按机器码查询到票据";
            } else {
                System.out.println("结果: 未找到票据");
                return "SUCCESS: 未找到票据";
            }
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetThirdAuth_ByMachineCode 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：获取第三方认证票据 - 按IP查询
     * 条件分支测试：<otherwise> #{ip} = ANY(string_to_array(ip, ',')) </otherwise>
     * 预期：machineCode 为空时，使用 IP 进行数组匹配
     */
    @GetMapping("/testGetThirdAuthByIp")
    public String testGetThirdAuth_ByIp() {
        try {
            System.out.println("测试: getThirdAuth - 按IP查询 (machineCode 为空)");
            
            String ip = "192.168.1.100";  // 测试IP
            String result = mapper.getThirdAuth(null, ip);  // machineCode 传 null
            
            if (result != null) {
                System.out.println("结果: 找到票据 " + result.substring(0, Math.min(20, result.length())) + "...");
                return "SUCCESS: 按IP查询到票据";
            } else {
                System.out.println("结果: 未找到票据");
                return "SUCCESS: 未找到票据";
            }
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetThirdAuth_ByIp 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
