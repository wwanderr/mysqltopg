-- 测试数据：AttackerTrafficTask（攻击流量任务）
-- 表：t_attacker_traffic_task
-- 实际字段：ip, date_part, start_time, time_offset, history_time_offset, is_init
DELETE FROM "t_attacker_traffic_task" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_attacker_traffic_task" (
    "id",
    "ip",
    "date_part",
    "start_time",
    "time_offset",
    "history_time_offset",
    "is_init",
    "create_time"
) VALUES 
-- 场景1：DDoS攻击源（已初始化）
(1001, '203.0.113.100', '2026-01-26', '2026-01-26 08:00:00', '2026-01-26 10:30:00', '2026-01-26 07:00:00', true, CURRENT_TIMESTAMP - INTERVAL '3 hours'),

-- 场景2：APT攻击源（已初始化）
(1002, '198.51.100.50', '2026-01-25', '2026-01-25 14:00:00', '2026-01-25 18:30:00', '2026-01-25 12:00:00', true, CURRENT_TIMESTAMP - INTERVAL '1 day'),

-- 场景3：扫描攻击源（未初始化）
(1003, '185.220.101.30', '2026-01-26', '2026-01-26 12:00:00', '2026-01-26 12:15:00', '2026-01-26 11:00:00', false, CURRENT_TIMESTAMP - INTERVAL '5 minutes');

SELECT setval('"t_attacker_traffic_task_id_seq"', 1003, true);

-- 验证插入结果
SELECT 
    id,
    ip AS "攻击者IP",
    date_part AS "日期分区",
    start_time AS "首次计算时间",
    time_offset AS "当前计算时间",
    CASE WHEN is_init THEN '是' ELSE '否' END AS "已初始化"
FROM "t_attacker_traffic_task"
WHERE id >= 1001 AND id <= 1003
ORDER BY create_time DESC;
