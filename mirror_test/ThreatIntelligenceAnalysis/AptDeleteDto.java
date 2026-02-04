package com.dbapp.xdr.bean.dto;

/**
 * AptDeleteDto（最小可用版本）
 * 对应 SQL: select ttia.id id, tsai.agent_ip server, tsai.agent_code machineCode ...
 */
public class AptDeleteDto {
    private Long id;
    private String server;
    private String machineCode;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getServer() {
        return server;
    }

    public void setServer(String server) {
        this.server = server;
    }

    public String getMachineCode() {
        return machineCode;
    }

    public void setMachineCode(String machineCode) {
        this.machineCode = machineCode;
    }
}

