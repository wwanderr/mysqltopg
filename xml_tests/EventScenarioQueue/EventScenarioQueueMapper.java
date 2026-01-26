package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * EventScenarioQueue Mapper 接口
 * 
 * 对应 XML: EventScenarioQueueMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface EventScenarioQueueMapper {

    Object selectLast();  // TODO: 根据实际返回类型修改
    int insertIgnore(EventScenarioQueue entity);
    void updateSyncSuccessBatch(EventScenarioQueue entity);  // UPDATE 无返回值
    int tryClean(Integer id);

}
