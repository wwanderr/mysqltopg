package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * RiskIncident Mapper 接口
 * 
 * 对应 XML: RiskIncidentMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface RiskIncidentMapper {

    Object aggClueSecurityEventByName();  // TODO: 根据实际返回类型修改
    Object mappingNormalSecurityEvent();  // TODO: 根据实际返回类型修改
    Object selectOldIncidentByCodes();  // TODO: 根据实际返回类型修改
    Object getRiskList();  // TODO: 根据实际返回类型修改
    Object getCountByStatus();  // TODO: 根据实际返回类型修改
    Object getByEventCode();  // TODO: 根据实际返回类型修改
    Object selectEventAndTempById();  // TODO: 根据实际返回类型修改
    Object selectAllByIdList();  // TODO: 根据实际返回类型修改
    Object queryEventCount();  // TODO: 根据实际返回类型修改
    Object queryIncidentsCount();  // TODO: 根据实际返回类型修改
    Object queryKillChains();  // TODO: 根据实际返回类型修改
    Object getEventIdsById();  // TODO: 根据实际返回类型修改
    Object getFilterContent();  // TODO: 根据实际返回类型修改
    Object FocusIpMessage();  // TODO: 根据实际返回类型修改
    Object getFocusObject();  // TODO: 根据实际返回类型修改
    Object getRiskListByIds();  // TODO: 根据实际返回类型修改
    Object getCount();  // TODO: 根据实际返回类型修改
    Object queryFocusIps();  // TODO: 根据实际返回类型修改
    Object queryFocusIpCount();  // TODO: 根据实际返回类型修改
    Object getSecurityEventIdsByCondition();  // TODO: 根据实际返回类型修改
    Object countByDate();  // TODO: 根据实际返回类型修改
    Object selectIncidentForCheckScenario();  // TODO: 根据实际返回类型修改
    Object isHandled();  // TODO: 根据实际返回类型修改
    int backUpLastTermData(RiskIncident entity);
    void batchInsertOrUpdateIncident(RiskIncident entity);  // UPDATE 无返回值
    void updateStatus(RiskIncident entity);  // UPDATE 无返回值
    void updateJudgeResults(RiskIncident entity);  // UPDATE 无返回值
    void updateJudgeStatus(RiskIncident entity);  // UPDATE 无返回值
    int deleteOldIncidentAnalysis(Integer id);
    int deleteOldIncident(Integer id);

}
