package com.dbapp.xdr.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.time.LocalDateTime;

/**
 * TSevAgentMonitor 实体（最小可用版本）
 * 对应表：t_sev_agent_monitor
 * 
 * 注意：此表有外键约束
 * - agent_code 引用 t_sev_agent_info(agent_code) ON DELETE CASCADE ON UPDATE CASCADE
 */
@TableName("t_sev_agent_monitor")
public class TSevAgentMonitor {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String agentCode;
    private String agentType;
    private Double cpuUsage;
    private Double memoryTotal;
    private Double memoryUse;
    private Double diskTotal;
    private Double diskUse;
    private Double metric1;
    private Double metric2;
    private Double metric3;
    private LocalDateTime createTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAgentCode() {
        return agentCode;
    }

    public void setAgentCode(String agentCode) {
        this.agentCode = agentCode;
    }

    public String getAgentType() {
        return agentType;
    }

    public void setAgentType(String agentType) {
        this.agentType = agentType;
    }

    public Double getCpuUsage() {
        return cpuUsage;
    }

    public void setCpuUsage(Double cpuUsage) {
        this.cpuUsage = cpuUsage;
    }

    public Double getMemoryTotal() {
        return memoryTotal;
    }

    public void setMemoryTotal(Double memoryTotal) {
        this.memoryTotal = memoryTotal;
    }

    public Double getMemoryUse() {
        return memoryUse;
    }

    public void setMemoryUse(Double memoryUse) {
        this.memoryUse = memoryUse;
    }

    public Double getDiskTotal() {
        return diskTotal;
    }

    public void setDiskTotal(Double diskTotal) {
        this.diskTotal = diskTotal;
    }

    public Double getDiskUse() {
        return diskUse;
    }

    public void setDiskUse(Double diskUse) {
        this.diskUse = diskUse;
    }

    public Double getMetric1() {
        return metric1;
    }

    public void setMetric1(Double metric1) {
        this.metric1 = metric1;
    }

    public Double getMetric2() {
        return metric2;
    }

    public void setMetric2(Double metric2) {
        this.metric2 = metric2;
    }

    public Double getMetric3() {
        return metric3;
    }

    public void setMetric3(Double metric3) {
        this.metric3 = metric3;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }
}
