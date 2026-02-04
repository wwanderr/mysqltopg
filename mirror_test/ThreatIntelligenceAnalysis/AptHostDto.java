package com.dbapp.xdr.bean.dto;

/**
 * AptHostDto（最小可用版本）
 * 对应 SQL: select agent_ip server, agent_code machineCode ...
 */
public class AptHostDto {
    private String server;
    private String machineCode;

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

