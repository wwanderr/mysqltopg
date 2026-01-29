package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.SecurityEventTemplate;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * QueryTemplate Mapper接口
 * 映射文件：QueryTemplateMapper.xml
 */
@Mapper
public interface QueryTemplateMapper {
    
    /**
     * 查询所有模板
     */
    List<SecurityEventTemplate> queryAllTemplate();
    
    /**
     * 根据ID更新模板
     * @param template 模板对象
     */
    void updateById(@Param("template") SecurityEventTemplate template);
    
    /**
     * 根据ID查询模板
     * @param templateId 模板ID
     */
    SecurityEventTemplate queryTemplateById(@Param("templateId") String templateId);
}
