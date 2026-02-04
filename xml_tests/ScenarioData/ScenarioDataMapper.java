package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.ScenarioData;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ScenarioDataMapper extends BaseMapper<ScenarioData> {
    void insertOrUpdate(ScenarioData entity);
}
