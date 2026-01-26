package com.dbapp.extension.xdr.outgoingData.po;

import lombok.Data;
import java.time.OffsetDateTime;

/**
 * 告警外发配置实体类
 * 表：t_alarm_out_going_config
 * 
 * @author Auto Generated
 * @date 2026-01-22
 */
@Data
public class AlarmOutGoingConfig {
    
    /**
     * 主键自增id
     */
    private Long id;
    
    /**
     * 告警来源（数组）
     */
    private String alarmSource;
    
    /**
     * 告警子类型（数组）
     */
    private String subCategory;
    
    /**
     * 威胁等级（数组）
     */
    private String threatSeverity;
    
    /**
     * 告警结果（数组）
     */
    private String alarmResults;
    
    /**
     * 是否开启（1是，0否）
     */
    private Integer enable;
    
    /**
     * 映射文件路径
     */
    private String mappingConfigPath;
    
    /**
     * 是否已删除（1是，0否）
     */
    private Integer isDel;
    
    /**
     * 上次发送结果
     */
    private String lastSendResult;
    
    /**
     * 发送失败的原因
     */
    private String causeOfFailure;
    
    /**
     * 上次发送时间
     */
    private OffsetDateTime lastSendTime;
    
    /**
     * 发送总次数
     */
    private Long sendCount;
    
    /**
     * 成功发送次数
     */
    private Long succeedCount;
    
    /**
     * 创建时间
     */
    private OffsetDateTime createTime;
    
    /**
     * 更新时间
     */
    private OffsetDateTime updateTime;
}
