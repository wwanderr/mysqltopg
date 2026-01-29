package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.IsolationHistory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * IsolationHistory Mapper接口
 * 映射文件：IsolationHistoryMapper.xml
 */
@Mapper
public interface IsolationHistoryMapper {
    
    /**
     * 按策略ID统计启动次数
     * @param strategyIds 策略ID列表
     */
    List<BaseHistoryVO> countLaunchTimesByStrategyId(@Param("strategyIds") List<Integer> strategyIds);
    
    /**
     * 批量插入隔离历史
     * @param list 隔离历史列表
     */
    int batchInsert(@Param("list") List<IsolationHistory> list);
}
