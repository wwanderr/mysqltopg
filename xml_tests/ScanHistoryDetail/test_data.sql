-- 测试数据：ScanHistoryDetail（扫描历史详情）
DELETE FROM "t_scan_history_detail" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_scan_history_detail" ("id", "scan_id", "target_ip", "target_port", "vul_name", "vul_level", "vul_description", "fix_suggestion", "create_time") VALUES 
(1001, 1001, '192.168.1.50', 22, 'SSH弱密码', 'high', 'SSH服务使用弱密码，可被暴力破解', '使用强密码或密钥认证', CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes'),
(1002, 1001, '192.168.1.50', 3306, 'MySQL未授权访问', 'critical', 'MySQL服务对外开放且无密码', '配置防火墙并设置强密码', CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes'),
(1003, 1002, '192.168.2.50', 80, 'SQL注入漏洞', 'high', 'Web应用存在SQL注入漏洞', '使用参数化查询', CURRENT_TIMESTAMP - INTERVAL '23 hours');

SELECT setval('"t_scan_history_detail_id_seq"', 1003, true);
