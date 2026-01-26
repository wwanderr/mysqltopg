-- 测试数据：SecurityType（安全类型配置）
DELETE FROM "t_security_type" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_security_type" (
    "id", "type_code", "type_name", "parent_code", "level", "description", "is_enable", "sort_order", "create_time"
) VALUES 
(1001, 'INTRUSION', '入侵检测', NULL, 1, '网络入侵检测相关事件', true, 1, CURRENT_TIMESTAMP),
(1002, 'INTRUSION_SCAN', '端口扫描', 'INTRUSION', 2, '端口扫描行为', true, 11, CURRENT_TIMESTAMP),
(1003, 'MALWARE', '恶意软件', NULL, 1, '恶意软件相关事件', true, 2, CURRENT_TIMESTAMP);

SELECT setval('"t_security_type_id_seq"', 1003, true);
