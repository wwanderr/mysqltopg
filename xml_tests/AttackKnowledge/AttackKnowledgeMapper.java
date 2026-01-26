package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * AttackKnowledge Mapper 接口
 * 
 * 对应 XML: AttackKnowledgeMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface AttackKnowledgeMapper {

    Object selectListByParams();  // TODO: 根据实际返回类型修改
    Object selectByparentCode();  // TODO: 根据实际返回类型修改
    Object queryIdBytacticName();  // TODO: 根据实际返回类型修改
    Object queryNameByCode();  // TODO: 根据实际返回类型修改
    Object queryParentId();  // TODO: 根据实际返回类型修改
    Object selectTactic();  // TODO: 根据实际返回类型修改
    Object truncateTable();  // TODO: 根据实际返回类型修改
    int batchInsert(AttackKnowledge entity);
    void updateByCode(AttackKnowledge entity);  // UPDATE 无返回值

}
