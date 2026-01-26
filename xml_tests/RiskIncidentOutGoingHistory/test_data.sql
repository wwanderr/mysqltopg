-- 测试数据：RiskIncidentOutGoingHistory
DELETE FROM "t_risk_incident_out_going_history" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_risk_incident_out_going_history" ("id", "out_going_id", "retry_time", "status", "error_msg", "create_time") VALUES 
(1001, 1003, CURRENT_TIMESTAMP - INTERVAL '25 minutes', 'failed', 'Timeout', CURRENT_TIMESTAMP - INTERVAL '25 minutes'),
(1002, 1003, CURRENT_TIMESTAMP - INTERVAL '20 minutes', 'failed', 'Timeout', CURRENT_TIMESTAMP - INTERVAL '20 minutes'),
(1003, 1003, CURRENT_TIMESTAMP - INTERVAL '15 minutes', 'failed', 'Connection refused', CURRENT_TIMESTAMP - INTERVAL '15 minutes');

SELECT setval('"t_risk_incident_out_going_history_id_seq"', 1003, true);
