package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * EventOutGoing Mapper 接口
 * 
 * 对应 XML: EventOutGoingMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface EventOutGoingMapper {

    int batchInsert(EventOutGoing entity);

}
