package com.dbapp.extension.xdr.outgoingData.mapper;

import com.dbapp.extension.xdr.outgoingData.po.AlarmOutGoingConfig;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 告警外发配置 Mapper 接口
 * 
 * @author Auto Generated
 * @date 2026-01-22
 */
@Mapper
public interface AlarmOutGoingConfigMapper {
    
    /**
     * 根据ID删除记录（逻辑删除）
     * 
     * @param alarmOutGoingConfig 告警外发配置对象
     * @return 影响行数
     */
    int delById(@Param("alarmOutGoingConfig") AlarmOutGoingConfig alarmOutGoingConfig);
    
    /**
     * 更新发送状态
     * 
     * @param alarmOutGoingConfig 告警外发配置对象
     * @return 影响行数
     */
    int updateSendStatus(@Param("alarmOutGoingConfig") AlarmOutGoingConfig alarmOutGoingConfig);
}
