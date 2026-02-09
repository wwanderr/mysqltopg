package com.dbapp.xdr.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.time.LocalDateTime;

/**
 * TSevAgentInfo 实体（最小可用版本）
 * 对应表：t_sev_agent_info
 */
@TableName("t_sev_agent_info")
public class TSevAgentInfo {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String agentCode;
    private String agentName;
    private String agentIp;
    private String agentIpNum;
    private String agentType;
    private String machineCode;
    private String deviceModel;
    private String softVersion;
    private String ruleVersion;
    private String intelligenceVersion;
    private Long configVersion;
    private String singleLoginUri;
    private String status;
    private String orgId;
    private LocalDateTime registTime;
    private LocalDateTime updateTime;
    private Long monitorId;
    private Integer upgradeLogId;

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

    public String getAgentName() {
        return agentName;
    }

    public void setAgentName(String agentName) {
        this.agentName = agentName;
    }

    public String getAgentIp() {
        return agentIp;
    }

    public void setAgentIp(String agentIp) {
        this.agentIp = agentIp;
    }

    public String getAgentIpNum() {
        return agentIpNum;
    }

    public void setAgentIpNum(String agentIpNum) {
        this.agentIpNum = agentIpNum;
    }

    public String getAgentType() {
        return agentType;
    }

    public void setAgentType(String agentType) {
        this.agentType = agentType;
    }

    public String getMachineCode() {
        return machineCode;
    }

    public void setMachineCode(String machineCode) {
        this.machineCode = machineCode;
    }

    public String getDeviceModel() {
        return deviceModel;
    }

    public void setDeviceModel(String deviceModel) {
        this.deviceModel = deviceModel;
    }

    public String getSoftVersion() {
        return softVersion;
    }

    public void setSoftVersion(String softVersion) {
        this.softVersion = softVersion;
    }

    public String getRuleVersion() {
        return ruleVersion;
    }

    public void setRuleVersion(String ruleVersion) {
        this.ruleVersion = ruleVersion;
    }

    public String getIntelligenceVersion() {
        return intelligenceVersion;
    }

    public void setIntelligenceVersion(String intelligenceVersion) {
        this.intelligenceVersion = intelligenceVersion;
    }

    public Long getConfigVersion() {
        return configVersion;
    }

    public void setConfigVersion(Long configVersion) {
        this.configVersion = configVersion;
    }

    public String getSingleLoginUri() {
        return singleLoginUri;
    }

    public void setSingleLoginUri(String singleLoginUri) {
        this.singleLoginUri = singleLoginUri;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public LocalDateTime getRegistTime() {
        return registTime;
    }

    public void setRegistTime(LocalDateTime registTime) {
        this.registTime = registTime;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }

    public Long getMonitorId() {
        return monitorId;
    }

    public void setMonitorId(Long monitorId) {
        this.monitorId = monitorId;
    }

    public Integer getUpgradeLogId() {
        return upgradeLogId;
    }

    public void setUpgradeLogId(Integer upgradeLogId) {
        this.upgradeLogId = upgradeLogId;
    }
}

