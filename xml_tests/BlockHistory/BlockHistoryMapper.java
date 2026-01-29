package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.BlockHistory;
import com.dbapp.extension.xdr.linkageHandle.entity.BlockHistoryVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * BlockHistory Mapper接口
 * 映射文件：BlockHistoryMapper.xml
 * 
 * 包含11个方法
 */
@Mapper
public interface BlockHistoryMapper {
    
    /**
     * 按策略ID汇总启动次数
     * @param strategyIds 策略ID列表
     */
    List<BaseHistoryVO> sumLaunchTimesByStrategyId(@Param("strategyIds") List<Integer> strategyIds);
    
    /**
     * 插入封堵历史记录
     * @param blockHistory 封堵历史对象
     */
    int insertBlockHistory(@Param("blockHistory") BlockHistory blockHistory);
    
    /**
     * 查询封堵列表数量
     * @param param 查询条件对象（包含 strategyName, linkDeviceIp, srcAddress, destAddress, strategyId）
     */
    Long getBlockListCount(@Param("param") Map<String, Object> param);
    
    /**
     * 查询封堵历史列表
     * @param param 查询条件对象（包含 strategyId, strategyName, linkDeviceIp, srcAddress, destAddress, limit, offset）
     * @param orderByStr 排序字符串（可选）
     */
    List<BlockHistoryVO> getBlockHistory(@Param("param") Map<String, Object> param, @Param("orderByStr") String orderByStr);
    
    /**
     * 按IP查询历史记录
     * @param linkDeviceIp 链路设备IP
     * @param srcAddress 源地址
     * @param destAddress 目标地址
     */
    List<BlockHistoryVO> getHistoryByIp(
        @Param("linkDeviceIp") String linkDeviceIp, 
        @Param("srcAddress") String srcAddress, 
        @Param("destAddress") String destAddress
    );
    
    /**
     * 按条件查询封堵历史
     * @param strategyId 策略ID
     * @param linkDeviceIp 链路设备IP
     */
    List<BlockHistoryVO> getBlockHistoryByCondition(
        @Param("strategyId") Integer strategyId, 
        @Param("linkDeviceIp") String linkDeviceIp
    );
    
    /**
     * 按策略ID查询历史记录
     * @param strategyId 策略ID
     */
    List<BlockHistoryVO> getHistoryByStrategyId(@Param("strategyId") Integer strategyId);
    
    /**
     * 按ID列表查询历史记录
     * @param ids ID列表
     */
    List<BlockHistoryVO> getHistoryByIds(@Param("ids") List<Long> ids);
    
    /**
     * 按ID删除历史记录
     * @param id 记录ID
     */
    int deleteHistoryById(@Param("id") Long id);
    
    /**
     * 更新设备IP和ID
     * @param previousDeviceId 旧设备ID
     * @param currentDeviceId 新设备ID
     * @param linkDeviceType 链路设备类型
     * @param masterHost 主机地址
     */
    void updateDeviceIpAndId(
        @Param("previousDeviceId") String previousDeviceId,
        @Param("currentDeviceId") String currentDeviceId,
        @Param("linkDeviceType") String linkDeviceType,
        @Param("masterHost") String masterHost
    );
    
    /**
     * 按策略ID查询ID列表
     * @param strategyId 策略ID
     */
    List<Long> getIdsByStrategyId(@Param("strategyId") Integer strategyId);
}
