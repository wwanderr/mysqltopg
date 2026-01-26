package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * ScanHistoryDetail Mapper 接口
 * 
 * 对应 XML: ScanHistoryDetailMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface ScanHistoryDetailMapper {

    Object countLaunchTimesByStrategyId();  // TODO: 根据实际返回类型修改
    Object getIdsByStrategyId();  // TODO: 根据实际返回类型修改
    Object selectByOption();  // TODO: 根据实际返回类型修改
    Object selectScanIps();  // TODO: 根据实际返回类型修改
    int insertBatch(ScanHistoryDetail entity);

}
