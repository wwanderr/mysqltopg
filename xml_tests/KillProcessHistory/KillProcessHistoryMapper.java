package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.KillProcessHistory;
import com.dbapp.extension.xdr.linkageHandle.entity.KillProcessParam;
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
 * KillProcessHistory Mapper接口
 * 映射文件：KillProcessHistoryMapper.xml
 */
@Mapper
public interface KillProcessHistoryMapper extends BaseMapper<KillProcessHistory> {
    
    /**
     * 按策略ID统计启动次数
     * @param strategyIds 策略ID列表
     */
    List<BaseHistoryVO> countLaunchTimesByStrategyId(@Param("strategyIds") List<Long> strategyIds);
    
    /**
     * 批量插入进程终止历史
     * @param list 进程终止历史列表
     */
    void batchInsert(@Param("list") List<KillProcessHistory> list);

    /**
     * 分页查询进程终止历史
     * @param killProcessParam 查询参数
     * @param page 页码
     * @param size 每页大小
     * @return 总数和记录列表
     */
    default Pair<Long, List<KillProcessHistory>> selectPage(KillProcessParam killProcessParam, long page, long size) {
        LambdaQueryWrapper<KillProcessHistory> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(killProcessParam.getNodeIp())) {
            queryWrapper.like(KillProcessHistory::getNodeIp, killProcessParam.getNodeIp());
        }

        if (StringUtils.isNotBlank(killProcessParam.getDeviceIp())) {
            queryWrapper.like(KillProcessHistory::getDeviceIp, killProcessParam.getDeviceIp());
        }

        if (StringUtils.isNotBlank(killProcessParam.getStrategyName())) {
            queryWrapper.like(KillProcessHistory::getStrategyName, killProcessParam.getStrategyName());
        }

        if (StringUtils.isNotBlank(killProcessParam.getImage())) {
            queryWrapper.like(KillProcessHistory::getImage, killProcessParam.getImage());
        }

        if (ObjectUtils.isNotEmpty(killProcessParam.getProcessId())) {
            queryWrapper.like(KillProcessHistory::getProcessId, killProcessParam.getProcessId());
        }

        if (StringUtils.isNotBlank(killProcessParam.getAction())) {
            String[] actionSplit = killProcessParam.getAction().split(",");
            // PostgreSQL: action 字段为 enum(t_process_kill_history_action)，直接用 varchar 参数会报错
            // 使用 action::text 来进行 in 匹配
            StringBuilder applySql = new StringBuilder("action::text IN (");
            for (int i = 0; i < actionSplit.length; i++) {
                if (i > 0) {
                    applySql.append(",");
                }
                applySql.append("{").append(i).append("}");
            }
            applySql.append(")");
            queryWrapper.apply(applySql.toString(), (Object[]) actionSplit);
        }

        if (StringUtils.isNotBlank(killProcessParam.getSource())) {
            String[] sourceSplit = killProcessParam.getSource().split(",");
            List<String> collect = Arrays.stream(sourceSplit)
                    .map(Source::getNameByDesc)
                    .collect(Collectors.toList());
            queryWrapper.in(KillProcessHistory::getSource, collect);
        }

        if (StringUtils.isNotBlank(killProcessParam.getStartTime()) && StringUtils.isNotBlank(killProcessParam.getEndTime())) {
            // PostgreSQL: last_occur_time 为 timestamp，start/end 为字符串时需要显式转 timestamp
            queryWrapper.apply("last_occur_time BETWEEN {0}::timestamp AND {1}::timestamp",
                    killProcessParam.getStartTime(), killProcessParam.getEndTime());
        }

        queryWrapper.orderByDesc(KillProcessHistory::getId);
        Page<KillProcessHistory> processKillHistoryPage = (Page<KillProcessHistory>) this.selectPage(new Page<>(page, size), queryWrapper);
        return Pair.of(processKillHistoryPage.getTotal(), processKillHistoryPage.getRecords());
    }

    /**
     * 根据条件删除进程终止历史
     * @param killProcessParam 删除参数
     * @return 删除的记录数
     */
    default int delete(KillProcessParam killProcessParam) {
        LambdaQueryWrapper<KillProcessHistory> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(killProcessParam.getNodeIp())) {
            queryWrapper.like(KillProcessHistory::getNodeIp, killProcessParam.getNodeIp());
        }

        if (StringUtils.isNotBlank(killProcessParam.getDeviceIp())) {
            queryWrapper.like(KillProcessHistory::getDeviceIp, killProcessParam.getDeviceIp());
        }

        if (StringUtils.isNotBlank(killProcessParam.getStrategyName())) {
            queryWrapper.like(KillProcessHistory::getStrategyName, killProcessParam.getStrategyName());
        }

        if (StringUtils.isNotBlank(killProcessParam.getImage())) {
            queryWrapper.like(KillProcessHistory::getImage, killProcessParam.getImage());
        }

        if (ObjectUtils.isNotEmpty(killProcessParam.getProcessId())) {
            queryWrapper.like(KillProcessHistory::getProcessId, killProcessParam.getProcessId());
        }

        if (StringUtils.isNotBlank(killProcessParam.getAction())) {
            String[] actionSplit = killProcessParam.getAction().split(",");
            // PostgreSQL: action 字段为 enum(t_process_kill_history_action)，直接用 varchar 参数会报错
            // 使用 action::text 来进行 in 匹配
            StringBuilder applySql = new StringBuilder("action::text IN (");
            for (int i = 0; i < actionSplit.length; i++) {
                if (i > 0) {
                    applySql.append(",");
                }
                applySql.append("{").append(i).append("}");
            }
            applySql.append(")");
            queryWrapper.apply(applySql.toString(), (Object[]) actionSplit);
        }

        if (StringUtils.isNotBlank(killProcessParam.getSource())) {
            String[] sourceSplit = killProcessParam.getSource().split(",");
            List<String> collect = Arrays.stream(sourceSplit)
                    .map(Source::getNameByDesc)
                    .collect(Collectors.toList());
            queryWrapper.in(KillProcessHistory::getSource, collect);
        }

        if (ObjectUtils.isNotEmpty(killProcessParam.getId())) {
            queryWrapper.eq(KillProcessHistory::getId, killProcessParam.getId());
        }

        if (StringUtils.isNotBlank(killProcessParam.getIds())) {
            String[] idSplit = killProcessParam.getIds().split(",");
            List<Long> idList = Arrays.stream(idSplit)
                    .map(String::trim)
                    .map(Long::parseLong)
                    .collect(Collectors.toList());
            queryWrapper.in(KillProcessHistory::getId, idList);
        }

        return this.delete(queryWrapper);
    }
}
