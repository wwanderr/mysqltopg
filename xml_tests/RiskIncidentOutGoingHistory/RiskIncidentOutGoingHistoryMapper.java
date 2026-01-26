package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * RiskIncidentOutGoingHistory Mapper 接口
 * 
 * 对应 XML: RiskIncidentOutGoingHistoryMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface RiskIncidentOutGoingHistoryMapper {

    Object mappingFromClueSecurityEvent();  // TODO: 根据实际返回类型修改
    Object mappingNormalSecurityEvent();  // TODO: 根据实际返回类型修改
    Object queryListByTime();  // TODO: 根据实际返回类型修改
    Object queryOutGoingList();  // TODO: 根据实际返回类型修改
    int backUpLastTermData(RiskIncidentOutGoingHistory entity);
    void batchInsertOrUpdateIncident(RiskIncidentOutGoingHistory entity);  // UPDATE 无返回值
    void batchUpdatePayload(RiskIncidentOutGoingHistory entity);  // UPDATE 无返回值
    int deleteOldIncident(Integer id);
    int clearHistoryData(Integer id);

}
