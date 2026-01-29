package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.dbapp.extension.xdr.linkageHandle.entity.EndTimeEntity;
import com.dbapp.extension.xdr.linkageHandle.entity.ProhibitHistory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * LinkedStrategyValidtime Mapper接口
 * 映射文件：LinkedStrategyValidtimeMapper.xml
 * 
 * 包含3个方法
 */
@Mapper
public interface LinkedStrategyValidtimeMapper {
    
    /**
     * 插入有效时间
     * @param prohibitHistory 封堵历史对象
     * @param endTime 结束时间
     */
    int insertValidtime(@Param("prohibitHistory") ProhibitHistory prohibitHistory, @Param("endTime") String endTime);
    
    /**
     * 删除有效时间
     * @param params 删除参数（linkDeviceIp, blockIp, blockDomain, nodeId, direction, effectTime等）
     */
    int deleteEndtime(@Param("params") Map<String, Object> params);
    
    /**
     * 查询过期的有效时间记录
     * @param nowTime 当前时间
     */
    List<EndTimeEntity> selectEndTime(@Param("nowTime") String nowTime);
}
