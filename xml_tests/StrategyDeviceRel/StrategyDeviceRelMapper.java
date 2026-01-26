package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * StrategyDeviceRel Mapper 接口
 * 
 * 对应 XML: StrategyDeviceRelMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface StrategyDeviceRelMapper {

    Object selectById();  // TODO: 根据实际返回类型修改
    Object getAlarmStrategyList();  // TODO: 根据实际返回类型修改
    Object findDeviceByStrateId();  // TODO: 根据实际返回类型修改
    Object findStrategyIdByDeviceId();  // TODO: 根据实际返回类型修改
    Object getDeviceCount();  // TODO: 根据实际返回类型修改
    int insert(StrategyDeviceRel entity);
    int batchInsert(StrategyDeviceRel entity);
    void update(StrategyDeviceRel entity);  // UPDATE 无返回值
    void batchInsertOrUpdate(StrategyDeviceRel entity);  // UPDATE 无返回值
    void updateDeviceIpAndId(StrategyDeviceRel entity);  // UPDATE 无返回值
    int deleteRelByStrategyId(Integer id);
    int deleteRelByStrategyIdAndDeviceId(Integer id);

}
