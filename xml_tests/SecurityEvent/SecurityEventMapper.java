package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.SecurityEvent;
import com.dbapp.extension.xdr.threatMonitor.entity.ThreadEvent;
import com.dbapp.extension.xdr.logCorrelation.entity.AlarmInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@Mapper
public interface SecurityEventMapper extends BaseMapper<SecurityEvent> {

    List<Map<String, String>> selectBaseInfoById(@Param("ids") Integer[] ids);

    Map<String, Object> selectNewEventAndTempById(Integer id);

    Map<String, Object> selectEventAndTempById(@Param("ids") Integer[] ids);

    Map<String, Object> selectLogFieldsByIds(@Param("ids") Integer[] ids);

    Map<String, Object> selectEventAndTempByIds(@Param("ids") List<Integer> ids);

    List<String> queryEventById(List<String> ids);

    List<Map<String, Object>> queryTrend(@Param("startTime") String startTime,
                                         @Param("endTime") String endTime);

    List<Map<String, Object>> selectAllByIdList(@Param("evenIdList") List<String> evenIdList);

    List<Map<String, Object>> getIncidentsTypePercent(@Param("startTime") String startTime,
                                                      @Param("endTime") String endTime,
                                                      @Param("eventName") String eventName,
                                                      @Param("focusIp") String focusIp,
                                                      @Param("subCategory") List<String> subCategory,
                                                      @Param("alarmStatus") List<String> alarmStatus,
                                                      @Param("alarmResult") List<String> alarmResult,
                                                      @Param("threatSeverity") List<String> threatSeverity,
                                                      @Param("tagSearch") List<String> tagSearch,
                                                      @Param("killChain") List<String> killChain,
                                                      @Param("flag") int flag,
                                                      @Param("scenarioType") String scenarioType);

    List<Map<String, Object>> getSecurityEventList(@Param("startTime") String startTime,
                                                   @Param("endTime") String endTime,
                                                   @Param("eventName") String eventName,
                                                   @Param("focusIp") String focusIp,
                                                   @Param("subCategory") List<String> subCategory,
                                                   @Param("alarmStatus") List<String> alarmStatus,
                                                   @Param("alarmResult") List<String> alarmResult,
                                                   @Param("threatSeverity") List<String> threatSeverity,
                                                   @Param("tagSearch") List<String> tagSearch,
                                                   @Param("orderByStr") String orderByStr,
                                                   @Param("killChain") List<String> killChain,
                                                   @Param("offset") Long offset,
                                                   @Param("size") Long size,
                                                   @Param("isScenario") Boolean isScenario);

    List<String> getKillChain(@Param("startTime") String startTime,
                              @Param("endTime") String endTime,
                              @Param("eventName") String eventName,
                              @Param("focusIp") String focusIp,
                              @Param("subCategory") List<String> subCategory,
                              @Param("alarmStatus") List<String> alarmStatus,
                              @Param("alarmResult") List<String> alarmResult,
                              @Param("threatSeverity") List<String> threatSeverity,
                              @Param("tagSearch") List<String> tagSearch,
                              @Param("killChainList") List<String> killChainList,
                              @Param("scenarioType") String scenarioType);

    List<Map<String, Object>> getSecurityEventListByFieldMapping(@Param("startTime") String startTime,
                                                                 @Param("endTime") String endTime,
                                                                 @Param("eventName") String eventName,
                                                                 @Param("focusIp") String focusIp,
                                                                 @Param("subCategory") List<String> subCategory,
                                                                 @Param("alarmStatus") List<String> alarmStatus,
                                                                 @Param("alarmResult") List<String> alarmResult,
                                                                 @Param("threatSeverity") List<String> threatSeverity,
                                                                 @Param("tagSearch") List<String> tagSearch,
                                                                 @Param("orderByStr") String orderByStr,
                                                                 @Param("killChain") List<String> killChain,
                                                                 @Param("offset") Long offset,
                                                                 @Param("size") Long size);

    Long getTotal(@Param("startTime") String startTime,
                  @Param("endTime") String endTime,
                  @Param("eventName") String eventName,
                  @Param("focusIp") String focusIp,
                  @Param("subCategory") List<String> subCategory,
                  @Param("alarmStatus") List<String> alarmStatus,
                  @Param("alarmResult") List<String> alarmResult,
                  @Param("threatSeverity") List<String> threatSeverity,
                  @Param("tagSearch") List<String> tagSearch,
                  @Param("killChain") List<String> killChain,
                  @Param("isScenario") Boolean isScenario);

    List<Map<String, Object>> queryOverview(@Param("startTime") String startTime,
                                            @Param("endTime") String endTime,
                                            @Param("keyword") String keyword);

    List<Map> queryEventCount(@Param("startTime") String startTime,
                              @Param("endTime") String endTime,
                              @Param("eventName") String eventName,
                              @Param("focusIp") String focusIp,
                              @Param("subCategory") List<String> subCategory,
                              @Param("alarmStatus") List<String> alarmStatus,
                              @Param("alarmResult") List<String> alarmResult,
                              @Param("threatSeverity") List<String> threatSeverity,
                              @Param("tagSearch") List<String> tagSearch,
                              @Param("killChain") List<String> killChain,
                              @Param("scenarioType") String scenarioType);

    int insertOrUpdate(SecurityEvent securityEvent);

    void batchInsert(@Param("eventList") List<SecurityEvent> eventList);

    void updateStatus(SecurityEvent securityEvent);

    SecurityEvent queryByEventCode(String eventCode);

    void updateAlarmResultById(@Param("eventId") Integer eventId,
                               @Param("alarmResults") String alarmResults);

    List<ThreadEvent> getExistThreadEvents(@Param("timePart") String timePart);

    long insertBatchThreadEvents(@Param("events") Collection<ThreadEvent> events);

    long insertBatchSecurityAlarm(@Param("alarms") Collection<AlarmInfo> alarms);

    List<AlarmInfo> queryThreadAlarm(@Param("attacker") String attacker,
                                     @Param("victim") String victim,
                                     @Param("subCategory") String subCategory,
                                     @Param("timePart") String timePart,
                                     @Param("offset") long offset);

    LocalDateTime getMinTime(@Param("timePart") String timePart);

    LocalDateTime getOneHourTime();

    long deleteOneHourLeft(@Param("time") LocalDateTime time);

    long updateThreadLowPriority(@Param("timePart") String timePart,
                                 @Param("focus") String focus,
                                 @Param("focusIp") String focusIp,
                                 @Param("priority") Integer priority);

    long deleteLowPriority(@Param("timePart") String timePart,
                           @Param("focus") String focus,
                           @Param("focusIp") String focusIp,
                           @Param("priority") Integer priority);

    List<Map<String, Object>> getSecurityEventOutGoingTemplate(@Param("startTime") String startTime,
                                                               @Param("endTime") String endTime,
                                                               @Param("offset") long offset,
                                                               @Param("size") long size);

    void deleteTimingTask(@Param("timePart") String timePart,
                          @Param("focus") String focus,
                          @Param("focusIp") String focusIp,
                          @Param("priority") Integer priority);
}

