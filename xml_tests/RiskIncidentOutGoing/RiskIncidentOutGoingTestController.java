package com.test.controller;

import com.dbapp.extension.xdr.threatMonitor.mapper.RiskIncidentOutGoingMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentOutGoing;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.joda.time.DateTime;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * RiskIncidentOutGoing 深度测试控制器
 * 主表：t_risk_incidents_out_going
 * 测试方法数：14个（根据反编译接口定义）
 * 生成时间：2026-01-30（根据反编译接口完全修复）
 */
@RestController
@RequestMapping("/test/riskIncidentOutGoing")
public class RiskIncidentOutGoingTestController {
    
    @Autowired
    private RiskIncidentOutGoingMapper mapper;

    /**
     * 方法1：mappingFromClueSecurityEvent
     * 参数：eventIds (List<Long>)
     */
    @GetMapping("/testMappingFromClueSecurityEvent")
    public String testMappingFromClueSecurityEvent() {
        try {
            System.out.println("测试: mappingFromClueSecurityEvent - 线索事件映射");
            
            List<RiskIncidentOutGoing> result = mapper.mappingFromClueSecurityEvent(
                Arrays.asList(1001L, 1002L, 1003L)
            );
            
            System.out.println("结果: 查询到 " + result.size() + " 条记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testMappingFromClueSecurityEvent 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：backUpLastTermData
     * 参数：currentDate (String), timestamp (DateTime)
     */
    @GetMapping("/testBackUpLastTermData")
    public String testBackUpLastTermData() {
        try {
            System.out.println("测试: backUpLastTermData - 备份到历史表");
            
            String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            DateTime timestamp = DateTime.now();
            
            mapper.backUpLastTermData(currentDate, timestamp);
            System.out.println("结果: 备份成功");
            return "SUCCESS: backup completed";
        } catch (Exception e) {
            String errorMsg = "测试方法 testBackUpLastTermData 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：batchInsertOrUpdateIncident
     * 参数：riskIncidentList (List<RiskIncidentOutGoing>)
     */
    @GetMapping("/testBatchInsertOrUpdateIncident")
    public String testBatchInsertOrUpdateIncident() {
        try {
            System.out.println("测试: batchInsertOrUpdateIncident - 批量插入或更新");
            
            List<RiskIncidentOutGoing> list = new ArrayList<>();
            RiskIncidentOutGoing incident = new RiskIncidentOutGoing();
            incident.setUniqCode("TEST-CODE-001");
            incident.setEventCode("RISK-2026-TEST");
            incident.setName("测试外发事件");
            // 设置其他必要字段...
            list.add(incident);
            
            mapper.batchInsertOrUpdateIncident(list);
            System.out.println("结果: 批量处理 " + list.size() + " 条记录");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testBatchInsertOrUpdateIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法4：deleteOldIncident
     * 参数：currentDate (String), ids (List<Long>)
     */
    @GetMapping("/testDeleteOldIncident")
    public String testDeleteOldIncident() {
        try {
            System.out.println("测试: deleteOldIncident - 删除旧数据");
            
            String currentDate = "2026-01-29";  // 昨天的日期
            
            mapper.deleteOldIncident(
                currentDate,
                Arrays.asList(9999L)  // 不存在的ID，不会真删除数据
            );
            System.out.println("结果: 删除成功");
            return "SUCCESS: deleted";
        } catch (Exception e) {
            String errorMsg = "测试方法 testDeleteOldIncident 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法5：queryListByTime
     * 参数：startTime, endTime, offset (long), size (long)
     */
    @GetMapping("/testQueryListByTime")
    public String testQueryListByTime() {
        try {
            System.out.println("测试: queryListByTime - 按时间查询列表");
            
            List<RiskIncidentOutGoing> result = mapper.queryListByTime(
                "2026-01-25 00:00:00",  // startTime
                "2026-01-30 23:59:59",  // endTime
                0L,                      // offset
                10L                      // size
            );
            
            System.out.println("结果: 查询到 " + result.size() + " 条记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryListByTime 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法6：batchUpdatePayload
     * 参数：List<RiskIncidentOutGoing>（无@Param注解）
     */
    @GetMapping("/testBatchUpdatePayload")
    public String testBatchUpdatePayload() {
        try {
            System.out.println("测试: batchUpdatePayload - 批量更新payload");
            
            List<RiskIncidentOutGoing> list = new ArrayList<>();
            RiskIncidentOutGoing incident = new RiskIncidentOutGoing();
            incident.setId(1001L);
            incident.setPayload("{\"updated\": true}");
            list.add(incident);
            
            mapper.batchUpdatePayload(list);
            System.out.println("结果: 批量更新 " + list.size() + " 条记录");
            return "SUCCESS: " + list.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testBatchUpdatePayload 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法7：clearHistoryData
     * 参数：timestamp (DateTime)
     */
    @GetMapping("/testClearHistoryData")
    public String testClearHistoryData() {
        try {
            System.out.println("测试: clearHistoryData - 清理历史数据");
            
            DateTime timestamp = DateTime.now().minusDays(30);
            
            mapper.clearHistoryData(timestamp);
            System.out.println("结果: 清理成功");
            return "SUCCESS: cleared";
        } catch (Exception e) {
            String errorMsg = "测试方法 testClearHistoryData 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法8：queryOutGoingList
     * 参数：startTime, endTime, lastTermTime, offset (long), size (long)
     */
    @GetMapping("/testQueryOutGoingList")
    public String testQueryOutGoingList() {
        try {
            System.out.println("测试: queryOutGoingList - 查询外发列表");
            
            List<Map<String, Object>> result = mapper.queryOutGoingList(
                "2026-01-25 00:00:00",  // startTime
                "2026-01-30 23:59:59",  // endTime
                "2026-01-20 00:00:00",  // lastTermTime
                0L,                      // offset
                10L                      // size
            );
            
            System.out.println("结果: 查询到 " + result.size() + " 条记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testQueryOutGoingList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法9：selectOldIncidentByCodes
     * 参数：currentDate, excludeUniqCodes (List<String>)
     */
    @GetMapping("/testSelectOldIncidentByCodes")
    public String testSelectOldIncidentByCodes() {
        try {
            System.out.println("测试: selectOldIncidentByCodes - 根据代码选择旧事件");
            
            String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            
            List<Long> ids = mapper.selectOldIncidentByCodes(
                currentDate,
                Arrays.asList("EXCLUDE-CODE-001", "EXCLUDE-CODE-002")
            );
            
            System.out.println("结果: 查询到 " + ids.size() + " 个ID");
            return "SUCCESS: " + ids.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectOldIncidentByCodes 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法10：updateKillChain
     * 参数：beforeTime (String)
     */
    @GetMapping("/testUpdateKillChain")
    public String testUpdateKillChain() {
        try {
            System.out.println("测试: updateKillChain - 更新攻击链");
            
            String beforeTime = LocalDateTime.now().minusHours(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            
            mapper.updateKillChain(beforeTime);
            System.out.println("结果: 更新成功");
            return "SUCCESS: updated";
        } catch (Exception e) {
            String errorMsg = "测试方法 testUpdateKillChain 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法11：groupByFocusIp
     * 参数：focusIps (List<String>), startTime, endTime, top (Integer)
     */
    @GetMapping("/testGroupByFocusIp")
    public String testGroupByFocusIp() {
        try {
            System.out.println("测试: groupByFocusIp - 按焦点IP分组");
            
            List<Map<String, Object>> result = mapper.groupByFocusIp(
                Arrays.asList("192.168.10.50", "192.168.20.88"),  // focusIps
                "2026-01-25 00:00:00",  // startTime
                "2026-01-30 23:59:59",  // endTime
                10  // top
            );
            
            System.out.println("结果: 查询到 " + result.size() + " 条记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGroupByFocusIp 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法12：groupNameByFocusIp
     * 参数：focusIps (List<String>), startTime, endTime
     */
    @GetMapping("/testGroupNameByFocusIp")
    public String testGroupNameByFocusIp() {
        try {
            System.out.println("测试: groupNameByFocusIp - 按焦点IP分组名称");
            
            List<Map<String, Object>> result = mapper.groupNameByFocusIp(
                Arrays.asList("192.168.10.50", "192.168.20.88"),  // focusIps
                "2026-01-25 00:00:00",  // startTime
                "2026-01-30 23:59:59"   // endTime
            );
            
            System.out.println("结果: 查询到 " + result.size() + " 条记录");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testGroupNameByFocusIp 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法13：selectOldHistoryIds
     * 参数：beforeTime (String), lastId (long), size (long)
     */
    @GetMapping("/testSelectOldHistoryIds")
    public String testSelectOldHistoryIds() {
        try {
            System.out.println("测试: selectOldHistoryIds - 选择旧历史ID");
            
            String beforeTime = LocalDateTime.now().minusDays(30).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            
            List<Long> ids = mapper.selectOldHistoryIds(
                beforeTime,  // beforeTime
                0L,          // lastId
                100L         // size
            );
            
            System.out.println("结果: 查询到 " + ids.size() + " 个ID");
            return "SUCCESS: " + ids.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 testSelectOldHistoryIds 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法14：deleteHistoryByIds
     * 参数：ids (List<Long>)
     */
    @GetMapping("/testDeleteHistoryByIds")
    public String testDeleteHistoryByIds() {
        try {
            System.out.println("测试: deleteHistoryByIds - 按ID删除历史");
            
            mapper.deleteHistoryByIds(Arrays.asList(9999L));  // 不存在的ID
            System.out.println("结果: 删除成功");
            return "SUCCESS: deleted";
        } catch (Exception e) {
            String errorMsg = "测试方法 testDeleteHistoryByIds 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试汇总方法 - 执行所有测试
     */
    @GetMapping("/testAll")
    public String testAll() {
        StringBuilder result = new StringBuilder("开始执行所有测试...\n\n");
        int successCount = 0;
        int failCount = 0;

        String[] testMethods = {
            "testMappingFromClueSecurityEvent", "testBackUpLastTermData", "testBatchInsertOrUpdateIncident",
            "testDeleteOldIncident", "testQueryListByTime", "testBatchUpdatePayload",
            "testClearHistoryData", "testQueryOutGoingList", "testSelectOldIncidentByCodes",
            "testUpdateKillChain", "testGroupByFocusIp", "testGroupNameByFocusIp",
            "testSelectOldHistoryIds", "testDeleteHistoryByIds"
        };

        for (int i = 0; i < testMethods.length; i++) {
            String methodName = testMethods[i];
            try {
                String testResult = "";
                switch (i) {
                    case 0: testResult = testMappingFromClueSecurityEvent(); break;
                    case 1: testResult = testBackUpLastTermData(); break;
                    case 2: testResult = testBatchInsertOrUpdateIncident(); break;
                    case 3: testResult = testDeleteOldIncident(); break;
                    case 4: testResult = testQueryListByTime(); break;
                    case 5: testResult = testBatchUpdatePayload(); break;
                    case 6: testResult = testClearHistoryData(); break;
                    case 7: testResult = testQueryOutGoingList(); break;
                    case 8: testResult = testSelectOldIncidentByCodes(); break;
                    case 9: testResult = testUpdateKillChain(); break;
                    case 10: testResult = testGroupByFocusIp(); break;
                    case 11: testResult = testGroupNameByFocusIp(); break;
                    case 12: testResult = testSelectOldHistoryIds(); break;
                    case 13: testResult = testDeleteHistoryByIds(); break;
                }

                if (testResult.startsWith("SUCCESS")) {
                    result.append("✓ ").append(methodName).append(": ").append(testResult).append("\n");
                    successCount++;
                } else {
                    result.append("✗ ").append(methodName).append(": ").append(testResult).append("\n");
                    failCount++;
                }
            } catch (Exception e) {
                result.append("✗ ").append(methodName).append(": ERROR - ").append(e.getMessage()).append("\n");
                failCount++;
            }
        }

        result.append("\n测试汇总: 成功=").append(successCount).append(", 失败=").append(failCount);
        result.append(", 总计=").append(testMethods.length).append("\n");

        return result.toString();
    }
}
