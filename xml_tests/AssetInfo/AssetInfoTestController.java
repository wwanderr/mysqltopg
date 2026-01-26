package com.test.controller;

import com.dbapp.extension.xdr.asset.mapper.AssetInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

/**
 * AssetInfo 测试控制器
 * 对应XML方法：queryAssetsCount, queryAssets
 */
@RestController
@RequestMapping("/test/asset-info")
public class AssetInfoTestController {
    @Autowired
    private AssetInfoMapper mapper;

    @GetMapping("/test-query-count")
    public String testQueryCount() {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("importance", "critical");
            Long count = mapper.queryAssetsCount(params);
            System.out.println("✅ 查询资产数量：" + count);
            return "资产数量：" + count;
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败";
        }
    }
}
