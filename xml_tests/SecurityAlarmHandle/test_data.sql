-- ============================================
-- 测试数据：SecurityAlarmHandle（安全告警处理）
-- 主表：t_security_alarm_handle (6个字段)
-- 唯一约束：(agg_condition, window_id)
-- 生成时间：2026-01-28（深度修复）
-- ============================================

DELETE FROM "t_security_alarm_handle" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据（完整6个字段）
INSERT INTO "t_security_alarm_handle" (
    "id",
    "agg_condition",
    "window_id",
    "execute_time",
    "handle_status",
    "result"
) VALUES 

-- ==========================================
-- 场景1：未处置（待执行）
-- ==========================================
(
    1001,
    'AGG-COND-001',
    'WIN-2026-001',
    CURRENT_TIMESTAMP + INTERVAL '1 hour',
    'pending',
    false
),

-- ==========================================
-- 场景2：已处置（成功）
-- ==========================================
(
    1002,
    'AGG-COND-002',
    'WIN-2026-002',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    'completed',
    true
),

-- ==========================================
-- 场景3：处置中
-- ==========================================
(
    1003,
    'AGG-COND-003',
    'WIN-2026-003',
    CURRENT_TIMESTAMP,
    'processing',
    false
),

-- ==========================================
-- 场景4：处置失败
-- ==========================================
(
    1004,
    'AGG-COND-004',
    'WIN-2026-004',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    'failed',
    false
),

-- ==========================================
-- 场景5：已取消
-- ==========================================
(
    1005,
    'AGG-COND-005',
    'WIN-2026-005',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    'cancelled',
    false
);

SELECT setval('"t_security_alarm_handle_id_seq"', 1005, true);

-- ==========================================
-- 验证：按处置状态统计
-- ==========================================
SELECT 
    handle_status AS "处置状态",
    COUNT(*) AS "数量",
    SUM(CASE WHEN result = true THEN 1 ELSE 0 END) AS "成功数"
FROM "t_security_alarm_handle"
WHERE id >= 1001 AND id <= 1005
GROUP BY handle_status
ORDER BY handle_status;

-- ==========================================
-- 验证：按处置结果统计
-- ==========================================
SELECT 
    CASE result 
        WHEN true THEN '已处置'
        ELSE '未处置'
    END AS "处置结果",
    COUNT(*) AS "数量"
FROM "t_security_alarm_handle"
WHERE id >= 1001 AND id <= 1005
GROUP BY result;
