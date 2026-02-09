package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dbapp.xdr.bean.dto.LicenseStatusDto;
import com.dbapp.xdr.bean.dto.XdrDeviceDetailDto;
import com.dbapp.xdr.bean.dto.XdrDeviceDto;
import com.dbapp.xdr.bean.request.XdrDeviceDetailRequest;
import com.dbapp.xdr.bean.request.XdrDeviceRequest;
import com.dbapp.xdr.bean.response.XdrDeviceBase;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface XdrDeviceMapper {
    List<XdrDeviceDto> getAllXdrDevices(@Param("request") XdrDeviceRequest var1);

    Page<XdrDeviceDto> getXdrDevices(Page var1, @Param("request") XdrDeviceRequest var2);

    Page<XdrDeviceBase> listXdrDevices(Page var1, @Param("request") XdrDeviceRequest var2);

    XdrDeviceDetailDto getXdrDeviceByAgentCode(@Param("orderSql") String var1, @Param("request") XdrDeviceDetailRequest var2);

    List<LicenseStatusDto> getAgentTypeLicenseStatus();

    XdrDeviceDetailDto getXdrDeviceByNo(@Param("orderSql") String var1, @Param("request") XdrDeviceDetailRequest var2, @Param("no") long var3);
}
