-- ============================================
-- 测试数据：Intelligence（威胁情报订阅）
-- 表：t_intelligence
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_intelligence" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_intelligence" (
    "id",
    "threat_ip",
    "threat_type",
    "threat_level",
    "source",
    "description",
    "first_seen",
    "last_seen",
    "confidence",
    "status",
    "tags",
    "create_time",
    "update_time"
) VALUES 

-- ==========================================
-- 场景1：僵尸网络C&C服务器（高置信度）
-- ==========================================
(
    1001,
    '203.0.113.50',
    'botnet_c2',
    'critical',
    'ThreatIntel_Feed_A',
    '已知僵尸网络C&C服务器，控制超过5000台被感染主机',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    95,  -- 95%置信度
    'active',
    '{"tags": ["botnet", "c2", "malware", "high_risk"]}',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
),

-- ==========================================
-- 场景2：钓鱼网站域名（中等置信度）
-- ==========================================
(
    1002,
    'evil-phishing-site.com',
    'phishing',
    'high',
    'ThreatIntel_Feed_B',
    '模仿知名银行的钓鱼网站，窃取用户凭证',
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    75,  -- 75%置信度
    'active',
    '{"tags": ["phishing", "credential_theft", "banking"]}',
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    CURRENT_TIMESTAMP - INTERVAL '3 hours'
),

-- ==========================================
-- 场景3：恶意软件下载站点（已失效）
-- ==========================================
(
    1003,
    '198.51.100.88',
    'malware_distribution',
    'medium',
    'ThreatIntel_Feed_C',
    '曾用于分发勒索软件，目前已下线',
    CURRENT_TIMESTAMP - INTERVAL '90 days',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    60,  -- 60%置信度
    'inactive',
    '{"tags": ["malware", "ransomware", "distribution", "inactive"]}',
    CURRENT_TIMESTAMP - INTERVAL '90 days',
    CURRENT_TIMESTAMP - INTERVAL '30 days'
),

-- ==========================================
-- 场景4：扫描器IP（低风险，活跃）
-- ==========================================
(
    1004,
    '185.220.101.10',
    'scanner',
    'low',
    'ThreatIntel_Feed_D',
    '自动化扫描器，寻找开放端口和漏洞',
    CURRENT_TIMESTAMP - INTERVAL '365 days',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes',
    85,  -- 85%置信度
    'active',
    '{"tags": ["scanner", "reconnaissance", "automated"]}',
    CURRENT_TIMESTAMP - INTERVAL '365 days',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes'
),

-- ==========================================
-- 场景5：APT组织基础设施（极高风险）
-- ==========================================
(
    1005,
    '192.0.2.200',
    'apt_infrastructure',
    'critical',
    'ThreatIntel_Feed_Premium',
    '某APT组织使用的攻击基础设施，与多起数据泄露事件相关',
    CURRENT_TIMESTAMP - INTERVAL '180 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    98,  -- 98%置信度
    'active',
    '{"tags": ["apt", "targeted_attack", "data_exfiltration", "critical"]}',
    CURRENT_TIMESTAMP - INTERVAL '180 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days'
);

-- 重置序列
SELECT setval('"t_intelligence_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    threat_ip,
    threat_type,
    threat_level,
    source,
    confidence AS "置信度%",
    status AS "状态",
    EXTRACT(DAY FROM (CURRENT_TIMESTAMP - last_seen)) AS "最后出现天数前"
FROM "t_intelligence"
WHERE id >= 1001 AND id <= 1005
ORDER BY threat_level DESC, confidence DESC;
