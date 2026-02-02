package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentOutGoing;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.joda.time.DateTime;
import java.util.List;
import java.util.Map;

@Mapper
public interface RiskIncidentOutGoingMapper extends BaseMapper<RiskIncidentOutGoing> {
    // 方法1: mappingFromClueSecurityEvent - 参数：eventIds (List<Long>)
    List<RiskIncidentOutGoing> mappingFromClueSecurityEvent(@Param("eventIds") List<Long> var1);

    // 方法2: backUpLastTermData - 参数：currentDate (String), timestamp (DateTime)
    void backUpLastTermData(
        @Param("currentDate") String var1,
        @Param("timestamp") DateTime var2
    );

    // 方法3: batchInsertOrUpdateIncident - 参数：riskIncidentList
    void batchInsertOrUpdateIncident(@Param("riskIncidentList") List<RiskIncidentOutGoing> var1);

    // 方法4: deleteOldIncident - 参数：currentDate (String), ids (List<Long>)
    void deleteOldIncident(
        @Param("currentDate") String var1,
        @Param("ids") List<Long> var2
    );

    // 方法5: queryListByTime - 4个参数（增加了offset和size）
    List<RiskIncidentOutGoing> queryListByTime(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("offset") long var3,
        @Param("size") long var5
    );

    // 方法6: batchUpdatePayload - 参数：List（无@Param注解）
    void batchUpdatePayload(List<RiskIncidentOutGoing> var1);

    // 方法7: clearHistoryData - 参数：timestamp (DateTime)
    void clearHistoryData(@Param("timestamp") DateTime var1);

    // 方法8: queryOutGoingList - 5个参数
    List<Map<String, Object>> queryOutGoingList(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("lastTermTime") String var3,
        @Param("offset") long var4,
        @Param("size") long var6
    );

    // 方法9: selectOldIncidentByCodes - 参数：currentDate, excludeUniqCodes
    List<Long> selectOldIncidentByCodes(
        @Param("currentDate") String var1,
        @Param("excludeUniqCodes") List<String> var2
    );

    // 方法10: updateKillChain - 参数：beforeTime (String)
    void updateKillChain(@Param("beforeTime") String var1);

    // 方法11: groupByFocusIp - 4个参数
    List<Map<String, Object>> groupByFocusIp(
        @Param("focusIps") List<String> var1,
        @Param("startTime") String var2,
        @Param("endTime") String var3,
        @Param("top") Integer var4
    );

    // 方法12: groupNameByFocusIp - 3个参数
    List<Map<String, Object>> groupNameByFocusIp(
        @Param("focusIps") List<String> var1,
        @Param("startTime") String var2,
        @Param("endTime") String var3
    );

    // 方法13: selectOldHistoryIds - 3个参数（beforeTime, lastId, size）
    List<Long> selectOldHistoryIds(
        @Param("beforeTime") String var1,
        @Param("lastId") long var2,
        @Param("size") long var4
    );

    // 方法14: deleteHistoryByIds - 参数：ids (List<Long>)
    void deleteHistoryByIds(@Param("ids") List<Long> var1);
}
