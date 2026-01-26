-- 测试数据：LoginBaseline（登录基线）
DELETE FROM "t_login_baseline" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_login_baseline" ("id", "user_id", "username", "baseline_ips", "baseline_locations", "baseline_time_range", "last_login_ip", "last_login_time", "anomaly_count", "status", "create_time") VALUES 
(1001, 'user001', 'admin', '{"ips": ["192.168.1.100", "192.168.1.101"]}', '{"locations": ["Beijing", "Shanghai"]}', '{"start": "08:00", "end": "18:00"}', '192.168.1.100', CURRENT_TIMESTAMP - INTERVAL '1 hour', 0, 'normal', CURRENT_TIMESTAMP - INTERVAL '30 days'),
(1002, 'user002', 'analyst', '{"ips": ["192.168.1.200"]}', '{"locations": ["Beijing"]}', '{"start": "09:00", "end": "17:00"}', '203.0.113.50', CURRENT_TIMESTAMP - INTERVAL '2 hours', 5, 'anomaly', CURRENT_TIMESTAMP - INTERVAL '20 days'),
(1003, 'user003', 'operator', '{"ips": ["192.168.2.0/24"]}', '{"locations": ["Guangzhou"]}', '{"start": "00:00", "end": "23:59"}', '192.168.2.50', CURRENT_TIMESTAMP - INTERVAL '30 minutes', 0, 'normal', CURRENT_TIMESTAMP - INTERVAL '60 days');

SELECT setval('"t_login_baseline_id_seq"', 1003, true);
