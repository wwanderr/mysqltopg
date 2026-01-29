-- ============================================
-- 深度测试数据：RiskIncident（风险事件）
-- 主表：t_risk_incidents (24个字段)
-- 关联表：t_event_template, t_query_template, t_security_incidents
-- 生成时间：2026-01-28
-- ============================================

-- ==========================================
-- 1. 先插入关联表 t_event_template 数据
-- ==========================================
DELETE FROM "t_event_template" WHERE id >= 2001 AND id <= 2005;

INSERT INTO "t_event_template" (
    "id", "incident_name", "incident_rule_type", "incident_class_type", "incident_sub_class_type",
    "incident_type", "incident_cond", "incident_description", "incident_suggestion", 
    "conclusion", "focus", "enable", "priority", "update_time"
) VALUES 
(2001, '高级持续性威胁(APT)攻击', 'APT攻击', '高级威胁', '持续性威胁', true,
'attack_stages >= 5 AND persistence_found = true', '检测到完整的APT攻击链', 
'建议：1.立即隔离受感染主机；2.全网排查类似攻击；3.加固防护措施',
'APT攻击成功，已造成数据泄露', 'target_ip', true, 10, CURRENT_TIMESTAMP),

(2002, '勒索软件传播尝试', '恶意软件', '勒索软件', '横向传播', true,
'smb_exploit_detected AND file_encryption_attempt', '检测到勒索软件通过SMB漏洞尝试横向传播',
'建议：1.确认漏洞已修复；2.全网扫描勒索软件；3.更新EDR规则',
'勒索软件传播尝试，已成功拦截', 'target_network', true, 9, CURRENT_TIMESTAMP),

(2003, '内网横向移动攻击', '横向移动', '内网渗透', 'Pass-the-Hash', true,
'lateral_movement_detected AND target_is_critical', '检测到攻击者从被控主机向核心网段进行横向移动',
'建议：1.立即隔离跳板机；2.监控核心网段；3.检查域控安全',
'攻击正在进行，已成功渗透2台主机', 'src_ip', true, 8, CURRENT_TIMESTAMP),

(2004, '钓鱼邮件攻击', '社会工程', '钓鱼攻击', '邮件钓鱼', false,
'phishing_indicators AND suspicious_sender', '检测到钓鱼邮件，但收件人未点击恶意链接',
'建议：1.加强安全意识培训；2.更新邮件过滤规则',
'钓鱼邮件已拦截，未造成危害', 'recipient_email', true, 3, CURRENT_TIMESTAMP),

(2005, '大规模数据外传', '数据外泄', '目标达成', '数据窃取', true,
'outbound_data_volume > 10GB AND destination_is_foreign', '检测到内网主机向境外IP传输大量数据',
'建议：1.阻断外连；2.分析传输内容；3.检查主机进程',
'正在分析数据内容和外泄原因', 'src_ip', true, 7, CURRENT_TIMESTAMP);

SELECT setval('t_event_template_id_seq', (SELECT MAX(id) FROM t_event_template), true);

-- ==========================================
-- 2. 插入关联表 t_query_template 数据
-- ==========================================
DELETE FROM "t_query_template" WHERE id >= 201 AND id <= 205;

INSERT INTO "t_query_template" (
    "id", "template_name", "template_code", "attack_conclusion",
    "ck_query_condition", "interval_time", "description", "suggestion",
    "enable", "is_thread", "category", "sub_category"
) VALUES 
(201, 'APT攻击查询', 'APT_ATTACK', 
'攻击者完成了完整的APT攻击链，造成数据泄露',
'attacker,victim,attack_stages', 60, 
'APT攻击查询模板', '建议立即隔离受感染主机并全网排查', 1, 1, '/aptIncident', '/aptIncident/advancedThreat'),

(202, '勒索软件查询', 'RANSOMWARE', 
'勒索软件尝试感染多台主机',
'malware_type,target_network', 30, 
'勒索软件查询模板', '建议确认漏洞已修复并全网扫描', 1, 1, '/malwareIncident', '/malwareIncident/ransomware'),

(203, '横向移动查询', 'LATERAL_MOVEMENT', 
'攻击者横向移动到核心网段',
'src_ip,target_ip,lateral_method', 20, 
'横向移动查询模板', '建议立即隔离跳板机并监控核心网段', 1, 1, '/lateralMovement', '/lateralMovement/passTheHash'),

(204, '钓鱼邮件查询', 'PHISHING_EMAIL', 
'检测到钓鱼邮件',
'sender,recipient,email_subject', 15, 
'钓鱼邮件查询模板', '建议加强安全意识培训', 1, 0, '/phishingIncident', '/phishingIncident/emailPhishing'),

(205, '数据外泄查询', 'DATA_EXFILTRATION', 
'内网主机向境外传输大量数据',
'src_ip,dest_ip,data_volume', 30, 
'数据外泄查询模板', '建议阻断外连并分析传输内容', 1, 1, '/dataExfiltration', '/dataExfiltration/largeTransfer');

SELECT setval('t_query_template_id_seq', (SELECT MAX(id) FROM t_query_template), true);

-- ==========================================
-- 3. 插入关联表 t_security_incidents 数据（用于某些JOIN查询）
-- ==========================================
DELETE FROM "t_security_incidents" WHERE id >= 5001 AND id <= 5005;

INSERT INTO "t_security_incidents" (
    "id", "event_code", "event_name", "template_id", "category", "sub_category",
    "attacker", "victim", "focus", "focus_ip", "threat_severity", "alarm_results",
    "start_time", "end_time", "counts", "alarm_status", "create_time", "update_time"
) VALUES
(5001, 'RISK-2026-001', 'APT Attack Event', '2001', 'Advanced Threat', 'APT Attack',
 '203.0.113.88', '192.168.10.50', 'target_ip', '192.168.10.50', 'High', 'OK',
 CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '2 days 12 hours',
 15, 'unprocessed', CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP),

(5002, 'RISK-2026-002', 'Ransomware Event', '2002', 'Malware', 'Ransomware',
 '198.51.100.150', '192.168.50.0/24', 'target_network', '192.168.50.1', 'High', 'FAIL',
 CURRENT_TIMESTAMP - INTERVAL '12 hours', CURRENT_TIMESTAMP - INTERVAL '11 hours',
 3, 'processing', CURRENT_TIMESTAMP - INTERVAL '12 hours', CURRENT_TIMESTAMP),

(5003, 'RISK-2026-003', 'Lateral Movement Event', '2003', 'Lateral Movement', 'Pass-the-Hash',
 '192.168.20.88', '192.168.30.0/24', 'src_ip', '192.168.20.88', 'Medium', 'OK',
 CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP,
 8, 'unprocessed', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP),

(5004, 'RISK-2026-004', 'Phishing Email Event', '2004', 'Social Engineering', 'Email Phishing',
 'phishing@evil-domain.com', '192.168.100.25', 'recipient_email', '192.168.100.25', 'Low', 'FAIL',
 CURRENT_TIMESTAMP - INTERVAL '5 days', CURRENT_TIMESTAMP - INTERVAL '5 days',
 1, 'processed', CURRENT_TIMESTAMP - INTERVAL '5 days', CURRENT_TIMESTAMP),

(5005, 'RISK-2026-005', 'Data Exfiltration Event', '2005', 'Data Exfiltration', 'Large Transfer',
 '192.168.80.120', '45.xxx.xxx.xxx', 'src_ip', '192.168.80.120', 'High', 'UNKNOWN',
 CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP,
 1, 'unprocessed', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP);

-- ==========================================
-- 4. 插入主表 t_risk_incidents 数据（完整24个字段）
-- ==========================================
DELETE FROM "t_risk_incidents" WHERE id >= 1001 AND id <= 1010;

INSERT INTO "t_risk_incidents" (
    "id", "event_code", "name", "template_id", "threat_severity",
    "start_time", "end_time", "top_event_type_chinese", "second_event_type_chinese",
    "focus_ip", "focus_object", "counts", "alarm_status", "alarm_results",
    "filter_content", "event_ids", "data_source",
    "create_time", "update_time", "tag_search", "is_scenario",
    "filter_content_aiql", "kill_chain", "judge_result", "judge_status"
) VALUES 

-- ==========================================
-- 场景1：高危APT攻击（已研判-成功攻击）
-- ==========================================
(1001, 'RISK-2026-001', '高级持续性威胁(APT)攻击', '2001', 'High',
 CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '2 days 12 hours',
 '高级威胁', '持续性威胁',
 '192.168.10.50', 'victim', 15, 'unprocessed', 'OK',
 'attacker=203.0.113.88&victim=192.168.10.50', '[5001]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '2 days 12 hours',
 '["APT", "数据泄露", "高级威胁"]', 1,
 'attacker="203.0.113.88" AND victim="192.168.10.50"',
 '侦查→武器化→投递→利用→安装→C&C→目标达成', 1, '系统自动研判'),

-- ==========================================
-- 场景2：高危勒索软件（已研判-尝试攻击）
-- ==========================================
(1002, 'RISK-2026-002', '勒索软件传播尝试', '2002', 'High',
 CURRENT_TIMESTAMP - INTERVAL '12 hours', CURRENT_TIMESTAMP - INTERVAL '11 hours 30 minutes',
 '恶意软件', '勒索软件',
 '192.168.50.1', 'victim', 3, 'processing', 'FAIL',
 'attacker=198.51.100.150&victim=192.168.50.0/24', '[5002]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '12 hours', CURRENT_TIMESTAMP - INTERVAL '11 hours 30 minutes',
 '["勒索软件", "横向传播", "SMB漏洞"]', 1,
 'malware_type="ransomware" AND target_network="192.168.50.0/24"',
 '初始访问→横向移动→防御规避（已拦截）', 2, '威胁情报回连时序研判'),

-- ==========================================
-- 场景3：中危横向移动（正在进行-未研判）
-- ==========================================
(1003, 'RISK-2026-003', '内网横向移动攻击', '2003', 'Medium',
 CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP,
 '横向移动', 'Pass-the-Hash',
 '192.168.20.88', 'attacker', 8, 'unprocessed', 'OK',
 'src_ip=192.168.20.88&target_ip=192.168.30.0/24', '[5003]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '5 minutes',
 '["横向移动", "Pass-the-Hash", "内网渗透"]', 1,
 'src_ip="192.168.20.88" AND lateral_method="pass_the_hash"',
 '初始访问→权限提升→横向移动（进行中）', 0, ''),

-- ==========================================
-- 场景4：低危钓鱼邮件（已研判-无害）
-- ==========================================
(1004, 'RISK-2026-004', '钓鱼邮件攻击', '2004', 'Low',
 CURRENT_TIMESTAMP - INTERVAL '5 days', CURRENT_TIMESTAMP - INTERVAL '5 days',
 '社会工程', '邮件钓鱼',
 '192.168.100.25', 'victim', 1, 'processed', 'FAIL',
 'sender=phishing@evil-domain.com&recipient=192.168.100.25', '[5004]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '5 days', CURRENT_TIMESTAMP - INTERVAL '5 days',
 '["钓鱼邮件", "社会工程", "已拦截"]', 0,
 'phishing_indicators=true AND suspicious_sender=true',
 '初始访问（已阻断）', 3, '人工研判'),

-- ==========================================
-- 场景5：高危数据外泄（未知-待研判）
-- ==========================================
(1005, 'RISK-2026-005', '大规模数据外传', '2005', 'High',
 CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP,
 '数据外泄', '数据窃取',
 '192.168.80.120', 'attacker', 1, 'unprocessed', 'UNKNOWN',
 'src_ip=192.168.80.120&dest_ip=45.xxx.xxx.xxx', '[5005]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP,
 '["数据外泄", "境外传输", "大规模"]', 1,
 'outbound_data_volume>10GB AND destination_is_foreign=true',
 '目标达成？（待确认）', 4, '主动攻击研判'),

-- ==========================================
-- 场景6-10：补充更多测试数据
-- ==========================================
(1006, 'RISK-2026-006', 'SQL注入攻击', '2001', 'Medium',
 CURRENT_TIMESTAMP - INTERVAL '8 hours', CURRENT_TIMESTAMP - INTERVAL '7 hours',
 'Web攻击', 'SQL注入',
 '10.0.0.50', 'victim', 20, 'processing', 'OK',
 'attack_type=sql_injection', '[5001,5002]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '8 hours', CURRENT_TIMESTAMP - INTERVAL '7 hours',
 '["SQL注入", "Web攻击"]', 0,
 NULL, '侦查→初始访问→持久化', 2, '系统自动研判'),

(1007, 'RISK-2026-007', 'DDoS拒绝服务', '2002', 'High',
 CURRENT_TIMESTAMP - INTERVAL '6 hours', CURRENT_TIMESTAMP - INTERVAL '5 hours',
 '拒绝服务', 'DDoS攻击',
 '203.0.113.100', 'attacker', 1000, 'unprocessed', 'OK',
 'attack_type=ddos', '[5003]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '6 hours', CURRENT_TIMESTAMP - INTERVAL '5 hours',
 '["DDoS", "拒绝服务"]', 1,
 'traffic_volume>1000Mbps', '初始访问', 1, '威胁情报回连时序研判'),

(1008, 'RISK-2026-008', '暴力破解攻击', '2003', 'Medium',
 CURRENT_TIMESTAMP - INTERVAL '4 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours',
 '凭证访问', '暴力破解',
 '198.51.100.200', 'attacker', 500, 'processed', 'FAIL',
 'attack_type=brute_force', '[]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '4 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours',
 '["暴力破解", "SSH"]', 0,
 'failed_login_attempts>100', '初始访问（已拦截）', 2, '人工研判'),

(1009, 'RISK-2026-009', '木马植入', '2004', 'High',
 CURRENT_TIMESTAMP - INTERVAL '24 hours', CURRENT_TIMESTAMP - INTERVAL '23 hours',
 '恶意代码', '木马程序',
 '172.16.0.100', 'victim', 1, 'unprocessed', 'OK',
 'malware_detected=true', '[5004,5005]', 'alert',
 CURRENT_TIMESTAMP - INTERVAL '24 hours', CURRENT_TIMESTAMP - INTERVAL '23 hours',
 '["木马", "远程控制"]', 1,
 'malware_hash="abc123def456"', '初始访问→执行→持久化', 1, '系统自动研判'),

(1010, 'RISK-2026-010', '提权攻击', '2005', 'High',
 CURRENT_TIMESTAMP - INTERVAL '48 hours', CURRENT_TIMESTAMP - INTERVAL '47 hours',
 '权限提升', '本地提权',
 '192.168.5.50', 'victim', 2, 'processed', 'OK',
 'privilege_escalation=CVE-2023-1234', '[]', 'incident',
 CURRENT_TIMESTAMP - INTERVAL '48 hours', CURRENT_TIMESTAMP - INTERVAL '47 hours',
 '["提权", "漏洞利用"]', 0,
 'exploit_cve="CVE-2023-1234"', '权限提升', 1, '威胁情报回连时序研判');

SELECT setval('"t_risk_incidents_id_seq"', 1010, true);

-- ==========================================
-- 验证：关联查询测试
-- ==========================================
SELECT 
    ri.id AS "风险事件ID",
    ri.name AS "事件名称",
    te.incident_name AS "事件模板",
    qt.template_name AS "查询模板",
    ri.threat_severity AS "威胁等级",
    ri.alarm_status AS "处置状态",
    CASE ri.judge_result
        WHEN 1 THEN '成功'
        WHEN 2 THEN '尝试'
        WHEN 3 THEN '无害'
        WHEN 4 THEN '未知'
        ELSE '待研判'
    END AS "研判结果",
    TO_CHAR(ri.create_time, 'YYYY-MM-DD HH24:MI:SS') AS "创建时间"
FROM "t_risk_incidents" ri
LEFT JOIN "t_event_template" te ON ri.template_id = te.id::varchar
LEFT JOIN "t_query_template" qt ON ri.event_code LIKE qt.template_code || '%'
WHERE ri.id >= 1001 AND ri.id <= 1010
ORDER BY ri.create_time DESC;

-- ==========================================
-- 统计信息
-- ==========================================
SELECT 
    threat_severity AS "威胁级别",
    COUNT(*) AS "数量",
    SUM(CASE WHEN alarm_status = 'unprocessed' THEN 1 ELSE 0 END) AS "未处置"
FROM "t_risk_incidents"
WHERE id >= 1001 AND id <= 1010
GROUP BY threat_severity
ORDER BY "数量" DESC;
