package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.xdr.bean.dto.AptDeleteDto;
import com.dbapp.xdr.bean.dto.AptHostDto;
import com.dbapp.xdr.bean.po.ThreatIntelligenceAnalysis;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;
import java.util.List;

/**
 * ThreatIntelligenceAnalysis Mapper 接口（Mirror 测试套件）
 *
 * 对应 PG XML:
 * - mysql/mirror_pg_xml/ThreatIntelligenceAnalysisMapper.xml
 *
 * 注意：
 * - XML 中使用了 #{id} 和 collection 变量名，这里补充 @Param 以确保 MyBatis 能正确绑定参数名
 */
@Mapper
public interface ThreatIntelligenceAnalysisMapper extends BaseMapper<ThreatIntelligenceAnalysis> {
    AptHostDto getServerById(@Param("id") Long id);

    List<AptDeleteDto> getAptDeleteDtosByIds(@Param("collection") Collection<Long> ids);

    List<ThreatIntelligenceAnalysis> selectAll();
}

