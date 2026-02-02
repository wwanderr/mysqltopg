package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.RiskIncidentHistory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface RiskIncidentHistoryMapper extends BaseMapper<RiskIncidentHistory> {
    List<Map<String, Object>> getRiskHistoryList(
            @Param("orderByStr") String orderByStr,
            @Param("name") String name,
            @Param("threatSeverity") List<String> threatSeverity,
            @Param("endTime") String endTime,
            @Param("subCategory") List<String> subCategory,
            @Param("focusObject") String focusObject,
            @Param("focusIp") String focusIp,
            @Param("alarmResult") List<String> alarmResult,
            @Param("startTime") String startTime,
            @Param("size") Long size,
            @Param("offSet") Long offSet);

    List<Map> queryEventCount(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime,
            @Param("eventName") String eventName,
            @Param("focusIp") String focusIp,
            @Param("focusObject") String focusObject,
            @Param("subCategory") List<String> subCategory,
            @Param("alarmResult") List<String> alarmResult,
            @Param("threatSeverity") List<String> threatSeverity);

    List<Map<String, Object>> FocusIpMessage(
            @Param("id") Integer id,
            @Param("ip") String ip,
            @Param("size") long size,
            @Param("offSet") long offSet);

    String getFocusObject(@Param("id") Integer id);

    List<Map<String, Object>> selectAllByIdList(@Param("evenIdList") List<String> evenIdList);

    Long getFocusIpCount(
            @Param("id") Integer id,
            @Param("ip") String ip);

    Long getCount(
            @Param("name") String name,
            @Param("endTime") String endTime,
            @Param("subCategory") List<String> subCategory,
            @Param("alarmResult") List<String> alarmResult,
            @Param("threatSeverity") List<String> threatSeverity,
            @Param("focusObject") String focusObject,
            @Param("focusIp") String focusIp,
            @Param("startTime") String startTime);

    List<Map<String, String>> queryFocusIps(
            @Param("timePart") String timePart,
            @Param("eventCode") String eventCode,
            @Param("ip") String ip,
            @Param("offset") long offset,
            @Param("size") long size);

    Long queryFocusIpCount(
            @Param("timePart") String timePart,
            @Param("eventCode") String eventCode,
            @Param("ip") String ip);

    Integer countByDate(
            @Param("currentDate") String currentDate,
            @Param("yesterdayDate") String yesterdayDate);
}
