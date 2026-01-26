-- 测试数据：AssetInfo（资产信息）
DELETE FROM "t_asset_info" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_asset_info" ("id", "asset_ip", "asset_name", "asset_type", "os_type", "department", "owner", "importance", "status", "last_scan_time", "create_time") VALUES 
(1001, '192.168.1.50', 'Web-Server-01', 'server', 'Linux', 'IT部门', '张三', 'high', 'online', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '180 days'),
(1002, '192.168.2.100', 'DB-Server-Main', 'database', 'Linux', '数据中心', '李四', 'critical', 'online', CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP - INTERVAL '365 days'),
(1003, '192.168.3.10', 'Test-PC-01', 'workstation', 'Windows', '测试部', '王五', 'low', 'offline', CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP - INTERVAL '90 days');

SELECT setval('"t_asset_info_id_seq"', 1003, true);
