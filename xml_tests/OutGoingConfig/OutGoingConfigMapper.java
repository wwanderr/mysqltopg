package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * OutGoingConfig Mapper 接口
 * 
 * 对应 XML: OutGoingConfigMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface OutGoingConfigMapper {

    Object selectOutGoingConfig();  // TODO: 根据实际返回类型修改
    Object selectConfigById();  // TODO: 根据实际返回类型修改
    Object selectOutGoingConfigCount();  // TODO: 根据实际返回类型修改
    Object selectOutGoingConfigByPage();  // TODO: 根据实际返回类型修改
    Object selectKbrCount();  // TODO: 根据实际返回类型修改
    void updateSwitchById(OutGoingConfig entity);  // UPDATE 无返回值
    void closeConfig(OutGoingConfig entity);  // UPDATE 无返回值

}
