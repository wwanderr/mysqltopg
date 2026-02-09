package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.xdr.bean.po.TSevAgentLicense;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;

@Mapper
public interface TSevAgentLicenseMapper extends BaseMapper<TSevAgentLicense> {

    TSevAgentLicense selectOneByAgentCode(@Param("agentCode") String agentCode);

    int deleteByAgentCodeIn(@Param("agentCodeCollection") Collection<String> agentCodeCollection);

    int deleteAll();
}

