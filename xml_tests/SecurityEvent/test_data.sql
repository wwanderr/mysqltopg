-- ============================================
-- 测试数据：SecurityEvent（安全事件）
-- 主表：t_security_incidents (31个字段)
-- 生成时间：2026-01-28（深度修复）
-- ============================================

DELETE FROM "t_security_incidents" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据（完整31个字段）
INSERT INTO "t_security_incidents" (
    "id",
    "template_id",
    "template_code",
    "attack_conclusion",
    "threat_severity",
    "start_time",
    "end_time",
    "create_time",
    "sub_category",
    "category",
    "event_name",
    "attacker",
    "victim",
    "counts",
    "alarm_status",
    "alarm_results",
    "kill_chain",
    "succeed_count",
    "fail_count",
    "event_ids",
    "mirror_sub_category",
    "family_id",
    "organization_id",
    "focus",
    "event_code",
    "focus_ip",
    "incident_cond",
    "tag_search",
    "is_scenario",
    "update_time",
    "update_ip_information"
) VALUES 

-- ==========================================
-- 场景1：SSH暴力破解攻击（正在进行）
-- ==========================================
(
    1001,
    1001,
    'SSH_BRUTE_FORCE',
    '检测到来自203.0.113.100的SSH暴力破解尝试，已失败25次',
    'high',
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    'Brute Force',
    'Network Attack',
    'SSH暴力破解攻击',
    '203.0.113.100',
    '192.168.1.50',
    25,
    'pending',
    '部分失败',
    'Reconnaissance,Initial Access',
    0,
    25,
    'ALM-001,ALM-002,ALM-003',
    'SSH_LOGIN_FAIL',
    NULL,
    NULL,
    'server',
    'EVT-SEC-2026-001',
    '192.168.1.50',
    'login_fail_count > 5',
    '{"tags": ["SSH", "暴力破解", "高危"]}',
    1,
    CURRENT_TIMESTAMP,
    '{"region": "US", "isp": "Unknown", "risk_level": "high"}'
),

-- ==========================================
-- 场景2：SQL注入攻击（已处理）
-- ==========================================
(
    1002,
    1002,
    'SQL_INJECTION',
    'Web应用遭受SQL注入攻击，攻击者尝试获取数据库信息',
    'critical',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '1 hour 50 minutes',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    'SQL Injection',
    'Web Attack',
    'SQL注入攻击检测',
    '198.51.100.25',
    '192.168.10.100',
    3,
    'handled',
    '已拦截',
    'Initial Access,Execution',
    0,
    3,
    'ALM-010',
    'WEB_INJECTION',
    NULL,
    NULL,
    'server',
    'EVT-SEC-2026-002',
    '192.168.10.100',
    'url LIKE ''%union%select%''',
    '{"tags": ["SQL注入", "Web攻击", "严重"]}',
    1,
    CURRENT_TIMESTAMP - INTERVAL '1 hour 50 minutes',
    '{"region": "CN", "isp": "ChinaNet", "risk_level": "critical"}'
),

-- ==========================================
-- 场景3：端口扫描（已确认）
-- ==========================================
(
    1003,
    1003,
    'PORT_SCAN',
    '检测到来自185.220.101.30的大规模端口扫描，扫描了152个端口',
    'medium',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours 55 minutes',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    'Port Scan',
    'Network Attack',
    '端口扫描行为',
    '185.220.101.30',
    '192.168.1.0/24',
    152,
    'handled',
    '已记录',
    'Reconnaissance',
    0,
    0,
    'ALM-020,ALM-021',
    'PORT_SCAN_SYN',
    NULL,
    NULL,
    'network',
    'EVT-SEC-2026-003',
    '192.168.1.1',
    'unique_ports > 20',
    '{"tags": ["端口扫描", "侦查", "中危"]}',
    1,
    CURRENT_TIMESTAMP - INTERVAL '4 hours 55 minutes',
    '{"region": "Unknown", "isp": "TOR_EXIT", "risk_level": "medium"}'
),

-- ==========================================
-- 场景4：恶意文件下载（已隔离）
-- ==========================================
(
    1004,
    1004,
    'MALWARE_FILE',
    '内网主机192.168.50.120下载了已知恶意软件',
    'critical',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '23 hours 50 minutes',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    'Trojan Download',
    'Malware',
    '恶意文件下载行为',
    '192.168.50.120',
    '203.0.113.200',
    1,
    'handled',
    '已隔离',
    'Execution,Persistence',
    1,
    0,
    'ALM-030',
    'MALWARE_TROJAN',
    'Trojan.Win32.Agent',
    NULL,
    'server',
    'EVT-SEC-2026-004',
    '192.168.50.120',
    'file_md5 IN (malware_hash_list)',
    '{"tags": ["恶意软件", "木马", "严重"]}',
    1,
    CURRENT_TIMESTAMP - INTERVAL '23 hours 50 minutes',
    '{"region": "CN", "isp": "Internal", "risk_level": "critical"}'
),

-- ==========================================
-- 场景5：异常外连（正在调查）
-- ==========================================
(
    1005,
    1005,
    'ABNORMAL_OUTBOUND',
    '内网主机异常向外部IP建立大量连接，疑似C&C通信或数据外泄',
    'high',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    'Outbound Connection',
    'Abnormal Traffic',
    '内网主机异常外连',
    '192.168.100.88',
    '45.xxx.xxx.xxx',
    1250,
    'pending',
    '监控中',
    'Command and Control,Exfiltration',
    125,
    0,
    'ALM-040,ALM-041,ALM-042',
    'C2_BEACON',
    'Cobalt_Strike',
    'APT28',
    'server',
    'EVT-SEC-2026-005',
    '192.168.100.88',
    'connection_count > 100',
    '{"tags": ["C2通信", "数据外泄", "高危", "APT"]}',
    1,
    CURRENT_TIMESTAMP,
    '{"region": "RU", "isp": "Unknown", "risk_level": "high", "threat_intel": "APT28"}'
);

SELECT setval('t_security_incidents_id_seq', (SELECT MAX(id) FROM t_security_incidents), true);

-- ==========================================
-- 验证：按威胁等级统计
-- ==========================================
SELECT 
    threat_severity AS "威胁等级",
    COUNT(*) AS "数量",
    SUM(counts) AS "总攻击次数"
FROM "t_security_incidents"
WHERE id >= 1001 AND id <= 1005
GROUP BY threat_severity
ORDER BY 
    CASE threat_severity
        WHEN 'critical' THEN 1
        WHEN 'high' THEN 2
        WHEN 'medium' THEN 3
        ELSE 4
    END;

-- ==========================================
-- 验证：按处置状态统计
-- ==========================================
SELECT 
    alarm_status AS "处置状态",
    COUNT(*) AS "数量"
FROM "t_security_incidents"
WHERE id >= 1001 AND id <= 1005
GROUP BY alarm_status;
