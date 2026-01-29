package com.dbapp.extension.xdr.threatMonitor.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

/**
 * AssetInfo Mapper接口
 * 映射文件：AssetInfoMapper.xml
 */
@Mapper
public interface AssetInfoMapper {
    
    /**
     * 查询资产总数
     */
    long queryAssetsCount();
    
    /**
     * 分页查询资产列表
     * @param offset 偏移量
     * @param size 每页大小
     * @return 返回Map列表，包含assetIp和assetName
     */
    List<Map<String, Object>> queryAssets(@Param("offset") int offset, @Param("size") int size);
}
