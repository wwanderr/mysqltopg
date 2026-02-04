package com.dbapp.extension.xdr.logCorrelation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.dbapp.extension.xdr.logCorrelation.enums.StatusEnum;

import java.time.LocalDateTime;

/**
 * LogCorrelationJob 实体类
 * 对应表：t_log_correlation_job
 */
@TableName("t_log_correlation_job")
public class LogCorrelationJob {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private StatusEnum status;
    
    private String executorClassName;
    
    private String parameters;
    
    private String echoParameters;
    
    private String waitingParameters;
    
    private LocalDateTime startTime;
    
    private LocalDateTime queryStartTime;
    
    private LocalDateTime queryEndTime;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public StatusEnum getStatus() {
        return status;
    }

    public void setStatus(StatusEnum status) {
        this.status = status;
    }

    public String getExecutorClassName() {
        return executorClassName;
    }

    public void setExecutorClassName(String executorClassName) {
        this.executorClassName = executorClassName;
    }

    public String getParameters() {
        return parameters;
    }

    public void setParameters(String parameters) {
        this.parameters = parameters;
    }

    public String getEchoParameters() {
        return echoParameters;
    }

    public void setEchoParameters(String echoParameters) {
        this.echoParameters = echoParameters;
    }

    public String getWaitingParameters() {
        return waitingParameters;
    }

    public void setWaitingParameters(String waitingParameters) {
        this.waitingParameters = waitingParameters;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getQueryStartTime() {
        return queryStartTime;
    }

    public void setQueryStartTime(LocalDateTime queryStartTime) {
        this.queryStartTime = queryStartTime;
    }

    public LocalDateTime getQueryEndTime() {
        return queryEndTime;
    }

    public void setQueryEndTime(LocalDateTime queryEndTime) {
        this.queryEndTime = queryEndTime;
    }
}
