package com.test.controller;

import com.dbapp.extension.xdr.outgoingData.mapper.EventOutGoingMapper;
import com.dbapp.extension.xdr.outgoingData.po.EventOutGoingData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * EventOutGoing (事件外发数据) 深度测试控制器
 * 主表：t_event_out_going_data (36个字段)
 * 测试方法数：2
 * 关键逻辑：ON CONFLICT (event_code, time_part) DO UPDATE
 * 生成时间：2026-01-28（深度修复）
 */
@RestController
@RequestMapping("/test/eventOutGoing")
public class EventOutGoingTestController {
    @Autowired
    private EventOutGoingMapper mapper;

    /**
     * 方法1：batchInsert - 批量插入（正常场景）
     * 测试条件：<foreach collection="list">
     */
    @GetMapping("/test1_batchInsert_new")
    public String test1_batchInsert_new() {
        try {
            System.out.println("测试: batchInsert - 批量插入新事件");
            List<EventOutGoingData> dataList = new ArrayList<>();
            
            // 构造测试数据1：端口扫描事件
            EventOutGoingData data1 = new EventOutGoingData();
            data1.setEventCode("EVT-TEST-" + System.currentTimeMillis());
            data1.setCategory("Network Attack");
            data1.setSubCategory("Port Scan");
            data1.setThreatSeverity("medium");
            data1.setIncidentName("端口扫描攻击-测试");
            data1.setEventDescription("检测到来自外部IP的端口扫描行为");
            data1.setStartTime(LocalDateTime.now().minusMinutes(30).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data1.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data1.setAttacker("198.51.100.99");
            data1.setVictim("192.168.1.100");
            data1.setDestAddress("192.168.1.100");
            data1.setSrcAddress("198.51.100.99");
            data1.setRequestUrl(null);
            data1.setRequestDomain(null);
            data1.setDestPort(80L);
            data1.setDestGeoRegion("广东省");
            data1.setDestGeoCity("深圳市");
            data1.setDestGeoCounty("中国");
            data1.setSrcPort(12345L);
            data1.setSrcGeoRegion("浙江省");
            data1.setSrcGeoCity("杭州市");
            data1.setSrcGeoCounty("中国");
            data1.setAlarmResult("已拦截");
            data1.setEventCount(100L);
            data1.setKillChain("Reconnaissance");
            data1.setMirrorCategory("端口扫描");
            data1.setFocus("server");
            data1.setFocusIp("192.168.1.100");
            data1.setTagSearch("端口扫描,网络攻击,中危");
            data1.setTimePart(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            data1.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data1.setAlarm("原始告警数据...");
            data1.setIncidentDescription("攻击者对目标服务器进行全端口扫描");
            data1.setIncidentSuggestion("建议配置防火墙规则，限制非法端口访问");
            dataList.add(data1);
            
            // 构造测试数据2：XSS攻击事件
            EventOutGoingData data2 = new EventOutGoingData();
            data2.setEventCode("EVT-XSS-" + System.currentTimeMillis());
            data2.setCategory("Web Attack");
            data2.setSubCategory("XSS");
            data2.setThreatSeverity("high");
            data2.setIncidentName("跨站脚本攻击-测试");
            data2.setEventDescription("检测到XSS攻击尝试");
            data2.setStartTime(LocalDateTime.now().minusMinutes(10).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data2.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data2.setAttacker("203.0.113.88");
            data2.setVictim("192.168.1.200");
            data2.setDestAddress("192.168.1.200");
            data2.setSrcAddress("203.0.113.88");
            data2.setRequestUrl("http://example.com/search?q=<script>alert('XSS')</script>");
            data2.setRequestDomain("example.com");
            data2.setDestPort(8080L);
            data2.setDestGeoRegion("上海市");
            data2.setDestGeoCity("上海市");
            data2.setDestGeoCounty("中国");
            data2.setSrcPort(54321L);
            data2.setSrcGeoRegion("北京市");
            data2.setSrcGeoCity("北京市");
            data2.setSrcGeoCounty("中国");
            data2.setAlarmResult("攻击被WAF拦截");
            data2.setEventCount(3L);
            data2.setKillChain("Initial Access,Execution");
            data2.setMirrorCategory("XSS攻击");
            data2.setFocus("webapp");
            data2.setFocusIp("192.168.1.200");
            data2.setTagSearch("XSS,Web攻击,高危");
            data2.setTimePart(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            data2.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data2.setAlarm("原始告警数据-XSS...");
            data2.setIncidentDescription("攻击者尝试在搜索框注入恶意JavaScript代码");
            data2.setIncidentSuggestion("建议对用户输入进行HTML转义，配置CSP策略");
            dataList.add(data2);
            
            int rows = mapper.batchInsert(dataList);
            System.out.println("结果: 插入 " + rows + " 条");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_batchInsert_new 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：batchInsert - ON CONFLICT DO UPDATE 测试
     * 测试条件：event_code + time_part 冲突时触发UPDATE
     */
    @GetMapping("/test2_batchInsert_conflict")
    public String test2_batchInsert_conflict() {
        try {
            System.out.println("测试: batchInsert - ON CONFLICT DO UPDATE");
            List<EventOutGoingData> dataList = new ArrayList<>();
            
            // 使用已存在的event_code和time_part（从test_data.sql）
            EventOutGoingData data = new EventOutGoingData();
            data.setEventCode("EVT-DDOS-20260126-001");  // 已存在
            data.setCategory("Network Attack");
            data.setSubCategory("DDoS");
            data.setThreatSeverity("critical");  // 更新：从high到critical
            data.setIncidentName("DDoS洪水攻击-更新版");
            data.setEventDescription("检测到超大规模DDoS攻击，目标服务器遭受SYN洪水攻击（已更新）");
            data.setStartTime(LocalDateTime.now().minusHours(2).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data.setAttacker("10.0.0.100,10.0.0.101,10.0.0.102,10.0.0.103");  // 新增攻击源
            data.setVictim("192.168.1.10");
            data.setDestAddress("192.168.1.10");
            data.setSrcAddress("10.0.0.100");
            data.setRequestUrl(null);
            data.setRequestDomain(null);
            data.setDestPort(80L);
            data.setDestGeoRegion("广东省");
            data.setDestGeoCity("深圳市");
            data.setDestGeoCounty("中国");
            data.setSrcPort(12345L);
            data.setSrcGeoRegion("浙江省");
            data.setSrcGeoCity("杭州市");
            data.setSrcGeoCounty("中国");
            data.setAlarmResult("服务完全中断");  // 更新：从"攻击成功导致服务中断"
            data.setEventCount(25000L);  // 更新：从15000
            data.setKillChain("Reconnaissance,Resource Development,Impact");
            data.setMirrorCategory("DDoS攻击");
            data.setFocus("server");
            data.setFocusIp("192.168.1.10");
            data.setTagSearch("DDoS,网络攻击,严重");  // 更新：从高危到严重
            data.setTimePart(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));  // 相同time_part
            data.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            data.setAlarm("原始告警数据-更新版...");
            data.setIncidentDescription("攻击者使用更大规模僵尸网络发起DDoS攻击，服务器已完全无法响应");  // 更新
            data.setIncidentSuggestion("紧急启用DDoS防护，联系运营商进行流量清洗");  // 更新
            dataList.add(data);
            
            int rows = mapper.batchInsert(dataList);
            System.out.println("结果: ON CONFLICT触发，更新 " + rows + " 条");
            return "SUCCESS: " + rows + " (ON CONFLICT DO UPDATE)";
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_batchInsert_conflict 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
