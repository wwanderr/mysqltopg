-- 测试数据：AttackerTrafficTask（攻击流量任务）
DELETE FROM "t_attacker_traffic_task" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_attacker_traffic_task" ("id", "task_name", "attacker_ip", "target_ip", "traffic_type", "capture_duration", "task_status", "start_time", "end_time", "pcap_path", "create_time") VALUES 
(1001, 'DDoS流量捕获', '203.0.113.100', '192.168.1.100', 'ddos', 300, 'completed', CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours 55 minutes', '/data/pcap/ddos_20260126_001.pcap', CURRENT_TIMESTAMP - INTERVAL '3 hours'),
(1002, 'APT流量分析', '198.51.100.50', '192.168.10.50', 'apt', 1800, 'completed', CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '23 hours 30 minutes', '/data/pcap/apt_20260125_001.pcap', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(1003, '扫描流量捕获', '185.220.101.30', '192.168.0.0/16', 'scan', 600, 'running', CURRENT_TIMESTAMP - INTERVAL '5 minutes', NULL, NULL, CURRENT_TIMESTAMP - INTERVAL '5 minutes');

SELECT setval('"t_attacker_traffic_task_id_seq"', 1003, true);
