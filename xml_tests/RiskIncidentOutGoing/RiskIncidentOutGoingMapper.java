package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * RiskIncidentOutGoing Mapper 接口
 * 
 * 对应 XML: RiskIncidentOutGoingMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface RiskIncidentOutGoingMapper {

    Object mappingFromClueSecurityEvent();  // TODO: 根据实际返回类型修改
    Object mappingNormalSecurityEvent();  // TODO: 根据实际返回类型修改
    Object queryListByTime();  // TODO: 根据实际返回类型修改
    Object queryOutGoingList();  // TODO: 根据实际返回类型修改
    Object selectOldIncidentByCodes();  // TODO: 根据实际返回类型修改
    Object groupByFocusIp();  // TODO: 根据实际返回类型修改
    Object groupNameByFocusIp();  // TODO: 根据实际返回类型修改
    Object selectOldHistoryIds();  // TODO: 根据实际返回类型修改
    int backUpLastTermData(RiskIncidentOutGoing entity);
    void batchInsertOrUpdateIncident(RiskIncidentOutGoing entity);  // UPDATE 无返回值
    void batchUpdatePayload(RiskIncidentOutGoing entity);  // UPDATE 无返回值
    void updateKillChain(RiskIncidentOutGoing entity);  // UPDATE 无返回值
    int deleteOldIncident(Integer id);
    int clearHistoryData(Integer id);
    int deleteHistoryByIds(Integer id);

}
