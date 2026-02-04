package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.StrategyDeviceRelMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.StrategyDeviceRel;
import com.dbapp.extension.xdr.linkageHandle.entity.StrategyAlarmInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * StrategyDeviceRel 测试控制器
 * 根据反编译接口修复：2026-01-28
 */
@RestController
@RequestMapping("/test/strategyDeviceRel")
public class StrategyDeviceRelTestController {
    @Autowired
    private StrategyDeviceRelMapper mapper;

    /**
     * 测试1：insert - 插入策略设备关联
     */
    @GetMapping("/test1_insert")
    public String test1_insert() {
        try {
            System.out.println("测试: insert - 插入策略设备关联");
            StrategyDeviceRel rel = new StrategyDeviceRel();
            rel.setStrategyId(7001L);
            rel.setDeviceId("dev_fw_001");
            rel.setLinkDeviceIp("192.168.1.10");
            rel.setLinkDeviceType("firewall");
            rel.setAppId("app_fw_001");
            rel.setArea("DMZ");
            rel.setAction("block");
            int rows = mapper.insert(rel);
            System.out.println("结果: 插入 " + rows + " 条记录");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_insert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：batchInsert - 批量插入
     */
    @GetMapping("/test2_batchInsert")
    public String test2_batchInsert() {
        try {
            System.out.println("测试: batchInsert - 批量插入策略设备关联");
            List<StrategyDeviceRel> list = new ArrayList<>();
            
            StrategyDeviceRel rel1 = new StrategyDeviceRel();
            rel1.setStrategyId(7001L);
            rel1.setDeviceId("dev_ids_001");
            rel1.setLinkDeviceIp("192.168.1.20");
            rel1.setLinkDeviceType("ids");
            rel1.setArea("Internal");
            rel1.setAction("monitor");
            list.add(rel1);
            
            StrategyDeviceRel rel2 = new StrategyDeviceRel();
            rel2.setStrategyId(7002L);
            rel2.setDeviceId("dev_waf_001");
            rel2.setLinkDeviceIp("192.168.2.10");
            rel2.setLinkDeviceType("waf");
            rel2.setArea("DMZ");
            rel2.setAction("block");
            list.add(rel2);
            
            int rows = mapper.batchInsert(list);
            System.out.println("结果: 插入 " + rows + " 条记录");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_batchInsert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：update - 更新策略设备关联
     */
    @GetMapping("/test3_update")
    public String test3_update() {
        try {
            System.out.println("测试: update - 更新策略设备关联");
            StrategyDeviceRel rel = new StrategyDeviceRel();
            rel.setId(1001L);
            rel.setLinkDeviceIp("192.168.1.100");
            rel.setLinkDeviceType("firewall_v2");
            rel.setArea("DMZ_Updated");
            int rows = mapper.update(rel);
            System.out.println("结果: 更新 " + rows + " 条记录");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test3_update 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：batchInsertOrUpdate - 批量插入或更新
     */
    @GetMapping("/test4_batchInsertOrUpdate")
    public String test4_batchInsertOrUpdate() {
        try {
            System.out.println("测试: batchInsertOrUpdate - 批量插入或更新");
            List<StrategyDeviceRel> list = new ArrayList<>();
            
            // 更新已存在的记录
            StrategyDeviceRel rel1 = new StrategyDeviceRel();
            rel1.setStrategyId(7001L);
            rel1.setDeviceId("dev_fw_001");
            rel1.setLinkDeviceIp("192.168.1.10");
            rel1.setLinkDeviceType("firewall_updated");
            rel1.setAction("block");
            list.add(rel1);
            
            // 插入新记录
            StrategyDeviceRel rel2 = new StrategyDeviceRel();
            rel2.setStrategyId(7005L);
            rel2.setDeviceId("dev_new_001");
            rel2.setLinkDeviceIp("192.168.5.10");
            rel2.setLinkDeviceType("new_device");
            rel2.setAction("monitor");
            list.add(rel2);
            
            int rows = mapper.batchInsertOrUpdate(list);
            System.out.println("结果: 插入/更新 " + rows + " 条记录");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test4_batchInsertOrUpdate 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：deleteRelByStrategyId - 根据策略ID删除关联
     */
    @GetMapping("/test5_deleteRelByStrategyId")
    public String test5_deleteRelByStrategyId() {
        try {
            System.out.println("测试: deleteRelByStrategyId - 根据策略ID删除关联");
            int rows = mapper.deleteRelByStrategyId(7005L);
            System.out.println("结果: 删除 " + rows + " 条记录");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test5_deleteRelByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试6：deleteRelByStrategyIdAndDeviceId - 根据策略ID和设备ID删除关联
     */
    @GetMapping("/test6_deleteRelByStrategyIdAndDeviceId")
    public String test6_deleteRelByStrategyIdAndDeviceId() {
        try {
            System.out.println("测试: deleteRelByStrategyIdAndDeviceId - 根据策略ID和设备ID删除关联");
            mapper.deleteRelByStrategyIdAndDeviceId(7001L, "dev_fw_001");
            System.out.println("结果: 删除成功");
            return "SUCCESS";
        } catch (Exception e) {
            String errorMsg = "测试方法 test6_deleteRelByStrategyIdAndDeviceId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试7：selectById - 根据ID查询
     */
    @GetMapping("/test7_selectById")
    public String test7_selectById() {
        try {
            System.out.println("测试: selectById - 根据ID查询");
            StrategyDeviceRel rel = mapper.selectById(1001L);
            if (rel != null) {
                System.out.println("结果: 找到记录，设备ID=" + rel.getDeviceId());
                return "SUCCESS: " + rel.getDeviceId();
            } else {
                System.out.println("结果: 未找到记录");
                return "NOT_FOUND";
            }
        } catch (Exception e) {
            String errorMsg = "测试方法 test7_selectById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试8：getAlarmStrategyList - 获取告警策略列表
     * 说明：查询 threat_type='alarmType' 且 status=true 的策略
     */
    @GetMapping("/test8_getAlarmStrategyList")
    public String test8_getAlarmStrategyList() {
        try {
            System.out.println("测试: getAlarmStrategyList - 获取告警策略列表");
            List<StrategyAlarmInfo> list = mapper.getAlarmStrategyList("alarmType");
            System.out.println("结果: 找到 " + list.size() + " 条策略");
            if (list.size() > 0) {
                System.out.println("示例: " + list.get(0).getStrategyName());
            }
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test8_getAlarmStrategyList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试9：findDeviceByStrateId - 根据策略ID查找设备
     */
    @GetMapping("/test9_findDeviceByStrateId")
    public String test9_findDeviceByStrateId() {
        try {
            System.out.println("测试: findDeviceByStrateId - 根据策略ID查找设备");
            List<StrategyDeviceRel> list = mapper.findDeviceByStrateId(7001L);
            System.out.println("结果: 找到 " + list.size() + " 个设备");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test9_findDeviceByStrateId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试10：findStrategyIdByDeviceId - 根据设备ID查找策略ID列表
     */
    @GetMapping("/test10_findStrategyIdByDeviceId")
    public String test10_findStrategyIdByDeviceId() {
        try {
            System.out.println("测试: findStrategyIdByDeviceId - 根据设备ID查找策略ID列表");
            List<Long> list = mapper.findStrategyIdByDeviceId("dev_fw_001");
            System.out.println("结果: 找到 " + list.size() + " 个策略");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test10_findStrategyIdByDeviceId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试11：getDeviceCount - 获取设备数量
     */
    @GetMapping("/test11_getDeviceCount")
    public String test11_getDeviceCount() {
        try {
            System.out.println("测试: getDeviceCount - 获取设备数量");
            int count = mapper.getDeviceCount(7001L);
            System.out.println("结果: 设备数量 = " + count);
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 test11_getDeviceCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试12：updateDeviceIpAndId - 更新设备IP和ID
     */
    @GetMapping("/test12_updateDeviceIpAndId")
    public String test12_updateDeviceIpAndId() {
        try {
            System.out.println("测试: updateDeviceIpAndId - 更新设备IP和ID");
            int rows = mapper.updateDeviceIpAndId("192.168.1.10", "dev_fw_001_new", "dev_fw_001");
            System.out.println("结果: 更新 " + rows + " 条记录");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test12_updateDeviceIpAndId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
