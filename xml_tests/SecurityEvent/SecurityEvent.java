package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * SecurityEvent Mapper 接口
 * 
 * 对应 XML: SecurityEvent.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface SecurityEvent {

    Object selectBaseInfoById();  // TODO: 根据实际返回类型修改
    Object selectEventAndTempById();  // TODO: 根据实际返回类型修改
    Object selectNewEventAndTempById();  // TODO: 根据实际返回类型修改
    Object queryEventById();  // TODO: 根据实际返回类型修改
    Object queryTrend();  // TODO: 根据实际返回类型修改
    Object selectAllByIdList();  // TODO: 根据实际返回类型修改
    Object queryOverview();  // TODO: 根据实际返回类型修改
    Object selectEventAndTempByIds();  // TODO: 根据实际返回类型修改
    Object selectLogFieldsByIds();  // TODO: 根据实际返回类型修改
    Object getIncidentsTypePercent();  // TODO: 根据实际返回类型修改
    Object getSecurityEventList();  // TODO: 根据实际返回类型修改
    Object getKillChain();  // TODO: 根据实际返回类型修改
    Object getSecurityEventListByFieldMapping();  // TODO: 根据实际返回类型修改
    Object getTotal();  // TODO: 根据实际返回类型修改
    Object queryEventCount();  // TODO: 根据实际返回类型修改
    Object queryByEventCode();  // TODO: 根据实际返回类型修改
    Object getExistThreadEvents();  // TODO: 根据实际返回类型修改
    Object queryThreadAlarm();  // TODO: 根据实际返回类型修改
    Object getMinTime();  // TODO: 根据实际返回类型修改
    Object getOneHourTime();  // TODO: 根据实际返回类型修改
    Object getSecurityEventOutGoingTemplate();  // TODO: 根据实际返回类型修改
    int insertOrUpdate(SecurityEvent entity);
    int updateStatus(SecurityEvent entity);
    int batchInsert(SecurityEvent entity);
    int insertBatchThreadEvents(SecurityEvent entity);
    int insertBatchSecurityAlarm(SecurityEvent entity);
    void updateAlarmResultById(SecurityEvent entity);  // UPDATE 无返回值
    void updateThreadLowPriority(SecurityEvent entity);  // UPDATE 无返回值
    int deleteLowPriority(Integer id);
    int deleteOneHourLeft(Integer id);
    int deleteTimingTask(Integer id);

}
