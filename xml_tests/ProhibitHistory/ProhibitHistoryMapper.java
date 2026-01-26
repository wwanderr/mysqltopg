package com.dbapp.extension.xdr.test.mapper;

import org.apache.ibatis.annotations.Mapper;

/**
 * ProhibitHistory Mapper 接口
 * 
 * 对应 XML: ProhibitHistoryMapper.xml
 * 
 * 生成时间: 2026-01-26 11:03:49
 */
@Mapper
public interface ProhibitHistoryMapper {

    Object sumLaunchTimesByStrategyId();  // TODO: 根据实际返回类型修改
    Object getProhibitListByCondition();  // TODO: 根据实际返回类型修改
    Object listByCondition();  // TODO: 根据实际返回类型修改
    Object getProhibitListCount();  // TODO: 根据实际返回类型修改
    Object getBlockIPDistribution();  // TODO: 根据实际返回类型修改
    Object getTrend();  // TODO: 根据实际返回类型修改
    Object getBlockIPCount();  // TODO: 根据实际返回类型修改
    Object getBlockIPTodayCount();  // TODO: 根据实际返回类型修改
    Object getAutoBlockIPCount();  // TODO: 根据实际返回类型修改
    Object getAutoBlockIPTodayCount();  // TODO: 根据实际返回类型修改
    Object getTriggerSubscriptionCount();  // TODO: 根据实际返回类型修改
    Object getStrategyCount();  // TODO: 根据实际返回类型修改
    Object getProhibitListByDeviceId();  // TODO: 根据实际返回类型修改
    Object getPairHistories();  // TODO: 根据实际返回类型修改
    Object getSingleHistories();  // TODO: 根据实际返回类型修改
    Object getHistoryByBlockList();  // TODO: 根据实际返回类型修改
    Object getHistoryById();  // TODO: 根据实际返回类型修改
    Object getUnsealIpTodayCount();  // TODO: 根据实际返回类型修改
    Object findHistoriesByDomain();  // TODO: 根据实际返回类型修改
    Object findEdrProhibitHistory();  // TODO: 根据实际返回类型修改
    Object findEdrProhibitHistories();  // TODO: 根据实际返回类型修改
    Object getAiGentNoDirectionHistory();  // TODO: 根据实际返回类型修改
    Object getAiGentNoDirectionHistories();  // TODO: 根据实际返回类型修改
    Object getAiGentDirectionHistories();  // TODO: 根据实际返回类型修改
    Object getAiGentProhibitDomain();  // TODO: 根据实际返回类型修改
    Object prohibitListByStrategyId();  // TODO: 根据实际返回类型修改
    Object getIdsByStrategyId();  // TODO: 根据实际返回类型修改
    Object getBlockDeviceIds();  // TODO: 根据实际返回类型修改
    Object getBlockDeviceIps();  // TODO: 根据实际返回类型修改
    Object countEdrProhibit();  // TODO: 根据实际返回类型修改
    Object getDomainList();  // TODO: 根据实际返回类型修改
    int insertProhibitHistory(ProhibitHistory entity);
    void updateByBlockipAndDeviceIp(ProhibitHistory entity);  // UPDATE 无返回值
    void updateStatusById(ProhibitHistory entity);  // UPDATE 无返回值
    void updateDeviceIpAndId(ProhibitHistory entity);  // UPDATE 无返回值
    int deleteByIds(Integer id);
    int deleteByStrategyId(Integer id);

}
