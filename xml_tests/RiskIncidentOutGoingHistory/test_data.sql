-- ============================================
-- 测试数据：RiskIncidentOutGoingHistory（风险事件外发历史）
-- 主表：t_risk_incidents_out_going_history (26个字段)
-- 生成时间：2026-01-28（深度修复）
-- ============================================

DELETE FROM "t_risk_incidents_out_going_history" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据（完整26个字段）
INSERT INTO "t_risk_incidents_out_going_history" (
    "id",
    "event_id",
    "uniq_code",
    "event_code",
    "security_incident_id",
    "name",
    "template_id",
    "start_time",
    "end_time",
    "top_event_type_chinese",
    "second_event_type_chinese",
    "src_geo_region",
    "security_zone",
    "device_address",
    "device_send_product_name",
    "send_host_address",
    "machine_code",
    "rule_type",
    "focus_ip",
    "attacker",
    "victim",
    "severity",
    "cat_outcome",
    "payload",
    "more_field",
    "time_part"
) VALUES 

-- ==========================================
-- 场景1：APT攻击外发历史（第1次外发成功）
-- ==========================================
(
    1001,
    10001,
    '20260128-apt-v1.0-192.168.10.50-history-001',
    'RISK-2026-001',
    1001,
    'APT高级持续威胁攻击',
    'APT_ATTACK',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days 12 hours',
    '高级威胁',
    'APT攻击',
    '美国',
    '互联网区',
    '192.168.100.100',
    'XDR安全平台',
    '10.20.30.40',
    'XDR-MACHINE-001',
    '高级威胁/APT攻击',
    '192.168.10.50',
    '203.0.113.88',
    '192.168.10.50',
    '7',
    'OK',
    '{"batch": 1, "send_time": "2026-01-25 10:00:00", "target": "primary_siem"}',
    '{"send_status": "success", "retry_count": 0, "response_code": 200}',
    CURRENT_TIMESTAMP - INTERVAL '3 days'
),

-- ==========================================
-- 场景2：勒索软件外发历史（第1次外发失败）
-- ==========================================
(
    1002,
    10002,
    '20260128-ransomware-v1.0-192.168.50.1-history-001',
    'RISK-2026-002',
    1002,
    '勒索软件横向传播',
    'RANSOMWARE',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '11 hours 30 minutes',
    '恶意软件',
    '勒索软件',
    '中国',
    'DMZ区',
    '192.168.100.100',
    'XDR安全平台',
    '10.20.30.40',
    'XDR-MACHINE-001',
    '恶意软件/勒索软件',
    '192.168.50.1',
    '198.51.100.150',
    '192.168.50.0/24',
    '7',
    'Attempt',
    '{"batch": 1, "send_time": "2026-01-28 00:00:00", "error": "Connection timeout"}',
    '{"send_status": "failed", "retry_count": 1, "error_msg": "Connection timeout after 30s"}',
    CURRENT_TIMESTAMP - INTERVAL '12 hours'
),

-- ==========================================
-- 场景3：勒索软件外发历史（第2次外发失败）
-- ==========================================
(
    1003,
    10002,
    '20260128-ransomware-v1.0-192.168.50.1-history-002',
    'RISK-2026-002',
    1002,
    '勒索软件横向传播',
    'RANSOMWARE',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '11 hours 30 minutes',
    '恶意软件',
    '勒索软件',
    '中国',
    'DMZ区',
    '192.168.100.100',
    'XDR安全平台',
    '10.20.30.40',
    'XDR-MACHINE-001',
    '恶意软件/勒索软件',
    '192.168.50.1',
    '198.51.100.150',
    '192.168.50.0/24',
    '7',
    'Attempt',
    '{"batch": 2, "send_time": "2026-01-28 00:30:00", "error": "Connection timeout"}',
    '{"send_status": "failed", "retry_count": 2, "error_msg": "Connection timeout after 30s"}',
    CURRENT_TIMESTAMP - INTERVAL '11 hours 30 minutes'
),

-- ==========================================
-- 场景4：勒索软件外发历史（第3次外发成功）
-- ==========================================
(
    1004,
    10002,
    '20260128-ransomware-v1.0-192.168.50.1-history-003',
    'RISK-2026-002',
    1002,
    '勒索软件横向传播',
    'RANSOMWARE',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '11 hours 30 minutes',
    '恶意软件',
    '勒索软件',
    '中国',
    'DMZ区',
    '192.168.100.100',
    'XDR安全平台',
    '10.20.30.40',
    'XDR-MACHINE-001',
    '恶意软件/勒索软件',
    '192.168.50.1',
    '198.51.100.150',
    '192.168.50.0/24',
    '7',
    'OK',
    '{"batch": 3, "send_time": "2026-01-28 01:00:00", "target": "backup_siem"}',
    '{"send_status": "success", "retry_count": 3, "response_code": 200}',
    CURRENT_TIMESTAMP - INTERVAL '11 hours'
),

-- ==========================================
-- 场景5：横向移动外发历史（第1次外发成功）
-- ==========================================
(
    1005,
    10003,
    '20260128-lateral-v1.0-192.168.20.88-history-001',
    'RISK-2026-003',
    1003,
    '内网横向移动攻击',
    'LATERAL_MOVEMENT',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP,
    '横向移动',
    'Pass-the-Hash',
    '中国',
    '内网核心区',
    '192.168.100.100',
    'XDR安全平台',
    '10.20.30.40',
    'XDR-MACHINE-001',
    '横向移动/Pass-the-Hash',
    '192.168.20.88',
    '192.168.20.88',
    '192.168.30.0/24',
    '6',
    'OK',
    '{"batch": 1, "send_time": "2026-01-28 10:00:00", "target": "primary_siem"}',
    '{"send_status": "success", "retry_count": 0, "response_code": 200, "movement_path": ["192.168.20.88", "192.168.30.50"]}',
    CURRENT_TIMESTAMP - INTERVAL '2 hours'
);

SELECT setval('t_risk_incidents_out_going_history_id_seq', (SELECT MAX(id) FROM t_risk_incidents_out_going_history), true);

-- ==========================================
-- 验证：按cat_outcome统计
-- ==========================================
SELECT 
    cat_outcome AS "外发结果",
    COUNT(*) AS "数量"
FROM "t_risk_incidents_out_going_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY cat_outcome
ORDER BY cat_outcome;

-- ==========================================
-- 验证：按event_id统计重试次数
-- ==========================================
SELECT 
    event_id AS "事件ID",
    name AS "事件名称",
    COUNT(*) AS "外发次数",
    SUM(CASE WHEN cat_outcome = 'OK' THEN 1 ELSE 0 END) AS "成功次数",
    SUM(CASE WHEN cat_outcome != 'OK' THEN 1 ELSE 0 END) AS "失败次数"
FROM "t_risk_incidents_out_going_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY event_id, name
ORDER BY event_id;
