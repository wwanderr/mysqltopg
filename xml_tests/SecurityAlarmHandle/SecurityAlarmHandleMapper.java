package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.SecurityAlarmHandle;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SecurityAlarmHandleMapper extends BaseMapper<SecurityAlarmHandle> {

    void insertOrUpdate(@Param("handleList") List<SecurityAlarmHandle> handleList);

    void updateStatusById(@Param("securityAlarmHandle") SecurityAlarmHandle securityAlarmHandle);
}
