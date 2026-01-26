package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * RiskIncidentHistory Mapper 接口
 * 
 * 对应 XML: RiskIncidentHistoryMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface RiskIncidentHistoryMapper {

    Object getRiskHistoryList();  // TODO: 根据实际返回类型修改
    Object queryEventCount();  // TODO: 根据实际返回类型修改
    Object getFocusObject();  // TODO: 根据实际返回类型修改
    Object FocusIpMessage();  // TODO: 根据实际返回类型修改
    Object selectAllByIdList();  // TODO: 根据实际返回类型修改
    Object getCount();  // TODO: 根据实际返回类型修改
    Object getFocusIpCount();  // TODO: 根据实际返回类型修改
    Object queryFocusIps();  // TODO: 根据实际返回类型修改
    Object queryFocusIpCount();  // TODO: 根据实际返回类型修改
    Object countByDate();  // TODO: 根据实际返回类型修改

}
