package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.VirusKillHistory;
import com.dbapp.extension.xdr.linkageHandle.entity.VirusKillParam;
import com.dbapp.extension.xdr.utils.Source;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * VirusKillHistory Mapper
 *
 * 对应 XML: VirusKillHistoryMapper.xml
 * 根据反编译接口修复：2026-02-03
 */
@Mapper
public interface VirusKillHistoryMapper extends BaseMapper<VirusKillHistory> {

    void batchInsert(@Param("list") List<VirusKillHistory> var1);

    default Pair<Long, List<VirusKillHistory>> selectPage(VirusKillParam virusKillParam, long page, long size) {
        LambdaQueryWrapper<VirusKillHistory> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(virusKillParam.getNodeIp())) {
            queryWrapper.like(VirusKillHistory::getNodeIp, virusKillParam.getNodeIp());
        }

        if (StringUtils.isNotBlank(virusKillParam.getDeviceIp())) {
            queryWrapper.like(VirusKillHistory::getDeviceIp, virusKillParam.getDeviceIp());
        }

        if (StringUtils.isNotBlank(virusKillParam.getStrategyName())) {
            queryWrapper.like(VirusKillHistory::getStrategyName, virusKillParam.getStrategyName());
        }

        if (StringUtils.isNotBlank(virusKillParam.getHash())) {
            queryWrapper.like(VirusKillHistory::getHashes, virusKillParam.getHash());
        }

        if (StringUtils.isNotBlank(virusKillParam.getAction())) {
            String[] actionSplit = virusKillParam.getAction().split(",");
            // PostgreSQL: action 字段为 enum(t_virus_kill_history_action)，直接用 varchar 参数会报错
            // 使用 action::text 来进行 in 匹配
            StringBuilder applySql = new StringBuilder("action::text in (");
            for (int i = 0; i < actionSplit.length; i++) {
                if (i > 0) {
                    applySql.append(",");
                }
                applySql.append("{").append(i).append("}");
            }
            applySql.append(")");
            queryWrapper.apply(applySql.toString(), (Object[]) actionSplit);
        }

        if (StringUtils.isNotBlank(virusKillParam.getSource())) {
            String[] sourceSplit = virusKillParam.getSource().split(",");
            queryWrapper.in(VirusKillHistory::getSource, Arrays.asList(sourceSplit));
        }

        if (StringUtils.isNotBlank(virusKillParam.getStartTime()) && StringUtils.isNotBlank(virusKillParam.getEndTime())) {
            // PostgreSQL: last_occur_time 为 timestamp，start/end 为字符串时需要显式转 timestamp
            queryWrapper.apply("last_occur_time between {0}::timestamp and {1}::timestamp",
                    virusKillParam.getStartTime(), virusKillParam.getEndTime());
        }

        queryWrapper.orderByDesc(VirusKillHistory::getId);
        Page<VirusKillHistory> virusKillHistoryPage = (Page<VirusKillHistory>) this.selectPage(new Page<>(page, size), queryWrapper);
        return Pair.of(virusKillHistoryPage.getTotal(), virusKillHistoryPage.getRecords());
    }

    default int delete(VirusKillParam virusKillParam) {
        LambdaQueryWrapper<VirusKillHistory> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(virusKillParam.getNodeIp())) {
            queryWrapper.like(VirusKillHistory::getNodeIp, virusKillParam.getNodeIp());
        }

        if (StringUtils.isNotBlank(virusKillParam.getDeviceIp())) {
            queryWrapper.like(VirusKillHistory::getDeviceIp, virusKillParam.getDeviceIp());
        }

        if (StringUtils.isNotBlank(virusKillParam.getStrategyName())) {
            queryWrapper.like(VirusKillHistory::getStrategyName, virusKillParam.getStrategyName());
        }

        if (StringUtils.isNotBlank(virusKillParam.getHash())) {
            queryWrapper.like(VirusKillHistory::getHashes, virusKillParam.getHash());
        }

        if (StringUtils.isNotBlank(virusKillParam.getAction())) {
            String[] actionSplit = virusKillParam.getAction().split(",");
            // PostgreSQL: action 字段为 enum(t_virus_kill_history_action)，直接用 varchar 参数会报错
            StringBuilder applySql = new StringBuilder("action::text in (");
            for (int i = 0; i < actionSplit.length; i++) {
                if (i > 0) {
                    applySql.append(",");
                }
                applySql.append("{").append(i).append("}");
            }
            applySql.append(")");
            queryWrapper.apply(applySql.toString(), (Object[]) actionSplit);
        }

        if (StringUtils.isNotBlank(virusKillParam.getSource())) {
            String[] sourceSplit = virusKillParam.getSource().split(",");
            List<String> collect = Arrays.stream(sourceSplit).map(Source::getNameByDesc).collect(Collectors.toList());
            queryWrapper.in(VirusKillHistory::getSource, collect);
        }

        if (ObjectUtils.isNotEmpty(virusKillParam.getId())) {
            queryWrapper.eq(VirusKillHistory::getId, virusKillParam.getId());
        }

        if (StringUtils.isNotBlank(virusKillParam.getIds())) {
            String[] idSplit = virusKillParam.getIds().split(",");
            queryWrapper.in(VirusKillHistory::getId, Arrays.asList(idSplit));
        }

        return this.delete(queryWrapper);
    }

    List<BaseHistoryVO> countLaunchTimesByStrategyId(@Param("strategyIds") List<Long> var1);
}
