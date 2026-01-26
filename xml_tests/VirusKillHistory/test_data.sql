-- 测试数据：VirusKillHistory（病毒查杀历史）
DELETE FROM "t_virus_kill_history" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_virus_kill_history" ("id", "host_ip", "virus_name", "virus_path", "virus_type", "kill_status", "kill_method", "kill_time", "create_time") VALUES 
(1001, '192.168.50.100', 'Trojan.Generic', 'C:\\Temp\\trojan.exe', 'trojan', 'success', 'delete', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '1 hour'),
(1002, '192.168.50.101', 'Ransomware.WannaCry', 'C:\\Users\\Public\\wannacry.exe', 'ransomware', 'success', 'quarantine', CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours'),
(1003, '192.168.50.102', 'Miner.XMRig', 'C:\\Windows\\Temp\\xmrig.exe', 'miner', 'success', 'delete', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours');

SELECT setval('"t_virus_kill_history_id_seq"', 1003, true);
