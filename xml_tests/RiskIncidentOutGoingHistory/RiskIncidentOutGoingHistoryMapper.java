package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentOutGoing;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface RiskIncidentOutGoingHistoryMapper {
    List<RiskIncidentOutGoing> mappingFromClueSecurityEvent(@Param("params") Map<String, Object> params);
    List<RiskIncidentOutGoing> mappingNormalSecurityEvent(@Param("params") Map<String, Object> params);
    int backUpLastTermData(@Param("params") Map<String, Object> params);
    void batchInsertOrUpdateIncident(@Param("list") List<RiskIncidentOutGoing> list);
    int deleteOldIncident(@Param("saveDays") Integer saveDays);
    List<RiskIncidentOutGoing> queryListByTime(@Param("startTime") String startTime, @Param("endTime") String endTime);
    void batchUpdatePayload(@Param("list") List<RiskIncidentOutGoing> list);
    int clearHistoryData(@Param("saveDays") Integer saveDays);
    List<Map<String, Object>> queryOutGoingList(@Param("params") Map<String, Object> params);
}
