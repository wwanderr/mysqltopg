package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.AssetInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * AssetInfo 测试控制器
 * 对应XML方法：queryAssetsCount, queryAssets
 */
@RestController
@RequestMapping("/test/assetInfo")
public class AssetInfoTestController {
    @Autowired
    private AssetInfoMapper mapper;

    /**
     * 测试1：查询资产总数
     */
    @GetMapping("/test-query-assets-count")
    public String testQueryAssetsCount() {
        try {
            long count = mapper.queryAssetsCount();
            System.out.println("✅ 查询资产总数：" + count);
            return "资产总数：" + count;
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试2：分页查询资产列表
     */
    @GetMapping("/test-query-assets")
    public String testQueryAssets() {
        try {
            // 查询第1页，每页10条
            int offset = 0;
            int size = 10;
            
            List<Map<String, Object>> assets = mapper.queryAssets(offset, size);
            System.out.println("✅ 分页查询资产(offset=" + offset + ", size=" + size + ")，共 " + assets.size() + " 条");
            for (Map<String, Object> asset : assets) {
                System.out.println("  - IP:" + asset.get("assetIp") + ", 名称:" + asset.get("assetName"));
            }
            return "查询成功：" + assets.size() + " 条资产";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }
}
