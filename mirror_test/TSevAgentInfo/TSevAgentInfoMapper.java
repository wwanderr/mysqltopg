package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.entity.ValueName;
import com.dbapp.xdr.bean.po.TSevAgentInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;
import java.util.List;
import java.util.Map;

@Mapper
public interface TSevAgentInfoMapper extends BaseMapper<TSevAgentInfo> {

    int deleteByAgentCodeIn(@Param("agentCodeCollection") Collection<String> agentCodeCollection);

    List<String> selectStatusByAgentCode(@Param("agentCode") String agentCode);

    int deleteAll();

    int updateOrgId(@Param("updatedOrgId") String updatedOrgId);

    int updateOrgIdByAgentCodeIn(@Param("updatedOrgId") String updatedOrgId,
                                 @Param("agentCodeCollection") Collection<String> agentCodeCollection);

    int updateAgentNameByAgentCode(@Param("updatedAgentName") String updatedAgentName,
                                   @Param("agentCode") String agentCode);

    String selectOneMachineCodeByAgentCode(@Param("agentCode") String agentCode);

    String selectOneStatusByAgentCode(@Param("agentCode") String agentCode);

    List<ValueName> selectAgentCodeAndAgentNameByAgentType(@Param("agentType") String agentType);

    TSevAgentInfo selectOneByMetric2Mix();

    List<Map<String, Object>> getAllHeartBeatTimeOnline();

    List<Map<String, Object>> getAllUpgrading();

    void updateAgentIp(@Param("oldAgentIp") String oldAgentIp,
                       @Param("newAgentIp") String newAgentIp,
                       @Param("agentType") String agentType);
}

