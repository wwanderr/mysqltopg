-- 测试数据：RiskIncidentOutGoing（风险事件外发）
DELETE FROM "t_risk_incident_out_going" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_risk_incident_out_going" ("id", "incident_id", "out_going_type", "out_going_addr", "send_status", "send_time", "retry_count", "error_msg", "create_time") VALUES 
(1001, 1001, 'siem', 'https://siem.company.com/api', 'success', CURRENT_TIMESTAMP - INTERVAL '1 hour', 0, NULL, CURRENT_TIMESTAMP - INTERVAL '1 hour'),
(1002, 1002, 'email', 'security@company.com', 'success', CURRENT_TIMESTAMP - INTERVAL '2 hours', 0, NULL, CURRENT_TIMESTAMP - INTERVAL '2 hours'),
(1003, 1003, 'webhook', 'https://webhook.company.com', 'failed', CURRENT_TIMESTAMP - INTERVAL '30 minutes', 3, 'Connection timeout', CURRENT_TIMESTAMP - INTERVAL '30 minutes');

SELECT setval('"t_risk_incident_out_going_id_seq"', 1003, true);
