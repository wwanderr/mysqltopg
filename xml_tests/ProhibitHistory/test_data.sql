-- ============================================
-- 测试数据：ProhibitHistory（封禁历史）
-- 主表：t_prohibit_history
-- 关联表：t_linked_strategy
-- 生成时间：2026-01-26
-- ============================================

-- ==========================================
-- 1. 先插入关联表 t_linked_strategy 数据
-- ==========================================
DELETE FROM "t_linked_strategy" WHERE id >= 5001 AND id <= 5005;

INSERT INTO "t_linked_strategy" (
    "id", "strategy_name", "auto_handle", "threat_type", "threat_type_config",
    "threat_level", "alarm_results", "status", "source", "template_id",
    "create_time", "update_time"
) VALUES 
(5001, '恶意IP自动封禁策略', true, 'alarmType', '/NetworkAttack/BruteForce',
'High,Critical', 'Failed', true, 'auto', 101,
CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP - INTERVAL '10 days'),

(5002, '攻击源手动封禁策略', false, 'alarmType', '/NetworkAttack/PortScan',
'High', 'OK', true, 'manual', 102,
CURRENT_TIMESTAMP - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '15 days'),

(5003, 'IP段批量封禁策略', true, 'securityEvent', '/NetworkAttack/DDoS',
'Critical', 'Failed', true, 'auto', 103,
CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_TIMESTAMP - INTERVAL '20 days'),

(5004, '临时封禁策略（已解除）', true, 'alarmType', '/WebAttack/SQLInjection',
'Medium', 'OK', false, 'auto', 104,
CURRENT_TIMESTAMP - INTERVAL '35 days', CURRENT_TIMESTAMP - INTERVAL '30 days'),

(5005, '扫描源紧急封禁策略', true, 'alarmType', '/Scan/PortScan',
'High', 'Failed', true, 'auto', 105,
CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '1 hour');

SELECT setval('t_linked_strategy_id_seq', (SELECT MAX(id) FROM t_linked_strategy), true);

-- ==========================================
-- 2. 插入主表 t_prohibit_history 数据
-- ==========================================
DELETE FROM "t_prohibit_history" WHERE id >= 1001 AND id <= 1005;

INSERT INTO "t_prohibit_history" (
    "id", "block_ip", "second_ip", "link_device_ip", "link_device_type", "status",
    "device_id", "effect_time", "create_time", "update_time", "source", "create_type",
    "strategy_id", "file_block", "process_block", "nta_name", "launch_times",
    "recovery_id", "direction", "node_ip", "node_id"
) VALUES 

-- ==========================================
-- 场景1：自动封禁的恶意IP（已生效）- 关联策略5001
-- ==========================================
(1001, '203.0.113.100', NULL, '192.168.1.10', 'firewall', true,
'dev_fw_001', '86400', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours',
'auto', 'alarmType', 5001, NULL, NULL, 'firewall-main', 1,
NULL, 1, '192.168.1.10', 'node_fw_01'),

-- ==========================================
-- 场景2：手动封禁的攻击源IP（已生效）- 关联策略5002
-- ==========================================
(1002, '198.51.100.50', NULL, '192.168.1.20', 'ids', true,
'dev_ids_001', '172800', CURRENT_TIMESTAMP - INTERVAL '5 days', CURRENT_TIMESTAMP - INTERVAL '5 days',
'manual', 'manual', 5002, NULL, NULL, 'ids-sensor-01', 1,
NULL, 2, '192.168.1.20', 'node_ids_01'),

-- ==========================================
-- 场景3：IP段封禁（已生效）- 关联策略5003
-- ==========================================
(1003, '10.0.0.0/8', '172.16.0.100', '192.168.1.11', 'firewall', true,
'dev_fw_002', '604800', CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP - INTERVAL '10 days',
'auto', 'securityEvent', 5003, NULL, NULL, 'firewall-backup', 1,
NULL, 3, '192.168.1.11', 'node_fw_02'),

-- ==========================================
-- 场景4：已解除的封禁记录（status=false）- 关联策略5004
-- ==========================================
(1004, '192.0.2.200', NULL, '192.168.1.10', 'firewall', false,
'dev_fw_001', '86400', CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '25 days',
'auto', 'alarmType', 5004, NULL, NULL, 'firewall-main', 1,
'REC-1004', 1, '192.168.1.10', 'node_fw_01'),

-- ==========================================
-- 场景5：最近封禁的扫描源（已生效）- 关联策略5005
-- ==========================================
(1005, '185.220.101.50', NULL, '192.168.1.21', 'ids', true,
'dev_ids_002', '3600', CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP - INTERVAL '30 minutes',
'auto', 'alarmType', 5005, NULL, NULL, 'ids-sensor-02', 1,
NULL, 1, '192.168.1.21', 'node_ids_02');

SELECT setval('t_prohibit_history_id_seq', (SELECT MAX(id) FROM t_prohibit_history), true);

-- ==========================================
-- 验证：关联查询测试
-- ==========================================
SELECT 
    tph.id AS "封禁ID",
    tph.block_ip AS "封禁IP",
    tph.direction AS "方向",
    tls.strategy_name AS "策略名称",
    tls.threat_type AS "威胁类型",
    tls.threat_level AS "威胁等级",
    CASE WHEN tph.status THEN '已生效' ELSE '已解除' END AS "状态",
    CASE WHEN tls.auto_handle THEN '自动' ELSE '手动' END AS "处置方式",
    tph.link_device_type AS "设备类型",
    TO_CHAR(tph.create_time, 'YYYY-MM-DD HH24:MI:SS') AS "创建时间"
FROM "t_prohibit_history" tph
RIGHT JOIN "t_linked_strategy" tls ON tph.strategy_id = tls.id
WHERE tph.id >= 1001 AND tph.id <= 1005
ORDER BY tph.create_time DESC;

-- ==========================================
-- 统计信息
-- ==========================================
SELECT 
    '封禁历史总数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_prohibit_history"
WHERE id >= 1001 AND id <= 1005
UNION ALL
SELECT 
    '关联策略数',
    COUNT(*) 
FROM "t_linked_strategy"
WHERE id >= 5001 AND id <= 5005
UNION ALL
SELECT 
    '生效中的封禁',
    COUNT(*) 
FROM "t_prohibit_history"
WHERE id >= 1001 AND id <= 1005 AND status = true
UNION ALL
SELECT 
    '已解除的封禁',
    COUNT(*) 
FROM "t_prohibit_history"
WHERE id >= 1001 AND id <= 1005 AND status = false;

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

-- 按策略统计
SELECT 
    tls.strategy_name AS "策略名称",
    tls.threat_level AS "威胁等级",
    COUNT(tph.id) AS "封禁次数",
    SUM(CASE WHEN tph.status THEN 1 ELSE 0 END) AS "生效中"
FROM "t_linked_strategy" tls
LEFT JOIN "t_prohibit_history" tph ON tls.id = tph.strategy_id
WHERE tls.id >= 5001 AND tls.id <= 5005
GROUP BY tls.strategy_name, tls.threat_level
ORDER BY "封禁次数" DESC;

-- ==========================================
-- 测试说明
-- ==========================================
-- ✅ getProhibitListByCondition: 查询封禁列表（RIGHT JOIN t_linked_strategy）
-- ✅ listByCondition: 查询封禁历史（RIGHT JOIN t_linked_strategy）
-- ✅ getProhibitListCount: 统计封禁数量（RIGHT JOIN t_linked_strategy）
-- ✅ getStrategyCount: 统计策略使用次数（LEFT JOIN t_linked_strategy）
-- ✅ 所有查询依赖 t_linked_strategy 的关联数据！
--
-- ⚠️ 注意：
-- 1. strategy_id 关联 t_linked_strategy.id
-- 2. RIGHT JOIN 表示以 t_linked_strategy 为主表
-- 3. 策略状态（status）和封禁状态（status）是两个不同的字段
-- 4. 策略的 auto_handle 决定是否自动处置
