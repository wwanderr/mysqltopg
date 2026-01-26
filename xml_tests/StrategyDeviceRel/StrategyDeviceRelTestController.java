package com.test.controller;

import com.dbapp.extension.xdr.strategy.mapper.StrategyDeviceRelMapper;
import com.dbapp.extension.xdr.strategy.entity.StrategyDeviceRel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/test/strategy-device-rel")
public class StrategyDeviceRelTestController {

    @Autowired
    private StrategyDeviceRelMapper mapper;

    @GetMapping("/test-query-by-strategy")
    public String testQueryByStrategy() {
        try {
            Long strategyId = 5001L;  // test_data.sql中的策略
            List<StrategyDeviceRel> result = mapper.selectByStrategyId(strategyId);
            System.out.println("✅ 查询策略" + strategyId + "关联设备，共 " + result.size() + " 个");
            for (StrategyDeviceRel rel : result) {
                System.out.println("  - " + rel.getDeviceName() + " (" + rel.getDeviceType() 
                    + ") | " + rel.getBindStatus() + " | " + rel.getSyncResult());
            }
            return "关联设备：" + result.size() + " 个";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    @GetMapping("/test-count-bound")
    public String testCountBound() {
        try {
            Long count = mapper.countByBindStatus("bound");
            System.out.println("✅ 已绑定设备：" + count + " 个");
            return "已绑定设备：" + count + " 个";
        } catch (Exception e) {
            System.err.println("❌ 统计失败：" + e.getMessage());
            e.printStackTrace();
            return "统计失败：" + e.getMessage();
        }
    }
}
