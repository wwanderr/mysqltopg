package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncident;
import com.dbapp.extension.xdr.entity.CommonFilter;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface RiskIncidentMapper {
    List<RiskIncident> aggClueSecurityEventByName(@Param("params") Map<String, Object> params);
    List<RiskIncident> mappingNormalSecurityEvent(@Param("params") Map<String, Object> params);
    int backUpLastTermData(@Param("params") Map<String, Object> params);
    void batchInsertOrUpdateIncident(@Param("list") List<RiskIncident> list);
    int deleteOldIncidentAnalysis(@Param("saveDays") Integer saveDays);
    int deleteOldIncident(@Param("saveDays") Integer saveDays);
    List<Long> selectOldIncidentByCodes(@Param("codes") List<String> codes);
    List<Map<String, Object>> getRiskList(@Param("params") Map<String, Object> params);
    List<Map<String, Object>> getCountByStatus(@Param("params") Map<String, Object> params);
    List<Map<String, Object>> getByEventCode(@Param("eventCode") String eventCode);
    Map<String, Object> selectEventAndTempById(@Param("id") Integer id);
    List<Map<String, Object>> selectAllByIdList(@Param("idList") List<Integer> idList);
    List<Map<String, Object>> queryEventCount(@Param("params") Map<String, Object> params);
    List<CommonFilter> queryIncidentsCount(@Param("params") Map<String, Object> params);
    List<String> queryKillChains(@Param("params") Map<String, Object> params);
    String getEventIdsById(@Param("id") Integer id);
    String getFilterContent(@Param("id") Integer id);
    List<Map<String, Object>> FocusIpMessage(@Param("list") List<String> list);
    List<String> getFocusObject();
}
