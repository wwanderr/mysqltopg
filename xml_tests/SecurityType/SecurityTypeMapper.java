package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.SecurityType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * SecurityType Mapper 接口
 * 
 * 对应 XML: SecurityTypeMapper.xml
 * 
 * 根据反编译接口修复：2026-01-28
 */
@Mapper
public interface SecurityTypeMapper extends BaseMapper<SecurityType> {

    /**
     * 查询所有安全类型（从 t_event_template 表查询 DISTINCT 类型）
     */
    List<SecurityType> queryTypes();

    /**
     * 清空 t_security_types 表
     */
    void truncate();

    /**
     * 批量插入安全类型（使用 ON CONFLICT 处理冲突）
     */
    void branchInsert(@Param("list") List<SecurityType> var1);

}
