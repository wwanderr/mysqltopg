package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.BlockHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.BlockHistory;
import com.dbapp.extension.xdr.linkageHandle.entity.BlockHistoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * BlockHistory 测试 Controller
 * 
 * 所有测试方法使用 GET 请求，参数在方法内部写死
 * 通过 Postman 调用 http://localhost:8080/test/blockHistory/testX_methodName
 * 
 * 测试数据ID范围：1001-1005
 * 
 * 生成时间: 2026-01-26
 */
@RestController
@RequestMapping("/test/blockHistory")
public class BlockHistoryTestController {

    @Autowired
    private BlockHistoryMapper mapper;

    /**
     * 测试1：按策略ID汇总启动次数
     * URL: /test/blockHistory/sumLaunchTimesByStrategyId
     */
    @GetMapping("/sumLaunchTimesByStrategyId")
    public String sumLaunchTimesByStrategyId() {
        try {
            System.out.println("=== 测试: sumLaunchTimesByStrategyId ===");
            List<Integer> strategyIds = Arrays.asList(5001, 5002, 5003);
            List<BaseHistoryVO> result = mapper.sumLaunchTimesByStrategyId(strategyIds);
            System.out.println("✓ 查询到 " + result.size() + " 条策略统计");
            for (BaseHistoryVO vo : result) {
                System.out.println("  - 策略ID=" + vo.getStrategyId() + ", 启动次数=" + vo.getLaunchTimes());
            }
            return "SUCCESS: 查询到 " + result.size() + " 条策略统计";
        } catch (Exception e) {
            String errorMsg = "测试方法 sumLaunchTimesByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：插入封堵历史记录
     * URL: /test/blockHistory/insertBlockHistory
     */
    @GetMapping("/insertBlockHistory")
    public String insertBlockHistory() {
        try {
            System.out.println("=== 测试: insertBlockHistory ===");
            BlockHistory blockHistory = new BlockHistory();
            blockHistory.setStrategyId(5001);
            blockHistory.setStrategyName("测试封堵策略");
            blockHistory.setLinkDeviceIp("192.168.1.10");
            blockHistory.setLinkDeviceType("firewall");
            blockHistory.setSrcAddress("203.0.113.200");
            blockHistory.setDestAddress("192.168.10.50");
            blockHistory.setBlockResult("成功封堵");
            blockHistory.setLaunchTime(new Date());
            
            int rows = mapper.insertBlockHistory(blockHistory);
            System.out.println("✓ 插入成功，影响 " + rows + " 行");
            return "SUCCESS: 插入 " + rows + " 条记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 insertBlockHistory 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：查询封堵列表数量
     * URL: /test/blockHistory/getBlockListCount
     */
    @GetMapping("/getBlockListCount")
    public String getBlockListCount() {
        try {
            System.out.println("=== 测试: getBlockListCount ===");
            Map<String, Object> param = new HashMap<>();
            param.put("strategyId", 5001);
            param.put("linkDeviceIp", "192.168.1.10");
            
            Long count = mapper.getBlockListCount(param);
            System.out.println("✓ 共 " + count + " 条封堵记录");
            return "SUCCESS: 共 " + count + " 条记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 getBlockListCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：查询封堵历史列表
     * URL: /test/blockHistory/getBlockHistory
     */
    @GetMapping("/getBlockHistory")
    public String getBlockHistory() {
        try {
            System.out.println("=== 测试: getBlockHistory ===");
            Map<String, Object> param = new HashMap<>();
            param.put("strategyId", 5001);
            param.put("limit", 10);
            param.put("offset", 0);
            String orderByStr = "launch_time DESC";
            
            List<BlockHistoryVO> result = mapper.getBlockHistory(param, orderByStr);
            System.out.println("✓ 查询到 " + result.size() + " 条");
            for (BlockHistoryVO vo : result) {
                System.out.println("  - ID=" + vo.getId() 
                    + ", 策略=" + vo.getStrategyName()
                    + ", 设备IP=" + vo.getLinkDeviceIp()
                    + ", 源地址=" + vo.getSrcAddress()
                    + ", 目标地址=" + vo.getDestAddress());
            }
            return "SUCCESS: 查询到 " + result.size() + " 条记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 getBlockHistory 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：按IP查询历史记录
     * URL: /test/blockHistory/getHistoryByIp
     */
    @GetMapping("/getHistoryByIp")
    public String getHistoryByIp() {
        try {
            System.out.println("=== 测试: getHistoryByIp ===");
            String linkDeviceIp = "192.168.1.10";
            String srcAddress = "203.0.113.100";
            String destAddress = "192.168.10.50";
            
            List<BlockHistoryVO> result = mapper.getHistoryByIp(linkDeviceIp, srcAddress, destAddress);
            System.out.println("✓ 查询到 " + result.size() + " 条");
            for (BlockHistoryVO vo : result) {
                System.out.println("  - 设备IP=" + vo.getLinkDeviceIp()
                    + ", 源=" + vo.getSrcAddress()
                    + ", 目标=" + vo.getDestAddress()
                    + ", 结果=" + vo.getBlockResult());
            }
            return "SUCCESS: 查询到 " + result.size() + " 条记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 getHistoryByIp 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试6：按条件查询封堵历史
     * URL: /test/blockHistory/getBlockHistoryByCondition
     */
    @GetMapping("/getBlockHistoryByCondition")
    public String getBlockHistoryByCondition() {
        try {
            System.out.println("=== 测试: getBlockHistoryByCondition ===");
            Integer strategyId = 5001;
            String linkDeviceIp = "192.168.1.10";
            
            List<BlockHistoryVO> result = mapper.getBlockHistoryByCondition(strategyId, linkDeviceIp);
            System.out.println("✓ 策略ID=" + strategyId + ", 设备IP=" + linkDeviceIp + ", 共 " + result.size() + " 条");
            return "SUCCESS: 查询到 " + result.size() + " 条记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 getBlockHistoryByCondition 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试7：按策略ID查询历史记录
     * URL: /test/blockHistory/getHistoryByStrategyId
     */
    @GetMapping("/getHistoryByStrategyId")
    public String getHistoryByStrategyId() {
        try {
            System.out.println("=== 测试: getHistoryByStrategyId ===");
            Integer strategyId = 5001;
            
            List<BlockHistoryVO> result = mapper.getHistoryByStrategyId(strategyId);
            System.out.println("✓ 策略ID=" + strategyId + ", 共 " + result.size() + " 条历史记录");
            for (BlockHistoryVO vo : result) {
                System.out.println("  - ID=" + vo.getId() + ", 启动时间=" + vo.getLaunchTime());
            }
            return "SUCCESS: 查询到 " + result.size() + " 条记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 getHistoryByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试8：按ID列表查询历史记录
     * URL: /test/blockHistory/getHistoryByIds
     */
    @GetMapping("/getHistoryByIds")
    public String getHistoryByIds() {
        try {
            System.out.println("=== 测试: getHistoryByIds ===");
            List<Long> ids = Arrays.asList(1001L, 1002L, 1003L);
            
            List<BlockHistoryVO> result = mapper.getHistoryByIds(ids);
            System.out.println("✓ 查询IDs=" + ids + ", 共 " + result.size() + " 条");
            for (BlockHistoryVO vo : result) {
                System.out.println("  - ID=" + vo.getId() + ", 策略=" + vo.getStrategyName());
            }
            return "SUCCESS: 查询到 " + result.size() + " 条记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 getHistoryByIds 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试9：按ID删除历史记录
     * URL: /test/blockHistory/deleteHistoryById
     */
    @GetMapping("/deleteHistoryById")
    public String deleteHistoryById() {
        try {
            System.out.println("=== 测试: deleteHistoryById ===");
            Long id = 1005L;  // 删除测试数据中的最后一条
            
            int rows = mapper.deleteHistoryById(id);
            System.out.println("✓ 删除ID=" + id + ", 影响 " + rows + " 行");
            return "SUCCESS: 删除了 " + rows + " 条记录";
        } catch (Exception e) {
            String errorMsg = "测试方法 deleteHistoryById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试10：更新设备IP和ID
     * URL: /test/blockHistory/updateDeviceIpAndId
     */
    @GetMapping("/updateDeviceIpAndId")
    public String updateDeviceIpAndId() {
        try {
            System.out.println("=== 测试: updateDeviceIpAndId ===");
            String previousDeviceId = "old-device-001";
            String currentDeviceId = "new-device-001";
            String linkDeviceType = "firewall";
            String masterHost = "192.168.1.10";
            
            mapper.updateDeviceIpAndId(previousDeviceId, currentDeviceId, linkDeviceType, masterHost);
            System.out.println("✓ 更新成功: " + previousDeviceId + " -> " + currentDeviceId);
            return "SUCCESS: 更新完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 updateDeviceIpAndId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试11：按策略ID查询ID列表
     * URL: /test/blockHistory/getIdsByStrategyId
     */
    @GetMapping("/getIdsByStrategyId")
    public String getIdsByStrategyId() {
        try {
            System.out.println("=== 测试: getIdsByStrategyId ===");
            Integer strategyId = 5001;
            
            List<Long> ids = mapper.getIdsByStrategyId(strategyId);
            System.out.println("✓ 策略ID=" + strategyId + ", 共 " + ids.size() + " 个ID");
            System.out.println("  IDs: " + ids);
            return "SUCCESS: 查询到 " + ids.size() + " 个ID";
        } catch (Exception e) {
            String errorMsg = "测试方法 getIdsByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
