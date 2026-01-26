package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * BlockHistory Mapper 接口
 * 
 * 对应 XML: BlockHistoryMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface BlockHistoryMapper {

    Object sumLaunchTimesByStrategyId();  // TODO: 根据实际返回类型修改
    Object getBlockListCount();  // TODO: 根据实际返回类型修改
    Object getBlockHistory();  // TODO: 根据实际返回类型修改
    Object getHistoryByIp();  // TODO: 根据实际返回类型修改
    Object getBlockHistoryByCondition();  // TODO: 根据实际返回类型修改
    Object getHistoryByStrategyId();  // TODO: 根据实际返回类型修改
    Object getHistoryByIds();  // TODO: 根据实际返回类型修改
    Object getIdsByStrategyId();  // TODO: 根据实际返回类型修改
    int insertBlockHistory(BlockHistory entity);
    void updateDeviceIpAndId(BlockHistory entity);  // UPDATE 无返回值
    int deleteHistoryById(Integer id);

}
