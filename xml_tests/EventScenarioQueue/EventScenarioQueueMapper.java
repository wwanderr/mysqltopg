package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.ScenarioWrapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * EventScenarioQueue Mapper接口
 * 映射文件：EventScenarioQueueMapper.xml
 * 
 * 包含4个方法
 */
@Mapper
public interface EventScenarioQueueMapper {
    
    /**
     * 查询最新未提交的记录（最多1000条）
     * 关联 t_security_incidents 表
     */
    List<ScenarioWrapper> selectLast();
    
    /**
     * 批量插入或忽略（如果主键冲突则忽略）
     * @param datas 场景数据列表（参数名必须是datas，与XML的collection匹配）
     */
    int insertIgnore(@Param("datas") List<ScenarioWrapper> datas);
    
    /**
     * 批量更新提交状态为true
     * @param datas 场景数据列表（参数名必须是datas，与XML的collection匹配）
     */
    void updateSyncSuccessBatch(@Param("datas") List<ScenarioWrapper> datas);
    
    /**
     * 清理已提交或无关联事件的旧数据
     * @param time 时间阈值（删除早于此时间的记录）
     */
    int tryClean(@Param("time") String time);
}
