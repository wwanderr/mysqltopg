package com.dbapp.xdr.bean.response;

/**
 * XdrDeviceBase - 设备基础信息响应
 * 对应视图：t_sev_agent_view
 */
public class XdrDeviceBase {
    private String agentCode;
    private String deviceName;
    private String agentType;
    private String agentTypeName;
    private String deviceIp;
    private String status;
    private Long offlineTime;

    // Getters and Setters
    public String getAgentCode() {
        return agentCode;
    }

    public void setAgentCode(String agentCode) {
        this.agentCode = agentCode;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getAgentType() {
        return agentType;
    }

    public void setAgentType(String agentType) {
        this.agentType = agentType;
    }

    public String getAgentTypeName() {
        return agentTypeName;
    }

    public void setAgentTypeName(String agentTypeName) {
        this.agentTypeName = agentTypeName;
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getOfflineTime() {
        return offlineTime;
    }

    public void setOfflineTime(Long offlineTime) {
        this.offlineTime = offlineTime;
    }
}
