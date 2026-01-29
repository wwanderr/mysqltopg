-- ============================================
-- 测试数据：EventUpdateCkAlarmQueue（事件更新CK告警队列）
-- 表：t_event_update_ck_alarm_queue
-- 生成时间：2026-01-26
-- ============================================

-- 主键：(window_id, agg_condition)

-- 清理旧测试数据
DELETE FROM "t_event_update_ck_alarm_queue" 
WHERE window_id LIKE 'WIN-2026-%';

-- 插入测试数据
INSERT INTO "t_event_update_ck_alarm_queue" (
    "window_id",
    "agg_condition",
    "time_part",
    "event_id",
    "end_time",
    "is_ck_sync",
    "create_time"
) VALUES 

-- ==========================================
-- 场景1：未同步的告警记录（is_ck_sync=false）
-- ==========================================
(
    'WIN-2026-001',
    'cond-2026-001',
    TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD'),
    'EVT-001',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    false,
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
),

-- ==========================================
-- 场景2：未同步的横向移动告警（is_ck_sync=false）
-- ==========================================
(
    'WIN-2026-002',
    'cond-2026-002',
    TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD'),
    'EVT-002',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    false,
    CURRENT_TIMESTAMP - INTERVAL '30 minutes'
),

-- ==========================================
-- 场景3：已同步的告警记录（is_ck_sync=true）
-- ==========================================
(
    'WIN-2026-003',
    'cond-2026-003',
    TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD'),
    'EVT-003',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    true,
    CURRENT_TIMESTAMP - INTERVAL '2 hours'
),

-- ==========================================
-- 场景4：多事件关联告警（未同步）
-- ==========================================
(
    'WIN-2026-004',
    'cond-2026-004',
    TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD'),
    'EVT-004,EVT-005,EVT-006',
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    false,
    CURRENT_TIMESTAMP - INTERVAL '15 minutes'
),

-- ==========================================
-- 场景5：昨天的已同步告警（用于验证查询时间范围）
-- ==========================================
(
    'WIN-2026-005',
    'cond-2026-005',
    TO_CHAR(CURRENT_TIMESTAMP - INTERVAL '1 day', 'YYYY-MM-DD'),
    'EVT-007',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    true,
    CURRENT_TIMESTAMP - INTERVAL '1 day'
);

-- ==========================================
-- 验证：查看插入的数据
-- ==========================================
SELECT 
    window_id AS "窗口ID",
    agg_condition AS "聚合条件",
    event_id AS "事件ID",
    time_part AS "时间分区",
    CASE WHEN is_ck_sync THEN '已同步' ELSE '未同步' END AS "同步状态",
    TO_CHAR(end_time, 'YYYY-MM-DD HH24:MI:SS') AS "结束时间",
    TO_CHAR(create_time, 'YYYY-MM-DD HH24:MI:SS') AS "创建时间"
FROM "t_event_update_ck_alarm_queue"
WHERE window_id LIKE 'WIN-2026-%'
ORDER BY create_time DESC;

-- ==========================================
-- 统计信息
-- ==========================================
SELECT 
    '总记录数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_event_update_ck_alarm_queue"
WHERE window_id LIKE 'WIN-2026-%'
UNION ALL
SELECT 
    '未同步记录数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_event_update_ck_alarm_queue"
WHERE window_id LIKE 'WIN-2026-%' AND is_ck_sync = false
UNION ALL
SELECT 
    '已同步记录数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_event_update_ck_alarm_queue"
WHERE window_id LIKE 'WIN-2026-%' AND is_ck_sync = true;

-- ==========================================
-- 测试查询说明
-- ==========================================
-- 1. selectLast: 应该返回 WIN-2026-001, WIN-2026-002, WIN-2026-004（3条未同步记录）
-- 2. insertIgnore: 插入时如果主键(window_id, agg_condition)冲突会被忽略
-- 3. updateSyncSuccessBatch: 将 WIN-2026-001 和 WIN-2026-002 标记为已同步

-- ==========================================
-- 数据说明
-- ==========================================
-- 未同步记录：WIN-2026-001, WIN-2026-002, WIN-2026-004（3条）
-- 已同步记录：WIN-2026-003, WIN-2026-005（2条）
-- 
-- window_id 和 agg_condition 组成主键，用于去重
-- is_ck_sync=false 表示未同步到ClickHouse
-- selectLast 只查询 is_ck_sync=false 的记录，最多1000条
