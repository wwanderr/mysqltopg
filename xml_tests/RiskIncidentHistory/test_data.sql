-- 测试数据：RiskIncidentHistory（风险事件历史）
DELETE FROM "t_risk_incident_history" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_risk_incident_history" ("id", "incident_id", "operation_type", "operation_content", "operator", "operation_time", "create_time") VALUES 
(1001, 1001, 'status_change', '{"from": "open", "to": "confirmed"}', 'analyst', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours'),
(1002, 1001, 'comment_add', '{"comment": "已确认为APT攻击，启动应急响应"}', 'analyst', CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes', CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes'),
(1003, 1002, 'status_change', '{"from": "monitoring", "to": "closed"}', 'system', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '1 hour');

SELECT setval('"t_risk_incident_history_id_seq"', 1003, true);
