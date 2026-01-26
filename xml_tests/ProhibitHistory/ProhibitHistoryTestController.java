package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.ProhibitHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.ProhibitHistoryParam;
import com.dbapp.extension.xdr.linkageHandle.entity.ProhibitHistoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * ProhibitHistory 测试控制器
 * 
 * 测试说明：
 * 1. 所有方法使用 GET 请求
 * 2. 参数已硬编码，无需 Postman 传参
 * 3. 测试数据参考：test_data.sql 中的场景
 * 
 * 核心测试方法（从37个方法中精选5个）：
 * - insertProhibitHistory: 插入封禁历史
 * - getProhibitListByCondition: 按条件查询封禁列表
 * - updateStatusById: 更新封禁状态
 * - deleteByIds: 删除封禁记录
 * - getBlockIPCount: 获取封禁IP统计
 */
@RestController
@RequestMapping("/test/prohibit-history")
public class ProhibitHistoryTestController {

    @Autowired
    private ProhibitHistoryMapper mapper;

    /**
     * 测试1：插入新封禁记录
     * 场景：自动封禁检测到的DDoS攻击源
     */
    @GetMapping("/test-insert")
    public String testInsertProhibitHistory() {
        try {
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            // 使用 test_data.sql 之外的新数据
            param.setBlockIp("198.51.100.200");  // 新DDoS攻击源
            param.setDirection("INPUT,OUTPUT");
            param.setNodeId("node_fw_01");
            param.setNodeIp("192.168.1.10");
            param.setNtaName("firewall-main");
            param.setStrategyId(5001L);
            param.setLinkDeviceIp("192.168.1.10");
            param.setLinkDeviceType("firewall");
            param.setDeviceId("dev_fw_001");
            param.setEffectTime("3600");  // 1小时
            param.setCreateType("auto");
            param.setActionId("action_ddos_001");
            param.setSource("threat_intelligence");
            
            mapper.insertProhibitHistory(param);
            
            System.out.println("✅ 插入成功：封禁IP=" + param.getBlockIp() 
                + ", 策略ID=" + param.getStrategyId()
                + ", 生效时间=" + param.getEffectTime() + "秒");
            
            return "成功插入封禁记录：" + param.getBlockIp();
        } catch (Exception e) {
            System.err.println("❌ 插入失败：" + e.getMessage());
            e.printStackTrace();
            return "插入失败：" + e.getMessage();
        }
    }

    /**
     * 测试2：按条件查询封禁列表
     * 场景：查询防火墙设备上所有生效中的封禁记录
     */
    @GetMapping("/test-query-list")
    public String testGetProhibitListByCondition() {
        try {
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setLinkDeviceType("firewall");  // 查询防火墙设备
            param.setNodeIp("192.168.1.10");  // 主防火墙节点
            param.setStatus(true);  // 只查询生效中的
            param.setPageNum(1);
            param.setPageSize(10);
            
            List<ProhibitHistoryVO> result = mapper.getProhibitListByCondition(param);
            
            System.out.println("✅ 查询成功，共 " + result.size() + " 条记录：");
            for (ProhibitHistoryVO vo : result) {
                System.out.println("  - ID=" + vo.getId() 
                    + ", 封禁IP=" + vo.getBlockIp()
                    + ", 策略ID=" + vo.getStrategyId()
                    + ", 方向=" + vo.getDirection()
                    + ", 状态=" + (vo.getStatus() ? "生效中" : "已失效"));
            }
            
            return "查询成功，共 " + result.size() + " 条记录";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试3：更新封禁状态
     * 场景：将测试数据中的 1002 号记录从生效改为失效（手动解封）
     */
    @GetMapping("/test-update-status")
    public void testUpdateStatusById() {
        try {
            Long id = 1002L;  // test_data.sql 中的手动封禁记录
            Boolean newStatus = false;  // 改为失效
            
            mapper.updateStatusById(id, newStatus);
            
            System.out.println("✅ 更新成功：ID=" + id + ", 新状态=" + (newStatus ? "生效" : "失效"));
        } catch (Exception e) {
            System.err.println("❌ 更新失败：" + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 测试4：删除封禁记录
     * 场景：删除测试数据中的 1005 号记录（过期的测试封禁）
     */
    @GetMapping("/test-delete")
    public void testDeleteByIds() {
        try {
            List<String> ids = Arrays.asList("1005");  // test_data.sql 中的测试环境记录
            
            mapper.deleteByIds(ids);
            
            System.out.println("✅ 删除成功：删除了 " + ids.size() + " 条记录，IDs=" + ids);
        } catch (Exception e) {
            System.err.println("❌ 删除失败：" + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 测试5：获取封禁IP统计
     * 场景：统计防火墙设备上的封禁IP总数
     */
    @GetMapping("/test-count")
    public String testGetBlockIPCount() {
        try {
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setLinkDeviceType("firewall");  // 统计防火墙设备
            param.setNodeIp("192.168.1.10");  // 主防火墙节点
            
            Long count = mapper.getBlockIPCount(param);
            
            System.out.println("✅ 统计成功：防火墙设备上共有 " + count + " 个封禁IP");
            
            return "封禁IP总数：" + count;
        } catch (Exception e) {
            System.err.println("❌ 统计失败：" + e.getMessage());
            e.printStackTrace();
            return "统计失败：" + e.getMessage();
        }
    }
}
