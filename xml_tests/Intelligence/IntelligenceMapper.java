package com.dbapp.extension.xdr.threatIntelligence.mapper;

import com.dbapp.extension.xdr.threatIntelligence.entity.IntelligenceSub;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Intelligence Mapper接口
 * 映射文件：IntelligenceMapper.xml
 * 
 * 包含14个方法
 */
@Mapper
public interface IntelligenceMapper {
    
    /**
     * 批量保存或更新情报数据
     * @param subList 情报列表（参数名必须是subList，与XML的collection匹配）
     */
    int saveOrUpdateBatch(@Param("subList") List<IntelligenceSub> subList);
    
    /**
     * 插入IoC资产关联数据
     * @param subList 情报列表（参数名必须是subList，与XML的collection匹配）
     */
    int insertIoCAsset(@Param("subList") List<IntelligenceSub> subList);
    
    /**
     * 查询情报列表数量
     * @param params 查询参数（startTime, endTime, ioC, subCategory, threatSeverity, alarmName, tag, isCrossDay等）
     */
    Long listCount(@Param("params") Map<String, Object> params);
    
    /**
     * 查询情报列表
     * @param params 查询参数（包含分页offset, limit等）
     */
    List<Map<String, Object>> list(@Param("params") Map<String, Object> params);
    
    /**
     * 更新资产列表关联
     * @param params 更新参数（ioC, eventTime）
     */
    void updateAssetList(@Param("params") Map<String, Object> params);
    
    /**
     * 从资产表更新情报列表
     * @param params 更新参数（ioC, eventTime）
     */
    void updateListFromAsset(@Param("params") Map<String, Object> params);
    
    /**
     * 更新情报列表
     * @param params 更新参数（ioC, eventTime, alarmStatus）
     */
    void updateList(@Param("params") Map<String, Object> params);
    
    /**
     * 部分导出情报数据
     * @param params 导出参数（startTime, endTime, offset, limit等）
     */
    List<Map<String, Object>> partExport(@Param("params") Map<String, Object> params);
    
    /**
     * 查询情报比例分布
     * @param params 查询参数（startTime, endTime等）
     */
    List<Map<String, Object>> proportion(@Param("params") Map<String, Object> params);
    
    /**
     * 查询Top5情报
     * @param params 查询参数（startTime, endTime等）
     */
    List<Map<String, Object>> top5(@Param("params") Map<String, Object> params);
    
    /**
     * 查询情报子列表数量
     * @param params 查询参数（ioC, startTime, endTime）
     */
    Long subListCount(@Param("params") Map<String, Object> params);
    
    /**
     * 查询情报子列表
     * @param params 查询参数（ioC, startTime, endTime, offset, limit）
     */
    List<Map<String, Object>> subList(@Param("params") Map<String, Object> params);
    
    /**
     * 更新标签
     * @param subList 情报列表（参数名必须是subList，与XML的collection匹配）
     */
    void updateTag(@Param("subList") List<IntelligenceSub> subList);
    
    /**
     * 更新资产标签
     * @param subList 情报列表（参数名必须是subList，与XML的collection匹配）
     */
    void updateAssetTag(@Param("subList") List<IntelligenceSub> subList);
}
