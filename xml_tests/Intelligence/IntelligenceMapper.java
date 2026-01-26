package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * Intelligence Mapper 接口
 * 
 * 对应 XML: IntelligenceMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface IntelligenceMapper {

    Object listCount();  // TODO: 根据实际返回类型修改
    Object list();  // TODO: 根据实际返回类型修改
    Object partExport();  // TODO: 根据实际返回类型修改
    Object proportion();  // TODO: 根据实际返回类型修改
    Object top5();  // TODO: 根据实际返回类型修改
    Object subListCount();  // TODO: 根据实际返回类型修改
    Object subList();  // TODO: 根据实际返回类型修改
    int saveOrUpdateBatch(Intelligence entity);
    int insertIoCAsset(Intelligence entity);
    void updateAssetList(Intelligence entity);  // UPDATE 无返回值
    void updateListFromAsset(Intelligence entity);  // UPDATE 无返回值
    void updateList(Intelligence entity);  // UPDATE 无返回值
    void updateTag(Intelligence entity);  // UPDATE 无返回值
    void updateAssetTag(Intelligence entity);  // UPDATE 无返回值

}
