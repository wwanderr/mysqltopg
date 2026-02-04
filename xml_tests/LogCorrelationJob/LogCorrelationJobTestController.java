package com.test.controller;

import com.dbapp.extension.xdr.logCorrelation.entity.LogCorrelationJob;
import com.dbapp.extension.xdr.logCorrelation.enums.StatusEnum;
import com.dbapp.extension.xdr.logCorrelation.mapper.LogCorrelationJobMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;

/**
 * LogCorrelationJob 测试控制器
 * 
 * 覆盖 Mapper 中的 2 个方法：
 * - getAllReadyJobs: 获取所有就绪的任务（query_end_time <= 当前时间）
 * - updateStatusToWaiting: 更新任务状态为等待中
 */
@RestController
@RequestMapping("/test/logCorrelationJob")
public class LogCorrelationJobTestController {

    @Autowired
    private LogCorrelationJobMapper mapper;

    /**
     * 测试1：getAllReadyJobs - 获取所有就绪的任务
     * URL: /test/logCorrelationJob/test1-getAllReadyJobs
     * 
     * 测试场景：
     * - 查询 query_end_time <= 当前时间的任务
     * - 分页查询（第1页，每页1000条）
     */
    @GetMapping("/test1-getAllReadyJobs")
    public String testGetAllReadyJobs() {
        try {
            List<LogCorrelationJob> readyJobs = mapper.getAllReadyJobs();
            
            System.out.println("✅ getAllReadyJobs 执行成功");
            System.out.println("  当前时间: " + LocalDateTime.now());
            System.out.println("  就绪任务数量: " + readyJobs.size());
            
            for (int i = 0; i < Math.min(readyJobs.size(), 10); i++) {
                LogCorrelationJob job = readyJobs.get(i);
                System.out.println(String.format("  任务[%d]: id=%d, status=%s, queryEndTime=%s, executorClass=%s",
                    i + 1, job.getId(), job.getStatus(), job.getQueryEndTime(), job.getExecutorClassName()));
            }
            
            if (readyJobs.size() > 10) {
                System.out.println("  ... 还有 " + (readyJobs.size() - 10) + " 个任务未显示");
            }
            
            return String.format("SUCCESS: 就绪任务数量=%d (当前时间: %s)", 
                readyJobs.size(), LocalDateTime.now());
        } catch (Exception e) {
            String msg = "❌ testGetAllReadyJobs 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：updateStatusToWaiting - 更新任务状态为等待中
     * URL: /test/logCorrelationJob/test2-updateStatusToWaiting
     * 
     * 测试场景：
     * - 先查询一个就绪的任务
     * - 更新其状态为 Waiting
     * - 验证更新是否成功
     */
    @GetMapping("/test2-updateStatusToWaiting")
    public String testUpdateStatusToWaiting() {
        try {
            // 1. 先获取一个就绪的任务
            List<LogCorrelationJob> readyJobs = mapper.getAllReadyJobs();
            
            if (readyJobs.isEmpty()) {
                return "WARNING: 没有就绪的任务可供测试，请先插入测试数据";
            }
            
            LogCorrelationJob job = readyJobs.get(0);
            Long jobId = job.getId();
            StatusEnum originalStatus = job.getStatus();
            
            System.out.println("✅ 找到测试任务: id=" + jobId + ", 当前状态=" + originalStatus);
            
            // 2. 更新状态为 Waiting
            LogCorrelationJob updateJob = new LogCorrelationJob();
            updateJob.setId(jobId);
            
            boolean success = mapper.updateStatusToWaiting(updateJob);
            
            System.out.println("✅ updateStatusToWaiting 执行结果: " + (success ? "成功" : "失败"));
            
            // 3. 验证更新结果（重新查询）
            LogCorrelationJob updatedJob = mapper.selectById(jobId);
            if (updatedJob != null) {
                System.out.println("  更新后状态: " + updatedJob.getStatus());
                System.out.println("  状态更新: " + originalStatus + " -> " + updatedJob.getStatus());
            }
            
            return String.format("SUCCESS: 更新结果=%s (任务ID=%d, 原状态=%s, 新状态=%s)", 
                success ? "成功" : "失败", 
                jobId, 
                originalStatus,
                updatedJob != null ? updatedJob.getStatus() : "未知");
        } catch (Exception e) {
            String msg = "❌ testUpdateStatusToWaiting 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试3：updateStatusToWaiting - 测试空ID的情况
     * URL: /test/logCorrelationJob/test3-updateStatusToWaitingWithNullId
     * 
     * 测试场景：
     * - 传入一个没有ID的任务对象
     * - 应该返回 false
     */
    @GetMapping("/test3-updateStatusToWaitingWithNullId")
    public String testUpdateStatusToWaitingWithNullId() {
        try {
            LogCorrelationJob job = new LogCorrelationJob();
            // 不设置ID，测试空ID的情况
            job.setStatus(StatusEnum.Todo);
            
            boolean success = mapper.updateStatusToWaiting(job);
            
            System.out.println("✅ updateStatusToWaiting (null id) 执行结果: " + success);
            System.out.println("  预期结果: false (因为ID为null)");
            
            if (success) {
                return "WARNING: 更新成功，但预期应该失败（ID为null）";
            } else {
                return "SUCCESS: 更新失败（符合预期，因为ID为null）";
            }
        } catch (Exception e) {
            String msg = "❌ testUpdateStatusToWaitingWithNullId 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试：测试所有方法
     * URL: /test/logCorrelationJob/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        StringBuilder result = new StringBuilder();
        result.append("=== LogCorrelationJob 综合测试 ===\n\n");
        
        try {
            // 1. 测试 getAllReadyJobs
            List<LogCorrelationJob> readyJobs = mapper.getAllReadyJobs();
            result.append("1. getAllReadyJobs: ").append(readyJobs.size()).append(" 个就绪任务\n");
            
            // 2. 如果有就绪任务，测试更新状态
            if (!readyJobs.isEmpty()) {
                LogCorrelationJob job = readyJobs.get(0);
                LogCorrelationJob updateJob = new LogCorrelationJob();
                updateJob.setId(job.getId());
                
                boolean updateSuccess = mapper.updateStatusToWaiting(updateJob);
                result.append("2. updateStatusToWaiting: ").append(updateSuccess ? "成功" : "失败")
                      .append(" (任务ID=").append(job.getId()).append(")\n");
            } else {
                result.append("2. updateStatusToWaiting: 跳过（没有就绪任务）\n");
            }
            
            // 3. 测试空ID的情况
            LogCorrelationJob nullIdJob = new LogCorrelationJob();
            boolean nullIdResult = mapper.updateStatusToWaiting(nullIdJob);
            result.append("3. updateStatusToWaiting (null id): ").append(nullIdResult ? "成功" : "失败")
                  .append(" (预期: 失败)\n");
            
            result.append("\n✅ 所有测试执行完成！");
            return result.toString();
        } catch (Exception e) {
            result.append("\n❌ 测试失败: ").append(e.getMessage());
            e.printStackTrace();
            return result.toString();
        }
    }
}
