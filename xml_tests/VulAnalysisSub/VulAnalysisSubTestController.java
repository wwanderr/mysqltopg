package com.test.controller;

import com.dbapp.extension.xdr.vulnerabilityAnalysis.mapper.VulAnalysisSubMapper;
import com.dbapp.extension.xdr.vulnerabilityAnalysis.entity.VulAnalysisSub;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.*;

/**
 * VulAnalysisSub (漏洞分析) 深度测试控制器
 * 主表：t_vul_analysis_sub (26个字段)
 * 测试方法数：11
 * 注意：XML涉及跨schema引用 bigdata_web.t_asset_info等表
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/vulAnalysisSub")
public class VulAnalysisSubTestController {
    @Autowired
    private VulAnalysisSubMapper mapper;

    /**
     * 方法1：insertOrUpdate
     * 测试条件：
     * - INSERT ... ON CONFLICT (event_code) DO UPDATE
     * - <foreach collection="list">
     */
    @GetMapping("/testInsertOrUpdate")
    public String testInsertOrUpdate() {
        try {
            System.out.println("测试: insertOrUpdate - 批量插入或更新漏洞数据");
            List<VulAnalysisSub> list = new ArrayList<>();
            
            VulAnalysisSub vul1 = new VulAnalysisSub();
            vul1.setEndTime(new Timestamp(System.currentTimeMillis()));
            vul1.setStartTime(new Timestamp(System.currentTimeMillis() - 3600000));
            vul1.setAlarmResult(3);
            vul1.setAlarmStatus(5);
            vul1.setAppProtocol("HTTP");
            vul1.setSource(1);
            vul1.setChartId(101);
            vul1.setAssetIp("192.168.100.100");
            vul1.setAssetTags("[\"测试服务器\"]");
            vul1.setAssetName("TestServer-Auto");
            vul1.setDestSecurityZone("zone_name:测试区");
            vul1.setAssetType("Server");
            vul1.setCve("CVE-2026-AUTO-001");
            vul1.setSeverityLevel("High");
            vul1.setVulnerabilityName("自动化测试漏洞");
            vul1.setClassType("RCE");
            vul1.setHigh(5);
            vul1.setMedium(3);
            vul1.setLow(1);
            vul1.setAggCount(10);
            vul1.setEventCode("VUL-AUTO-001");
            list.add(vul1);
            
            VulAnalysisSub vul2 = new VulAnalysisSub();
            vul2.setEndTime(new Timestamp(System.currentTimeMillis()));
            vul2.setStartTime(new Timestamp(System.currentTimeMillis() - 7200000));
            vul2.setAlarmResult(2);
            vul2.setAlarmStatus(4);
            vul2.setAppProtocol("SSH");
            vul2.setSource(2);
            vul2.setChartId(102);
            vul2.setAssetIp("192.168.100.101");
            vul2.setAssetTags("[\"Linux服务器\"]");
            vul2.setAssetName("LinuxServer-Auto");
            vul2.setDestSecurityZone("zone_name:生产区");
            vul2.setAssetType("Server");
            vul2.setCve("CVE-2026-AUTO-002");
            vul2.setSeverityLevel("Medium");
            vul2.setVulnerabilityName("SSH暴力破解");
            vul2.setClassType("Brute Force");
            vul2.setSrcUserName("root");
            vul2.setHigh(2);
            vul2.setMedium(8);
            vul2.setLow(5);
            vul2.setAggCount(15);
            vul2.setEventCode("VUL-AUTO-002");
            list.add(vul2);
            
            int rows = mapper.insertOrUpdate(list);
            System.out.println("结果: 成功插入/更新 " + rows + " 条数据");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 testInsertOrUpdate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：queryListCount
     * 测试条件：
     * - <if test="assetName">（资产名称）
     * - <if test="assetIp">（资产IP）
     * - <if test="assetType">（资产类型）
     * - <if test="assetTags">（资产标签）
     * - <if test="source">（资产来源）
     * - <if test="appProtocol">（协议列表）
     * - <if test="vulnerabilityName">（漏洞名称）
     * - <if test="alarmResultsVal">（告警结果）
     * - <choose><when order>（排序选择）
     * - 复杂JOIN查询：bigdata_web.t_asset_info, t_ailpha_network_segment, t_ailpha_security_zone, t_vulnerability_info
     * - GROUP BY ts.asset_ip, ti.assetType, ti.assetName, f."name"
     */
    @GetMapping("/testQueryListCount")
    public String testQueryListCount() {
        try {
            System.out.println("测试: queryListCount - 查询列表数量（包含所有条件参数）");
            Map<String, Object> params = new HashMap<>();
            
            // 必填参数
            params.put("startTime", "2026-01-27 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("chartId", 101);
            
            // 可选参数 - 全部测试
            params.put("assetName", "Server");
            params.put("assetIp", "192.168");
            params.put("assetType", "Server");
            params.put("assetTags", "生产环境");
            params.put("source", "1");
            params.put("appProtocol", Arrays.asList("HTTP", "SSH", "FTP"));
            params.put("vulnerabilityName", "代码执行");
            params.put("alarmResultsVal", Arrays.asList(1, 2, 3));
            params.put("order", "endTime DESC");
            
            Long count = mapper.queryListCount(params);
            System.out.println("结果: 查询到 " + count + " 条聚合记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryListCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：queryList
     * 测试条件：
     * - 与 queryListCount 相同的参数
     * - LIMIT #{limit} OFFSET #{offset}（分页）
     */
    @GetMapping("/testQueryList")
    public String testQueryList() {
        try {
            System.out.println("测试: queryList - 查询列表（包含所有条件参数 + 分页）");
            Map<String, Object> params = new HashMap<>();
            
            // 必填参数
            params.put("startTime", "2026-01-27 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("chartId", 101);
            
            // 可选参数
            params.put("assetName", "Server");
            params.put("assetIp", "192.168.10");
            params.put("assetType", "Server");
            params.put("assetTags", "Web服务器");
            params.put("source", "1");
            params.put("appProtocol", Arrays.asList("HTTP", "HTTPS"));
            params.put("vulnerabilityName", "Log4j");
            params.put("alarmResultsVal", Arrays.asList(3));
            
            // 测试默认排序（order为null）
            // params.put("order", "endTime DESC");
            
            // 分页参数
            params.put("offset", 0);
            params.put("limit", 10);
            
            List<Map<String, Object>> list = mapper.queryList(params);
            System.out.println("结果: 查询到 " + list.size() + " 条聚合数据");
            if (!list.isEmpty()) {
                Map<String, Object> first = list.get(0);
                System.out.println("样例: assetIp=" + first.get("assetIp") + ", aggCount=" + first.get("aggCount"));
            }
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法4：querySubListCount
     * 测试条件：
     * - <if test="assetName">（资产名称）
     * - <if test="assetIp">（资产IP）
     * - <if test="appProtocol">（协议列表）
     * - <if test="severityLevel">（漏洞等级列表）
     * - <if test="cve">（CVE编号）
     * - <if test="vulnerabilityName">（漏洞名称）
     * - <if test="classType">（漏洞类型）
     * - <if test="alarmResults">（告警结果列表）
     * - <if test="alarmStatus">（告警状态列表）
     */
    @GetMapping("/testQuerySubListCount")
    public String testQuerySubListCount() {
        try {
            System.out.println("测试: querySubListCount - 查询子列表数量（包含所有条件参数）");
            Map<String, Object> params = new HashMap<>();
            
            // 必填参数
            params.put("startTime", "2026-01-27 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("chartId", 101);
            
            // 测试所有9个条件参数
            params.put("assetName", "WebServer");
            params.put("assetIp", "192.168.10.50");
            params.put("appProtocol", Arrays.asList("HTTP", "HTTPS"));
            params.put("severityLevel", Arrays.asList("High", "Medium"));
            params.put("cve", "CVE-2021");
            params.put("vulnerabilityName", "远程代码执行");
            params.put("classType", "RCE");
            params.put("alarmResults", Arrays.asList(1, 2, 3));
            params.put("alarmStatus", Arrays.asList(5, 4, 3));
            
            Long count = mapper.querySubListCount(params);
            System.out.println("结果: 查询到 " + count + " 条子列表记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testQuerySubListCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法5：querySubListCveCount
     * 测试条件：
     * - 与 querySubListCount 相同的参数
     * - GROUP BY ts.cve, ts.severity_level, ts.vulnerability_name, ts.class_type
     */
    @GetMapping("/testQuerySubListCveCount")
    public String testQuerySubListCveCount() {
        try {
            System.out.println("测试: querySubListCveCount - 按CVE统计数量");
            Map<String, Object> params = new HashMap<>();
            
            // 必填参数
            params.put("startTime", "2026-01-27 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("chartId", 101);
            
            // 可选参数
            params.put("assetIp", "192.168");
            params.put("severityLevel", Arrays.asList("High", "Medium"));
            params.put("appProtocol", Arrays.asList("HTTP"));
            
            List<Map<String, Object>> list = mapper.querySubListCveCount(params);
            System.out.println("结果: 统计到 " + list.size() + " 个不同CVE");
            for (Map<String, Object> item : list) {
                System.out.println("CVE: " + item.get("cve") + " = " + item.get("aggCount"));
            }
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQuerySubListCveCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法6：querySubList
     * 测试条件：
     * - 与 querySubListCount 相同的参数
     * - <choose><when order>（排序选择）
     * - LIMIT #{limit} OFFSET #{offset}（分页）
     */
    @GetMapping("/testQuerySubList")
    public String testQuerySubList() {
        try {
            System.out.println("测试: querySubList - 查询子列表（包含所有条件参数 + 分页）");
            Map<String, Object> params = new HashMap<>();
            
            // 必填参数
            params.put("startTime", "2026-01-27 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("chartId", 101);
            
            // 测试部分参数
            params.put("assetIp", "192.168.10.50");
            params.put("severityLevel", Arrays.asList("High"));
            params.put("appProtocol", Arrays.asList("HTTP"));
            
            // 测试自定义排序
            params.put("order", "ts.end_time DESC");
            
            // 分页参数
            params.put("offset", 0);
            params.put("limit", 10);
            
            List<Map<String, Object>> list = mapper.querySubList(params);
            System.out.println("结果: 查询到 " + list.size() + " 条子列表数据");
            if (!list.isEmpty()) {
                Map<String, Object> first = list.get(0);
                System.out.println("样例: cve=" + first.get("cve") + ", vulnerabilityName=" + first.get("vulnerabilityName"));
            }
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQuerySubList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法7：querySubListById
     * 测试条件：
     * - <foreach collection="list" item="id">
     * - id in (ids)
     */
    @GetMapping("/testQuerySubListById")
    public String testQuerySubListById() {
        try {
            System.out.println("测试: querySubListById - 根据ID列表查询子列表");
            List<Long> idList = Arrays.asList(1001L, 1002L, 1003L, 1004L, 1005L);
            List<Map<String, Object>> list = mapper.querySubListById(idList);
            System.out.println("结果: 查询到 " + list.size() + " 条子列表数据");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQuerySubListById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法8：updateByParams
     * 测试条件：
     * - UPDATE t_vul_analysis_sub
     * - <if test="ignoreStatus">（设置忽略状态）
     * - <if test="alarmStatus">（设置告警状态）
     * - <if test="assetIp">（按资产IP）
     * - <if test="eventCode">（按事件编号）
     * - <if test="idList">（按ID列表）
     * - <if test="chartId">（按模板ID）
     * - <if test="startTime">（按开始时间）
     * - <if test="endTime">（按结束时间）
     */
    @GetMapping("/testUpdateByParams")
    public String testUpdateByParams() {
        try {
            System.out.println("测试: updateByParams - 按条件更新（包含所有条件参数）");
            Map<String, Object> params = new HashMap<>();
            
            // 更新字段
            params.put("alarmStatus", 3);
            
            // 条件参数 - 测试多个条件组合
            params.put("assetIp", "192.168.10.50");
            params.put("chartId", 101);
            params.put("startTime", "2026-01-27 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            
            int count = mapper.updateByParams(params);
            System.out.println("结果: 更新了 " + count + " 条记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateByParams 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法9：updateByIds
     * 测试条件：
     * - UPDATE t_vul_analysis_sub
     * - SET alarm_status = #{alarmStatus}
     * - <foreach collection="ids" item="id">
     * - id in (ids)
     */
    @GetMapping("/testUpdateByIds")
    public String testUpdateByIds() {
        try {
            System.out.println("测试: updateByIds - 根据ID列表更新状态");
            List<Long> ids = Arrays.asList(1001L, 1002L, 1003L);
            int alarmStatus = 3;
            
            int count = mapper.updateByIds(ids, alarmStatus);
            System.out.println("结果: 更新了 " + count + " 条记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateByIds 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法10：queryTop10
     * 测试条件：
     * - <if test="assetName">（资产名称）
     * - <if test="assetIp">（资产IP）
     * - <if test="severityLevel">（漏洞等级列表）
     * - <if test="classType">（漏洞类型）
     * - GROUP BY asset_ip, severity_level, vulnerability_name
     * - ORDER BY agg_count DESC
     * - LIMIT 10
     */
    @GetMapping("/testQueryTop10")
    public String testQueryTop10() {
        try {
            System.out.println("测试: queryTop10 - 查询Top10漏洞（包含所有条件参数）");
            Map<String, Object> params = new HashMap<>();
            
            // 必填参数
            params.put("startTime", "2026-01-27 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("chartId", 101);
            
            // 可选参数 - 测试部分条件
            params.put("assetIp", "192.168");
            params.put("severityLevel", Arrays.asList("High", "Medium"));
            params.put("classType", "RCE");
            
            List<Map<String, Object>> list = mapper.queryTop10(params);
            System.out.println("结果: 查询到 " + list.size() + " 条Top漏洞");
            for (int i = 0; i < Math.min(list.size(), 3); i++) {
                Map<String, Object> item = list.get(i);
                System.out.println("Top" + (i+1) + ": " + item.get("vulnerabilityName") + " = " + item.get("aggCount"));
            }
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryTop10 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法11：queryProportion
     * 测试条件：
     * - <if test="assetName">（资产名称）
     * - <if test="assetIp">（资产IP）
     * - <if test="classType">（漏洞类型）
     * - GROUP BY severity_level
     * - ORDER BY severity_level
     */
    @GetMapping("/testQueryProportion")
    public String testQueryProportion() {
        try {
            System.out.println("测试: queryProportion - 查询漏洞占比（包含所有条件参数）");
            Map<String, Object> params = new HashMap<>();
            
            // 必填参数
            params.put("startTime", "2026-01-27 00:00:00");
            params.put("endTime", "2026-01-28 23:59:59");
            params.put("chartId", 101);
            
            // 可选参数
            params.put("assetIp", "192.168");
            params.put("classType", "RCE");
            
            List<Map<String, Object>> list = mapper.queryProportion(params);
            System.out.println("结果: 统计到 " + list.size() + " 个漏洞等级");
            for (Map<String, Object> item : list) {
                System.out.println("等级: " + item.get("severityLevel") + " = " + item.get("aggCount"));
            }
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryProportion 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
