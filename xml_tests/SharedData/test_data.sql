-- 测试数据：SharedData（共享数据）
DELETE FROM "t_shared_data" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_shared_data" ("id", "data_key", "data_value", "data_type", "expire_time", "owner", "share_scope", "create_time", "update_time") VALUES 
(1001, 'config:threat_intelligence_api', '{"url": "https://threat-intel.company.com", "api_key": "encrypted"}', 'config', NULL, 'system', 'global', CURRENT_TIMESTAMP - INTERVAL '180 days', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(1002, 'cache:ip_reputation:203.0.113.100', '{"score": 95, "category": "malicious", "updated": "2026-01-26"}', 'cache', CURRENT_TIMESTAMP + INTERVAL '1 day', 'system', 'global', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '1 hour'),
(1003, 'temp:analysis_result:1001', '{"result": "confirmed", "confidence": 98}', 'temp', CURRENT_TIMESTAMP + INTERVAL '2 hours', 'analyst_team', 'team', CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP - INTERVAL '30 minutes');

SELECT setval('"t_shared_data_id_seq"', 1003, true);
