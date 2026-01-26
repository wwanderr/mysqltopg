package com.test.controller;

import com.dbapp.extension.xdr.block.mapper.BlockHistoryMapper;
import com.dbapp.extension.xdr.block.entity.BlockHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/test/block-history")
public class BlockHistoryTestController {

    @Autowired
    private BlockHistoryMapper mapper;

    @GetMapping("/test-query-active")
    public String testQueryActive() {
        try {
            List<BlockHistory> result = mapper.selectByStatus("active");
            System.out.println("✅ 查询活跃封堵记录，共 " + result.size() + " 条");
            for (BlockHistory block : result) {
                System.out.println("  - IP:" + block.getBlockIp() + " | 原因:" + block.getBlockReason() 
                    + " | 设备:" + block.getDeviceType() + " | " + (block.getAutoBlock() ? "自动" : "手动"));
            }
            return "活跃封堵：" + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    @GetMapping("/test-count-by-type")
    public String testCountByType() {
        try {
            Long count = mapper.countByDeviceType("firewall");
            System.out.println("✅ 防火墙封堵记录：" + count + " 条");
            return "防火墙封堵记录：" + count + " 条";
        } catch (Exception e) {
            System.err.println("❌ 统计失败：" + e.getMessage());
            e.printStackTrace();
            return "统计失败：" + e.getMessage();
        }
    }
}
