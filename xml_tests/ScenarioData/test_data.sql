-- ============================================
-- 测试数据：ScenarioData（场景数据）
-- 主表：t_event_scenario_data (12个字段)
-- 生成时间：2026-01-28（深度修复）
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_event_scenario_data" WHERE id >= 7001 AND id <= 7005;

-- 插入测试数据（完整12个字段）
INSERT INTO "t_event_scenario_data" (
    "id",
    "result",
    "log_session_id",
    "incident_id",
    "scenario_id",
    "event_time",
    "update_time",
    "focus_ip",
    "target_ip",
    "conclusion",
    "trace_graph_version",
    "trace_graph",
    "risk_id"
) VALUES 

-- ==========================================
-- 场景1：APT攻击溯源完成
-- ==========================================
(
    7001,
    '{"status": "success", "confidence": 0.95, "attack_chain": ["reconnaissance", "initial_access", "execution", "persistence", "exfiltration"]}',
    'LOG-SESSION-2026-001',
    1001,
    101,
    '2026-01-28',
    CURRENT_TIMESTAMP,
    '192.168.10.50',
    '192.168.10.100',
    'APT攻击者通过鱼叉式钓鱼邮件获取初始访问权限，后续建立持久化机制并窃取敏感数据',
    'v2.1.0',
    '{"nodes": [{"id": "N1", "type": "attacker", "ip": "203.0.113.88"}, {"id": "N2", "type": "victim", "ip": "192.168.10.50"}], "edges": [{"from": "N1", "to": "N2", "action": "phishing"}]}',
    1001
),

-- ==========================================
-- 场景2：勒索软件溯源进行中
-- ==========================================
(
    7002,
    '{"status": "in_progress", "confidence": 0.80, "attack_chain": ["initial_access", "lateral_movement"]}',
    'LOG-SESSION-2026-002',
    1002,
    102,
    '2026-01-28',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    '192.168.20.100',
    '192.168.20.200',
    '勒索软件通过SMB漏洞进行横向移动，正在分析加密行为',
    'v2.1.0',
    '{"nodes": [{"id": "N1", "type": "malware", "name": "WannaCry"}, {"id": "N2", "type": "victim", "ip": "192.168.20.100"}], "edges": [{"from": "N1", "to": "N2", "action": "exploit"}]}',
    1002
),

-- ==========================================
-- 场景3：内网横向移动溯源
-- ==========================================
(
    7003,
    '{"status": "success", "confidence": 0.75, "attack_chain": ["lateral_movement", "privilege_escalation"]}',
    'LOG-SESSION-2026-003',
    1003,
    103,
    '2026-01-27',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    '192.168.30.50',
    '192.168.30.100',
    '攻击者从被控主机通过Pass-the-Hash技术进行横向移动，已成功提权',
    'v2.0.5',
    '{"nodes": [{"id": "N1", "type": "attacker", "ip": "192.168.30.50"}, {"id": "N2", "type": "target", "ip": "192.168.30.100"}], "edges": [{"from": "N1", "to": "N2", "action": "pth"}]}',
    1003
),

-- ==========================================
-- 场景4：数据外泄溯源失败
-- ==========================================
(
    7004,
    '{"status": "failed", "confidence": 0.30, "error": "insufficient_logs", "attack_chain": []}',
    'LOG-SESSION-2026-004',
    1004,
    104,
    '2026-01-26',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    '192.168.40.80',
    '45.xxx.xxx.xxx',
    '日志不足，无法完成完整溯源',
    'v2.1.0',
    '{}',
    NULL
),

-- ==========================================
-- 场景5：Web攻击溯源完成
-- ==========================================
(
    7005,
    '{"status": "success", "confidence": 0.90, "attack_chain": ["reconnaissance", "exploitation", "command_execution"]}',
    'LOG-SESSION-2026-005',
    1005,
    105,
    '2026-01-28',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    '198.51.100.100',
    '192.168.50.10',
    'SQL注入攻击成功，攻击者执行了数据库查询并尝试下载数据',
    'v2.1.0',
    '{"nodes": [{"id": "N1", "type": "attacker", "ip": "198.51.100.100"}, {"id": "N2", "type": "web_server", "ip": "192.168.50.10"}, {"id": "N3", "type": "database"}], "edges": [{"from": "N1", "to": "N2", "action": "sql_injection"}, {"from": "N2", "to": "N3", "action": "query"}]}',
    1005
);

SELECT setval('"t_event_scenario_data_id_seq"', 7005, true);

-- ==========================================
-- 验证：按溯源状态统计
-- ==========================================
SELECT 
    result::json->>'status' AS "溯源状态",
    COUNT(*) AS "数量",
    AVG((result::json->>'confidence')::numeric) AS "平均置信度"
FROM "t_event_scenario_data"
WHERE id >= 7001 AND id <= 7005
GROUP BY result::json->>'status'
ORDER BY "数量" DESC;

-- ==========================================
-- 验证：按事件日期统计
-- ==========================================
SELECT 
    event_time AS "事件日期",
    COUNT(*) AS "溯源数量"
FROM "t_event_scenario_data"
WHERE id >= 7001 AND id <= 7005
GROUP BY event_time
ORDER BY event_time DESC;
