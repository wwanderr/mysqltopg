package com.dbapp.extension.xdr.logCorrelation.enums;

/**
 * 日志关联任务状态枚举
 * 对应数据库枚举类型：t_log_correlation_job_status
 */
public enum StatusEnum {
    /**
     * 未处理
     */
    Todo,
    
    /**
     * 等待结果
     */
    Waiting
}
