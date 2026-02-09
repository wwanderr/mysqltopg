package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.xdr.bean.po.TSevAgentConfig;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * TSevAgentConfig Mapper 接口（Mirror 测试套件）
 *
 * 对应 PG XML:
 * - mysql/mirror_pg_xml/TSevAgentConfigMapper.xml
 */
@Mapper
public interface TSevAgentConfigMapper extends BaseMapper<TSevAgentConfig> {

    TSevAgentConfig selectOneByAgentTypeAndConfigKey(@Param("agentType") String agentType,
                                                     @Param("configKey") String configKey);

    Long getLastVersion(@Param("agentType") String agentType);

    Long getLastRuleClosedVersion(@Param("agentCode") String agentCode);

    List<String> getAllClosedRuleIds(@Param("agentCode") String agentCode,
                                     @Param("agentType") String agentType);
}

