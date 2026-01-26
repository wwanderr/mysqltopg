-- 测试数据：ScenarioData（场景数据）
DELETE FROM "t_scenario_data" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_scenario_data" ("id", "scenario_id", "template_id", "data_content", "match_score", "status", "create_time", "update_time") VALUES 
(1001, 'SCEN-2026-001', 1001, '{"events": [{"type": "port_scan"}, {"type": "exploit"}, {"type": "backdoor"}]}', 85, 'matched', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour'),
(1002, 'SCEN-2026-002', 1002, '{"events": [{"type": "file_encryption"}, {"type": "network_spread"}]}', 92, 'matched', CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours'),
(1003, 'SCEN-2026-003', 1003, '{"events": [{"type": "large_upload"}]}', 45, 'pending', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '1 hour');

SELECT setval('"t_scenario_data_id_seq"', 1003, true);
