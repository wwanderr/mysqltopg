package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * NoticeHistory Mapper 接口
 * 
 * 对应 XML: NoticeHistoryMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface NoticeHistoryMapper {

    Object countLaunchTimesByStrategyId();  // TODO: 根据实际返回类型修改
    Object getNoticeListCount();  // TODO: 根据实际返回类型修改
    Object getNoticeHistory();  // TODO: 根据实际返回类型修改
    Object getIdsByStrategyId();  // TODO: 根据实际返回类型修改
    int batchInsert(NoticeHistory entity);

}
