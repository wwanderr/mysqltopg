package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * LinkedStrategyValidtime Mapper 接口
 * 
 * 对应 XML: LinkedStrategyValidtimeMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface LinkedStrategyValidtimeMapper {

    Object selectEndTime();  // TODO: 根据实际返回类型修改
    int insertValidtime(LinkedStrategyValidtime entity);
    int deleteEndtime(Integer id);

}
