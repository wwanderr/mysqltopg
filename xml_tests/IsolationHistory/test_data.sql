-- 测试数据：IsolationHistory（隔离历史）
DELETE FROM "t_isolation_history" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_isolation_history" ("id", "isolated_ip", "isolated_reason", "isolation_method", "isolation_status", "start_time", "end_time", "operator", "create_time") VALUES 
(1001, '192.168.50.100', '勒索软件感染', 'network_isolation', 'active', CURRENT_TIMESTAMP - INTERVAL '3 hours', NULL, 'system', CURRENT_TIMESTAMP - INTERVAL '3 hours'),
(1002, '192.168.50.101', '僵尸网络通信', 'network_isolation', 'released', CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP - INTERVAL '1 day', 'admin', CURRENT_TIMESTAMP - INTERVAL '2 days'),
(1003, '192.168.50.102', '异常外连行为', 'process_isolation', 'active', CURRENT_TIMESTAMP - INTERVAL '1 hour', NULL, 'system', CURRENT_TIMESTAMP - INTERVAL '1 hour');

SELECT setval('"t_isolation_history_id_seq"', 1003, true);
