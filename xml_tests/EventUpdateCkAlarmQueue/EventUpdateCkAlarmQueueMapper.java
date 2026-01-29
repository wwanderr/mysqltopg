package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.TEventUpdateCkAlarmQueue;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * EventUpdateCkAlarmQueue Mapper接口
 * 映射文件：EventUpdateCkAlarmQueueMapper.xml
 * 
 * 包含3个方法
 */
@Mapper
public interface EventUpdateCkAlarmQueueMapper {
    
    /**
     * 查询最新未同步的记录（最多1000条）
     * @return 返回Map列表
     */
    List<Map<String, Object>> selectLast();
    
    /**
     * 批量插入或忽略（如果主键冲突则忽略）
     * @param datas 队列数据列表（参数名必须是datas，与XML的collection匹配）
     */
    int insertIgnore(@Param("datas") List<TEventUpdateCkAlarmQueue> datas);
    
    /**
     * 批量更新同步状态为true
     * @param datas 队列数据列表（参数名必须是datas，与XML的collection匹配）
     */
    void updateSyncSuccessBatch(@Param("datas") List<TEventUpdateCkAlarmQueue> datas);
}
