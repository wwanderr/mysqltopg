package com.dbapp.xdr.bean.dto;

import java.util.Date;

/**
 * XdrDeviceDetailDto - 设备详细信息 DTO
 * 对应视图：t_sev_agent_detail_view
 */
public class XdrDeviceDetailDto {
    private Long no;
    private String agentCode;
    private String singleLoginUri;
    private String agentName;
    private String agentType;
    private String agentIp;
    private String machineCode;
    private String orgId;
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
    private String metric3;
    private String softVersion;
    private String ruleVersion;
    private String fileName;
    private Date expireTime;
    private Integer licenseType;
    private Date offlineTime;

    // Getters and Setters
    public Long getNo() {
        return no;
    }

    public void setNo(Long no) {
        this.no = no;
    }

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

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
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

    public String getMetric3() {
        return metric3;
    }

    public void setMetric3(String metric3) {
        this.metric3 = metric3;
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

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
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
