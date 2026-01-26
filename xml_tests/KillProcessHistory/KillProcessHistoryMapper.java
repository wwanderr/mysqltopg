package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * KillProcessHistory Mapper 接口
 * 
 * 对应 XML: KillProcessHistoryMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface KillProcessHistoryMapper {

    Object countLaunchTimesByStrategyId();  // TODO: 根据实际返回类型修改
    int batchInsert(KillProcessHistory entity);

}
