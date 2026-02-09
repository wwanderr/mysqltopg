package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.xdr.bean.po.TSevAgentRuleClosed;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;
import java.util.List;

public interface TSevAgentRuleClosedMapper extends BaseMapper<TSevAgentRuleClosed> {
    int deleteByPrimaryKey(Long var1);

    int insertBatch(@Param("closedRules") Collection<TSevAgentRuleClosed> var1);

    int insertSelective(TSevAgentRuleClosed var1);

    TSevAgentRuleClosed selectByPrimaryKey(Long var1);

    int updateByPrimaryKeySelective(TSevAgentRuleClosed var1);

    int updateByPrimaryKey(TSevAgentRuleClosed var1);

    int updateAgentCodeByRuleClosedId(@Param("agentCode") String var1, @Param("ruleClosedId") Long var2);

    int deleteByAgentCodesNotIn(@Param("mainId") long var1, @Param("agentCodes") Collection<String> var3);

    int isExistNull(@Param("id") Long var1);

    int deleteByRuleClosedId(@Param("ruleClosedId") Long var1);

    List<TSevAgentRuleClosed> selectAgentCodeByRuleClosedId(@Param("ruleClosedId") Long var1);

    int selectCountNullByRuleClosedId(@Param("ruleClosedId") Long var1);
}
