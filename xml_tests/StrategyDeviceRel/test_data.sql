-- ============================================
-- 测试数据：StrategyDeviceRel（策略设备关联）
-- 主表：t_strategy_device_rel
-- 关联表：t_linked_strategy
-- 生成时间：2026-01-26
-- ============================================

-- ==========================================
-- 1. 先插入关联表 t_linked_strategy 数据
-- ==========================================
DELETE FROM "t_linked_strategy" WHERE id >= 7001 AND id <= 7005;

INSERT INTO "t_linked_strategy" (
    "id", "strategy_name", "auto_handle", "threat_type", "threat_type_config",
    "threat_level", "alarm_results", "status", "source", "template_id",
    "create_time", "update_time", "link_device_config"
) VALUES 
(7001, '防火墙+IDS联动封禁策略', true, 'alarmType', '/NetworkAttack/BruteForce,/NetworkAttack/PortScan',
'High,Critical', 'Failed', true, 'auto', 301,
CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '25 days',
'[{"deviceConfig":[{"appId":"dev_fw_001"},{"appId":"dev_ids_001"}],"linkDeviceType":"防火墙+IDS"}]'),

(7002, 'WAF拦截策略', true, 'alarmType', '/WebAttack/SQLInjection,/WebAttack/XSS',
'High', 'OK', true, 'auto', 302,
CURRENT_TIMESTAMP - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '10 days',
'[{"deviceConfig":[{"appId":"dev_waf_001"}],"linkDeviceType":"WAF"}]'),

(7003, '防火墙备份策略', false, 'alarmType', '/DDoS/Attack',
'Critical', 'Failed', false, 'manual', 303,
CURRENT_TIMESTAMP - INTERVAL '90 days', CURRENT_TIMESTAMP - INTERVAL '85 days',
'[{"deviceConfig":[{"appId":"dev_fw_002"}],"linkDeviceType":"防火墙"}]'),

(7004, 'EDR终端防护策略', true, 'alarmType', '/Malware/Ransomware,/Malware/Trojan',
'Critical,High', 'OK', true, 'auto', 304,
CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '5 days',
'[{"deviceConfig":[{"appId":"dev_edr_001"}],"linkDeviceType":"EDR"}]'),

(7005, '综合防护策略', true, 'alarmType', '/AdvancedThreat/APT',
'Critical', 'Failed,OK', true, 'auto', 305,
CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_TIMESTAMP - INTERVAL '15 days',
'[{"deviceConfig":[{"appId":"dev_fw_001"},{"appId":"dev_ids_001"},{"appId":"dev_waf_001"}],"linkDeviceType":"综合防护"}]');

SELECT setval('t_linked_strategy_id_seq', (SELECT MAX(id) FROM t_linked_strategy), true);

-- ==========================================
-- 2. 插入主表 t_strategy_device_rel 数据
-- ==========================================
DELETE FROM "t_strategy_device_rel" WHERE id >= 1001 AND id <= 1005;

INSERT INTO "t_strategy_device_rel" (
    "id", "strategy_id", "device_id", "device_ip", "device_type",
    "device_name", "bind_status", "last_sync_time", "sync_result",
    "create_time", "update_time"
) VALUES 

-- ==========================================
-- 场景1：主防火墙（绑定，同步成功）- 关联策略7001
-- ==========================================
(1001, 7001, 'dev_fw_001', '192.168.1.10', 'firewall',
'Firewall-Main', 'bound', CURRENT_TIMESTAMP - INTERVAL '5 minutes', 'success',
CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '5 minutes'),

-- ==========================================
-- 场景2：IDS传感器（绑定，同步成功）- 关联策略7001
-- ==========================================
(1002, 7001, 'dev_ids_001', '192.168.1.20', 'ids',
'IDS-Sensor-01', 'bound', CURRENT_TIMESTAMP - INTERVAL '10 minutes', 'success',
CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '10 minutes'),

-- ==========================================
-- 场景3：WAF网关（绑定，同步成功）- 关联策略7002
-- ==========================================
(1003, 7002, 'dev_waf_001', '192.168.2.10', 'waf',
'WAF-Gateway', 'bound', CURRENT_TIMESTAMP - INTERVAL '1 hour', 'success',
CURRENT_TIMESTAMP - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '1 hour'),

-- ==========================================
-- 场景4：备份防火墙（未绑定，设备离线）- 关联策略7003
-- ==========================================
(1004, 7003, 'dev_fw_002', '192.168.1.11', 'firewall',
'Firewall-Backup', 'unbound', CURRENT_TIMESTAMP - INTERVAL '2 days', 'device_offline',
CURRENT_TIMESTAMP - INTERVAL '90 days', CURRENT_TIMESTAMP - INTERVAL '2 days'),

-- ==========================================
-- 场景5：EDR管理器（绑定，同步成功）- 关联策略7004
-- ==========================================
(1005, 7004, 'dev_edr_001', '192.168.3.10', 'edr',
'EDR-Agent-Manager', 'bound', CURRENT_TIMESTAMP - INTERVAL '30 minutes', 'success',
CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '30 minutes');

SELECT setval('t_strategy_device_rel_id_seq', (SELECT MAX(id) FROM t_strategy_device_rel), true);

-- ==========================================
-- 验证：关联查询测试
-- ==========================================
SELECT 
    tsd.id AS "关联ID",
    tls.strategy_name AS "策略名称",
    tsd.device_name AS "设备名称",
    tsd.device_type AS "设备类型",
    tsd.device_ip AS "设备IP",
    tsd.bind_status AS "绑定状态",
    tsd.sync_result AS "同步结果",
    tls.threat_level AS "威胁等级",
    CASE WHEN tls.auto_handle THEN '自动' ELSE '手动' END AS "处置方式",
    TO_CHAR(tsd.last_sync_time, 'YYYY-MM-DD HH24:MI:SS') AS "最后同步时间"
FROM "t_linked_strategy" tls
LEFT JOIN "t_strategy_device_rel" tsd ON tls.id = tsd.strategy_id
WHERE tls.id >= 7001 AND tls.id <= 7005
ORDER BY tsd.bind_status DESC, tsd.last_sync_time DESC;

-- ==========================================
-- 统计信息
-- ==========================================
SELECT 
    '设备关联总数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_strategy_device_rel"
WHERE id >= 1001 AND id <= 1005
UNION ALL
SELECT 
    '关联策略数',
    COUNT(*) 
FROM "t_linked_strategy"
WHERE id >= 7001 AND id <= 7005
UNION ALL
SELECT 
    '已绑定设备',
    COUNT(*) 
FROM "t_strategy_device_rel"
WHERE id >= 1001 AND id <= 1005 AND bind_status = 'bound'
UNION ALL
SELECT 
    '未绑定设备',
    COUNT(*) 
FROM "t_strategy_device_rel"
WHERE id >= 1001 AND id <= 1005 AND bind_status = 'unbound';

-- 按设备类型统计
SELECT 
    device_type AS "设备类型",
    COUNT(*) AS "设备数量",
    SUM(CASE WHEN bind_status = 'bound' THEN 1 ELSE 0 END) AS "已绑定",
    SUM(CASE WHEN sync_result = 'success' THEN 1 ELSE 0 END) AS "同步成功"
FROM "t_strategy_device_rel"
WHERE id >= 1001 AND id <= 1005
GROUP BY device_type
ORDER BY "设备数量" DESC;

-- 按策略统计设备
SELECT 
    tls.strategy_name AS "策略名称",
    tls.threat_level AS "威胁等级",
    COUNT(tsd.id) AS "关联设备数",
    SUM(CASE WHEN tsd.bind_status = 'bound' THEN 1 ELSE 0 END) AS "已绑定设备",
    STRING_AGG(tsd.device_type, ',') AS "设备类型列表"
FROM "t_linked_strategy" tls
LEFT JOIN "t_strategy_device_rel" tsd ON tls.id = tsd.strategy_id
WHERE tls.id >= 7001 AND tls.id <= 7005
GROUP BY tls.strategy_name, tls.threat_level
ORDER BY "关联设备数" DESC;

-- ==========================================
-- 测试说明
-- ==========================================
-- ✅ getAlarmStrategyList: 查询告警策略列表（LEFT JOIN t_linked_strategy）
-- ✅ selectByStrategyId: 按策略ID查询设备关联
-- ✅ selectByDeviceId: 按设备ID查询策略关联
-- ✅ countByStrategyId: 按策略ID统计关联设备数
-- ✅ 所有查询依赖 t_linked_strategy 的关联数据！
--
-- ⚠️ 注意：
-- 1. strategy_id 关联 t_linked_strategy.id
-- 2. bind_status: bound=已绑定, unbound=未绑定
-- 3. sync_result: success=成功, failed=失败, device_offline=设备离线
-- 4. device_type: firewall, ids, waf, edr 等
-- 5. 一个策略可以关联多个设备（1对多关系）
