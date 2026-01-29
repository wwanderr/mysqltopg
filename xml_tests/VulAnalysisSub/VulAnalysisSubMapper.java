package com.dbapp.extension.xdr.vulnerabilityAnalysis.mapper;

import com.dbapp.extension.xdr.vulnerabilityAnalysis.entity.VulAnalysisSub;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * VulAnalysisSub Mapper接口
 * 映射文件：VulAnalysisSubMapper.xml
 * 包含11个方法
 */
@Mapper
public interface VulAnalysisSubMapper {
    
    int insertOrUpdate(@Param("vulList") List<VulAnalysisSub> vulList);
    Long queryListCount(@Param("params") Map<String, Object> params);
    List<Map<String, Object>> queryList(@Param("params") Map<String, Object> params);
    Long querySubListCount(@Param("params") Map<String, Object> params);
    List<Map<String, Object>> querySubListCveCount(@Param("params") Map<String, Object> params);
    List<Map<String, Object>> querySubList(@Param("params") Map<String, Object> params);
    List<Map<String, Object>> querySubListById(@Param("idList") List<Long> idList);
    void updateByParams(@Param("params") Map<String, Object> params);
    void updateByIds(@Param("ids") List<Long> ids, @Param("ignoreStatus") Integer ignoreStatus);
    List<Map<String, Object>> queryTop10(@Param("params") Map<String, Object> params);
    List<Map<String, Object>> queryProportion(@Param("params") Map<String, Object> params);
}
