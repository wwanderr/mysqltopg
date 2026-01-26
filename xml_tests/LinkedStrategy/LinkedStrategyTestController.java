package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.LinkedStrategyMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.LinkedStrategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * LinkedStrategy 测试控制器
 * 
 * 测试说明：
 * 1. 所有方法使用 GET 请求
 * 2. 参数已硬编码，无需 Postman 传参
 * 3. 测试数据参考：test_data.sql 中的场景
 */
@RestController
@RequestMapping("/test/linked-strategy")
public class LinkedStrategyTestController {

    @Autowired
    private LinkedStrategyMapper mapper;

    /**
     * 测试1：查询所有联动策略
     */
    @GetMapping("/test-query-all")
    public String testGetAllStrategys() {
        try {
            List<LinkedStrategy> result = mapper.getAllStrategys();
            
            System.out.println("✅ 查询成功，共 " + result.size() + " 条策略：");
            for (LinkedStrategy strategy : result) {
                System.out.println("  - ID=" + strategy.getId() 
                    + ", 策略名=" + strategy.getStrategyName()
                    + ", 设备类型=" + strategy.getLinkDeviceType()
                    + ", 是否自动=" + (strategy.getIsAuto() ? "是" : "否")
                    + ", 是否开启=" + (strategy.getIsOpen() ? "是" : "否"));
            }
            
            return "查询成功，共 " + result.size() + " 条策略";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试2：按ID查询单个策略
     */
    @GetMapping("/test-query-by-id")
    public String testGetLinkStrategyById() {
        try {
            Long id = 1001L;  // test_data.sql 中的自动封禁策略
            
            LinkedStrategy strategy = mapper.getLinkStrategyById(id);
            
            if (strategy != null) {
                System.out.println("✅ 查询成功：");
                System.out.println("  - ID：" + strategy.getId());
                System.out.println("  - 策略名称：" + strategy.getStrategyName());
                System.out.println("  - 策略类型：" + strategy.getStrategyType());
                System.out.println("  - 设备类型：" + strategy.getLinkDeviceType());
                System.out.println("  - 设备IP：" + strategy.getLinkDeviceIp());
                System.out.println("  - 执行方式：" + (strategy.getIsAuto() ? "自动" : "手动"));
                System.out.println("  - 是否系统策略：" + (strategy.getIsSystemCa() ? "是" : "否"));
                System.out.println("  - 是否开启：" + (strategy.getIsOpen() ? "是" : "否"));
                
                return "查询成功：" + strategy.getStrategyName();
            } else {
                return "未找到ID=" + id + "的策略";
            }
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试3：启用/禁用策略
     */
    @GetMapping("/test-enable-strategy")
    public void testEnableLinkStrategy() {
        try {
            Long id = 1004L;  // test_data.sql 中的已关闭策略
            Boolean enable = true;  // 启用它
            
            mapper.enableLinkStrategy(id, enable);
            
            System.out.println("✅ 更新成功：策略ID=" + id + ", 新状态=" + (enable ? "已启用" : "已禁用"));
        } catch (Exception e) {
            System.err.println("❌ 更新失败：" + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 测试4：删除策略
     */
    @GetMapping("/test-delete-strategy")
    public void testDeleteLinkStrategy() {
        try {
            Long id = 1004L;  // test_data.sql 中的定时解除策略（测试用）
            
            mapper.deleteLinkStrategy(id);
            
            System.out.println("✅ 删除成功：策略ID=" + id);
        } catch (Exception e) {
            System.err.println("❌ 删除失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
