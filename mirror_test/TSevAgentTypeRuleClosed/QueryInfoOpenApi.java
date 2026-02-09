package com.dbapp.xdr.bean.dto;

import com.dbapp.entity.ValueName;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * QueryInfoOpenApi DTO
 * 用于 OpenAPI 查询规则关闭信息
 */
public class QueryInfoOpenApi {
    public static final String ALL_AGENT = "all";
    public static final String ALL_AGENT_LABEL = "全部";
    
    private long id;
    private String ruleId;
    private String agentType;
    
    @JsonIgnore
    private List<ValueName> agents;
    
    private String remarks;
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;
    
    private Map<String, Object> data;

    @JsonGetter("agentName")
    public String getAgentName() {
        if (agents != null && !agents.isEmpty()) {
            return agents.get(0) == null ? "全部" : agents.stream()
                    .map(ValueName::getName)
                    .collect(Collectors.joining(","));
        } else {
            return null;
        }
    }

    @JsonGetter("agentCode")
    public List<String> getAgentCode() {
        if (agents != null && !agents.isEmpty()) {
            return agents.get(0) == null ? Collections.singletonList("all") : 
                    agents.stream()
                            .map(v -> (String) v.getValue())
                            .collect(Collectors.toList());
        } else {
            return Collections.emptyList();
        }
    }

    @JsonAnySetter
    public void addData(String key, Object value) {
        if (this.data == null) {
            this.data = new HashMap<>();
        }
        this.data.put(key, value);
    }

    @JsonAnyGetter
    public Map<String, Object> getData() {
        return data;
    }

    // Getters and Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getRuleId() {
        return ruleId;
    }

    public void setRuleId(String ruleId) {
        this.ruleId = ruleId;
    }

    public String getAgentType() {
        return agentType;
    }

    public void setAgentType(String agentType) {
        this.agentType = agentType;
    }

    public List<ValueName> getAgents() {
        return agents;
    }

    public void setAgents(List<ValueName> agents) {
        this.agents = agents;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }
}
