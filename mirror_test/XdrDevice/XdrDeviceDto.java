package com.dbapp.xdr.bean.dto;

import java.util.Date;

/**
 * XdrDeviceDto - 设备信息 DTO
 * 对应视图：t_sev_agent_view
 */
public class XdrDeviceDto {
    private String agentCode;
    private String singleLoginUri;
    private String agentName;
    private String agentType;
    private String agentIp;
    private String machineCode;
    private String orgName;
    private Double cpuUsage;
    private Long memoryTotal;
    private Long memoryUse;
    private Double memoryRadio;
    private Long diskTotal;
    private Long diskUse;
    private Double diskRadio;
    private String status;
    private Date registTime;
    private Date expireTime;
    private Integer licenseType;
    private Date offlineTime;

    // Getters and Setters
    public String getAgentCode() {
        return agentCode;
    }

    public void setAgentCode(String agentCode) {
        this.agentCode = agentCode;
    }

    public String getSingleLoginUri() {
        return singleLoginUri;
    }

    public void setSingleLoginUri(String singleLoginUri) {
        this.singleLoginUri = singleLoginUri;
    }

    public String getAgentName() {
        return agentName;
    }

    public void setAgentName(String agentName) {
        this.agentName = agentName;
    }

    public String getAgentType() {
        return agentType;
    }

    public void setAgentType(String agentType) {
        this.agentType = agentType;
    }

    public String getAgentIp() {
        return agentIp;
    }

    public void setAgentIp(String agentIp) {
        this.agentIp = agentIp;
    }

    public String getMachineCode() {
        return machineCode;
    }

    public void setMachineCode(String machineCode) {
        this.machineCode = machineCode;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public Double getCpuUsage() {
        return cpuUsage;
    }

    public void setCpuUsage(Double cpuUsage) {
        this.cpuUsage = cpuUsage;
    }

    public Long getMemoryTotal() {
        return memoryTotal;
    }

    public void setMemoryTotal(Long memoryTotal) {
        this.memoryTotal = memoryTotal;
    }

    public Long getMemoryUse() {
        return memoryUse;
    }

    public void setMemoryUse(Long memoryUse) {
        this.memoryUse = memoryUse;
    }

    public Double getMemoryRadio() {
        return memoryRadio;
    }

    public void setMemoryRadio(Double memoryRadio) {
        this.memoryRadio = memoryRadio;
    }

    public Long getDiskTotal() {
        return diskTotal;
    }

    public void setDiskTotal(Long diskTotal) {
        this.diskTotal = diskTotal;
    }

    public Long getDiskUse() {
        return diskUse;
    }

    public void setDiskUse(Long diskUse) {
        this.diskUse = diskUse;
    }

    public Double getDiskRadio() {
        return diskRadio;
    }

    public void setDiskRadio(Double diskRadio) {
        this.diskRadio = diskRadio;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getRegistTime() {
        return registTime;
    }

    public void setRegistTime(Date registTime) {
        this.registTime = registTime;
    }

    public Date getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(Date expireTime) {
        this.expireTime = expireTime;
    }

    public Integer getLicenseType() {
        return licenseType;
    }

    public void setLicenseType(Integer licenseType) {
        this.licenseType = licenseType;
    }

    public Date getOfflineTime() {
        return offlineTime;
    }

    public void setOfflineTime(Date offlineTime) {
        this.offlineTime = offlineTime;
    }
}
