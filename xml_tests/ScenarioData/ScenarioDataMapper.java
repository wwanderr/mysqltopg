package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * ScenarioData Mapper 接口
 * 
 * 对应 XML: ScenarioDataMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface ScenarioDataMapper {

    int insertOrUpdate(ScenarioData entity);

}
