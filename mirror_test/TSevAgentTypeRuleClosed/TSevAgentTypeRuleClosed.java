package com.dbapp.xdr.bean.po;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

@TableName("t_sev_agent_type_rule_closed")
public class TSevAgentTypeRuleClosed implements Serializable {
    @TableId(
        value = "id",
        type = IdType.AUTO
    )
    private Long id;
    @TableField(
        value = "agent_type",
        fill = FieldFill.INSERT
    )
    private String agentType;
    @TableField(
        value = "rule_id",
        fill = FieldFill.INSERT
    )
    private String ruleId;
    private String remarks;
    private Boolean updateHistoryAlarm;
    @TableField(
        value = "create_time",
        fill = FieldFill.INSERT
    )
    private Date createTime;
    @TableField(
        value = "update_time",
        fill = FieldFill.INSERT
    )
    private Date updateTime;
    @TableField(
        value = "data",
        fill = FieldFill.INSERT
    )
    private Map<String, Object> data;
    @TableField("is_delete")
    private boolean isDelete;
    private static final long serialVersionUID = 1L;
    public static final String COL_ID = "id";
    public static final String COL_AGENT_TYPE = "agent_type";
    public static final String COL_RULE_ID = "rule_id";
    public static final String COL_REMARKS = "remarks";
    public static final String COL_UPDATE_HISTORY_ALARM = "update_history_alarm";
    public static final String COL_CREATE_TIME = "create_time";
    public static final String COL_UPDATE_TIME = "update_time";
    public static final String COL_IS_DELETE = "is_delete";

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAgentType() {
        return agentType;
    }

    public void setAgentType(String agentType) {
        this.agentType = agentType;
    }

    public String getRuleId() {
        return ruleId;
    }

    public void setRuleId(String ruleId) {
        this.ruleId = ruleId;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Boolean getUpdateHistoryAlarm() {
        return updateHistoryAlarm;
    }

    public void setUpdateHistoryAlarm(Boolean updateHistoryAlarm) {
        this.updateHistoryAlarm = updateHistoryAlarm;
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

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public Boolean getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Boolean isDelete) {
        this.isDelete = isDelete;
    }
}
