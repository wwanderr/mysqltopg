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
 * AlarmOutGoingConfig (告警外发配置) 深度测试控制器
 * 主表：t_alarm_out_going_config (15个字段)
 * 测试方法数：2 (delById, updateSendStatus)
 * 生成时间：2026-01-28
 */
@RestController
@RequestMapping("/test/alarmOutGoingConfig")
public class AlarmOutGoingConfigTestController {

    @Autowired
    private AlarmOutGoingConfigMapper mapper;

    /**
     * 方法1：delById - 删除告警外发配置（逻辑删除）
     * 测试条件：UPDATE SET is_del=1
     */
    @GetMapping("/test1_delById")
    public String test1_delById() {
        try {
            System.out.println("测试: delById - 逻辑删除告警外发配置");
            Map<String, Object> param = new HashMap<>();
            param.put("alarmOutGoingConfig", new AlarmOutGoingConfig() {{
                setId(1004L);  // 测试数据中的ID
            }});
            
            mapper.delById(param);
            System.out.println("结果: 已标记删除 ID=1004");
            return "SUCCESS: 1";
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_delById 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：updateSendStatus - 更新发送状态
     * 测试条件：UPDATE SET last_send_time, send_count+1, succeed_count+1 (if 成功)
     */
    @GetMapping("/test2_updateSendStatus")
    public String test2_updateSendStatus() {
        try {
            System.out.println("测试: updateSendStatus - 更新发送状态");
            Map<String, Object> param = new HashMap<>();
            param.put("alarmOutGoingConfig", new AlarmOutGoingConfig() {{
                setId(1001L);
                setLastSendResult("成功");
                setCauseOfFailure(null);
            }});
            
            mapper.updateSendStatus(param);
            System.out.println("结果: 更新成功 ID=1001");
            return "SUCCESS: 1";
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_updateSendStatus 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
