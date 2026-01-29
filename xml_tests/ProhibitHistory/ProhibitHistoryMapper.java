package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.dbapp.extension.xdr.linkageHandle.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

/**
 * ProhibitHistory Mapper接口（19个方法）
 * 映射文件：ProhibitHistoryMapper.xml
 */
@Mapper
public interface ProhibitHistoryMapper {
    
    List<BaseHistoryVO> sumLaunchTimesByStrategyId(@Param("strategyIds") List<Integer> strategyIds);
    int insertProhibitHistory(@Param("prohibitHistory") ProhibitHistory prohibitHistory);
    void updateByBlockipAndDeviceIp(@Param("prohibitHistory") ProhibitHistory prohibitHistory);
    void updateStatusById(@Param("prohibitHistory") ProhibitHistory prohibitHistory);
    int deleteByIds(@Param("ids") List<Long> ids);
    List<ProhibitHistoryVO> getProhibitListByCondition(@Param("param") ProhibitHistoryParam param);
    List<ProhibitHistoryVO> listByCondition(@Param("param") ProhibitHistoryParam param);
    Long getProhibitListCount(@Param("param") ProhibitHistoryParam param);
    List<BlockIPDistribution> getBlockIPDistribution(@Param("startTime") String startTime, @Param("endTime") String endTime);
    List<BlockIPTrend> getTrend(@Param("startTime") String startTime, @Param("endTime") String endTime);
    Long getBlockIPCount(@Param("startTime") String startTime, @Param("endTime") String endTime);
    Long getBlockIPTodayCount();
    Long getAutoBlockIPCount(@Param("startTime") String startTime, @Param("endTime") String endTime);
    Long getAutoBlockIPTodayCount();
    Long getTriggerSubscriptionCount(@Param("startTime") String startTime, @Param("endTime") String endTime);
    Long getStrategyCount(@Param("startTime") String startTime, @Param("endTime") String endTime);
    List<ProhibitHistoryVO> getProhibitListByDeviceId(@Param("deviceId") String deviceId, @Param("linkDeviceIp") String linkDeviceIp);
    List<ProhibitHistoryVO> getPairHistories(@Param("params") Map<String, Object> params);
    List<ProhibitHistoryVO> getSingleHistories(@Param("params") Map<String, Object> params);
}
