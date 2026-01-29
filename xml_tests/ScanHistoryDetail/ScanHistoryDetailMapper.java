package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.ScanHistoryDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * ScanHistoryDetail Mapper接口
 * 映射文件：ScanHistoryDetailMapper.xml
 */
@Mapper
public interface ScanHistoryDetailMapper {
    
    /**
     * 按策略ID统计启动次数
     * @param strategyIds 策略ID列表
     */
    List<BaseHistoryVO> countLaunchTimesByStrategyId(@Param("strategyIds") List<Integer> strategyIds);
    
    /**
     * 批量插入扫描历史详情
     * @param list 扫描历史详情列表
     */
    int insertBatch(@Param("list") List<ScanHistoryDetail> list);
    
    /**
     * 根据策略ID获取历史记录ID列表
     * @param strategyId 策略ID
     */
    List<Long> getIdsByStrategyId(@Param("strategyId") Long strategyId);
    
    /**
     * 根据条件查询扫描历史详情
     * @param params 查询参数
     */
    List<ScanHistoryDetail> selectByOption(@Param("params") Map<String, Object> params);
    
    /**
     * 查询扫描的IP列表
     * @param strategyId 策略ID
     */
    List<String> selectScanIps(@Param("strategyId") Long strategyId);
}
