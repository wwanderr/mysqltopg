package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.KillProcessHistory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * KillProcessHistory Mapper接口
 * 映射文件：KillProcessHistoryMapper.xml
 */
@Mapper
public interface KillProcessHistoryMapper {
    
    /**
     * 按策略ID统计启动次数
     * @param strategyIds 策略ID列表
     */
    List<BaseHistoryVO> countLaunchTimesByStrategyId(@Param("strategyIds") List<Integer> strategyIds);
    
    /**
     * 批量插入进程终止历史
     * @param list 进程终止历史列表
     */
    int batchInsert(@Param("list") List<KillProcessHistory> list);
}
