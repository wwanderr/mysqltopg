package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * EventTemplate Mapper 接口
 * 
 * 对应 XML: EventTemplateMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface EventTemplateMapper {

    Object selectAllTemplate();  // TODO: 根据实际返回类型修改
    Object truncate();  // TODO: 根据实际返回类型修改
    Object queryCodeCount();  // TODO: 根据实际返回类型修改
    int batchInsert(EventTemplate entity);
    int updateByUniqCode(EventTemplate entity);
    void updateByIncidentName(EventTemplate entity);  // UPDATE 无返回值

}
