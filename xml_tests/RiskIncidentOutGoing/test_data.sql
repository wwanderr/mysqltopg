-- ============================================
-- 测试数据：RiskIncidentOutGoing（风险事件外发）
-- 主表：t_risk_incidents_out_going
-- 关联表：t_risk_incidents
-- 生成时间：2026-01-26
-- ============================================

-- ==========================================
-- 注意：关联表 t_risk_incidents 的数据已在 RiskIncident 模块中创建
-- 使用 event_code 关联：RISK-2026-001 到 RISK-2026-005
-- ==========================================

-- ==========================================
-- 插入主表 t_risk_incidents_out_going 数据
-- ==========================================
DELETE FROM "t_risk_incidents_out_going" WHERE id >= 1001 AND id <= 1005;

INSERT INTO "t_risk_incidents_out_going" (
    "id", "uniq_code", "event_code", "security_incident_id", "name",
    "template_id", "start_time", "end_time",
    "top_event_type_chinese", "second_event_type_chinese",
    "device_address", "device_send_product_name", "send_host_address",
    "machine_code", "rule_type", "focus_ip", "attacker", "victim",
    "severity", "cat_outcome", "payload", "more_field",
    "time_part", "kill_chain", "is_scenario"
) VALUES 

-- ==========================================
-- 场景1：APT攻击外发记录 - 关联 RISK-2026-001
-- ==========================================
(1001, '20260126-alert-APT_ATTACK-v1.0-192.168.10.50', 'RISK-2026-001', 1001,
'高级持续性威胁(APT)攻击', 'APT_ATTACK',
CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '2 days 12 hours',
'高级威胁', 'APT攻击',
'192.168.100.100', 'XDR安全平台', '10.20.30.40',
'XDR-MACHINE-001', '高级威胁/APT攻击', '192.168.10.50',
'203.0.113.88', '192.168.10.50',
'7', 'OK', '{"子事件1":"侦查","子事件2":"武器化","子事件3":"投递"}',
'{"affected_assets":["192.168.10.50"],"data_exfiltrated":"5.2GB"}',
CURRENT_TIMESTAMP - INTERVAL '3 days', '侦查→武器化→投递→利用→安装→C&C→目标达成', 1),

-- ==========================================
-- 场景2：勒索软件外发记录 - 关联 RISK-2026-002
-- ==========================================
(1002, '20260126-alert-RANSOMWARE-v1.0-192.168.50.1', 'RISK-2026-002', 1002,
'勒索软件传播尝试', 'RANSOMWARE',
CURRENT_TIMESTAMP - INTERVAL '12 hours', CURRENT_TIMESTAMP - INTERVAL '11 hours 30 minutes',
'恶意软件', '勒索软件',
'192.168.100.100', 'XDR安全平台', '10.20.30.40',
'XDR-MACHINE-001', '恶意软件/勒索软件', '192.168.50.1',
'198.51.100.150', '192.168.50.0/24',
'7', 'Attempt', '{"子事件1":"SMB漏洞利用","子事件2":"文件加密尝试"}',
'{"blocked_hosts":["192.168.50.10","192.168.50.20","192.168.50.30"],"malware_variant":"WannaCry2.0"}',
CURRENT_TIMESTAMP - INTERVAL '12 hours', '初始访问→横向移动→防御规避（已拦截）', 1),

-- ==========================================
-- 场景3：横向移动外发记录 - 关联 RISK-2026-003
-- ==========================================
(1003, '20260126-alert-LATERAL_MOVEMENT-v1.0-192.168.20.88', 'RISK-2026-003', 1003,
'内网横向移动攻击', 'LATERAL_MOVEMENT',
CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP,
'横向移动', 'Pass-the-Hash',
'192.168.100.100', 'XDR安全平台', '10.20.30.40',
'XDR-MACHINE-001', '横向移动/Pass-the-Hash', '192.168.20.88',
'192.168.20.88', '192.168.30.0/24',
'6', 'OK', '{"子事件1":"凭证窃取","子事件2":"横向移动","子事件3":"权限提升"}',
'{"compromised_hosts":2,"target_count":8,"method":"pass_the_hash"}',
CURRENT_TIMESTAMP - INTERVAL '2 hours', '初始访问→权限提升→横向移动（进行中）', 1),

-- ==========================================
-- 场景4：钓鱼邮件外发记录 - 关联 RISK-2026-004
-- ==========================================
(1004, '20260126-alert-PHISHING_EMAIL-v1.0-192.168.100.25', 'RISK-2026-004', 1004,
'钓鱼邮件攻击', 'PHISHING_EMAIL',
CURRENT_TIMESTAMP - INTERVAL '5 days', CURRENT_TIMESTAMP - INTERVAL '5 days',
'社会工程', '邮件钓鱼',
'192.168.100.100', 'XDR安全平台', '10.20.30.40',
'XDR-MACHINE-001', '社会工程/邮件钓鱼', '192.168.100.25',
'phishing@evil-domain.com', '192.168.100.25',
'3', 'FAIL', '{"子事件1":"钓鱼邮件发送","子事件2":"收件人未点击"}',
'{"email_quarantined":true,"link_clicked":false}',
CURRENT_TIMESTAMP - INTERVAL '5 days', '初始访问（已阻断）', 0),

-- ==========================================
-- 场景5：数据外泄外发记录 - 关联 RISK-2026-005
-- ==========================================
(1005, '20260126-alert-DATA_EXFILTRATION-v1.0-192.168.80.120', 'RISK-2026-005', 1005,
'大规模数据外传', 'DATA_EXFILTRATION',
CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP,
'数据外泄', '大规模传输',
'192.168.100.100', 'XDR安全平台', '10.20.30.40',
'XDR-MACHINE-001', '数据外泄/大规模传输', '192.168.80.120',
'192.168.80.120', '45.xxx.xxx.xxx',
'6', 'OK', '{"子事件1":"建立外连","子事件2":"大量数据传输"}',
'{"data_volume":"15GB","destination_country":"unknown","protocol":"HTTPS"}',
CURRENT_TIMESTAMP - INTERVAL '1 hour', '目标达成？（待确认）', 1);

SELECT setval('t_risk_incidents_out_going_id_seq', (SELECT MAX(id) FROM t_risk_incidents_out_going), true);

-- ==========================================
-- 验证：关联查询测试
-- ==========================================
SELECT 
    t.id AS "外发ID",
    t.name AS "事件名称",
    t.event_code AS "事件Code",
    tt.event_name AS "关联风险事件",
    tt.threat_severity AS "威胁等级",
    t.severity AS "外发威胁等级",
    t.cat_outcome AS "事件结果",
    tt.alarm_status AS "处置状态",
    TO_CHAR(t.start_time, 'YYYY-MM-DD HH24:MI:SS') AS "开始时间"
FROM "t_risk_incidents_out_going" t
LEFT JOIN "t_risk_incidents" tt ON t.event_code = tt.event_code
WHERE t.id >= 1001 AND t.id <= 1005
ORDER BY t.start_time DESC;

-- ==========================================
-- 统计信息
-- ==========================================
SELECT 
    '外发记录总数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_risk_incidents_out_going"
WHERE id >= 1001 AND id <= 1005
UNION ALL
SELECT 
    '关联风险事件数',
    COUNT(DISTINCT tt.id) 
FROM "t_risk_incidents_out_going" t
LEFT JOIN "t_risk_incidents" tt ON t.event_code = tt.event_code
WHERE t.id >= 1001 AND t.id <= 1005
UNION ALL
SELECT 
    '成功外发数',
    COUNT(*) 
FROM "t_risk_incidents_out_going"
WHERE id >= 1001 AND id <= 1005 AND cat_outcome = 'OK';

-- 按事件结果统计
SELECT 
    cat_outcome AS "事件结果",
    COUNT(*) AS "数量",
    STRING_AGG(DISTINCT rule_type, ', ') AS "规则类型"
FROM "t_risk_incidents_out_going"
WHERE id >= 1001 AND id <= 1005
GROUP BY cat_outcome
ORDER BY "数量" DESC;

-- 按威胁等级统计
SELECT 
    CASE severity
        WHEN '7' THEN '高危'
        WHEN '6' THEN '中危'
        WHEN '3' THEN '低危'
        ELSE '未知'
    END AS "威胁等级",
    COUNT(*) AS "数量"
FROM "t_risk_incidents_out_going"
WHERE id >= 1001 AND id <= 1005
GROUP BY severity
ORDER BY severity DESC;

-- ==========================================
-- 测试说明
-- ==========================================
-- ✅ queryListByTime: 查询指定时间范围的外发记录（LEFT JOIN t_risk_incidents）
-- ✅ 关联字段：t.event_code = tt.event_code
-- ✅ 所有外发记录都关联到 RiskIncident 模块的测试数据！
--
-- ⚠️ 注意：
-- 1. event_code 关联 t_risk_incidents.event_code
-- 2. severity: 7=高危, 6=中危, 3=低危
-- 3. cat_outcome: OK=成功, Attempt=尝试, FAIL=失败
-- 4. is_scenario: 1=关联场景, 0=未关联
-- 5. payload: 子事件描述（JSON格式）
