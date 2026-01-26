-- 测试数据：SecurityZoneSync（安全域同步）
DELETE FROM "t_security_zone_sync" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_security_zone_sync" ("id", "zone_name", "zone_type", "asset_count", "sync_status", "last_sync_time", "next_sync_time", "sync_interval", "create_time") VALUES 
(1001, '生产环境', 'production', 256, 'success', CURRENT_TIMESTAMP - INTERVAL '5 minutes', CURRENT_TIMESTAMP + INTERVAL '55 minutes', 3600, CURRENT_TIMESTAMP - INTERVAL '30 days'),
(1002, '办公网络', 'office', 512, 'success', CURRENT_TIMESTAMP - INTERVAL '10 minutes', CURRENT_TIMESTAMP + INTERVAL '50 minutes', 3600, CURRENT_TIMESTAMP - INTERVAL '30 days'),
(1003, '测试环境', 'test', 48, 'failed', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP + INTERVAL '1 hour', 3600, CURRENT_TIMESTAMP - INTERVAL '30 days');

SELECT setval('"t_security_zone_sync_id_seq"', 1003, true);
