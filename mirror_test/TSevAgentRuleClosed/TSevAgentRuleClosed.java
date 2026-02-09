package com.dbapp.xdr.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

/**
 * TSevAgentRuleClosed 实体
 * 对应表：t_sev_agent_rule_closed
 * 
 * 注意：此表有外键约束
 * - rule_closed_id 引用 t_sev_agent_type_rule_closed(id) ON DELETE CASCADE ON UPDATE CASCADE
 * - agent_code 引用 t_sev_agent_info(agent_code) ON DELETE CASCADE ON UPDATE CASCADE（可为 NULL）
 */
@TableName("t_sev_agent_rule_closed")
public class TSevAgentRuleClosed {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private Long ruleClosedId;
    private String agentCode;
    
    @TableField("config_version")
    private Long configVersion;
    
    @TableField("is_delete")
    private Boolean isDelete;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getRuleClosedId() {
        return ruleClosedId;
    }

    public void setRuleClosedId(Long ruleClosedId) {
        this.ruleClosedId = ruleClosedId;
    }

    public String getAgentCode() {
        return agentCode;
    }

    public void setAgentCode(String agentCode) {
        this.agentCode = agentCode;
    }

    public long getConfigVersion() {
        return this.configVersion;
    }

    public boolean isDelete() {
        return this.isDelete;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setRuleClosedId(Long ruleClosedId) {
        this.ruleClosedId = ruleClosedId;
    }

    public void setAgentCode(String agentCode) {
        this.agentCode = agentCode;
    }

    public void setConfigVersion(long configVersion) {
        this.configVersion = configVersion;
    }

    public void setDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }
}
