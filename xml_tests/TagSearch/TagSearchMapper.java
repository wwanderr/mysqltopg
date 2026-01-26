package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * TagSearch Mapper 接口
 * 
 * 对应 XML: TagSearchMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface TagSearchMapper {

    int batchInsert(TagSearch entity);
    void truncateTable(TagSearch entity);  // UPDATE 无返回值

}
