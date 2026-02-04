package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.ScanHistoryDetail;
import com.dbapp.extension.xdr.linkageHandle.entity.ScanHistoryDetailVO;
import com.dbapp.extension.xdr.linkageHandle.entity.ScanStrategyParam;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ScanHistoryDetailMapper extends BaseMapper<ScanHistoryDetail> {
    List<BaseHistoryVO> countLaunchTimesByStrategyId(@Param("strategyIds") List<Long> strategyIds);

    int insertBatch(@Param("scanHistoryDetails") List<ScanHistoryDetail> scanHistoryDetails);

    List<Long> getIdsByStrategyId(@Param("strategyId") Long strategyId);

    IPage<ScanHistoryDetailVO> selectByOption(
            @Param("page") IPage<ScanHistoryDetailVO> page,
            @Param("param") ScanStrategyParam param);

    List<String> selectScanIps(@Param("param") ScanStrategyParam param);
}
