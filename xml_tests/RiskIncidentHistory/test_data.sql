-- ================================================================
-- 深度测试数据：RiskIncidentHistory（风险事件历史）
-- 主表: t_risk_incidents_history
-- 生成时间: 2026-01-28
-- 说明：完整19个字段，覆盖所有XML查询参数
-- ================================================================

DELETE FROM "t_risk_incidents_history" WHERE id >= 9001 AND id <= 9010;

-- ================================================================
-- 测试数据：10条完整记录，覆盖所有字段和查询条件
-- ================================================================
INSERT INTO "t_risk_incidents_history" (
    "id", "event_id", "event_code", "name", "template_id",
    "threat_severity", "start_time", "end_time",
    "top_event_type_chinese", "second_event_type_chinese",
    "focus_ip", "focus_object", "counts",
    "alarm_status", "alarm_results",
    "filter_content", "event_ids", "data_source",
    "create_time", "update_time"
) VALUES

-- ==========================================
-- 场景1：高危APT攻击（攻击者视角，已处置）
-- ==========================================
(9001, 100001, 'RH-2026-001', 'APT组织横向移动攻击', 'TPL-APT-001',
 'High', CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP - INTERVAL '9 days',
 '入侵攻击', '横向移动',
 '203.0.113.50,192.168.1.100', 'attacker', 15,
 'processed', 'OK',
 'src_ip=203.0.113.50&dst_ip=192.168.1.100', '[1001,1002,1003]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP - INTERVAL '8 days'),

-- ==========================================
-- 场景2：中危SQL注入（受害者视角，处置中）
-- ==========================================
(9002, 100002, 'RH-2026-002', 'SQL注入攻击尝试', 'TPL-WEB-002',
 'Medium', CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '6 days',
 'Web攻击', 'SQL注入',
 '10.0.0.50', 'victim', 8,
 'processing', 'FAIL',
 'url=/admin&method=POST', '[2001,2002]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '6 days'),

-- ==========================================
-- 场景3：低危端口扫描（未处置）
-- ==========================================
(9003, 100003, 'RH-2026-003', '端口扫描行为', 'TPL-SCAN-001',
 'Low', CURRENT_TIMESTAMP - INTERVAL '5 days', CURRENT_TIMESTAMP - INTERVAL '4 days',
 '侦查行为', '端口扫描',
 '198.51.100.10', 'attacker', 50,
 'unprocessed', 'UNKNOWN',
 'scan_type=SYN', '[3001]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '5 days', CURRENT_TIMESTAMP - INTERVAL '4 days'),

-- ==========================================
-- 场景4：高危勒索软件（攻击者，标记误报）
-- ==========================================
(9004, 100004, 'RH-2026-004', '勒索软件执行检测', 'TPL-MALWARE-001',
 'High', CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '2 days',
 '恶意代码', '勒索软件',
 '192.168.10.20', 'attacker', 1,
 'falsePositives', 'OK',
 'file_hash=abc123def456', '[4001,4002,4003,4004]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '2 days'),

-- ==========================================
-- 场景5：中危数据外泄（受害者，已忽略）
-- ==========================================
(9005, 100005, 'RH-2026-005', '敏感数据外泄', 'TPL-EXFIL-001',
 'Medium', CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP - INTERVAL '1 day',
 '数据泄露', '数据外泄',
 '172.16.0.100', 'victim', 3,
 'ignore', 'FAIL',
 'protocol=HTTPS&size=500MB', '[5001,5002]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP - INTERVAL '1 day'),

-- ==========================================
-- 场景6：高危C&C通信（攻击者，未处置）
-- ==========================================
(9006, 100006, 'RH-2026-006', 'C&C服务器通信', 'TPL-C2-001',
 'High', CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '12 hours',
 '恶意通信', 'C&C通信',
 '10.10.10.50,203.0.113.99', 'attacker', 20,
 'unprocessed', 'OK',
 'domain=malicious.com', '[6001,6002,6003]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '12 hours'),

-- ==========================================
-- 场景7：低危暴力破解（受害者，已处置）
-- ==========================================
(9007, 100007, 'RH-2026-007', 'SSH暴力破解攻击', 'TPL-BRUTE-001',
 'Low', CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_TIMESTAMP - INTERVAL '19 days',
 '登录攻击', '暴力破解',
 '192.168.2.10', 'victim', 100,
 'processed', 'UNKNOWN',
 'service=SSH&port=22', '[7001]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_TIMESTAMP - INTERVAL '19 days'),

-- ==========================================
-- 场景8：中危XSS攻击（受害者，处置中）
-- ==========================================
(9008, 100008, 'RH-2026-008', 'XSS跨站脚本攻击', 'TPL-WEB-003',
 'Medium', CURRENT_TIMESTAMP - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '14 days',
 'Web攻击', 'XSS攻击',
 '10.20.30.40', 'victim', 5,
 'processing', 'OK',
 'payload=<script>alert(1)</script>', '[8001,8002]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '14 days'),

-- ==========================================
-- 场景9：高危提权攻击（攻击者，已处置）
-- ==========================================
(9009, 100009, 'RH-2026-009', '权限提升攻击', 'TPL-PRIV-001',
 'High', CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '29 days',
 '权限滥用', '权限提升',
 '172.20.0.50', 'attacker', 2,
 'processed', 'FAIL',
 'method=CVE-2023-1234', '[9001,9002]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '29 days'),

-- ==========================================
-- 场景10：低危DDoS攻击（攻击者，未处置）
-- ==========================================
(9010, 100010, 'RH-2026-010', 'DDoS拒绝服务攻击', 'TPL-DDOS-001',
 'Low', CURRENT_TIMESTAMP - INTERVAL '60 days', CURRENT_TIMESTAMP - INTERVAL '59 days',
 '拒绝服务', 'DDoS攻击',
 '198.51.100.200', 'attacker', 1000,
 'unprocessed', 'OK',
 'type=SYN-Flood', '[10001]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '60 days', CURRENT_TIMESTAMP - INTERVAL '59 days');

SELECT setval('"t_risk_incidents_history_id_seq"', 9010, true);

-- ================================================================
-- 关联表数据：t_risk_incidents_out_going_history
-- 用于支持FocusIpMessage、getFocusIpCount、queryFocusIps等测试
-- ================================================================
DELETE FROM "t_risk_incidents_out_going_history" WHERE event_id >= 100001 AND event_id <= 100010;

INSERT INTO "t_risk_incidents_out_going_history" (
    "event_id", "uniq_code", "event_code", "security_incident_id",
    "name", "template_id", "start_time", "end_time",
    "top_event_type_chinese", "second_event_type_chinese",
    "src_geo_region", "security_zone", "device_address",
    "device_send_product_name", "send_host_address", "machine_code",
    "rule_type", "focus_ip", "attacker", "victim",
    "severity", "cat_outcome", "time_part"
) VALUES
-- 关联到RH-2026-001的历史数据（event_id=100001）
(100001, 'RH-2026-001-192.168.1.100', 'RH-2026-001', 1001,
 'APT组织横向移动攻击', 'TPL-APT-001',
 CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP - INTERVAL '9 days',
 '入侵攻击', '横向移动',
 '美国', 'DMZ', '192.168.1.100', 'Firewall-01', '203.0.113.50', 'MAC-001',
 'Network Intrusion', '192.168.1.100', '203.0.113.50', '192.168.1.100',
 'High', 'OK', CAST('2026-01' AS timestamp)),

-- 关联到RH-2026-001的第二条历史数据
(100001, 'RH-2026-001-192.168.1.101', 'RH-2026-001', 1002,
 'APT组织横向移动攻击', 'TPL-APT-001',
 CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP - INTERVAL '9 days',
 '入侵攻击', '横向移动',
 '美国', 'Internal', '192.168.1.101', 'Switch-02', '203.0.113.50', 'MAC-002',
 'Lateral Movement', '192.168.1.101', '203.0.113.50', '192.168.1.101',
 'High', 'Attempt', CAST('2026-01' AS timestamp)),

-- 关联到RH-2026-002的历史数据
(100002, 'RH-2026-002-10.0.0.50', 'RH-2026-002', 2001,
 'SQL注入攻击尝试', 'TPL-WEB-002',
 CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '6 days',
 'Web攻击', 'SQL注入',
 '中国', 'Public', '10.0.0.50', 'WebServer-01', '198.51.100.20', 'MAC-003',
 'Web Application Attack', '10.0.0.50', '198.51.100.20', '10.0.0.50',
 'Medium', 'FAIL', CAST('2026-01' AS timestamp));

-- 验证关联数据
SELECT 
    event_code AS "事件编号",
    COUNT(*) AS "历史记录数",
    STRING_AGG(DISTINCT focus_ip, ', ') AS "关注IP"
FROM t_risk_incidents_out_going_history
WHERE event_id >= 100001 AND event_id <= 100010
GROUP BY event_code;

-- ================================================================
-- 验证数据统计
-- ================================================================
SELECT 
    threat_severity AS "威胁等级",
    COUNT(*) AS "数量",
    STRING_AGG(DISTINCT alarm_status, ', ') AS "处置状态"
FROM t_risk_incidents_history
WHERE id >= 9001 AND id <= 9010
GROUP BY threat_severity
ORDER BY 
    CASE threat_severity
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low' THEN 3
    END;

SELECT 
    focus_object AS "关注对象",
    COUNT(*) AS "数量",
    STRING_AGG(DISTINCT alarm_results, ', ') AS "攻击结果"
FROM t_risk_incidents_history
WHERE id >= 9001 AND id <= 9010
GROUP BY focus_object;

SELECT 
    alarm_status AS "处置状态",
    COUNT(*) AS "数量"
FROM t_risk_incidents_history
WHERE id >= 9001 AND id <= 9010
GROUP BY alarm_status
ORDER BY COUNT(*) DESC;
