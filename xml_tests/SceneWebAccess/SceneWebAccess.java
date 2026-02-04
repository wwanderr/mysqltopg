package com.dbapp.extension.xdr.threatMonitor.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.time.LocalDateTime;

/**
 * SceneWebAccess 实体类
 * 对应表：t_scene_web_access_temp
 */
@TableName("t_scene_web_access_temp")
public class SceneWebAccess {
    
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;
    
    private String srcAddress;
    
    private String destAddress;
    
    private String victim;
    
    private String attacker;
    
    private String requestUrl;
    
    private String destHostName;
    
    private LocalDateTime startTime;
    
    private LocalDateTime endTime;
    
    private LocalDateTime oldestTime;
    
    private LocalDateTime latestTime;
    
    private Long eventCount;
    
    private LocalDateTime createTime;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSrcAddress() {
        return srcAddress;
    }

    public void setSrcAddress(String srcAddress) {
        this.srcAddress = srcAddress;
    }

    public String getDestAddress() {
        return destAddress;
    }

    public void setDestAddress(String destAddress) {
        this.destAddress = destAddress;
    }

    public String getVictim() {
        return victim;
    }

    public void setVictim(String victim) {
        this.victim = victim;
    }

    public String getAttacker() {
        return attacker;
    }

    public void setAttacker(String attacker) {
        this.attacker = attacker;
    }

    public String getRequestUrl() {
        return requestUrl;
    }

    public void setRequestUrl(String requestUrl) {
        this.requestUrl = requestUrl;
    }

    public String getDestHostName() {
        return destHostName;
    }

    public void setDestHostName(String destHostName) {
        this.destHostName = destHostName;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public LocalDateTime getOldestTime() {
        return oldestTime;
    }

    public void setOldestTime(LocalDateTime oldestTime) {
        this.oldestTime = oldestTime;
    }

    public LocalDateTime getLatestTime() {
        return latestTime;
    }

    public void setLatestTime(LocalDateTime latestTime) {
        this.latestTime = latestTime;
    }

    public Long getEventCount() {
        return eventCount;
    }

    public void setEventCount(Long eventCount) {
        this.eventCount = eventCount;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }
}
