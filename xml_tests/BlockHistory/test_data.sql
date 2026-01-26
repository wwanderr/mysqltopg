-- ============================================
-- 测试数据：BlockHistory（封堵历史）
-- 表：t_block_history
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_block_history" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_block_history" (
    "id",
    "block_ip",
    "block_type",
    "block_reason",
    "block_method",
    "device_ip",
    "device_type",
    "block_status",
    "block_start_time",
    "block_end_time",
    "operator",
    "auto_block",
    "associated_event_id",
    "create_time",
    "update_time"
) VALUES 

-- ==========================================
-- 场景1：自动封堵DDoS攻击源（进行中）
-- ==========================================
(
    1001,
    '203.0.113.100',
    'source_ip',
    'DDoS攻击，峰值流量5Gbps',
    'firewall_block',
    '192.168.1.10',
    'firewall',
    'active',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP + INTERVAL '22 hours',  -- 24小时封堵
    'system',
    true,
    '1001',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours'
),

-- ==========================================
-- 场景2：手动封堵APT攻击源（已解封）
-- ==========================================
(
    1002,
    '198.51.100.50',
    'source_ip',
    '高级持续性威胁(APT)攻击，已完成应急响应',
    'acl_block',
    '192.168.1.10',
    'firewall',
    'released',
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    'admin',
    false,
    '1002',
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
),

-- ==========================================
-- 场景3：封堵恶意域名（进行中）
-- ==========================================
(
    1003,
    'malware-c2.evil.com',
    'domain',
    '恶意软件C&C通信域名',
    'dns_block',
    '192.168.1.100',
    'dns_server',
    'active',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP + INTERVAL '29 days',  -- 30天封堵
    'system',
    true,
    '1003',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
),

-- ==========================================
-- 场景4：封堵IP段（扫描源）
-- ==========================================
(
    1004,
    '185.220.101.0/24',
    'ip_range',
    '大规模端口扫描活动',
    'firewall_block',
    '192.168.1.10',
    'firewall',
    'active',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP + INTERVAL '12 hours',  -- 24小时封堵
    'security_analyst',
    false,
    '1004',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '10 hours'
),

-- ==========================================
-- 场景5：封堵失败记录
-- ==========================================
(
    1005,
    '192.0.2.88',
    'source_ip',
    '勒索软件传播源',
    'firewall_block',
    '192.168.1.11',
    'firewall',
    'failed',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    NULL,
    'system',
    true,
    '1005',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours'
);

-- 重置序列
SELECT setval('"t_block_history_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    block_ip,
    block_type,
    block_reason,
    device_type,
    block_status AS "状态",
    CASE WHEN auto_block THEN '自动' ELSE '手动' END AS "封堵方式",
    operator AS "操作人"
FROM "t_block_history"
WHERE id >= 1001 AND id <= 1005
ORDER BY create_time DESC;
