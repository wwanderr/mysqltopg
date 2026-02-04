package com.dbapp.extension.xdr.commonConfig.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * CommonConfig Mapper接口
 * 映射文件：CommonConfigMapper.xml
 * 
 * 提供通用配置的查询、插入、更新功能
 */
@Mapper
public interface CommonConfigMapper {
    
    /**
     * 查询通用配置值
     * @param prefix 配置前缀（分类）
     * @param key 配置键（名称）
     * @return 配置值，如果不存在则返回 null
     */
    String queryCommonConfig(@Param("prefix") String prefix, @Param("key") String key);
    
    /**
     * 插入通用配置
     * @param prefix 配置前缀（分类）
     * @param key 配置键（名称）
     * @param value 配置值
     */
    void insertCommonConfig(@Param("prefix") String prefix, @Param("key") String key, @Param("value") String value);
    
    /**
     * 更新通用配置
     * @param prefix 配置前缀（分类）
     * @param key 配置键（名称）
     * @param value 新的配置值
     * @return 影响的行数
     */
    int updateCommonConfig(@Param("prefix") String prefix, @Param("key") String key, @Param("value") String value);
    
    /**
     * 查询镜像库中的通用配置值
     * @param prefix 配置前缀（分类）
     * @param key 配置键（名称）
     * @return 配置值，如果不存在则返回 null
     */
    String queryMirrorCommonConfig(@Param("prefix") String prefix, @Param("key") String key);
}
