package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * EventUpdateCkAlarmQueue Mapper 接口
 * 
 * 对应 XML: EventUpdateCkAlarmQueueMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface EventUpdateCkAlarmQueueMapper {

    Object selectLast();  // TODO: 根据实际返回类型修改
    int insertIgnore(EventUpdateCkAlarmQueue entity);
    void updateSyncSuccessBatch(EventUpdateCkAlarmQueue entity);  // UPDATE 无返回值

}
