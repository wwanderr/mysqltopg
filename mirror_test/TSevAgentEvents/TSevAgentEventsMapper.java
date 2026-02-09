package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.xdr.bean.po.TSevAgentEvents;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;

/**
 * TSevAgentEvents Mapper 接口（Mirror 测试套件）
 *
 * 对应 PG XML:
 * - mysql/mirror_pg_xml/TSevAgentEventsMapper.xml
 */
@Mapper
public interface TSevAgentEventsMapper extends BaseMapper<TSevAgentEvents> {

    int deleteByAgentCodeIn(@Param("agentCodeCollection") Collection<String> agentCodeCollection);

    int deleteAll();
}

