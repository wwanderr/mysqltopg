package com.dbapp.xdr.bean.request;

import io.swagger.annotations.ApiModelProperty;
import org.hibernate.validator.constraints.NotBlank;

public class XdrDeviceDetailRequest extends XdrDeviceRequest {
    @ApiModelProperty(
        value = "探针Code",
        name = "agentCode",
        example = ""
    )
    @NotBlank(message = "探针Code不能为空")
    private String agentCode;
    private Boolean next;

    public String getAgentCode() {
        return this.agentCode;
    }

    public Boolean getNext() {
        return this.next;
    }

    public void setAgentCode(String agentCode) {
        this.agentCode = agentCode;
    }

    public void setNext(Boolean next) {
        this.next = next;
    }
}
