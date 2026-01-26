package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * LinkedStrategy Mapper 接口
 * 
 * 对应 XML: LinkedStrategyMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface LinkedStrategyMapper {

    Object getLinkStrategyById();  // TODO: 根据实际返回类型修改
    Object getLinkStrategyByIds();  // TODO: 根据实际返回类型修改
    Object getLinkStrategyListTotal();  // TODO: 根据实际返回类型修改
    Object getLinkStrategyList();  // TODO: 根据实际返回类型修改
    Object getLinkStrategyCountByNameAndId();  // TODO: 根据实际返回类型修改
    Object findLinkStrategyByParam();  // TODO: 根据实际返回类型修改
    Object getAllTemplateStrategyIds();  // TODO: 根据实际返回类型修改
    Object getAllStrategys();  // TODO: 根据实际返回类型修改
    int insertOrUpdate(LinkedStrategy entity);
    void enableLinkStrategy(LinkedStrategy entity);  // UPDATE 无返回值
    void update(LinkedStrategy entity);  // UPDATE 无返回值
    void batchUpdateLinkDeviceConfig(LinkedStrategy entity);  // UPDATE 无返回值
    void updateAppId(LinkedStrategy entity);  // UPDATE 无返回值
    int deleteLinkStrategy(Integer id);

}
