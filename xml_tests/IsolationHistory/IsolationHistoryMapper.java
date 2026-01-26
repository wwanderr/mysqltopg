package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * IsolationHistory Mapper 接口
 * 
 * 对应 XML: IsolationHistoryMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface IsolationHistoryMapper {

    Object countLaunchTimesByStrategyId();  // TODO: 根据实际返回类型修改
    int batchInsert(IsolationHistory entity);

}
