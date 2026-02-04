package com.dbapp.extension.xdr.vulnerabilityAnalysis.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.extension.xdr.vulnerabilityAnalysis.entity.VulAnalysisSub;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * VulAnalysisSub Mapper 接口（根据反编译接口对齐）
 *
 * 对应 XML: VulAnalysisSubMapper.xml
 */
@Mapper
public interface VulAnalysisSubMapper extends BaseMapper<VulAnalysisSub> {

    Long insertOrUpdate(VulAnalysisSub var1);

    Long queryListCount(Map<String, Object> var1);

    List<Map<String, Object>> queryList(Map<String, Object> var1);

    List<Map<String, Object>> querySubList(Map<String, Object> var1);

    List<Map<String, Object>> querySubListById(List<String> var1);

    Long querySubListCount(Map<String, Object> var1);

    void updateByParams(Map<String, Object> var1);

    List<Map<String, Object>> queryTop10(Map<String, Object> var1);

    List<Map<String, Object>> queryProportion(Map<String, Object> var1);

    void updateByIds(@Param("id") List<String> var1, @Param("status") Integer var2);

    List<Map<String, Object>> querySubListCveCount(Map<String, Object> var1);
}
