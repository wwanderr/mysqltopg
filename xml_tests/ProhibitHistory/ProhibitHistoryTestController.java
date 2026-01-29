package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.ProhibitHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@RestController
@RequestMapping("/test/prohibitHistory")
public class ProhibitHistoryTestController {
    @Autowired
    private ProhibitHistoryMapper mapper;

    @GetMapping("/sumLaunchTimesByStrategyId")
    public String test01() {
        List<BaseHistoryVO> result = mapper.sumLaunchTimesByStrategyId(Arrays.asList(1001, 1002));
        return "SUCCESS: " + result.size();
    }

    @GetMapping("/insertProhibitHistory")
    public String test02() {
        ProhibitHistory history = new ProhibitHistory();
        history.setBlockIp("10.0.0.1");
        history.setLinkDeviceIp("192.168.1.1");
        int rows = mapper.insertProhibitHistory(history);
        return "SUCCESS: " + rows;
    }

    @GetMapping("/updateByBlockipAndDeviceIp")
    public String test03() {
        ProhibitHistory history = new ProhibitHistory();
        history.setBlockIp("10.0.0.1");
        history.setLinkDeviceIp("192.168.1.1");
        mapper.updateByBlockipAndDeviceIp(history);
        return "SUCCESS";
    }

    @GetMapping("/updateStatusById")
    public String test04() {
        ProhibitHistory history = new ProhibitHistory();
        history.setId(1L);
        history.setStatus(false);
        mapper.updateStatusById(history);
        return "SUCCESS";
    }

    @GetMapping("/deleteByIds")
    public String test05() {
        int rows = mapper.deleteByIds(Arrays.asList(1L, 2L));
        return "SUCCESS: " + rows;
    }

    @GetMapping("/getProhibitListByCondition")
    public String test06() {
        ProhibitHistoryParam param = new ProhibitHistoryParam();
        List<ProhibitHistoryVO> result = mapper.getProhibitListByCondition(param);
        return "SUCCESS: " + result.size();
    }

    @GetMapping("/listByCondition")
    public String test07() {
        ProhibitHistoryParam param = new ProhibitHistoryParam();
        List<ProhibitHistoryVO> result = mapper.listByCondition(param);
        return "SUCCESS: " + result.size();
    }

    @GetMapping("/getProhibitListCount")
    public String test08() {
        ProhibitHistoryParam param = new ProhibitHistoryParam();
        Long count = mapper.getProhibitListCount(param);
        return "SUCCESS: " + count;
    }

    @GetMapping("/getBlockIPDistribution")
    public String test09() {
        String now = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        String yesterday = LocalDateTime.now().minusDays(1).format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        List<BlockIPDistribution> result = mapper.getBlockIPDistribution(yesterday, now);
        return "SUCCESS: " + result.size();
    }

    @GetMapping("/getTrend")
    public String test10() {
        String now = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        String lastWeek = LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        List<BlockIPTrend> result = mapper.getTrend(lastWeek, now);
        return "SUCCESS: " + result.size();
    }

    @GetMapping("/getBlockIPCount")
    public String test11() {
        String now = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        String lastWeek = LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        Long count = mapper.getBlockIPCount(lastWeek, now);
        return "SUCCESS: " + count;
    }

    @GetMapping("/getBlockIPTodayCount")
    public String test12() {
        Long count = mapper.getBlockIPTodayCount();
        return "SUCCESS: " + count;
    }

    @GetMapping("/getAutoBlockIPCount")
    public String test13() {
        String now = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        String lastWeek = LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        Long count = mapper.getAutoBlockIPCount(lastWeek, now);
        return "SUCCESS: " + count;
    }

    @GetMapping("/getAutoBlockIPTodayCount")
    public String test14() {
        Long count = mapper.getAutoBlockIPTodayCount();
        return "SUCCESS: " + count;
    }

    @GetMapping("/getTriggerSubscriptionCount")
    public String test15() {
        String now = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        String lastWeek = LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        Long count = mapper.getTriggerSubscriptionCount(lastWeek, now);
        return "SUCCESS: " + count;
    }

    @GetMapping("/getStrategyCount")
    public String test16() {
        String now = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        String lastWeek = LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        Long count = mapper.getStrategyCount(lastWeek, now);
        return "SUCCESS: " + count;
    }

    @GetMapping("/getProhibitListByDeviceId")
    public String test17() {
        List<ProhibitHistoryVO> result = mapper.getProhibitListByDeviceId("device-001", "192.168.1.1");
        return "SUCCESS: " + result.size();
    }

    @GetMapping("/getPairHistories")
    public String test18() {
        Map<String, Object> params = new HashMap<>();
        List<ProhibitHistoryVO> result = mapper.getPairHistories(params);
        return "SUCCESS: " + result.size();
    }

    @GetMapping("/getSingleHistories")
    public String test19() {
        Map<String, Object> params = new HashMap<>();
        List<ProhibitHistoryVO> result = mapper.getSingleHistories(params);
        return "SUCCESS: " + result.size();
    }

    /**
     * 条件分支测试1：listByCondition - direction = 'in' (入向)
     * <when test="item == 'in'"> direction = 1 </when>
     */
    @GetMapping("/testListByConditionDirectionIn")
    public String testListByCondition_DirectionIn() {
        try {
            System.out.println("测试: listByCondition - direction = 'in'");
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setDirection("in");  // 触发 direction = 1 条件
            param.setLimit(10);
            param.setOffset(0);
            
            List<ProhibitHistoryVO> result = mapper.listByCondition(param);
            System.out.println("结果: 查询到 " + result.size() + " 条入向封禁记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testListByCondition_DirectionIn 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 条件分支测试2：listByCondition - direction = 'out' (出向)
     * <when test="item == 'out'"> direction = 2 </when>
     */
    @GetMapping("/testListByConditionDirectionOut")
    public String testListByCondition_DirectionOut() {
        try {
            System.out.println("测试: listByCondition - direction = 'out'");
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setDirection("out");  // 触发 direction = 2 条件
            param.setLimit(10);
            param.setOffset(0);
            
            List<ProhibitHistoryVO> result = mapper.listByCondition(param);
            System.out.println("结果: 查询到 " + result.size() + " 条出向封禁记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testListByCondition_DirectionOut 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 条件分支测试3：listByCondition - direction = 'both' (双向)
     * <otherwise> direction = 3 </otherwise>
     */
    @GetMapping("/testListByConditionDirectionBoth")
    public String testListByCondition_DirectionBoth() {
        try {
            System.out.println("测试: listByCondition - direction = 'both'");
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setDirection("both");  // 触发 otherwise (direction = 3) 条件
            param.setLimit(10);
            param.setOffset(0);
            
            List<ProhibitHistoryVO> result = mapper.listByCondition(param);
            System.out.println("结果: 查询到 " + result.size() + " 条双向封禁记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testListByCondition_DirectionBoth 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 条件分支测试4：getProhibitListCount - direction = 'in'
     */
    @GetMapping("/testGetProhibitListCountDirectionIn")
    public String testGetProhibitListCount_DirectionIn() {
        try {
            System.out.println("测试: getProhibitListCount - direction = 'in'");
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setDirection("in");
            
            Long count = mapper.getProhibitListCount(param);
            System.out.println("结果: 统计到 " + count + " 条入向封禁记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetProhibitListCount_DirectionIn 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 条件分支测试5：getProhibitListCount - direction = 'out'
     */
    @GetMapping("/testGetProhibitListCountDirectionOut")
    public String testGetProhibitListCount_DirectionOut() {
        try {
            System.out.println("测试: getProhibitListCount - direction = 'out'");
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setDirection("out");
            
            Long count = mapper.getProhibitListCount(param);
            System.out.println("结果: 统计到 " + count + " 条出向封禁记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetProhibitListCount_DirectionOut 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 条件分支测试6：getProhibitListCount - direction = 'both'
     */
    @GetMapping("/testGetProhibitListCountDirectionBoth")
    public String testGetProhibitListCount_DirectionBoth() {
        try {
            System.out.println("测试: getProhibitListCount - direction = 'both'");
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setDirection("both");
            
            Long count = mapper.getProhibitListCount(param);
            System.out.println("结果: 统计到 " + count + " 条双向封禁记录");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetProhibitListCount_DirectionBoth 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 条件分支测试7：getProhibitListByCondition - 默认排序
     * <when test="orderByStr == null or orderByStr == ''">
     */
    @GetMapping("/testGetProhibitListByConditionDefaultOrder")
    public String testGetProhibitListByCondition_DefaultOrder() {
        try {
            System.out.println("测试: getProhibitListByCondition - 默认排序");
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setLimit(10);
            param.setOffset(0);
            // 不设置 orderByStr
            
            List<ProhibitHistoryVO> result = mapper.getProhibitListByCondition(param);
            System.out.println("结果: 查询到 " + result.size() + " 条记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetProhibitListByCondition_DefaultOrder 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 条件分支测试8：getProhibitListByCondition - 自定义排序
     * <otherwise> ${orderByStr} </otherwise>
     */
    @GetMapping("/testGetProhibitListByConditionCustomOrder")
    public String testGetProhibitListByCondition_CustomOrder() {
        try {
            System.out.println("测试: getProhibitListByCondition - 自定义排序");
            ProhibitHistoryParam param = new ProhibitHistoryParam();
            param.setLimit(10);
            param.setOffset(0);
            param.setOrderByStr("create_time asc, block_ip asc");  // 自定义排序
            
            List<ProhibitHistoryVO> result = mapper.getProhibitListByCondition(param);
            System.out.println("结果: 查询到 " + result.size() + " 条记录 (按自定义顺序)");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetProhibitListByCondition_CustomOrder 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 条件分支测试9：getHistoryByBlockList - prohibitDomain = true (域名封禁)
     * <when test="prohibitDomain"> t_prohibit_domain_history </when>
     */
    @GetMapping("/testGetHistoryByBlockListDomain")
    public String testGetHistoryByBlockList_Domain() {
        try {
            System.out.println("测试: getHistoryByBlockList - 域名封禁");
            List<String> blockList = Arrays.asList("evil.com", "malware.net");
            
            List<ProhibitHistory> result = mapper.getHistoryByBlockList(blockList, true);  // prohibitDomain = true
            System.out.println("结果: 查询到 " + result.size() + " 条域名封禁记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGetHistoryByBlockList_Domain 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
