package com.dbapp.extension.xdr.riskIncident.mapper;

import com.dbapp.extension.xdr.outgoingData.po.OutGoingConfig;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * OutGoingConfig Mapper接口
 * 映射文件：OutGoingConfigMapper.xml
 */
@Mapper
public interface OutGoingConfigMapper {
    
    /**
     * 查询外发配置列表
     * @param type 类型（如SYSLOG, KAFKA等）
     * @param enable 是否启用
     */
    List<OutGoingConfig> selectOutGoingConfig(@Param("type") String type, @Param("enable") Boolean enable);
    
    /**
     * 按ID查询配置
     * @param id 配置ID
     */
    OutGoingConfig selectConfigById(@Param("id") Integer id);
    
    /**
     * 查询外发配置数量
     * @param type 类型
     * @param enable 是否启用
     */
    long selectOutGoingConfigCount(@Param("type") String type, @Param("enable") Boolean enable);
    
    /**
     * 分页查询外发配置
     * @param type 类型
     * @param enable 是否启用
     * @param offset 偏移量
     * @param size 每页大小
     */
    List<OutGoingConfig> selectOutGoingConfigByPage(@Param("type") String type, @Param("enable") Boolean enable, @Param("offset") int offset, @Param("size") int size);
    
    /**
     * 查询Kerberos配置数量
     * @param id 配置ID（排除该ID）
     * @param serverAddress 服务器地址
     * @param kdcServerName KDC服务器名称
     */
    int selectKbrCount(@Param("id") Integer id, @Param("serverAddress") String serverAddress, @Param("kdcServerName") String kdcServerName);
    
    /**
     * 按ID更新开关状态
     * @param id 配置ID
     * @param enable 是否启用
     */
    void updateSwitchById(@Param("id") Integer id, @Param("enable") Boolean enable);
    
    /**
     * 关闭配置（软删除）
     * @param outGoingConfig 配置对象
     */
    void closeConfig(@Param("outGoingConfig") OutGoingConfig outGoingConfig);
}
