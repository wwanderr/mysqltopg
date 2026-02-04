-- 测试数据：LogCorrelationJob（日志关联任务）
-- 表名：t_log_correlation_job
-- 
-- 测试场景说明：
-- 1. 就绪任务：query_end_time <= 当前时间的任务（用于测试 getAllReadyJobs）
-- 2. 未就绪任务：query_end_time > 当前时间的任务（不应被查询到）
-- 3. 不同状态：Todo 和 Waiting 状态的任务
-- 4. 状态更新：用于测试 updateStatusToWaiting

-- 清理测试数据
DELETE FROM "t_log_correlation_job" 
WHERE "id" BETWEEN 10001 AND 10020
   OR "executor_class_name" LIKE 'test.%';

-- 插入测试数据
-- 注意：status 字段是枚举类型，值为 'Todo' 或 'Waiting'
-- query_end_time 用于判断任务是否就绪（<= 当前时间表示就绪）

-- ============================================
-- 测试数据组1：就绪任务（query_end_time <= 当前时间）
-- ============================================

-- 就绪任务 1：Todo 状态，query_end_time 为 1 小时前
INSERT INTO "t_log_correlation_job" (
    "status", "executor_class_name", "parameters", "echo_parameters", 
    "start_time", "query_start_time", "query_end_time"
) VALUES (
    'Todo'::t_log_correlation_job_status,
    'test.executor.LogQueryExecutor',
    '{"queryType":"log","timeRange":"1h"}',
    '{"action":"notify","target":"admin"}',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
);

-- 就绪任务 2：Todo 状态，query_end_time 为 30 分钟前
INSERT INTO "t_log_correlation_job" (
    "status", "executor_class_name", "parameters", "echo_parameters", 
    "start_time", "query_start_time", "query_end_time"
) VALUES (
    'Todo'::t_log_correlation_job_status,
    'test.executor.AgentQueryExecutor',
    '{"queryType":"agent","taskId":"task-001"}',
    '{"action":"process","method":"kill"}',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes'
);

-- 就绪任务 3：Waiting 状态，query_end_time 为 10 分钟前
INSERT INTO "t_log_correlation_job" (
    "status", "executor_class_name", "parameters", "waiting_parameters", 
    "start_time", "query_start_time", "query_end_time"
) VALUES (
    'Waiting'::t_log_correlation_job_status,
    'test.executor.AsyncQueryExecutor',
    '{"queryType":"async","asyncId":"async-001"}',
    '{"taskId":"async-task-001","status":"pending"}',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes'
);

-- 就绪任务 4：Todo 状态，query_end_time 为 5 分钟前
INSERT INTO "t_log_correlation_job" (
    "status", "executor_class_name", "parameters", 
    "start_time", "query_start_time", "query_end_time"
) VALUES (
    'Todo'::t_log_correlation_job_status,
    'test.executor.SimpleQueryExecutor',
    '{"queryType":"simple","filter":"error"}',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP - INTERVAL '5 minutes'
);

-- ============================================
-- 测试数据组2：未就绪任务（query_end_time > 当前时间）
-- ============================================

-- 未就绪任务 1：Todo 状态，query_end_time 为 1 小时后
INSERT INTO "t_log_correlation_job" (
    "status", "executor_class_name", "parameters", 
    "start_time", "query_start_time", "query_end_time"
) VALUES (
    'Todo'::t_log_correlation_job_status,
    'test.executor.FutureQueryExecutor',
    '{"queryType":"future","scheduled":"1h"}',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP + INTERVAL '1 hour'
);

-- 未就绪任务 2：Todo 状态，query_end_time 为 30 分钟后
INSERT INTO "t_log_correlation_job" (
    "status", "executor_class_name", "parameters", 
    "start_time", "query_start_time", "query_end_time"
) VALUES (
    'Todo'::t_log_correlation_job_status,
    'test.executor.ScheduledQueryExecutor',
    '{"queryType":"scheduled","delay":"30m"}',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP + INTERVAL '30 minutes'
);

-- ============================================
-- 测试数据组3：边界情况
-- ============================================

-- 边界任务：query_end_time 正好等于当前时间（应该被查询到）
INSERT INTO "t_log_correlation_job" (
    "status", "executor_class_name", "parameters", 
    "start_time", "query_start_time", "query_end_time"
) VALUES (
    'Todo'::t_log_correlation_job_status,
    'test.executor.BoundaryQueryExecutor',
    '{"queryType":"boundary","time":"now"}',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP
);

-- ============================================
-- 验证插入的数据
-- ============================================

-- 验证就绪任务（query_end_time <= 当前时间）
SELECT 
    id,
    status,
    executor_class_name,
    query_end_time,
    CASE 
        WHEN query_end_time <= CURRENT_TIMESTAMP THEN '就绪'
        ELSE '未就绪'
    END AS ready_status
FROM "t_log_correlation_job"
WHERE "executor_class_name" LIKE 'test.%'
ORDER BY query_end_time DESC;

-- 统计就绪任务数量
SELECT 
    COUNT(*) AS ready_count,
    COUNT(CASE WHEN status = 'Todo' THEN 1 END) AS todo_count,
    COUNT(CASE WHEN status = 'Waiting' THEN 1 END) AS waiting_count
FROM "t_log_correlation_job"
WHERE "executor_class_name" LIKE 'test.%'
  AND query_end_time <= CURRENT_TIMESTAMP;

-- 说明：
-- 1. 就绪任务（4个）：query_end_time <= 当前时间，应该被 getAllReadyJobs 查询到
-- 2. 未就绪任务（2个）：query_end_time > 当前时间，不应被 getAllReadyJobs 查询到
-- 3. 边界任务（1个）：query_end_time = 当前时间，应该被查询到
-- 4. 状态分布：Todo 和 Waiting 状态都有，用于测试状态更新功能
