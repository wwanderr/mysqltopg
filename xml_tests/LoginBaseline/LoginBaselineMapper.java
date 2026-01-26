package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * LoginBaseline Mapper 接口
 * 
 * 对应 XML: LoginBaselineMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface LoginBaselineMapper {

    Object queryByPrimaryKey();  // TODO: 根据实际返回类型修改
    int cleanOvertimeData(Integer id);
    int insertOrUpdate(Integer id);

}
