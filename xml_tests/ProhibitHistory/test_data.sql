-- ============================================
-- 测试数据：ProhibitHistory（封禁历史）
-- 表：t_prohibit_history
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_prohibit_history" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_prohibit_history" (
    "id",
    "block_ip",
    "second_ip",
    "direction",
    "node_id",
    "node_ip",
    "nta_name",
    "create_time",
    "update_time",
    "strategy_id",
    "link_device_ip",
    "link_device_type",
    "status",
    "device_id",
    "effect_time",
    "create_type",
    "action_id",
    "source"
) VALUES 

-- ==========================================
-- 场景1：自动封禁的恶意IP（已生效）
-- ==========================================
(
    1001,
    '203.0.113.100',  -- 封禁的恶意IP
    NULL,
    'INPUT',  -- 入站方向
    'node_fw_01',
    '192.168.1.10',  -- 防火墙节点IP
    'firewall-main',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    5001,  -- 策略ID
    '192.168.1.10',
    'firewall',
    true,  -- 已生效
    'dev_fw_001',
    '86400',  -- 24小时
    'alarmType',  -- 告警触发
    'action_20260126001',
    'auto'  -- 自动封禁
),

-- ==========================================
-- 场景2：手动封禁的攻击源IP（已生效）
-- ==========================================
(
    1002,
    '198.51.100.50',
    NULL,
    'OUTPUT',  -- 出站方向
    'node_ids_01',
    '192.168.1.20',  -- IDS节点IP
    'ids-sensor-01',
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    5002,
    '192.168.1.20',
    'ids',
    true,
    'dev_ids_001',
    '172800',  -- 48小时
    'manual',  -- 手动封禁
    'action_20260121001',
    'manual'
),

-- ==========================================
-- 场景3：IP段封禁（已生效）
-- ==========================================
(
    1003,
    '10.0.0.0/8',  -- 封禁整个IP段
    '172.16.0.100',  -- 第二IP
    'FORWARD',  -- 转发方向
    'node_fw_02',
    '192.168.1.11',
    'firewall-backup',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    5003,
    '192.168.1.11',
    'firewall',
    true,
    'dev_fw_002',
    '604800',  -- 7天
    'securityEvent',  -- 安全事件触发
    'action_20260116001',
    'auto'
),

-- ==========================================
-- 场景4：已解除的封禁记录（status=false）
-- ==========================================
(
    1004,
    '192.0.2.200',
    NULL,
    'INPUT',
    'node_fw_01',
    '192.168.1.10',
    'firewall-main',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '25 days',
    5004,
    '192.168.1.10',
    'firewall',
    false,  -- 已解除
    'dev_fw_001',
    '86400',
    'alarmType',
    'action_20251227001',
    'auto'
),

-- ==========================================
-- 场景5：最近封禁的扫描源（已生效）
-- ==========================================
(
    1005,
    '185.220.101.50',  -- 已知扫描器IP
    NULL,
    'INPUT',
    'node_ids_02',
    '192.168.1.21',
    'ids-sensor-02',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    5005,
    '192.168.1.21',
    'ids',
    true,
    'dev_ids_002',
    '3600',  -- 1小时
    'alarmType',
    'action_20260126002',
    'auto'
);

-- 重置序列
SELECT setval('"t_prohibit_history_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    block_ip,
    direction,
    CASE WHEN status THEN '已生效' ELSE '已解除' END AS status_text,
    link_device_type,
    create_type,
    source,
    AGE(CURRENT_TIMESTAMP, create_time) AS blocked_duration
FROM "t_prohibit_history"
WHERE id >= 1001 AND id <= 1005
ORDER BY create_time DESC;

-- 按设备类型统计
SELECT 
    link_device_type AS "设备类型",
    COUNT(*) AS "封禁数量",
    SUM(CASE WHEN status THEN 1 ELSE 0 END) AS "生效中",
    SUM(CASE WHEN NOT status THEN 1 ELSE 0 END) AS "已解除"
FROM "t_prohibit_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY link_device_type
ORDER BY "封禁数量" DESC;

-- 按创建方式统计
SELECT 
    create_type AS "创建方式",
    COUNT(*) AS "数量"
FROM "t_prohibit_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY create_type
ORDER BY "数量" DESC;
