package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.entity.ValueName;
import com.dbapp.restful.entity.Page;
import com.dbapp.xdr.bean.dto.QueryInfo;
import com.dbapp.xdr.bean.dto.QueryInfoOpenApi;
import com.dbapp.xdr.bean.po.TSevAgentTypeRuleClosed;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * TSevAgentTypeRuleClosedMapper 接口
 * 对应 XML: mysql/mirror_pg_xml/TSevAgentTypeRuleClosedMapper.xml
 */
@Mapper
public interface TSevAgentTypeRuleClosedMapper extends BaseMapper<TSevAgentTypeRuleClosed> {

    int deleteByPrimaryKey(@Param("id") Long id);

    int insertSelective(TSevAgentTypeRuleClosed record);

    TSevAgentTypeRuleClosed selectByPrimaryKey(@Param("id") Long id);

    int updateByPrimaryKeySelective(TSevAgentTypeRuleClosed record);

    int updateByPrimaryKey(TSevAgentTypeRuleClosed record);

    int cascadeUpdateByPrimaryKey(TSevAgentTypeRuleClosed record);

    TSevAgentTypeRuleClosed selectByAgentCode(@Param("agentCode") String agentCode);

    int insertAgentCode(@Param("agentCode") String agentCode, @Param("ruleClosedId") long ruleClosedId);

    String selectRemarksById(@Param("id") Long id);

    List<String> selectAgentNameByPrimaryKey(@Param("id") Long id);

    TSevAgentTypeRuleClosed selectByAgentTypeAndRuleId(
            @Param("agentType") String agentType,
            @Param("ruleId") String ruleId
    );

    List<String> selectAgentCodeById(@Param("id") long id);

    List<QueryInfo> selectQueryIfoListByAgentTypeAndRuleId(
            @Param("agentType") String agentType,
            @Param("ruleId") String ruleId,
            @Param("page") Page page
    );

    QueryInfo selectQueryInfoByAgentTypeAndRuleId(
            @Param("agentType") String agentType,
            @Param("ruleId") String ruleId
    );

    List<ValueName> getAllAgentById(@Param("id") long id);

    int updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById(
            @Param("ruleId") String ruleId,
            @Param("agentType") String agentType,
            @Param("remarks") String remarks,
            @Param("updateHistoryAlarm") Boolean updateHistoryAlarm,
            @Param("id") Long id
    );

    List<Long> selectIdByRuleIdAndAgentType(
            @Param("ruleId") String ruleId,
            @Param("agentType") String agentType
    );

    Long selectIdByRuleIdAndAgentTypePrecisely(
            @Param("ruleId") String ruleId,
            @Param("agentType") String agentType
    );

    Boolean selectUpdateHistoryAlarmById(@Param("id") Long id);

    int tryCleanCloseRule();

    List<Map<String, Object>> queryRulesByCreateTime(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime
    );

    List<QueryInfoOpenApi> queryListOpenApi(
            @Param("agentType") String agentType,
            @Param("ruleId") String ruleId,
            @Param("page") Page page,
            @Param("sortStr") String sortStr
    );
}
