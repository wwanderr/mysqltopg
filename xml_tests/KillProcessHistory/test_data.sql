-- 测试数据：KillProcessHistory（进程终止历史）
DELETE FROM "t_kill_process_history" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_kill_process_history" ("id", "host_ip", "process_name", "process_path", "kill_reason", "kill_status", "kill_time", "operator", "create_time") VALUES 
(1001, '192.168.50.100', 'malware.exe', 'C:\\Temp\\malware.exe', '恶意软件进程', 'success', CURRENT_TIMESTAMP - INTERVAL '1 hour', 'system', CURRENT_TIMESTAMP - INTERVAL '1 hour'),
(1002, '192.168.50.101', 'miner.exe', 'C:\\Users\\Public\\miner.exe', '挖矿木马', 'success', CURRENT_TIMESTAMP - INTERVAL '2 hours', 'system', CURRENT_TIMESTAMP - INTERVAL '2 hours'),
(1003, '192.168.50.102', 'suspicious.exe', 'C:\\Windows\\Temp\\suspicious.exe', '可疑进程', 'failed', CURRENT_TIMESTAMP - INTERVAL '30 minutes', 'admin', CURRENT_TIMESTAMP - INTERVAL '30 minutes');

SELECT setval('"t_kill_process_history_id_seq"', 1003, true);
