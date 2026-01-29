package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentOutGoing;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface RiskIncidentOutGoingMapper {
    List<RiskIncidentOutGoing> mappingFromClueSecurityEvent(@Param("params") Map<String, Object> params);
    List<RiskIncidentOutGoing> mappingNormalSecurityEvent(@Param("params") Map<String, Object> params);
    int backUpLastTermData(@Param("params") Map<String, Object> params);
    void batchInsertOrUpdateIncident(@Param("list") List<RiskIncidentOutGoing> list);
    int deleteOldIncident(@Param("saveDays") Integer saveDays);
    List<RiskIncidentOutGoing> queryListByTime(@Param("startTime") String startTime, @Param("endTime") String endTime);
    void batchUpdatePayload(@Param("list") List<RiskIncidentOutGoing> list);
    void updateKillChain(@Param("id") Long id, @Param("killChain") String killChain);
    int clearHistoryData(@Param("saveDays") Integer saveDays);
    List<Map<String, Object>> queryOutGoingList(@Param("params") Map<String, Object> params);
    List<Long> selectOldIncidentByCodes(@Param("codes") List<String> codes, @Param("saveDays") Integer saveDays);
    List<Map<String, Object>> groupByFocusIp(@Param("focusIps") List<String> focusIps);
    List<Map<String, Object>> groupNameByFocusIp(@Param("focusIps") List<String> focusIps);
    List<Long> selectOldHistoryIds(@Param("saveDays") Integer saveDays);
    int deleteHistoryByIds(@Param("ids") List<Long> ids);
}
