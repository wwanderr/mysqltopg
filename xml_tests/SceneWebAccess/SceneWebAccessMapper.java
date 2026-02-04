package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.SceneWebAccess;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * SceneWebAccess Mapper接口
 * 提供场景Web访问临时数据的查询、统计和删除功能
 */
@Mapper
public interface SceneWebAccessMapper extends BaseMapper<SceneWebAccess> {
    
    /**
     * 查询正常URL数量
     * 统计在指定时间范围内，事件数量超过阈值的URL数量
     * 
     * @param normalUrlCountLimit 正常URL的事件数量阈值
     * @param beforeDateTime 开始时间
     * @param endDateTime 结束时间
     * @param destHostName 目标主机名
     * @return 正常URL数量
     */
    @Select({
        "SELECT COALESCE(SUM(t.count), 0) FROM ",
        "(SELECT request_url, ",
        "CASE WHEN SUM(event_count) > #{normalUrlCountLimit} THEN 1 ELSE 0 END AS count ",
        "FROM t_scene_web_access_temp ",
        "WHERE create_time BETWEEN CAST(#{beforeDateTime} AS TIMESTAMP) AND CAST(#{endDateTime} AS TIMESTAMP) ",
        "AND dest_host_name = #{destHostName} ",
        "GROUP BY request_url) AS t"
    })
    long selectNormalUrlCount(
        @Param("normalUrlCountLimit") Integer normalUrlCountLimit,
        @Param("beforeDateTime") String beforeDateTime,
        @Param("endDateTime") String endDateTime,
        @Param("destHostName") String destHostName
    );

    /**
     * 查询总URL数量
     * 统计在指定时间范围内，不同request_url的总数
     * 
     * @param beforeDateTime 开始时间
     * @param endDateTime 结束时间
     * @param destHostName 目标主机名
     * @return 总URL数量
     */
    @Select({
        "SELECT COUNT(request_url) FROM ",
        "(SELECT request_url FROM t_scene_web_access_temp ",
        "WHERE create_time BETWEEN CAST(#{beforeDateTime} AS TIMESTAMP) AND CAST(#{endDateTime} AS TIMESTAMP) ",
        "AND dest_host_name = #{destHostName} ",
        "GROUP BY request_url) AS t"
    })
    long selectTotalUrlCount(
        @Param("beforeDateTime") String beforeDateTime,
        @Param("endDateTime") String endDateTime,
        @Param("destHostName") String destHostName
    );

    /**
     * 查询异常URL列表
     * 查询在指定时间范围内，事件数量低于阈值的URL列表
     * 
     * @param abnormalUrlCountLimit 异常URL的事件数量阈值
     * @param beforeDateTime 开始时间
     * @param endDateTime 结束时间
     * @param destHostName 目标主机名
     * @return 异常URL列表
     */
    @Select({
        "SELECT request_url FROM t_scene_web_access_temp ",
        "WHERE create_time BETWEEN CAST(#{beforeDateTime} AS TIMESTAMP) AND CAST(#{endDateTime} AS TIMESTAMP) ",
        "AND dest_host_name = #{destHostName} ",
        "GROUP BY request_url ",
        "HAVING SUM(event_count) < #{abnormalUrlCountLimit}"
    })
    List<String> selectAbnormalUrlList(
        @Param("abnormalUrlCountLimit") Integer abnormalUrlCountLimit,
        @Param("beforeDateTime") String beforeDateTime,
        @Param("endDateTime") String endDateTime,
        @Param("destHostName") String destHostName
    );

    /**
     * 根据创建时间删除数据
     * 
     * @param beforeDateTime 开始时间
     * @param endDateTime 结束时间
     */
    @Delete({
        "DELETE FROM t_scene_web_access_temp ",
        "WHERE create_time BETWEEN CAST(#{beforeDateTime} AS TIMESTAMP) AND CAST(#{endDateTime} AS TIMESTAMP)"
    })
    void deleteByCreateTime(
        @Param("beforeDateTime") String beforeDateTime,
        @Param("endDateTime") String endDateTime
    );

    /**
     * 按目标主机名分组统计
     * 统计在指定时间范围内，每个目标主机名的访问次数
     * 
     * @param beforeDateTime 开始时间
     * @param endDateTime 结束时间
     * @return 包含destHostName和accessCount的Map列表
     */
    @Select({
        "SELECT dest_host_name AS destHostName, SUM(event_count) AS accessCount ",
        "FROM t_scene_web_access_temp ",
        "WHERE create_time BETWEEN CAST(#{beforeDateTime} AS TIMESTAMP) AND CAST(#{endDateTime} AS TIMESTAMP) ",
        "GROUP BY dest_host_name"
    })
    List<Map<String, Object>> groupByDestHostName(
        @Param("beforeDateTime") String beforeDateTime,
        @Param("endDateTime") String endDateTime
    );
}
