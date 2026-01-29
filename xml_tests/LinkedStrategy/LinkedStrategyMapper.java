package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.dbapp.extension.xdr.linkageHandle.entity.LinkedStrategy;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * LinkedStrategy Mapper接口
 * 映射文件：LinkedStrategyMapper.xml
 * 
 * 包含14个方法
 */
@Mapper
public interface LinkedStrategyMapper {
    
    /**
     * 插入或更新联动策略
     * @param linkedStrategy 联动策略对象
     */
    int insertOrUpdate(@Param("linkedStrategy") LinkedStrategy linkedStrategy);
    
    /**
     * 启用联动策略
     * @param linkedStrategy 联动策略对象（包含id和is_enable字段）
     */
    void enableLinkStrategy(@Param("linkedStrategy") LinkedStrategy linkedStrategy);
    
    /**
     * 更新联动策略
     * @param linkedStrategy 联动策略对象
     */
    void update(@Param("linkedStrategy") LinkedStrategy linkedStrategy);
    
    /**
     * 删除联动策略
     * @param id 策略ID
     */
    int deleteLinkStrategy(@Param("id") Long id);
    
    /**
     * 根据ID获取联动策略
     * @param id 策略ID
     */
    LinkedStrategy getLinkStrategyById(@Param("id") Long id);
    
    /**
     * 根据ID列表获取联动策略
     * @param ids 策略ID列表
     */
    List<LinkedStrategy> getLinkStrategyByIds(@Param("ids") List<Long> ids);
    
    /**
     * 获取联动策略列表总数
     * @param params 查询参数
     */
    Long getLinkStrategyListTotal(@Param("params") Map<String, Object> params);
    
    /**
     * 获取联动策略列表
     * @param params 查询参数（包含分页offset, limit等）
     */
    List<LinkedStrategy> getLinkStrategyList(@Param("params") Map<String, Object> params);
    
    /**
     * 根据名称和ID获取策略数量（用于唯一性校验）
     * @param strategyName 策略名称
     * @param id 策略ID（排除自己）
     */
    Integer getLinkStrategyCountByNameAndId(@Param("strategyName") String strategyName, @Param("id") Long id);
    
    /**
     * 根据参数查找联动策略
     * @param params 查询参数
     */
    List<LinkedStrategy> findLinkStrategyByParam(@Param("params") Map<String, Object> params);
    
    /**
     * 获取所有模板策略ID
     */
    List<LinkedStrategy> getAllTemplateStrategyIds();
    
    /**
     * 批量更新联动设备配置
     * @param linkedStrategy 联动策略对象（包含thirdAuthId）
     */
    void batchUpdateLinkDeviceConfig(@Param("linkedStrategy") LinkedStrategy linkedStrategy);
    
    /**
     * 获取所有策略
     */
    List<LinkedStrategy> getAllStrategys();
    
    /**
     * 更新AppId
     * @param linkedStrategy 联动策略对象（包含id和appId）
     */
    void updateAppId(@Param("linkedStrategy") LinkedStrategy linkedStrategy);
}
