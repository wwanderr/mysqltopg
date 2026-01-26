package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

/**
 * AlarmOutGoingConfig Mapper 接口
 * 
 * 对应 XML: AlarmOutGoingConfigMapper.xml
 * 
 * @author Auto Generated
 * @date 2026-01-26
 */
@Mapper
public interface AlarmOutGoingConfigMapper {

    /**
     * 根据ID删除告警外发配置（逻辑删除，将 is_del 设为 1）
     * 
     * @param param 参数Map，包含 alarmOutGoingConfig 对象，对象中包含 id
     * 示例：
     * Map<String, Object> param = new HashMap<>();
     * param.put("alarmOutGoingConfig", new AlarmOutGoingConfig() {{
     *     setId(1001L);
     * }});
     */
    void delById(Map<String, Object> param);

    /**
     * 更新发送状态
     * 
     * 更新内容：
     * - last_send_time: 自动设为当前时间
     * - send_count: 自动 +1
     * - last_send_result: 从参数获取（"成功" 或 "失败"）
     * - cause_of_failure: 从参数获取（失败原因，成功时为 null）
     * - succeed_count: 如果 last_send_result = "成功"，则自动 +1
     * 
     * @param param 参数Map，包含 alarmOutGoingConfig 对象，对象中包含：
     *              - id: 配置ID
     *              - lastSendResult: 发送结果（"成功" 或 "失败"）
     *              - causeOfFailure: 失败原因（可选）
     * 
     * 示例1：发送成功
     * Map<String, Object> param = new HashMap<>();
     * param.put("alarmOutGoingConfig", new AlarmOutGoingConfig() {{
     *     setId(1001L);
     *     setLastSendResult("成功");
     *     setCauseOfFailure(null);
     * }});
     * 
     * 示例2：发送失败
     * Map<String, Object> param = new HashMap<>();
     * param.put("alarmOutGoingConfig", new AlarmOutGoingConfig() {{
     *     setId(1002L);
     *     setLastSendResult("失败");
     *     setCauseOfFailure("连接超时");
     * }});
     */
    void updateSendStatus(Map<String, Object> param);
}
