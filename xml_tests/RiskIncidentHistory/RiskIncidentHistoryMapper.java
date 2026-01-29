package com.dbapp.extension.xdr.threatMonitor.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface RiskIncidentHistoryMapper {
    List<Map<String, Object>> getRiskHistoryList(@Param("params") Map<String, Object> params);
    List<Map<String, Object>> queryEventCount(@Param("params") Map<String, Object> params);
    List<String> getFocusObject();
    List<Map<String, Object>> FocusIpMessage(@Param("list") List<String> list);
    List<Map<String, Object>> selectAllByIdList(@Param("idList") List<Integer> idList);
    Long getCount(@Param("params") Map<String, Object> params);
    Long getFocusIpCount(@Param("params") Map<String, Object> params);
    List<Map<String, Object>> queryFocusIps(@Param("params") Map<String, Object> params);
    Long queryFocusIpCount(@Param("params") Map<String, Object> params);
    Integer countByDate(@Param("date") String date);
}
