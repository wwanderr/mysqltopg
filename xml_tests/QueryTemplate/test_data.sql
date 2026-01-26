-- ============================================
-- 测试数据：QueryTemplate（查询模板）
-- 表：t_query_template
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_query_template" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_query_template" (
    "id",
    "template_name",
    "template_type",
    "query_condition",
    "query_fields",
    "sort_field",
    "sort_order",
    "is_enable",
    "is_default",
    "creator",
    "description",
    "create_time",
    "update_time"
) VALUES 

(
    1001,
    '近24小时高危告警',
    'security_alarm',
    '{"time_range": "24h", "level": ["high", "critical"], "status": ["open", "monitoring"]}',
    '["id", "alarm_name", "level", "focus_ip", "target_ip", "count", "status", "create_time"]',
    'create_time',
    'DESC',
    true,
    true,
    'system',
    '查询近24小时内所有高危和严重级别的告警',
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
),

(
    1002,
    '我的待处理事件',
    'my_tasks',
    '{"status": "open", "assigned_to": "current_user"}',
    '["id", "incident_name", "priority", "create_time", "deadline"]',
    'priority',
    'DESC',
    true,
    false,
    'user',
    '查询分配给当前用户的所有待处理事件',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '5 days'
),

(
    1003,
    'TOP10攻击源IP',
    'statistics',
    '{"time_range": "7d", "group_by": "focus_ip", "limit": 10}',
    '["focus_ip", "count", "threat_level", "last_seen"]',
    'count',
    'DESC',
    true,
    false,
    'analyst',
    '统计近7天攻击次数最多的10个IP',
    CURRENT_TIMESTAMP - INTERVAL '90 days',
    CURRENT_TIMESTAMP - INTERVAL '10 days'
),

(
    1004,
    '失陷主机列表',
    'compromised_assets',
    '{"status": "compromised", "confirmed": true}',
    '["asset_ip", "asset_name", "compromise_type", "first_seen", "last_activity"]',
    'last_activity',
    'DESC',
    true,
    false,
    'soc_team',
    '查询所有已确认的失陷主机',
    CURRENT_TIMESTAMP - INTERVAL '120 days',
    CURRENT_TIMESTAMP - INTERVAL '20 days'
),

(
    1005,
    '历史查询-已停用',
    'historical',
    '{"time_range": "30d"}',
    '["*"]',
    'create_time',
    'ASC',
    false,
    false,
    'admin',
    '旧的查询模板，已停用',
    CURRENT_TIMESTAMP - INTERVAL '365 days',
    CURRENT_TIMESTAMP - INTERVAL '180 days'
);

SELECT setval('"t_query_template_id_seq"', 1005, true);

SELECT 
    id,
    template_name AS "模板名称",
    template_type AS "类型",
    CASE WHEN is_enable THEN '已启用' ELSE '已禁用' END AS "状态",
    CASE WHEN is_default THEN '是' ELSE '否' END AS "默认模板",
    creator AS "创建者"
FROM "t_query_template"
WHERE id >= 1001 AND id <= 1005
ORDER BY is_enable DESC, is_default DESC;
