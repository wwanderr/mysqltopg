package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.dbapp.extension.xdr.linkageHandle.entity.StrategyDeviceRel;
import com.dbapp.extension.xdr.linkageHandle.entity.StrategyAlarmInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * StrategyDeviceRel Mapper接口
 * 映射文件：StrategyDeviceRelMapper.xml
 * 根据反编译接口修复：2026-01-28
 */
@Mapper
public interface StrategyDeviceRelMapper {
    
    /**
     * 插入策略设备关联
     */
    int insert(@Param("strategyDeviceRelVO") StrategyDeviceRel var1);

    /**
     * 根据策略ID删除关联
     */
    int deleteRelByStrategyId(@Param("strategyId") Long var1);

    /**
     * 根据ID查询
     */
    StrategyDeviceRel selectById(@Param("id") Long var1);

    /**
     * 更新策略设备关联
     */
    int update(@Param("strategyDeviceRelVO") StrategyDeviceRel var1);

    /**
     * 批量插入
     */
    int batchInsert(@Param("insertList") List<StrategyDeviceRel> var1);

    /**
     * 批量插入或更新
     */
    int batchInsertOrUpdate(@Param("updateList") List<StrategyDeviceRel> var1);

    /**
     * 获取告警策略列表（返回 StrategyAlarmInfo）
     */
    List<StrategyAlarmInfo> getAlarmStrategyList(@Param("threatType") String var1);

    /**
     * 根据策略ID查找设备
     */
    List<StrategyDeviceRel> findDeviceByStrateId(@Param("strategyId") Long var1);

    /**
     * 根据设备ID查找策略ID列表
     */
    List<Long> findStrategyIdByDeviceId(@Param("deviceId") String var1);

    /**
     * 获取设备数量
     */
    int getDeviceCount(@Param("strategyId") Long var1);

    /**
     * 根据策略ID和设备ID删除关联
     */
    void deleteRelByStrategyIdAndDeviceId(@Param("strategyId") Long var1, @Param("deviceId") String var2);

    /**
     * 更新设备IP和ID
     */
    int updateDeviceIpAndId(@Param("masterHost") String var1, @Param("currentDeviceId") String var2, @Param("previousDeviceId") String var3);
}
