-- ================================================================
-- 测试数据：LinkedStrategyValidtime（联动策略有效期）
-- 主表: t_linkage_strategy_validtime (8字段)
-- 关联表: t_prohibit_history, t_prohibit_domain_history
-- 生成时间: 2026-01-28（深度修复）
-- ================================================================

-- 清理测试数据
DELETE FROM "t_linkage_strategy_validtime" 
WHERE link_device_ip IN ('192.168.1.101', '192.168.1.102', '192.168.1.103', '192.168.1.104', '192.168.1.105');

DELETE FROM "t_prohibit_history" 
WHERE id >= 2001 AND id <= 2003;

DELETE FROM "t_prohibit_domain_history" 
WHERE id >= 3001 AND id <= 3002;

-- ================================================================
-- 关联表1：t_prohibit_history（IP封禁历史）
-- ================================================================
INSERT INTO "t_prohibit_history" (
    "id", "block_ip", "second_ip", "link_device_ip", "link_device_type", "status", 
    "device_id", "effect_time", "create_time", "update_time", "source", "create_type", 
    "strategy_id", "file_block", "process_block", "nta_name", "launch_times", 
    "recovery_id", "direction", "node_ip", "node_id"
) VALUES
-- 场景1：已过期的IP封禁（status=true，关联有效期已过）
(2001, '10.0.0.100', '192.168.100.1', '192.168.1.101', 'firewall', true,
'FW-001', '3600', CURRENT_TIMESTAMP - INTERVAL '2 hours', NULL, 'auto', 'linkage',
1001, NULL, NULL, 'NTA-FW-001', 1,
'REC-001', 1, '192.168.1.101', 'node-2001'),

-- 场景2：有效的IP封禁（status=true，关联有效期未过）
(2002, '10.0.0.102', '192.168.100.2', '192.168.1.102', 'firewall', true,
'FW-002', '86400', CURRENT_TIMESTAMP - INTERVAL '1 hour', NULL, 'manual', 'linkage',
1002, NULL, NULL, 'NTA-FW-002', 1,
'REC-002', 2, '192.168.1.102', 'node-2002'),

-- 场景3：永久封禁（status=true，effect_time=0）
(2003, '10.0.0.103', '192.168.100.3', '192.168.1.103', 'firewall', true,
'FW-003', '0', CURRENT_TIMESTAMP - INTERVAL '3 days', NULL, 'auto', 'linkage',
1003, NULL, NULL, 'NTA-FW-003', 1,
'REC-003', 3, '192.168.1.103', 'node-2003');

-- ================================================================
-- 关联表2：t_prohibit_domain_history（域名封禁历史）
-- ================================================================
INSERT INTO "t_prohibit_domain_history" (
    "id", "block_domain", "link_device_ip", "link_device_type", "status", 
    "device_id", "effect_time", "create_time", "update_time", "source", "create_type", 
    "strategy_id", "file_block", "process_block", "nta_name", "launch_times", 
    "recovery_id", "direction", "node_ip", "node_id"
) VALUES
-- 场景1：已过期的域名封禁（status=true，关联有效期已过）
(3001, 'malware1.com', '192.168.1.104', 'firewall', true,
'FW-004', '7200', CURRENT_TIMESTAMP - INTERVAL '4 hours', NULL, 'auto', 'linkage',
1004, NULL, NULL, 'NTA-FW-004', 1,
'REC-004', 1, '192.168.1.104', 'node-3001'),

-- 场景2：有效的域名封禁（status=true，关联有效期未过）
(3002, 'phishing2.com', '192.168.1.105', 'firewall', true,
'FW-005', '172800', CURRENT_TIMESTAMP - INTERVAL '1 day', NULL, 'manual', 'linkage',
1005, NULL, NULL, 'NTA-FW-005', 1,
'REC-005', 2, '192.168.1.105', 'node-3002');

-- ================================================================
-- 主表：t_linkage_strategy_validtime（联动策略有效期）
-- ================================================================
INSERT INTO "t_linkage_strategy_validtime" (
    "block_ip", "block_domain", "link_device_ip", "end_time", "node_id", "direction", "effect_time"
) VALUES
-- 场景1：IP封禁 - 已过期（对应t_prohibit_history id=2001）
('10.0.0.100', '', '192.168.1.101', 
EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - INTERVAL '30 minutes'))::int8,  -- 30分钟前过期
'node-2001', 1, '3600'),

-- 场景2：IP封禁 - 未过期（对应t_prohibit_history id=2002）
('10.0.0.102', '', '192.168.1.102', 
EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP + INTERVAL '23 hours'))::int8,  -- 23小时后过期
'node-2002', 2, '86400'),

-- 场景3：IP封禁 - 永久（对应t_prohibit_history id=2003）
('10.0.0.103', '', '192.168.1.103', 
EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP + INTERVAL '100 years'))::int8,  -- 永久
'node-2003', 3, '0'),

-- 场景4：域名封禁 - 已过期（对应t_prohibit_domain_history id=3001）
('', 'malware1.com', '192.168.1.104', 
EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - INTERVAL '1 hour'))::int8,  -- 1小时前过期
'node-3001', 1, '7200'),

-- 场景5：域名封禁 - 未过期（对应t_prohibit_domain_history id=3002）
('', 'phishing2.com', '192.168.1.105', 
EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP + INTERVAL '1 day'))::int8,  -- 1天后过期
'node-3002', 2, '172800');
