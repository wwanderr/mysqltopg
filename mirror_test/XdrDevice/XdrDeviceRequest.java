package com.dbapp.xdr.bean.request;

import io.swagger.annotations.ApiModelProperty;

public class XdrDeviceRequest {
    @ApiModelProperty(
        value = "探针类型",
        name = "typeName",
        example = "流量探针"
    )
    private String typeName;
    @ApiModelProperty(
        value = "状态",
        name = "status",
        example = "在线"
    )
    private String status;
    @ApiModelProperty(
        value = "许可状态",
        name = "licenseStatus",
        example = "在线"
    )
    private String licenseStatus;
    @ApiModelProperty(
        value = "设备名称",
        name = "deviceName",
        example = "流量审计"
    )
    private String deviceName;

    public String getTypeName() {
        return this.typeName;
    }

    public String getStatus() {
        return this.status;
    }

    public String getLicenseStatus() {
        return this.licenseStatus;
    }

    public String getDeviceName() {
        return this.deviceName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setLicenseStatus(String licenseStatus) {
        this.licenseStatus = licenseStatus;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }
}
