package com.test.controller;

import com.dbapp.extension.xdr.threatIntelligence.mapper.IntelligenceMapper;
import com.dbapp.extension.xdr.threatIntelligence.entity.IntelligenceSub;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * Intelligence 测试 Controller
 * 
 * 所有测试方法使用 GET 请求，参数在方法内部写死
 * 通过 Postman 调用 http://localhost:8080/test/intelligence/testX_methodName
 * 
 * 测试数据：使用test_data.sql中的测试数据
 * 
 * 生成时间: 2026-01-26
 */
@RestController
@RequestMapping("/test/intelligence")
public class IntelligenceTestController {
    
    @Autowired
    private IntelligenceMapper mapper;

    /**
     * 测试1：批量保存或更新
     * URL: /test/intelligence/saveOrUpdateBatch
     */
    @GetMapping("/saveOrUpdateBatch")
    public String testSaveOrUpdateBatch() {
        try {
            System.out.println("=== 测试: saveOrUpdateBatch ===");
            
            List<IntelligenceSub> subList = new ArrayList<>();
            IntelligenceSub sub = new IntelligenceSub();
            sub.setIoC("malware-test.com");
            sub.setEventTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            sub.setStartTime(LocalDateTime.now().minusHours(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            sub.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            sub.setUpdateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            sub.setSubCategory("C2");
            sub.setAlarmName("C&C通信");
            sub.setThreatSeverity(3);
            sub.setCounts(10L);
            sub.setTag("测试标签");
            sub.setAlarmStatus(1);
            subList.add(sub);
            
            int rows = mapper.saveOrUpdateBatch(subList);
            System.out.println("✓ 影响 " + rows + " 行");
            return "SUCCESS: " + rows + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 saveOrUpdateBatch 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试2：插入IoC资产
     * URL: /test/intelligence/insertIoCAsset
     */
    @GetMapping("/insertIoCAsset")
    public String testInsertIoCAsset() {
        try {
            System.out.println("=== 测试: insertIoCAsset ===");
            
            List<IntelligenceSub> subList = new ArrayList<>();
            IntelligenceSub sub = new IntelligenceSub();
            sub.setIoC("malicious-ip-001");
            sub.setAssetIp("192.168.1.100");
            sub.setEventTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            sub.setStartTime(LocalDateTime.now().minusHours(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            sub.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            sub.setAlarmStatus(1);
            sub.setCounts(5L);
            sub.setSecurityZone("DMZ");
            subList.add(sub);
            
            int rows = mapper.insertIoCAsset(subList);
            System.out.println("✓ 影响 " + rows + " 行");
            return "SUCCESS: " + rows + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 insertIoCAsset 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试3：查询列表数量
     * URL: /test/intelligence/listCount
     */
    @GetMapping("/listCount")
    public String testListCount() {
        try {
            System.out.println("=== 测试: listCount ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            
            Long count = mapper.listCount(params);
            System.out.println("✓ 共 " + count + " 条");
            return "SUCCESS: " + count + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 listCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试4：查询列表
     * URL: /test/intelligence/list
     */
    @GetMapping("/list")
    public String testList() {
        try {
            System.out.println("=== 测试: list ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("offset", 0);
            params.put("limit", 10);
            
            List<Map<String, Object>> result = mapper.list(params);
            System.out.println("✓ 共 " + result.size() + " 条");
            return "SUCCESS: " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 list 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试5：更新资产列表
     * URL: /test/intelligence/updateAssetList
     */
    @GetMapping("/updateAssetList")
    public String testUpdateAssetList() {
        try {
            System.out.println("=== 测试: updateAssetList ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("ioC", "test-ioc");
            params.put("eventTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            
            mapper.updateAssetList(params);
            System.out.println("✓ 更新成功");
            return "SUCCESS: 更新完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 updateAssetList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试6：从资产更新列表
     * URL: /test/intelligence/updateListFromAsset
     */
    @GetMapping("/updateListFromAsset")
    public String testUpdateListFromAsset() {
        try {
            System.out.println("=== 测试: updateListFromAsset ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("ioC", "test-ioc");
            params.put("eventTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            
            mapper.updateListFromAsset(params);
            System.out.println("✓ 更新成功");
            return "SUCCESS: 更新完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 updateListFromAsset 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试7：更新列表
     * URL: /test/intelligence/updateList
     */
    @GetMapping("/updateList")
    public String testUpdateList() {
        try {
            System.out.println("=== 测试: updateList ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("ioC", "test-ioc");
            params.put("eventTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            params.put("alarmStatus", 0);
            
            mapper.updateList(params);
            System.out.println("✓ 更新成功");
            return "SUCCESS: 更新完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 updateList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试8：部分导出
     * URL: /test/intelligence/partExport
     */
    @GetMapping("/partExport")
    public String testPartExport() {
        try {
            System.out.println("=== 测试: partExport ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("offset", 0);
            params.put("limit", 100);
            
            List<Map<String, Object>> result = mapper.partExport(params);
            System.out.println("✓ 导出 " + result.size() + " 条");
            return "SUCCESS: " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 partExport 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试9：查询比例
     * URL: /test/intelligence/proportion
     */
    @GetMapping("/proportion")
    public String testProportion() {
        try {
            System.out.println("=== 测试: proportion ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            
            List<Map<String, Object>> result = mapper.proportion(params);
            System.out.println("✓ 共 " + result.size() + " 种类型");
            return "SUCCESS: " + result.size() + " 种类型";
        } catch (Exception e) {
            String errorMsg = "测试方法 proportion 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试10：查询Top5
     * URL: /test/intelligence/top5
     */
    @GetMapping("/top5")
    public String testTop5() {
        try {
            System.out.println("=== 测试: top5 ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("startTime", LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            
            List<Map<String, Object>> result = mapper.top5(params);
            System.out.println("✓ Top " + result.size() + " 条");
            return "SUCCESS: Top " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 top5 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试11：查询子列表数量
     * URL: /test/intelligence/subListCount
     */
    @GetMapping("/subListCount")
    public String testSubListCount() {
        try {
            System.out.println("=== 测试: subListCount ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("ioC", "test-ioc");
            params.put("startTime", LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            
            Long count = mapper.subListCount(params);
            System.out.println("✓ 共 " + count + " 条");
            return "SUCCESS: " + count + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 subListCount 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试12：查询子列表
     * URL: /test/intelligence/subList
     */
    @GetMapping("/subList")
    public String testSubList() {
        try {
            System.out.println("=== 测试: subList ===");
            
            Map<String, Object> params = new HashMap<>();
            params.put("ioC", "test-ioc");
            params.put("startTime", LocalDateTime.now().minusDays(7).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("endTime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            params.put("offset", 0);
            params.put("limit", 10);
            
            List<Map<String, Object>> result = mapper.subList(params);
            System.out.println("✓ 共 " + result.size() + " 条");
            return "SUCCESS: " + result.size() + " 条";
        } catch (Exception e) {
            String errorMsg = "测试方法 subList 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试13：更新标签
     * URL: /test/intelligence/updateTag
     */
    @GetMapping("/updateTag")
    public String testUpdateTag() {
        try {
            System.out.println("=== 测试: updateTag ===");
            
            List<IntelligenceSub> subList = new ArrayList<>();
            IntelligenceSub sub = new IntelligenceSub();
            sub.setIoC("test-ioc");
            sub.setTag("新标签");
            sub.setEventTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            subList.add(sub);
            
            mapper.updateTag(subList);
            System.out.println("✓ 更新成功");
            return "SUCCESS: 更新标签完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 updateTag 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 测试14：更新资产标签
     * URL: /test/intelligence/updateAssetTag
     */
    @GetMapping("/updateAssetTag")
    public String testUpdateAssetTag() {
        try {
            System.out.println("=== 测试: updateAssetTag ===");
            
            List<IntelligenceSub> subList = new ArrayList<>();
            IntelligenceSub sub = new IntelligenceSub();
            sub.setIoC("test-ioc");
            sub.setAssetIp("192.168.1.100");
            sub.setTag("资产标签");
            sub.setEventTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            subList.add(sub);
            
            mapper.updateAssetTag(subList);
            System.out.println("✓ 更新成功");
            return "SUCCESS: 更新资产标签完成";
        } catch (Exception e) {
            String errorMsg = "测试方法 updateAssetTag 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
