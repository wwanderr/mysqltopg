package com.dbapp.xdr.bean.dto;

import java.util.Date;

/**
 * LicenseStatusDto - 许可状态 DTO
 */
public class LicenseStatusDto {
    private String agentType;
    private Date expireTime;
    private Integer licenseType;

    // Getters and Setters
    public String getAgentType() {
        return agentType;
    }

    public void setAgentType(String agentType) {
        this.agentType = agentType;
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
}
