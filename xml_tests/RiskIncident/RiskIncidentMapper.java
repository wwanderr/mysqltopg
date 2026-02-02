package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncident;
import com.dbapp.extension.xdr.entity.CommonFilter;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.joda.time.DateTime;
import java.util.List;
import java.util.Map;

@Mapper
public interface RiskIncidentMapper {
    // 方法1: aggClueSecurityEventByName - 6个参数（按反编译顺序）
    List<RiskIncident> aggClueSecurityEventByName(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("topEventType") String var3,
        @Param("threatSeverity") List<String> var4,
        @Param("alarmResults") List<String> var5,
        @Param("excludeEventIds") List<Long> var6
    );

    // 方法2: mappingNormalSecurityEvent - 6个参数（按反编译顺序）
    List<RiskIncident> mappingNormalSecurityEvent(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("topEventType") String var3,
        @Param("threatSeverity") List<String> var4,
        @Param("alarmResults") List<String> var5,
        @Param("excludeEventIds") List<Long> var6
    );

    // 方法3: backUpLastTermData - 注意：var2是DateTime类型
    void backUpLastTermData(
        @Param("currentDate") String var1,
        @Param("timestamp") DateTime var2
    );

    // 方法4: batchInsertOrUpdateIncident
    void batchInsertOrUpdateIncident(@Param("riskIncidentList") List<RiskIncident> var1);

    // 方法5: selectOldIncidentByCodes
    List<Long> selectOldIncidentByCodes(
        @Param("currentDate") String var1,
        @Param("excludeEventCodes") List<String> var2
    );

    // 方法6: deleteOldIncident - 返回void
    void deleteOldIncident(
        @Param("currentDate") String var1,
        @Param("excludeEventCodes") List<String> var2
    );

    // 方法7: deleteOldIncidentAnalysis - 返回void
    void deleteOldIncidentAnalysis(
        @Param("currentDate") String var1,
        @Param("excludeEventCodes") List<String> var2
    );

    // 方法8: getRiskList - 16个参数（按反编译顺序，包含tagSearch和killChain）
    List<Map<String, Object>> getRiskList(
        @Param("orderByStr") String var1,
        @Param("name") String var2,
        @Param("endTime") String var3,
        @Param("subCategory") List<String> var4,
        @Param("alarmStatus") List<String> var5,
        @Param("alarmResult") List<String> var6,
        @Param("judgeResults") List<String> var7,
        @Param("threatSeverity") List<String> var8,
        @Param("focusObject") String var9,
        @Param("focusIp") String var10,
        @Param("startTime") String var11,
        @Param("isScenario") Integer var12,
        @Param("size") Long var13,
        @Param("offSet") Long var14,
        @Param("tagSearch") List<String> var15,
        @Param("killChain") List<String> var16
    );

    // 方法9: getCountByStatus - 返回List<Map>（不是List<Map<String, Object>>）
    List<Map> getCountByStatus(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("eventName") String var3,
        @Param("focusIp") String var4,
        @Param("focusObject") String var5,
        @Param("secondEventTypeChinese") List<String> var6,
        @Param("alarmStatus") List<String> var7,
        @Param("alarmResult") List<String> var8,
        @Param("judgeResults") List<String> var9,
        @Param("threatSeverity") List<String> var10,
        @Param("isScenario") Integer var11
    );

    // 方法10: getByEventCode - 返回单个Map，不是List
    Map<String, Object> getByEventCode(@Param("eventCode") String var1);

    // 方法11: selectEventAndTempById - 参数是Integer[]数组
    Map<String, Object> selectEventAndTempById(@Param("ids") Integer[] var1);

    // 方法12: selectAllByIdList - 参数是List<String>，不是List<Integer>
    List<Map<String, Object>> selectAllByIdList(@Param("evenIdList") List<String> var1);

    // 方法13: queryEventCount - 返回List<Map>
    List<Map> queryEventCount(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("eventName") String var3,
        @Param("focusIp") String var4,
        @Param("focusObject") String var5,
        @Param("secondEventTypeChinese") List<String> var6,
        @Param("alarmStatus") List<String> var7,
        @Param("alarmResult") List<String> var8,
        @Param("judgeResults") List<String> var9,
        @Param("threatSeverity") List<String> var10,
        @Param("isScenario") Integer var11
    );

    // 方法14: queryIncidentsCount
    List<CommonFilter> queryIncidentsCount(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("eventName") String var3,
        @Param("focusIp") String var4,
        @Param("focusObject") String var5,
        @Param("secondEventTypeChinese") List<String> var6,
        @Param("alarmStatus") List<String> var7,
        @Param("alarmResult") List<String> var8,
        @Param("judgeResults") List<String> var9,
        @Param("threatSeverity") List<String> var10,
        @Param("isScenario") Integer var11
    );

    // 方法15: queryKillChains
    List<String> queryKillChains(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("eventName") String var3,
        @Param("focusIp") String var4,
        @Param("focusObject") String var5,
        @Param("secondEventTypeChinese") List<String> var6,
        @Param("alarmStatus") List<String> var7,
        @Param("alarmResult") List<String> var8,
        @Param("judgeResults") List<String> var9,
        @Param("threatSeverity") List<String> var10,
        @Param("isScenario") Integer var11
    );

    // 方法16: getEventIdsById - 参数是int基本类型
    String getEventIdsById(@Param("id") int var1);

    // 方法17: getFilterContent - 参数是Integer[]数组
    String getFilterContent(@Param("id") Integer[] var1);

    // 方法18: getRiskListByIds
    List<RiskIncident> getRiskListByIds(@Param("ids") List<Long> var1);

    // 方法19: FocusIpMessage - size和offSet是long基本类型
    List<Map<String, Object>> FocusIpMessage(
        @Param("id") Integer var1,
        @Param("ip") String var2,
        @Param("size") long var3,
        @Param("offSet") long var5
    );

    // 方法20: getFocusObject
    String getFocusObject(@Param("id") Integer var1);

    // 方法21: getCount - 12个参数（包含tagSearch和killChain）
    Long getCount(
        @Param("name") String var1,
        @Param("endTime") String var2,
        @Param("subCategory") List<String> var3,
        @Param("alarmStatus") List<String> var4,
        @Param("alarmResult") List<String> var5,
        @Param("judgeResults") List<String> var6,
        @Param("threatSeverity") List<String> var7,
        @Param("focusObject") String var8,
        @Param("focusIp") String var9,
        @Param("startTime") String var10,
        @Param("tagSearch") List<String> var11,
        @Param("killChain") List<String> var12
    );

    // 方法22: queryFocusIps - 6个参数（包含startTime和endTime）
    List<Map<String, String>> queryFocusIps(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("eventCode") String var3,
        @Param("ip") String var4,
        @Param("offset") long var5,
        @Param("size") long var7
    );

    // 方法23: queryFocusIpCount - 4个参数（包含startTime和endTime）
    Long queryFocusIpCount(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("eventCode") String var3,
        @Param("ip") String var4
    );

    // 方法24: getSecurityEventIdsByCondition - 7个参数
    List<String> getSecurityEventIdsByCondition(
        @Param("startTime") String var1,
        @Param("endTime") String var2,
        @Param("topEventType") String var3,
        @Param("threatSeverity") List<String> var4,
        @Param("alarmResults") List<String> var5,
        @Param("excludeEventIds") List<Long> var6,
        @Param("eventName") String var7
    );

    // 方法25: countByDate - 返回Integer
    Integer countByDate(@Param("date") String var1);

    // 方法26: selectIncidentForCheckScenario - 无参数
    List<RiskIncident> selectIncidentForCheckScenario();

    // 方法27: updateStatus - 参数是RiskIncident对象！
    void updateStatus(RiskIncident var1);

    // 方法28: isHandled - 返回int基本类型
    int isHandled(@Param("eventCodes") List<String> var1);

    // 方法29: updateJudgeResults - 参数是Long和Integer
    void updateJudgeResults(
        @Param("id") Long var1,
        @Param("judgeResult") Integer var2
    );

    // 方法30: updateJudgeStatus - 参数是Long和String
    void updateJudgeStatus(
        @Param("id") Long var1,
        @Param("judgeStatus") String var2
    );
}
