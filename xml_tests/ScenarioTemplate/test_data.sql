-- 测试数据：ScenarioTemplate（场景模板）
DELETE FROM "t_scenario_template" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_scenario_template" ("id", "template_name", "scenario_type", "template_rules", "is_enable", "priority", "description", "create_time") VALUES 
(1001, 'APT攻击场景', 'apt_attack', '{"stages": ["reconnaissance", "weaponization", "delivery", "exploitation"], "min_stages": 3}', true, 10, 'APT攻击链检测场景', CURRENT_TIMESTAMP - INTERVAL '60 days'),
(1002, '勒索软件传播场景', 'ransomware', '{"indicators": ["file_encryption", "network_spread", "ransom_note"], "min_indicators": 2}', true, 9, '勒索软件传播检测', CURRENT_TIMESTAMP - INTERVAL '45 days'),
(1003, '数据泄露场景', 'data_exfiltration', '{"behaviors": ["large_upload", "unusual_connection", "compression"], "threshold": 2}', true, 8, '数据泄露检测场景', CURRENT_TIMESTAMP - INTERVAL '30 days');

SELECT setval('"t_scenario_template_id_seq"', 1003, true);
