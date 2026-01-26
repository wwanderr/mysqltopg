-- 测试数据：SecurityAlarmHandle（安全告警处理）
DELETE FROM "t_security_alarm_handle" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_security_alarm_handle" (
    "id", "alarm_id", "handle_type", "handle_result", "handle_content", "operator", "handle_time", "create_time"
) VALUES 
(1001, '1001', 'manual_confirm', 'confirmed', '确认为真实攻击，已封禁攻击源IP', 'admin', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '1 hour'),
(1002, '1002', 'auto_block', 'success', '自动封禁成功，规则已下发', 'system', CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP - INTERVAL '30 minutes'),
(1003, '1003', 'manual_ignore', 'false_positive', '误报，已忽略', 'analyst', CURRENT_TIMESTAMP - INTERVAL '10 minutes', CURRENT_TIMESTAMP - INTERVAL '10 minutes');

SELECT setval('"t_security_alarm_handle_id_seq"', 1003, true);
