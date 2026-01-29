-- ============================================
-- 测试数据：ScenarioTemplate（场景模板）
-- 主表：t_event_scenario_template (15个字段)
-- 生成时间：2026-01-28（深度修复）
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_event_scenario_template" WHERE id >= 8001 AND id <= 8005;

-- 插入测试数据（完整15个字段）
INSERT INTO "t_event_scenario_template" (
    "id",
    "scenario_name",
    "scenario_code",
    "source",
    "request_url",
    "condition",
    "event_name",
    "parameter",
    "result",
    "executor_class_name",
    "drill_down",
    "update_time",
    "conclusion",
    "log_aiql",
    "alarm_aiql"
) VALUES 

-- ==========================================
-- 场景1：APT攻击场景（可下钻）
-- ==========================================
(
    8001,
    'APT高级持续威胁检测',
    'APT_ATTACK',
    'system',
    '/api/scenario/apt/analyze',
    '{"severity": ["high", "critical"], "attack_stages": ["reconnaissance", "initial_access", "execution", "persistence", "exfiltration"]}',
    'APT攻击事件',
    '{"focus_ip": "target_ip", "time_range": "7d", "min_confidence": 0.8}',
    '{"status": "success", "confidence": 0.95, "threat_actor": "APT-28"}',
    'com.dbapp.extension.xdr.scenario.executor.AptAttackExecutor',
    1,
    CURRENT_TIMESTAMP,
    '检测到APT组织的高级持续威胁攻击，建议立即隔离受影响系统并进行深度溯源',
    'category="security_incident" AND sub_category="apt_attack" AND threat_severity="high"',
    'alarm_type="apt_detection" AND alarm_level IN ("high", "critical")'
),

-- ==========================================
-- 场景2：勒索软件场景（可下钻）
-- ==========================================
(
    8002,
    '勒索软件横向传播检测',
    'RANSOMWARE_PROPAGATION',
    'system',
    '/api/scenario/ransomware/trace',
    '{"malware_type": "ransomware", "propagation_method": ["smb", "rdp", "email"]}',
    '勒索软件传播事件',
    '{"victim_ip": "target_ip", "attacker_ip": "src_ip", "time_window": "24h"}',
    '{"status": "success", "infected_hosts": 5, "blocked": true}',
    'com.dbapp.extension.xdr.scenario.executor.RansomwareExecutor',
    1,
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    '检测到勒索软件通过SMB漏洞进行横向传播，已成功拦截',
    'category="malware" AND malware_type="ransomware"',
    'alarm_type="ransomware_detection" AND propagation="lateral_movement"'
),

-- ==========================================
-- 场景3：内网横向移动（可下钻）
-- ==========================================
(
    8003,
    '内网横向移动路径分析',
    'LATERAL_MOVEMENT',
    'custom',
    '/api/scenario/lateral/analyze',
    '{"attack_method": ["pass_the_hash", "rdp", "smb"], "target_type": ["server", "workstation"]}',
    '横向移动攻击事件',
    '{"source_ip": "attacker_ip", "target_network": "192.168.0.0/16", "time_range": "12h"}',
    '{"status": "success", "movement_path": ["192.168.1.100", "192.168.1.200", "192.168.2.50"], "compromised_hosts": 3}',
    'com.dbapp.extension.xdr.scenario.executor.LateralMovementExecutor',
    1,
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    '攻击者通过Pass-the-Hash技术从被控主机向核心网段进行横向移动',
    'category="lateral_movement" AND method IN ("pth", "rdp", "smb")',
    'alarm_type="lateral_movement" AND target_type IN ("server", "workstation")'
),

-- ==========================================
-- 场景4：数据外泄（不可下钻）
-- ==========================================
(
    8004,
    '敏感数据外泄检测',
    'DATA_EXFILTRATION',
    'system',
    '/api/scenario/exfiltration/detect',
    '{"data_volume_threshold": "1GB", "destination": "external", "protocols": ["https", "ftp", "dns"]}',
    '数据外泄事件',
    '{"src_ip": "internal_host", "dest_ip": "external_ip", "data_volume": "data_size", "time_range": "1h"}',
    '{"status": "alert", "data_volume": "5.2GB", "data_type": "confidential", "blocked": false}',
    'com.dbapp.extension.xdr.scenario.executor.DataExfiltrationExecutor',
    0,
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    '检测到内网主机向境外IP传输大量敏感数据，建议立即阻断',
    'category="data_exfiltration" AND data_volume>"1GB" AND destination_type="external"',
    'alarm_type="data_leak" AND severity="high"'
),

-- ==========================================
-- 场景5：C&C通信检测（可下钻）
-- ==========================================
(
    8005,
    'C&C服务器通信检测',
    'C2_COMMUNICATION',
    'system',
    '/api/scenario/c2/identify',
    '{"ioc_sources": ["threat_intel", "sandbox"], "protocols": ["http", "https", "dns"], "communication_pattern": "periodic"}',
    'C&C通信事件',
    '{"infected_ip": "victim_ip", "c2_ip": "attacker_ip", "protocol": "communication_protocol", "time_range": "24h"}',
    '{"status": "confirmed", "c2_server": "198.51.100.100", "malware_family": "Cobalt Strike", "communication_frequency": "every_5min"}',
    'com.dbapp.extension.xdr.scenario.executor.C2CommunicationExecutor',
    1,
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    '检测到受感染主机与已知C&C服务器建立周期性通信，疑似Cobalt Strike木马',
    'category="c2_communication" AND ioc_matched=true',
    'alarm_type="c2_beacon" AND malware_family="cobalt_strike"'
);

SELECT setval('"t_event_scenario_template_id_seq"', 8005, true);

-- ==========================================
-- 验证：按数据源统计
-- ==========================================
SELECT 
    source AS "数据源",
    COUNT(*) AS "场景数量",
    SUM(CASE WHEN drill_down = 1 THEN 1 ELSE 0 END) AS "可下钻数量"
FROM "t_event_scenario_template"
WHERE id >= 8001 AND id <= 8005
GROUP BY source
ORDER BY source;

-- ==========================================
-- 验证：场景列表
-- ==========================================
SELECT 
    id AS "ID",
    scenario_name AS "场景名称",
    scenario_code AS "场景代码",
    CASE drill_down 
        WHEN 1 THEN '可下钻'
        ELSE '不可下钻'
    END AS "下钻能力"
FROM "t_event_scenario_template"
WHERE id >= 8001 AND id <= 8005
ORDER BY id;
