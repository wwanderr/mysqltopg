package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * QueryTemplate Mapper 接口
 * 
 * 对应 XML: QueryTemplateMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface QueryTemplateMapper {

    Object queryAllTemplate();  // TODO: 根据实际返回类型修改
    Object queryTemplateById();  // TODO: 根据实际返回类型修改
    void updateById(QueryTemplate entity);  // UPDATE 无返回值

}
