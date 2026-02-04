package com.dbapp.extension.xdr.linkageHandle.entity;

import java.time.LocalDateTime;

/**
 * VirusKillHistory（最小实现）
 * 字段与 t_virus_kill_history 表保持一致，满足 Mapper 默认方法中的 Lambda 引用。
 */
public class VirusKillHistory {
    private Long id;
    private Long strategyId;
    private String strategyName;
    private String nodeIp;
    private String nodeId;
    private String osStr;
    private String deviceIp;
    private String deviceId;
    private String deviceType;
    private String action;
    private String source;
    private String hashes;
    private LocalDateTime lastOccurTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getStrategyId() {
        return strategyId;
    }

    public void setStrategyId(Long strategyId) {
        this.strategyId = strategyId;
    }

    public String getStrategyName() {
        return strategyName;
    }

    public void setStrategyName(String strategyName) {
        this.strategyName = strategyName;
    }

    public String getNodeIp() {
        return nodeIp;
    }

    public void setNodeIp(String nodeIp) {
        this.nodeIp = nodeIp;
    }

    public String getNodeId() {
        return nodeId;
    }

    public void setNodeId(String nodeId) {
        this.nodeId = nodeId;
    }

    public String getOsStr() {
        return osStr;
    }

    public void setOsStr(String osStr) {
        this.osStr = osStr;
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getHashes() {
        return hashes;
    }

    public void setHashes(String hashes) {
        this.hashes = hashes;
    }

    public LocalDateTime getLastOccurTime() {
        return lastOccurTime;
    }

    public void setLastOccurTime(LocalDateTime lastOccurTime) {
        this.lastOccurTime = lastOccurTime;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }
}

