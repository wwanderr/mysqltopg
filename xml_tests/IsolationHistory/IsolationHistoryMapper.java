package com.dbapp.extension.xdr.linkageHandle.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.IsolationHistory;
import com.dbapp.extension.xdr.linkageHandle.entity.IsolationParam;
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
 * IsolationHistory Mapper接口
 * 映射文件：IsolationHistoryMapper.xml
 */
@Mapper
public interface IsolationHistoryMapper extends BaseMapper<IsolationHistory> {
    
    /**
     * 按策略ID统计启动次数
     * @param strategyIds 策略ID列表
     */
    List<BaseHistoryVO> countLaunchTimesByStrategyId(@Param("strategyIds") List<Long> strategyIds);
    
    /**
     * 批量插入隔离历史
     * @param list 隔离历史列表
     */
    void batchInsert(@Param("list") List<IsolationHistory> list);

    /**
     * 分页查询隔离历史
     * @param isolationParam 查询参数
     * @param page 页码
     * @param size 每页大小
     * @return 总数和记录列表
     */
    default Pair<Long, List<IsolationHistory>> selectPage(IsolationParam isolationParam, long page, long size) {
        LambdaQueryWrapper<IsolationHistory> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(isolationParam.getNodeIp())) {
            queryWrapper.like(IsolationHistory::getNodeIp, isolationParam.getNodeIp());
        }

        if (StringUtils.isNotBlank(isolationParam.getDeviceIp())) {
            queryWrapper.like(IsolationHistory::getDeviceIp, isolationParam.getDeviceIp());
        }

        if (StringUtils.isNotBlank(isolationParam.getStrategyName())) {
            queryWrapper.like(IsolationHistory::getStrategyName, isolationParam.getStrategyName());
        }

        if (StringUtils.isNotBlank(isolationParam.getAction())) {
            String[] actionSplit = isolationParam.getAction().split(",");
            // PostgreSQL: action 字段为 enum(t_isolation_history_action)，直接用 varchar 参数会报错
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

        if (StringUtils.isNotBlank(isolationParam.getSource())) {
            String[] sourceSplit = isolationParam.getSource().split(",");
            List<String> collect = Arrays.stream(sourceSplit)
                    .map(Source::getNameByDesc)
                    .collect(Collectors.toList());
            queryWrapper.in(IsolationHistory::getSource, collect);
        }

        if (StringUtils.isNotBlank(isolationParam.getStartTime()) && StringUtils.isNotBlank(isolationParam.getEndTime())) {
            // PostgreSQL: last_occur_time 为 timestamp，start/end 为字符串时需要显式转 timestamp
            queryWrapper.apply("last_occur_time BETWEEN {0}::timestamp AND {1}::timestamp",
                    isolationParam.getStartTime(), isolationParam.getEndTime());
        }

        queryWrapper.orderByDesc(IsolationHistory::getId);
        Page<IsolationHistory> isolationHistoryPage = (Page<IsolationHistory>) this.selectPage(new Page<>(page, size), queryWrapper);
        return Pair.of(isolationHistoryPage.getTotal(), isolationHistoryPage.getRecords());
    }

    /**
     * 根据条件删除隔离历史
     * @param isolationParam 删除参数
     * @return 删除的记录数
     */
    default int delete(IsolationParam isolationParam) {
        LambdaQueryWrapper<IsolationHistory> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(isolationParam.getNodeIp())) {
            queryWrapper.like(IsolationHistory::getNodeIp, isolationParam.getNodeIp());
        }

        if (StringUtils.isNotBlank(isolationParam.getDeviceIp())) {
            queryWrapper.like(IsolationHistory::getDeviceIp, isolationParam.getDeviceIp());
        }

        if (StringUtils.isNotBlank(isolationParam.getStrategyName())) {
            queryWrapper.like(IsolationHistory::getStrategyName, isolationParam.getStrategyName());
        }

        if (StringUtils.isNotBlank(isolationParam.getAction())) {
            String[] actionSplit = isolationParam.getAction().split(",");
            // PostgreSQL: action 字段为 enum(t_isolation_history_action)，直接用 varchar 参数会报错
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

        if (StringUtils.isNotBlank(isolationParam.getSource())) {
            String[] sourceSplit = isolationParam.getSource().split(",");
            List<String> collect = Arrays.stream(sourceSplit)
                    .map(Source::getNameByDesc)
                    .collect(Collectors.toList());
            queryWrapper.in(IsolationHistory::getSource, collect);
        }

        if (ObjectUtils.isNotEmpty(isolationParam.getId())) {
            queryWrapper.eq(IsolationHistory::getId, isolationParam.getId());
        }

        if (StringUtils.isNotBlank(isolationParam.getIds())) {
            String[] idSplit = isolationParam.getIds().split(",");
            List<Long> idList = Arrays.stream(idSplit)
                    .map(String::trim)
                    .map(Long::parseLong)
                    .collect(Collectors.toList());
            queryWrapper.in(IsolationHistory::getId, idList);
        }

        if (StringUtils.isNotBlank(isolationParam.getStartTime()) && StringUtils.isNotBlank(isolationParam.getEndTime())) {
            // PostgreSQL: create_time 为 timestamp，start/end 为字符串时需要显式转 timestamp
            queryWrapper.apply("create_time BETWEEN {0}::timestamp AND {1}::timestamp",
                    isolationParam.getStartTime(), isolationParam.getEndTime());
        }

        return this.delete(queryWrapper);
    }
}
