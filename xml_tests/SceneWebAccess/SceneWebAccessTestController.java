package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.SceneWebAccessMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

/**
 * SceneWebAccess 测试控制器
 * 
 * 覆盖 Mapper 中的 5 个方法：
 * - selectNormalUrlCount: 查询正常URL数量
 * - selectTotalUrlCount: 查询总URL数量
 * - selectAbnormalUrlList: 查询异常URL列表
 * - deleteByCreateTime: 根据创建时间删除数据
 * - groupByDestHostName: 按目标主机名分组统计
 */
@RestController
@RequestMapping("/test/sceneWebAccess")
public class SceneWebAccessTestController {

    @Autowired
    private SceneWebAccessMapper mapper;

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    /**
     * 测试1：selectNormalUrlCount - 查询正常URL数量
     * URL: /test/sceneWebAccess/test1-normalUrlCount
     * 
     * 测试场景：
     * - 查询事件数量超过阈值的URL数量
     * - 阈值设为 5，即 event_count 总和 > 5 的 URL 被认为是正常URL
     */
    @GetMapping("/test1-normalUrlCount")
    public String testSelectNormalUrlCount() {
        try {
            // 设置时间范围（最近7天）
            LocalDateTime endTime = LocalDateTime.now();
            LocalDateTime startTime = endTime.minusDays(7);
            String beforeDateTime = startTime.format(FORMATTER);
            String endDateTime = endTime.format(FORMATTER);
            
            String destHostName = "test-host.example.com";
            Integer normalUrlCountLimit = 5; // 正常URL的事件数量阈值
            
            long count = mapper.selectNormalUrlCount(normalUrlCountLimit, beforeDateTime, endDateTime, destHostName);
            
            System.out.println("✅ selectNormalUrlCount 执行成功");
            System.out.println("  时间范围: " + beforeDateTime + " ~ " + endDateTime);
            System.out.println("  目标主机: " + destHostName);
            System.out.println("  阈值: " + normalUrlCountLimit);
            System.out.println("  正常URL数量: " + count);
            
            return String.format("SUCCESS: 正常URL数量=%d (时间范围: %s ~ %s, 主机: %s, 阈值: %d)", 
                count, beforeDateTime, endDateTime, destHostName, normalUrlCountLimit);
        } catch (Exception e) {
            String msg = "❌ testSelectNormalUrlCount 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：selectTotalUrlCount - 查询总URL数量
     * URL: /test/sceneWebAccess/test2-totalUrlCount
     * 
     * 测试场景：
     * - 统计指定时间范围内不同request_url的总数
     */
    @GetMapping("/test2-totalUrlCount")
    public String testSelectTotalUrlCount() {
        try {
            LocalDateTime endTime = LocalDateTime.now();
            LocalDateTime startTime = endTime.minusDays(7);
            String beforeDateTime = startTime.format(FORMATTER);
            String endDateTime = endTime.format(FORMATTER);
            
            String destHostName = "test-host.example.com";
            
            long count = mapper.selectTotalUrlCount(beforeDateTime, endDateTime, destHostName);
            
            System.out.println("✅ selectTotalUrlCount 执行成功");
            System.out.println("  时间范围: " + beforeDateTime + " ~ " + endDateTime);
            System.out.println("  目标主机: " + destHostName);
            System.out.println("  总URL数量: " + count);
            
            return String.format("SUCCESS: 总URL数量=%d (时间范围: %s ~ %s, 主机: %s)", 
                count, beforeDateTime, endDateTime, destHostName);
        } catch (Exception e) {
            String msg = "❌ testSelectTotalUrlCount 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试3：selectAbnormalUrlList - 查询异常URL列表
     * URL: /test/sceneWebAccess/test3-abnormalUrlList
     * 
     * 测试场景：
     * - 查询事件数量低于阈值的URL列表（异常URL）
     * - 阈值设为 3，即 event_count 总和 < 3 的 URL 被认为是异常URL
     */
    @GetMapping("/test3-abnormalUrlList")
    public String testSelectAbnormalUrlList() {
        try {
            LocalDateTime endTime = LocalDateTime.now();
            LocalDateTime startTime = endTime.minusDays(7);
            String beforeDateTime = startTime.format(FORMATTER);
            String endDateTime = endTime.format(FORMATTER);
            
            String destHostName = "test-host.example.com";
            Integer abnormalUrlCountLimit = 3; // 异常URL的事件数量阈值
            
            List<String> urlList = mapper.selectAbnormalUrlList(
                abnormalUrlCountLimit, beforeDateTime, endDateTime, destHostName);
            
            System.out.println("✅ selectAbnormalUrlList 执行成功");
            System.out.println("  时间范围: " + beforeDateTime + " ~ " + endDateTime);
            System.out.println("  目标主机: " + destHostName);
            System.out.println("  阈值: " + abnormalUrlCountLimit);
            System.out.println("  异常URL数量: " + urlList.size());
            for (String url : urlList) {
                System.out.println("    - " + url);
            }
            
            return String.format("SUCCESS: 异常URL数量=%d (时间范围: %s ~ %s, 主机: %s, 阈值: %d)", 
                urlList.size(), beforeDateTime, endDateTime, destHostName, abnormalUrlCountLimit);
        } catch (Exception e) {
            String msg = "❌ testSelectAbnormalUrlList 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试4：deleteByCreateTime - 根据创建时间删除数据
     * URL: /test/sceneWebAccess/test4-deleteByCreateTime
     * 
     * 测试场景：
     * - 删除指定时间范围内的数据
     * - 注意：此操作会实际删除数据，建议在测试环境使用
     */
    @GetMapping("/test4-deleteByCreateTime")
    public String testDeleteByCreateTime() {
        try {
            // 删除30天前的数据
            LocalDateTime endTime = LocalDateTime.now().minusDays(30);
            LocalDateTime startTime = endTime.minusDays(1);
            String beforeDateTime = startTime.format(FORMATTER);
            String endDateTime = endTime.format(FORMATTER);
            
            System.out.println("⚠️  准备删除数据，时间范围: " + beforeDateTime + " ~ " + endDateTime);
            
            // 先查询一下要删除的数据量（可选）
            // 这里直接执行删除
            mapper.deleteByCreateTime(beforeDateTime, endDateTime);
            
            System.out.println("✅ deleteByCreateTime 执行成功");
            System.out.println("  已删除时间范围: " + beforeDateTime + " ~ " + endDateTime);
            
            return String.format("SUCCESS: 已删除数据 (时间范围: %s ~ %s)", beforeDateTime, endDateTime);
        } catch (Exception e) {
            String msg = "❌ testDeleteByCreateTime 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试5：groupByDestHostName - 按目标主机名分组统计
     * URL: /test/sceneWebAccess/test5-groupByDestHostName
     * 
     * 测试场景：
     * - 统计每个目标主机名的访问次数
     */
    @GetMapping("/test5-groupByDestHostName")
    public String testGroupByDestHostName() {
        try {
            LocalDateTime endTime = LocalDateTime.now();
            LocalDateTime startTime = endTime.minusDays(7);
            String beforeDateTime = startTime.format(FORMATTER);
            String endDateTime = endTime.format(FORMATTER);
            
            List<Map<String, Object>> resultList = mapper.groupByDestHostName(beforeDateTime, endDateTime);
            
            System.out.println("✅ groupByDestHostName 执行成功");
            System.out.println("  时间范围: " + beforeDateTime + " ~ " + endDateTime);
            System.out.println("  主机数量: " + resultList.size());
            for (Map<String, Object> item : resultList) {
                String hostName = (String) item.get("destHostName");
                Object accessCount = item.get("accessCount");
                System.out.println("    - 主机: " + hostName + ", 访问次数: " + accessCount);
            }
            
            return String.format("SUCCESS: 主机数量=%d (时间范围: %s ~ %s)", 
                resultList.size(), beforeDateTime, endDateTime);
        } catch (Exception e) {
            String msg = "❌ testGroupByDestHostName 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试：测试所有方法
     * URL: /test/sceneWebAccess/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        StringBuilder result = new StringBuilder();
        result.append("=== SceneWebAccess 综合测试 ===\n\n");
        
        // 设置统一的时间范围
        LocalDateTime endTime = LocalDateTime.now();
        LocalDateTime startTime = endTime.minusDays(7);
        String beforeDateTime = startTime.format(FORMATTER);
        String endDateTime = endTime.format(FORMATTER);
        String destHostName = "test-host.example.com";
        
        try {
            // 1. 查询总URL数量
            long totalCount = mapper.selectTotalUrlCount(beforeDateTime, endDateTime, destHostName);
            result.append("1. 总URL数量: ").append(totalCount).append("\n");
            
            // 2. 查询正常URL数量（阈值=5）
            long normalCount = mapper.selectNormalUrlCount(5, beforeDateTime, endDateTime, destHostName);
            result.append("2. 正常URL数量(阈值=5): ").append(normalCount).append("\n");
            
            // 3. 查询异常URL列表（阈值=3）
            List<String> abnormalUrls = mapper.selectAbnormalUrlList(3, beforeDateTime, endDateTime, destHostName);
            result.append("3. 异常URL数量(阈值=3): ").append(abnormalUrls.size()).append("\n");
            
            // 4. 按主机名分组统计
            List<Map<String, Object>> hostStats = mapper.groupByDestHostName(beforeDateTime, endDateTime);
            result.append("4. 主机统计数量: ").append(hostStats.size()).append("\n");
            
            result.append("\n✅ 所有测试执行成功！");
            return result.toString();
        } catch (Exception e) {
            result.append("\n❌ 测试失败: ").append(e.getMessage());
            e.printStackTrace();
            return result.toString();
        }
    }
}
