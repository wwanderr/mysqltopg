-- 测试数据：ScanHistory（扫描历史）
DELETE FROM "t_scan_history" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_scan_history" ("id", "scan_type", "scan_target", "scan_status", "start_time", "end_time", "vul_count", "high_vul", "medium_vul", "low_vul", "create_time") VALUES 
(1001, 'port_scan', '192.168.1.0/24', 'completed', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes', 15, 3, 7, 5, CURRENT_TIMESTAMP - INTERVAL '2 hours'),
(1002, 'vul_scan', '192.168.2.50', 'completed', CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '23 hours', 8, 2, 4, 2, CURRENT_TIMESTAMP - INTERVAL '1 day'),
(1003, 'web_scan', 'https://app.company.com', 'running', CURRENT_TIMESTAMP - INTERVAL '30 minutes', NULL, 0, 0, 0, 0, CURRENT_TIMESTAMP - INTERVAL '30 minutes');

SELECT setval('"t_scan_history_id_seq"', 1003, true);
