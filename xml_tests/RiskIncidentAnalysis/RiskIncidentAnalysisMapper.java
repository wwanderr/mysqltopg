package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentAnalysis;
import org.apache.ibatis.annotations.Mapper;

/**
 * RiskIncidentAnalysisMapper - 仅继承BaseMapper，无自定义方法
 */
@Mapper
public interface RiskIncidentAnalysisMapper extends BaseMapper<RiskIncidentAnalysis> {
    // 无自定义方法，仅使用MyBatis-Plus提供的基础CRUD方法
}
