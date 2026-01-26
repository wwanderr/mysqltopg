package com.test.controller;

import com.dbapp.extension.xdr.outgoingData.mapper.OutGoingConfigMapper;
import com.dbapp.extension.xdr.outgoingData.po.OutGoingConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * OutGoingConfig 测试控制器
 * 
 * 测试说明：
 * 1. 所有方法使用 GET 请求
 * 2. 参数已硬编码，无需 Postman 传参
 * 3. 测试数据参考：test_data.sql 中的场景
 */
@RestController
@RequestMapping("/test/outgoing-config")
public class OutGoingConfigTestController {

    @Autowired
    private OutGoingConfigMapper mapper;

    /**
     * 测试1：查询所有外发配置
     */
    @GetMapping("/test-query-all")
    public String testSelectOutGoingConfig() {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("isEnable", true);  // 查询已启用的配置
            
            List<OutGoingConfig> result = mapper.selectOutGoingConfig(params);
            
            System.out.println("✅ 查询成功，共 " + result.size() + " 个外发配置：");
            for (OutGoingConfig config : result) {
                System.out.println("  - ID=" + config.getId() 
                    + ", 名称=" + config.getOutGoingName()
                    + ", 类型=" + config.getOutGoingChannelType()
                    + ", 地址=" + config.getOutGoingAddr()
                    + ", 是否启用=" + (config.getIsEnable() ? "是" : "否")
                    + ", 需要认证=" + (config.getIsAuth() ? "是" : "否"));
            }
            
            return "查询成功，共 " + result.size() + " 个配置";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试2：按ID查询单个配置
     */
    @GetMapping("/test-query-by-id")
    public String testSelectConfigById() {
        try {
            Long id = 1001L;  // test_data.sql 中的企业邮箱配置
            
            OutGoingConfig config = mapper.selectConfigById(id);
            
            if (config != null) {
                System.out.println("✅ 查询成功：");
                System.out.println("  - ID：" + config.getId());
                System.out.println("  - 配置名称：" + config.getOutGoingName());
                System.out.println("  - 渠道类型：" + config.getOutGoingChannelType());
                System.out.println("  - 服务器地址：" + config.getOutGoingAddr());
                System.out.println("  - 端口：" + config.getOutGoingPort());
                System.out.println("  - 是否启用：" + (config.getIsEnable() ? "是" : "否"));
                System.out.println("  - 需要认证：" + (config.getIsAuth() ? "是" : "否"));
                System.out.println("  - 超时时间：" + config.getTimeoutSeconds() + "秒");
                System.out.println("  - 重试次数：" + config.getRetryCount() + "次");
                System.out.println("  - 描述：" + config.getDescription());
                
                return "查询成功：" + config.getOutGoingName();
            } else {
                return "未找到ID=" + id + "的配置";
            }
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试3：更新配置开关
     */
    @GetMapping("/test-update-switch")
    public void testUpdateSwitchById() {
        try {
            Long id = 1004L;  // test_data.sql 中的企业微信测试配置（已禁用）
            Boolean enable = true;  // 启用它
            
            mapper.updateSwitchById(id, enable);
            
            System.out.println("✅ 更新成功：配置ID=" + id + ", 新状态=" + (enable ? "已启用" : "已禁用"));
        } catch (Exception e) {
            System.err.println("❌ 更新失败：" + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 测试4：统计配置数量
     */
    @GetMapping("/test-count")
    public String testSelectOutGoingConfigCount() {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("isEnable", true);  // 统计已启用的
            
            Long count = mapper.selectOutGoingConfigCount(params);
            
            System.out.println("✅ 统计成功：已启用的外发配置共 " + count + " 个");
            
            return "统计成功：共 " + count + " 个";
        } catch (Exception e) {
            System.err.println("❌ 统计失败：" + e.getMessage());
            e.printStackTrace();
            return "统计失败：" + e.getMessage();
        }
    }
}
