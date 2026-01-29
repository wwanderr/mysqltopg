-- ============================================
-- 深度测试数据：VulAnalysisSub（漏洞分析）
-- 主表：t_vul_analysis_sub (26个字段)
-- 关联表：bigdata_web.t_asset_info, bigdata_web.t_ailpha_network_segment, 
--         bigdata_web.t_ailpha_security_zone, bigdata_web.t_vulnerability_info
-- 注意：XML中涉及跨schema引用，测试数据仅插入主表
-- 生成时间：2026-01-28
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_vul_analysis_sub" WHERE id >= 1001 AND id <= 1015;

-- ==========================================
-- 插入主表 t_vul_analysis_sub 数据（完整26个字段）
-- ==========================================
INSERT INTO "t_vul_analysis_sub" (
    "id", "end_time", "start_time", "alarm_result", "alarm_status",
    "app_protocol", "source", "chart_id", "asset_ip", "asset_tags",
    "asset_name", "dest_security_zone", "asset_type", "clear_text", "request_url",
    "cve", "severity_level", "vulnerability_name", "class_type", "src_user_name",
    "passwd", "high", "medium", "low", "agg_count", "event_code", "update_time"
) VALUES 

-- ==========================================
-- 场景1：高危Log4j2远程代码执行（HTTP协议，未处置）
-- ==========================================
(1001, CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '2 hours',
 3, 5, 'HTTP', 1, 101, '192.168.10.50', '["Web服务器", "生产环境"]',
 'WebServer-01', 'zone_name:生产区', 'Server', NULL, '/api/vulnerable-endpoint',
 'CVE-2021-44228', 'High', 'Apache Log4j2 远程代码执行', 'RCE', NULL,
 NULL, 10, 5, 2, 15, 'VUL-2026-001', CURRENT_TIMESTAMP - INTERVAL '1 hour'),

-- ==========================================
-- 场景2：高危Windows SMB漏洞（SMB协议，处置中）
-- ==========================================
(1002, CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '5 hours',
 1, 4, 'SMB', 2, 102, '192.168.20.100', '["文件服务器"]',
 'FileServer-01', 'zone_name:办公区', 'Server', NULL, NULL,
 'CVE-2020-0796', 'High', 'Windows SMBv3 拒绝服务漏洞', 'DoS', NULL,
 NULL, 5, 3, 1, 8, 'VUL-2026-002', CURRENT_TIMESTAMP - INTERVAL '3 hours'),

-- ==========================================
-- 场景3：中危SQL注入（HTTP协议，已处置）
-- ==========================================
(1003, CURRENT_TIMESTAMP - INTERVAL '12 hours', CURRENT_TIMESTAMP - INTERVAL '15 hours',
 2, 3, 'HTTP', 1, 101, '192.168.30.200', '["数据库服务器", "测试环境"]',
 'DBServer-01', 'zone_name:测试区', 'Database', NULL, '/api/login?user=admin',
 'CVE-2023-1234', 'Medium', 'SQL注入漏洞', 'SQL Injection', 'admin',
 NULL, 0, 10, 5, 12, 'VUL-2026-003', CURRENT_TIMESTAMP - INTERVAL '12 hours'),

-- ==========================================
-- 场景4：中危弱密码（TELNET协议，未处置）
-- ==========================================
(1004, CURRENT_TIMESTAMP - INTERVAL '6 hours', CURRENT_TIMESTAMP - INTERVAL '8 hours',
 3, 5, 'TELNET', 3, 103, '192.168.40.150', '["网络设备"]',
 'Switch-01', 'zone_name:核心区', 'NetworkDevice', 'admin:123456', NULL,
 'CVE-2022-5678', 'Medium', '弱密码认证', 'Weak Authentication', 'admin',
 '123456', 2, 8, 10, 15, 'VUL-2026-004', CURRENT_TIMESTAMP - INTERVAL '6 hours'),

-- ==========================================
-- 场景5：低危信息泄露（HTTP协议，已忽略）
-- ==========================================
(1005, CURRENT_TIMESTAMP - INTERVAL '24 hours', CURRENT_TIMESTAMP - INTERVAL '30 hours',
 2, 1, 'HTTP', 1, 101, '192.168.50.50', '["Web应用"]',
 'WebApp-01', 'zone_name:DMZ区', 'Application', NULL, '/api/debug/info',
 'CVE-2024-9999', 'Low', '信息泄露漏洞', 'Information Disclosure', NULL,
 NULL, 0, 2, 20, 25, 'VUL-2026-005', CURRENT_TIMESTAMP - INTERVAL '24 hours'),

-- ==========================================
-- 场景6-10：补充更多测试数据（不同协议、不同安全域、不同漏洞等级）
-- ==========================================
(1006, CURRENT_TIMESTAMP - INTERVAL '4 hours', CURRENT_TIMESTAMP - INTERVAL '6 hours',
 3, 5, 'FTP', 2, 104, '192.168.60.10', '["FTP服务器"]',
 'FTPServer-01', 'zone_name:生产区', 'Server', 'username:password', NULL,
 'CVE-2021-9876', 'High', 'FTP明文传输密码', 'Weak Crypto', 'ftpuser',
 'ftppass123', 8, 4, 2, 10, 'VUL-2026-006', CURRENT_TIMESTAMP - INTERVAL '4 hours'),

(1007, CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours',
 1, 4, 'SSH', 1, 105, '192.168.70.100', '["Linux服务器"]',
 'LinuxServer-01', 'zone_name:办公区', 'Server', NULL, NULL,
 'CVE-2022-8888', 'Medium', 'SSH暴力破解尝试', 'Brute Force', 'root',
 NULL, 3, 15, 5, 18, 'VUL-2026-007', CURRENT_TIMESTAMP - INTERVAL '2 hours'),

(1008, CURRENT_TIMESTAMP - INTERVAL '8 hours', CURRENT_TIMESTAMP - INTERVAL '10 hours',
 2, 3, 'HTTPS', 3, 101, '192.168.80.50', '["Web服务器", "电商平台"]',
 'ECommerce-Web', 'zone_name:DMZ区', 'Server', NULL, '/api/xss-test',
 'CVE-2023-7777', 'Medium', '跨站脚本攻击', 'XSS', NULL,
 NULL, 1, 12, 8, 20, 'VUL-2026-008', CURRENT_TIMESTAMP - INTERVAL '8 hours'),

(1009, CURRENT_TIMESTAMP - INTERVAL '48 hours', CURRENT_TIMESTAMP - INTERVAL '50 hours',
 3, 5, 'RDP', 2, 106, '192.168.90.200', '["远程桌面"]',
 'RDPServer-01', 'zone_name:核心区', 'Server', NULL, NULL,
 'CVE-2019-0708', 'High', 'BlueKeep远程代码执行', 'RCE', 'administrator',
 NULL, 15, 3, 1, 18, 'VUL-2026-009', CURRENT_TIMESTAMP - INTERVAL '48 hours'),

(1010, CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '2 hours',
 1, 2, 'HTTP', 1, 101, '192.168.100.100', '["测试环境"]',
 'TestServer-01', 'zone_name:测试区', 'Server', NULL, '/api/csrf-test',
 'CVE-2024-1111', 'Low', '跨站请求伪造', 'CSRF', NULL,
 NULL, 0, 5, 15, 20, 'VUL-2026-010', CURRENT_TIMESTAMP - INTERVAL '1 hour'),

-- ==========================================
-- 场景11-15：多种漏洞类型组合（用于聚合统计测试）
-- ==========================================
(1011, CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '6 hours',
 3, 5, 'HTTP', 1, 101, '192.168.10.50', '["Web服务器", "生产环境"]',
 'WebServer-01', 'zone_name:生产区', 'Server', NULL, '/api/path-traversal',
 'CVE-2023-2222', 'High', '目录遍历漏洞', 'Path Traversal', NULL,
 NULL, 10, 5, 2, 8, 'VUL-2026-011', CURRENT_TIMESTAMP - INTERVAL '5 hours'),

(1012, CURRENT_TIMESTAMP - INTERVAL '7 hours', CURRENT_TIMESTAMP - INTERVAL '8 hours',
 2, 4, 'HTTP', 1, 101, '192.168.10.50', '["Web服务器", "生产环境"]',
 'WebServer-01', 'zone_name:生产区', 'Server', NULL, '/api/xxe',
 'CVE-2023-3333', 'Medium', 'XML外部实体注入', 'XXE', NULL,
 NULL, 10, 5, 2, 5, 'VUL-2026-012', CURRENT_TIMESTAMP - INTERVAL '7 hours'),

(1013, CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '4 hours',
 1, 3, 'HTTP', 2, 102, '192.168.20.100', '["文件服务器"]',
 'FileServer-01', 'zone_name:办公区', 'Server', NULL, NULL,
 'CVE-2022-4444', 'Medium', '任意文件上传', 'File Upload', NULL,
 NULL, 5, 3, 1, 6, 'VUL-2026-013', CURRENT_TIMESTAMP - INTERVAL '3 hours'),

(1014, CURRENT_TIMESTAMP - INTERVAL '9 hours', CURRENT_TIMESTAMP - INTERVAL '10 hours',
 2, 3, 'MYSQL', 3, 107, '192.168.30.200', '["数据库服务器", "测试环境"]',
 'DBServer-01', 'zone_name:测试区', 'Database', NULL, NULL,
 'CVE-2023-5555', 'High', 'MySQL权限提升', 'Privilege Escalation', 'dbuser',
 NULL, 0, 10, 5, 3, 'VUL-2026-014', CURRENT_TIMESTAMP - INTERVAL '9 hours'),

(1015, CURRENT_TIMESTAMP - INTERVAL '10 hours', CURRENT_TIMESTAMP - INTERVAL '12 hours',
 3, 5, 'DNS', 1, 108, '192.168.110.10', '["DNS服务器"]',
 'DNSServer-01', 'zone_name:核心区', 'Server', NULL, NULL,
 'CVE-2021-6666', 'High', 'DNS缓存中毒', 'DNS Poisoning', NULL,
 NULL, 12, 2, 0, 10, 'VUL-2026-015', CURRENT_TIMESTAMP - INTERVAL '10 hours');

SELECT setval('"t_vul_analysis_sub_id_seq"', 1015, true);

-- ==========================================
-- 验证：按漏洞等级统计
-- ==========================================
SELECT 
    severity_level AS "漏洞等级",
    COUNT(*) AS "数量",
    SUM(agg_count) AS "聚合数量",
    CASE 
        WHEN MAX(alarm_status) = 5 THEN '未处置'
        WHEN MAX(alarm_status) = 4 THEN '处置中'
        WHEN MAX(alarm_status) = 3 THEN '已处置'
        WHEN MAX(alarm_status) = 2 THEN '误报'
        WHEN MAX(alarm_status) = 1 THEN '已忽略'
    END AS "最高状态"
FROM "t_vul_analysis_sub"
WHERE id >= 1001 AND id <= 1015
GROUP BY severity_level
ORDER BY 
    CASE severity_level
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low' THEN 3
    END;

-- ==========================================
-- 验证：按协议统计
-- ==========================================
SELECT 
    app_protocol AS "协议",
    COUNT(*) AS "数量",
    SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END) AS "高危数量"
FROM "t_vul_analysis_sub"
WHERE id >= 1001 AND id <= 1015
GROUP BY app_protocol
ORDER BY "数量" DESC;

-- ==========================================
-- 验证：按资产IP聚合（测试GROUP BY）
-- ==========================================
SELECT 
    asset_ip AS "资产IP",
    COUNT(*) AS "漏洞数量",
    SUM(agg_count) AS "总聚合数",
    MAX(end_time) AS "最近发生时间"
FROM "t_vul_analysis_sub"
WHERE id >= 1001 AND id <= 1015
GROUP BY asset_ip
ORDER BY "漏洞数量" DESC;
