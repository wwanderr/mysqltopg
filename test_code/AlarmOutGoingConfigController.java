package com.dbapp.extension.xdr.outgoingData.controller;

import com.dbapp.extension.xdr.outgoingData.mapper.AlarmOutGoingConfigMapper;
import com.dbapp.extension.xdr.outgoingData.po.AlarmOutGoingConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 告警外发配置 Controller
 * 用于测试PostgreSQL XML转换后的SQL语句
 * 
 * @author Auto Generated
 * @date 2026-01-22
 */
@RestController
@RequestMapping("/api/test/alarm-outgoing-config")
public class AlarmOutGoingConfigController {
    
    @Autowired
    private AlarmOutGoingConfigMapper alarmOutGoingConfigMapper;
    
    /**
     * 测试方法1：删除记录（逻辑删除）
     * 
     * XML方法：delById
     * SQL：UPDATE t_alarm_out_going_config SET IS_DEL = 1 WHERE id = #{alarmOutGoingConfig.id}
     * 
     * @param id 记录ID
     * @return 测试结果
     */
    @DeleteMapping("/delete/{id}")
    public Map<String, Object> testDelById(@PathVariable Long id) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 构造参数对象
            AlarmOutGoingConfig config = new AlarmOutGoingConfig();
            config.setId(id);
            
            // 执行删除
            int affectedRows = alarmOutGoingConfigMapper.delById(config);
            
            // 返回结果
            result.put("success", true);
            result.put("method", "delById");
            result.put("affectedRows", affectedRows);
            result.put("message", "逻辑删除成功");
            result.put("testId", id);
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("method", "delById");
            result.put("error", e.getMessage());
            result.put("stackTrace", e.getClass().getName());
        }
        
        return result;
    }
    
    /**
     * 测试方法2：更新发送状态（成功）
     * 
     * XML方法：updateSendStatus
     * SQL：更新last_send_time, send_count, last_send_result, cause_of_failure
     *      如果成功则增加succeed_count
     * 
     * @param request 请求体
     * @return 测试结果
     */
    @PostMapping("/update-status/success")
    public Map<String, Object> testUpdateSendStatusSuccess(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 构造参数对象
            AlarmOutGoingConfig config = new AlarmOutGoingConfig();
            config.setId(Long.valueOf(request.get("id").toString()));
            config.setLastSendResult("成功");
            config.setCauseOfFailure(null);
            
            // 执行更新
            int affectedRows = alarmOutGoingConfigMapper.updateSendStatus(config);
            
            // 返回结果
            result.put("success", true);
            result.put("method", "updateSendStatus");
            result.put("scenario", "发送成功");
            result.put("affectedRows", affectedRows);
            result.put("message", "更新发送状态成功，send_count +1, succeed_count +1");
            result.put("testId", config.getId());
            result.put("lastSendResult", config.getLastSendResult());
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("method", "updateSendStatus");
            result.put("scenario", "发送成功");
            result.put("error", e.getMessage());
            result.put("stackTrace", e.getClass().getName());
        }
        
        return result;
    }
    
    /**
     * 测试方法3：更新发送状态（失败）
     * 
     * XML方法：updateSendStatus
     * SQL：更新last_send_time, send_count, last_send_result, cause_of_failure
     *      失败时不增加succeed_count
     * 
     * @param request 请求体
     * @return 测试结果
     */
    @PostMapping("/update-status/failure")
    public Map<String, Object> testUpdateSendStatusFailure(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 构造参数对象
            AlarmOutGoingConfig config = new AlarmOutGoingConfig();
            config.setId(Long.valueOf(request.get("id").toString()));
            config.setLastSendResult("失败");
            config.setCauseOfFailure(request.getOrDefault("causeOfFailure", "网络超时").toString());
            
            // 执行更新
            int affectedRows = alarmOutGoingConfigMapper.updateSendStatus(config);
            
            // 返回结果
            result.put("success", true);
            result.put("method", "updateSendStatus");
            result.put("scenario", "发送失败");
            result.put("affectedRows", affectedRows);
            result.put("message", "更新发送状态失败，send_count +1, succeed_count不变");
            result.put("testId", config.getId());
            result.put("lastSendResult", config.getLastSendResult());
            result.put("causeOfFailure", config.getCauseOfFailure());
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("method", "updateSendStatus");
            result.put("scenario", "发送失败");
            result.put("error", e.getMessage());
            result.put("stackTrace", e.getClass().getName());
        }
        
        return result;
    }
    
    /**
     * 组合测试：完整测试流程
     * 
     * @param id 测试记录ID
     * @return 测试结果
     */
    @GetMapping("/full-test/{id}")
    public Map<String, Object> fullTest(@PathVariable Long id) {
        Map<String, Object> result = new HashMap<>();
        result.put("testId", id);
        
        try {
            // 步骤1：更新发送状态为成功
            AlarmOutGoingConfig config1 = new AlarmOutGoingConfig();
            config1.setId(id);
            config1.setLastSendResult("成功");
            int step1 = alarmOutGoingConfigMapper.updateSendStatus(config1);
            result.put("step1_updateSuccess", step1);
            
            // 步骤2：更新发送状态为失败
            AlarmOutGoingConfig config2 = new AlarmOutGoingConfig();
            config2.setId(id);
            config2.setLastSendResult("失败");
            config2.setCauseOfFailure("测试失败场景");
            int step2 = alarmOutGoingConfigMapper.updateSendStatus(config2);
            result.put("step2_updateFailure", step2);
            
            // 步骤3：逻辑删除
            AlarmOutGoingConfig config3 = new AlarmOutGoingConfig();
            config3.setId(id);
            int step3 = alarmOutGoingConfigMapper.delById(config3);
            result.put("step3_delete", step3);
            
            result.put("success", true);
            result.put("message", "完整测试流程执行成功");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
            result.put("stackTrace", e.getClass().getName());
        }
        
        return result;
    }
}
