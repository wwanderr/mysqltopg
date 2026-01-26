-- 测试数据：TagSearch（标签搜索）
DELETE FROM "t_tag_search" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_tag_search" ("id", "tag_name", "tag_type", "tag_value", "related_count", "last_search_time", "search_count", "create_time") VALUES 
(1001, 'APT攻击', 'threat_type', 'apt', 15, CURRENT_TIMESTAMP - INTERVAL '1 hour', 120, CURRENT_TIMESTAMP - INTERVAL '90 days'),
(1002, '严重级别', 'severity', 'critical', 32, CURRENT_TIMESTAMP - INTERVAL '30 minutes', 580, CURRENT_TIMESTAMP - INTERVAL '120 days'),
(1003, '勒索软件', 'malware_type', 'ransomware', 8, CURRENT_TIMESTAMP - INTERVAL '2 hours', 45, CURRENT_TIMESTAMP - INTERVAL '60 days');

SELECT setval('"t_tag_search_id_seq"', 1003, true);
