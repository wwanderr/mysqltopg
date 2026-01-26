package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * VulAnalysisSub Mapper 接口
 * 
 * 对应 XML: VulAnalysisSubMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface VulAnalysisSubMapper {

    Object queryListCount();  // TODO: 根据实际返回类型修改
    Object queryList();  // TODO: 根据实际返回类型修改
    Object querySubListCount();  // TODO: 根据实际返回类型修改
    Object querySubListCveCount();  // TODO: 根据实际返回类型修改
    Object querySubList();  // TODO: 根据实际返回类型修改
    Object querySubListById();  // TODO: 根据实际返回类型修改
    Object queryTop10();  // TODO: 根据实际返回类型修改
    Object queryProportion();  // TODO: 根据实际返回类型修改
    int insertOrUpdate(VulAnalysisSub entity);
    void updateByParams(VulAnalysisSub entity);  // UPDATE 无返回值
    void updateByIds(VulAnalysisSub entity);  // UPDATE 无返回值

}
