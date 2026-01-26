package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * EventOutGoingConfig Mapper 接口
 * 
 * 对应 XML: EventOutGoingConfigMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface EventOutGoingConfigMapper {

    void delById(EventOutGoingConfig entity);  // UPDATE 无返回值

}
