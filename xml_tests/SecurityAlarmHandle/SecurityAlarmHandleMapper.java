package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * SecurityAlarmHandle Mapper 接口
 * 
 * 对应 XML: SecurityAlarmHandleMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface SecurityAlarmHandleMapper {

    int insertOrUpdate(SecurityAlarmHandle entity);
    void updateStatusById(SecurityAlarmHandle entity);  // UPDATE 无返回值

}
