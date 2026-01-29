package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.dbapp.extension.xdr.linkageHandle.entity.StrategyDeviceRel;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * StrategyDeviceRel Mapper接口
 * 映射文件：StrategyDeviceRelMapper.xml
 * 包含12个方法
 */
@Mapper
public interface StrategyDeviceRelMapper {
    
    int insert(@Param("strategyDeviceRel") StrategyDeviceRel strategyDeviceRel);
    int batchInsert(@Param("list") List<StrategyDeviceRel> list);
    void update(@Param("strategyDeviceRel") StrategyDeviceRel strategyDeviceRel);
    void batchInsertOrUpdate(@Param("list") List<StrategyDeviceRel> list);
    int deleteRelByStrategyId(@Param("strategyId") Long strategyId);
    int deleteRelByStrategyIdAndDeviceId(@Param("strategyId") Long strategyId, @Param("deviceId") String deviceId);
    StrategyDeviceRel selectById(@Param("id") Long id);
    List<StrategyDeviceRel> getAlarmStrategyList(@Param("params") Map<String, Object> params);
    List<StrategyDeviceRel> findDeviceByStrateId(@Param("strategyId") Long strategyId);
    List<Long> findStrategyIdByDeviceId(@Param("deviceId") String deviceId);
    Integer getDeviceCount(@Param("strategyId") Long strategyId);
    void updateDeviceIpAndId(@Param("oldDeviceId") String oldDeviceId, @Param("newDeviceIp") String newDeviceIp, @Param("newDeviceId") String newDeviceId);
}
