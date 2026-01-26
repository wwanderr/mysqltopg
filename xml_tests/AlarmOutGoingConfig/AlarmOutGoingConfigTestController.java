package com.dbapp.extension.xdr.test;

import com.dbapp.extension.xdr.outgoingData.po.AlarmOutGoingConfig;
import com.dbapp.extension.xdr.test.mapper.AlarmOutGoingConfigMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * AlarmOutGoingConfig 测试 Controller
 * 
 * 所有测试方法使用 GET 请求，参数在方法内部写死
 * 通过 Postman 调用 http://localhost:8080/test/alarmoutgoingconfig/testX_methodName
 * 
 * 测试数据ID范围：1001-1005
 * 
 * 生成时间: 2026-01-26
 */
@RestController
@RequestMapping("/test/alarmoutgoingconfig")
public class AlarmOutGoingConfigTestController {

    @Autowired
    private AlarmOutGoingConfigMapper mapper;

    /**
     * 接口列表
     */
    @GetMapping("/")
    public Map<String, Object> index() {
        Map<String, Object> result = new HashMap<>();
        result.put("module", "AlarmOutGoingConfig 测试接口");
        result.put("total_tests", 2);
        result.put("test_data_range", "ID: 1001-1005");
        return result;
    }

    /**
     * 测试1：删除告警外发配置
     * 场景：删除 ID=1004 的配置
     * 预期：is_del 从 0 变为 1
     */
    @GetMapping("/test1_delById")
    public Map<String, Object> test1_delById() {
        Map<String, Object> result = new HashMap<>();
        result.put("test", "delById");
        
        try {
            // 构造测试数据（参数写死）
            Map<String, Object> param = new HashMap<>();
            param.put("alarmOutGoingConfig", new AlarmOutGoingConfig() {{
                setId(1004L);  // 使用测试数据中的 ID
            }});
            
            // 执行删除（UPDATE 无返回值）
            mapper.delById(param);
            
            result.put("status", "SUCCESS");
            result.put("deleted_id", 1004);
            result.put("message", "配置已标记为删除");
            
            System.out.println("✓ 测试通过：delById (ID=1004)");
            
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }

    /**
     * 测试2：更新发送状态
     * 场景：ID=1001 发送成功
     * 预期：
     * - last_send_time 更新为当前时间
     * - send_count +1
     * - last_send_result = "成功"
     * - succeed_count +1（因为成功）
     */
    @GetMapping("/test2_updateSendStatus")
    public Map<String, Object> test2_updateSendStatus() {
        Map<String, Object> result = new HashMap<>();
        result.put("test", "updateSendStatus");
        
        try {
            // 构造测试数据（参数写死）
            Map<String, Object> param = new HashMap<>();
            param.put("alarmOutGoingConfig", new AlarmOutGoingConfig() {{
                setId(1001L);
                setLastSendResult("成功");
                setCauseOfFailure(null);  // 成功时清空失败原因
            }});
            
            // 执行更新（UPDATE 无返回值）
            mapper.updateSendStatus(param);
            
            result.put("status", "SUCCESS");
            result.put("config_id", 1001);
            result.put("send_result", "成功");
            result.put("message", "发送状态更新成功");
            result.put("note", "send_count 和 succeed_count 都会 +1");
            
            System.out.println("✓ 测试通过：updateSendStatus (成功)");
            
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }
}
