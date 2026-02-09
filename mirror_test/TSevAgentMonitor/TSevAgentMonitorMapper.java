package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.xdr.bean.po.TSevAgentMonitor;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;

/**
 * TSevAgentMonitorMapper 接口
 * 对应 XML: mysql/mirror_pg_xml/TSevAgentMonitorMapper.xml
 */
@Mapper
public interface TSevAgentMonitorMapper extends BaseMapper<TSevAgentMonitor> {

    /**
     * 根据 agent_code 集合删除监控记录
     * @param agentCodeCollection agent_code 集合
     * @return 受影响行数
     */
    int deleteByAgentCodeIn(@Param("agentCodeCollection") Collection<String> agentCodeCollection);

    /**
     * 删除所有监控记录
     * @return 受影响行数
     */
    int deleteAll();
}
