package com.dbapp.extension.xdr.logCorrelation.mapper;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dbapp.extension.xdr.logCorrelation.entity.LogCorrelationJob;
import com.dbapp.extension.xdr.logCorrelation.enums.StatusEnum;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDateTime;
import java.util.List;

/**
 * LogCorrelationJob Mapper接口
 * 提供日志关联任务的查询和更新功能
 */
@Mapper
public interface LogCorrelationJobMapper extends BaseMapper<LogCorrelationJob> {
    
    /**
     * 获取所有就绪的任务
     * 查询 query_end_time <= 当前时间的任务，分页查询（第1页，每页1000条）
     * 
     * @return 就绪的任务列表
     */
    default List<LogCorrelationJob> getAllReadyJobs() {
        IPage<LogCorrelationJob> page = this.selectPage(
            new Page<>(1L, 1000L),
            Wrappers.lambdaQuery()
                .le(LogCorrelationJob::getQueryEndTime, LocalDateTime.now())
        );
        return page.getRecords();
    }

    /**
     * 更新任务状态为等待中
     * 
     * @param logCorrelationJob 任务对象（必须包含id）
     * @return 是否更新成功
     */
    default boolean updateStatusToWaiting(LogCorrelationJob logCorrelationJob) {
        if (logCorrelationJob.getId() == null) {
            return false;
        } else {
            LambdaUpdateWrapper<LogCorrelationJob> updateWrapper = Wrappers.lambdaUpdate()
                .eq(LogCorrelationJob::getId, logCorrelationJob.getId())
                .set(LogCorrelationJob::getStatus, StatusEnum.Waiting);
            int affectRows = this.update(null, updateWrapper);
            return affectRows > 0;
        }
    }
}
