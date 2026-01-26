package com.dbapp.extension.xdr.outgoingData.po;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 告警外发配置实体类 - PostgreSQL版本
 * 
 * 注意事项:
 * 1. 时间字段使用 LocalDateTime 而不是 Date
 * 2. LocalDateTime 不包含时区信息，完美匹配PostgreSQL的 timestamp 类型
 * 3. JDBC驱动会自动转换，无需手动处理
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
     * 注意: PostgreSQL中是 int4 类型，不是 bool
     */
    private Integer enable;
    
    /**
     * 映射文件路径
     */
    private String mappingConfigPath;
    
    /**
     * 是否已删除（1是，0否）
     * 注意: PostgreSQL中是 int4 类型，不是 bool
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
     * 类型: LocalDateTime
     * 数据库类型: timestamp(6)
     * 
     * 获取示例: 2024-01-15T14:30:00 (无时区后缀)
     */
    private LocalDateTime lastSendTime;
    
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
     * 类型: LocalDateTime
     * 数据库类型: timestamp(6)
     */
    private LocalDateTime createTime;
    
    /**
     * 更新时间
     * 类型: LocalDateTime
     * 数据库类型: timestamp(6)
     */
    private LocalDateTime updateTime;
    
    // ============================================
    // 如果使用JPA/Hibernate，可以添加以下注解
    // ============================================
    
    /*
    @Entity
    @Table(name = "t_alarm_out_going_config")
    public class AlarmOutGoingConfig {
        
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;
        
        @Column(name = "alarm_source", columnDefinition = "text")
        private String alarmSource;
        
        @Column(name = "sub_category", columnDefinition = "text")
        private String subCategory;
        
        @Column(name = "threat_severity", length = 50)
        private String threatSeverity;
        
        @Column(name = "alarm_results", length = 50)
        private String alarmResults;
        
        @Column(name = "enable", nullable = false)
        private Integer enable = 1;
        
        @Column(name = "mapping_config_path", length = 100)
        private String mappingConfigPath;
        
        @Column(name = "is_del", nullable = false)
        private Integer isDel = 0;
        
        @Column(name = "last_send_result", length = 10)
        private String lastSendResult;
        
        @Column(name = "cause_of_failure", columnDefinition = "text")
        private String causeOfFailure;
        
        // 时间字段使用 LocalDateTime，映射到 PostgreSQL 的 timestamp(6)
        @Column(name = "last_send_time")
        private LocalDateTime lastSendTime;
        
        @Column(name = "send_count")
        private Long sendCount = 0L;
        
        @Column(name = "succeed_count")
        private Long succeedCount = 0L;
        
        @Column(name = "create_time")
        private LocalDateTime createTime;
        
        @Column(name = "update_time")
        private LocalDateTime updateTime;
    }
    */
}
