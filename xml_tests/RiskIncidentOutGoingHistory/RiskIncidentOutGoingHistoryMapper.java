package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentOutGoingHistory;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * RiskIncidentOutGoingHistoryMapper
 * 只继承BaseMapper，没有自定义方法
 */
@Mapper
public interface RiskIncidentOutGoingHistoryMapper extends BaseMapper<RiskIncidentOutGoingHistory> {
    // 空接口，所有CRUD方法继承自BaseMapper
}
