-- ============================================
-- 测试数据：StrategyDeviceRel（策略设备关联）
-- 主表：t_strategy_device_rel
-- 关联表：t_linked_strategy
-- 根据反编译接口修复：2026-01-28
-- ============================================

-- ==========================================
-- 1. 先插入关联表 t_linked_strategy 数据
-- 说明：getAlarmStrategyList 需要 threat_type='alarmType' 且 status=true 的策略
-- ==========================================
DELETE FROM "t_linked_strategy" WHERE id >= 7001 AND id <= 7006;

INSERT INTO "t_linked_strategy" (
    "id", "strategy_name", "auto_handle", "threat_type", "threat_type_config",
    "threat_level", "alarm_results", "alarm_names", "status", "source", "template_id",
    "create_time", "update_time", "link_device_config"
) VALUES 
-- ==========================================
-- 场景1：防火墙+IDS联动封禁策略（status=true, threat_type='alarmType'）
-- ==========================================
(7001, '防火墙+IDS联动封禁策略', true, 'alarmType', '/NetworkAttack/BruteForce,/NetworkAttack/PortScan',
'High,Critical', 'Failed', '暴力破解告警,端口扫描告警', true, 'auto', 301,
CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '25 days',
'[{"deviceConfig":[{"appId":"app_fw_001"},{"appId":"app_ids_001"}],"linkDeviceType":"防火墙+IDS"}]'),

-- ==========================================
-- 场景2：WAF拦截策略（status=true, threat_type='alarmType'）
-- ==========================================
(7002, 'WAF拦截策略', true, 'alarmType', '/WebAttack/SQLInjection,/WebAttack/XSS',
'High', 'OK', 'SQL注入告警,XSS攻击告警', true, 'auto', 302,
CURRENT_TIMESTAMP - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '10 days',
'[{"deviceConfig":[{"appId":"app_waf_001"}],"linkDeviceType":"WAF"}]'),

-- ==========================================
-- 场景3：防火墙备份策略（status=false，用于测试 getAlarmStrategyList 不返回）
-- ==========================================
(7003, '防火墙备份策略', false, 'alarmType', '/DDoS/Attack',
'Critical', 'Failed', 'DDoS攻击告警', false, 'manual', 303,
CURRENT_TIMESTAMP - INTERVAL '90 days', CURRENT_TIMESTAMP - INTERVAL '85 days',
'[{"deviceConfig":[{"appId":"app_fw_002"}],"linkDeviceType":"防火墙"}]'),

-- ==========================================
-- 场景4：EDR终端防护策略（status=true, threat_type='alarmType'）
-- ==========================================
(7004, 'EDR终端防护策略', true, 'alarmType', '/Malware/Ransomware,/Malware/Trojan',
'Critical,High', 'OK', '勒索软件告警,木马告警', true, 'auto', 304,
CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '5 days',
'[{"deviceConfig":[{"appId":"app_edr_001"}],"linkDeviceType":"EDR"}]'),

-- ==========================================
-- 场景5：综合防护策略（status=true, threat_type='alarmType'，用于 deleteRelByStrategyId 测试）
-- ==========================================
(7005, '综合防护策略', true, 'alarmType', '/AdvancedThreat/APT',
'Critical', 'Failed,OK', 'APT攻击告警', true, 'auto', 305,
CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_TIMESTAMP - INTERVAL '15 days',
'[{"deviceConfig":[{"appId":"app_fw_001"},{"appId":"app_ids_001"},{"appId":"app_waf_001"}],"linkDeviceType":"综合防护"}]'),

-- ==========================================
-- 场景6：额外策略（用于测试）
-- ==========================================
(7006, '额外测试策略', true, 'alarmType', '/NetworkAttack/PortScan',
'Medium', 'OK', '端口扫描告警', true, 'auto', 306,
CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP - INTERVAL '8 days',
'[{"deviceConfig":[{"appId":"app_test_001"}],"linkDeviceType":"测试设备"}]');

SELECT setval('t_linked_strategy_id_seq', (SELECT MAX(id) FROM t_linked_strategy), true);

-- ==========================================
-- 2. 插入主表 t_strategy_device_rel 数据
-- 说明：根据实际表结构，字段为：id, strategy_id, device_id, link_device_ip, link_device_type,
--       area, area_data, agents, action, action_config, app_id, create_time, update_time
-- ==========================================
DELETE FROM "t_strategy_device_rel" WHERE id >= 1001 AND id <= 1008;

INSERT INTO "t_strategy_device_rel" (
    "id", "strategy_id", "device_id", "link_device_ip", "link_device_type",
    "area", "area_data", "agents", "action", "action_config", "app_id",
    "create_time", "update_time"
) VALUES 

-- ==========================================
-- 场景1：主防火墙（id=1001，用于 selectById 和 update 测试）
-- ==========================================
(1001, 7001, 'dev_fw_001', '192.168.1.10', 'firewall',
'DMZ', '{"zones": ["dmz", "internal"]}', '[{"agentId": "agent001", "hostname": "fw-main"}]',
'block', '{"duration": 3600, "reason": "brute_force"}', 'app_fw_001',
CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '5 minutes'),

-- ==========================================
-- 场景2：IDS传感器（strategy_id=7001，用于 findDeviceByStrateId 和 getDeviceCount 测试）
-- ==========================================
(1002, 7001, 'dev_ids_001', '192.168.1.20', 'ids',
'Internal', '{"zones": ["internal"]}', '[{"agentId": "agent002", "hostname": "ids-sensor"}]',
'monitor', '{"alert_level": "high"}', 'app_ids_001',
CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '10 minutes'),

-- ==========================================
-- 场景3：WAF网关（strategy_id=7002）
-- ==========================================
(1003, 7002, 'dev_waf_001', '192.168.2.10', 'waf',
'DMZ', '{"zones": ["dmz"]}', '[{"agentId": "agent003", "hostname": "waf-gateway"}]',
'block', '{"rules": ["sql_injection", "xss"]}', 'app_waf_001',
CURRENT_TIMESTAMP - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '1 hour'),

-- ==========================================
-- 场景4：备份防火墙（strategy_id=7003，status=false，用于测试 getAlarmStrategyList 不返回）
-- ==========================================
(1004, 7003, 'dev_fw_002', '192.168.1.11', 'firewall',
'Backup', '{"zones": ["backup"]}', '[{"agentId": "agent004", "hostname": "fw-backup"}]',
'block', '{"duration": 7200}', 'app_fw_002',
CURRENT_TIMESTAMP - INTERVAL '90 days', CURRENT_TIMESTAMP - INTERVAL '2 days'),

-- ==========================================
-- 场景5：EDR管理器（strategy_id=7004）
-- ==========================================
(1005, 7004, 'dev_edr_001', '192.168.3.10', 'edr',
'Internal', '{"zones": ["internal", "dmz"]}', '[{"agentId": "agent005", "hostname": "edr-manager"}]',
'scan', '{"scan_type": "full", "immediate": true}', 'app_edr_001',
CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '30 minutes'),

-- ==========================================
-- 场景6：综合防护设备1（strategy_id=7005，用于 deleteRelByStrategyId 测试）
-- ==========================================
(1006, 7005, 'dev_combo_001', '192.168.4.10', 'combo',
'All', '{"zones": ["all"]}', '[{"agentId": "agent006", "hostname": "combo-01"}]',
'block', '{"comprehensive": true}', 'app_combo_001',
CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_TIMESTAMP - INTERVAL '1 day'),

-- ==========================================
-- 场景7：综合防护设备2（strategy_id=7005，用于 deleteRelByStrategyId 测试）
-- ==========================================
(1007, 7005, 'dev_combo_002', '192.168.4.11', 'combo',
'All', '{"zones": ["all"]}', '[{"agentId": "agent007", "hostname": "combo-02"}]',
'monitor', '{"comprehensive": true}', 'app_combo_002',
CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_TIMESTAMP - INTERVAL '1 day'),

-- ==========================================
-- 场景8：额外设备（device_id=dev_fw_001，用于 findStrategyIdByDeviceId 测试，可能有多个策略）
-- ==========================================
(1008, 7006, 'dev_fw_001', '192.168.1.10', 'firewall',
'DMZ', '{"zones": ["dmz"]}', '[{"agentId": "agent008", "hostname": "fw-extra"}]',
'block', '{"test": true}', 'app_fw_001',
CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP - INTERVAL '1 day');

SELECT setval('t_strategy_device_rel_id_seq', (SELECT MAX(id) FROM t_strategy_device_rel), true);

-- ==========================================
-- 3. 验证：关联查询测试（getAlarmStrategyList）
-- ==========================================
SELECT 
    tsd.id AS "关联ID",
    tls.strategy_name AS "策略名称",
    tls.threat_type AS "威胁类型",
    tls.status AS "策略状态",
    tsd.device_id AS "设备ID",
    tsd.link_device_ip AS "设备IP",
    tsd.link_device_type AS "设备类型",
    tsd.action AS "动作",
    tls.threat_level AS "威胁等级",
    CASE WHEN tls.auto_handle THEN '自动' ELSE '手动' END AS "处置方式"
FROM "t_linked_strategy" tls
LEFT JOIN "t_strategy_device_rel" tsd ON tls.id = tsd.strategy_id
WHERE tls.id >= 7001 AND tls.id <= 7006
  AND tls.threat_type = 'alarmType'
  AND tls.status = true
ORDER BY tls.id, tsd.id;

-- ==========================================
-- 4. 统计信息
-- ==========================================
SELECT 
    '设备关联总数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_strategy_device_rel"
WHERE id >= 1001 AND id <= 1008
UNION ALL
SELECT 
    '关联策略数',
    COUNT(*) 
FROM "t_linked_strategy"
WHERE id >= 7001 AND id <= 7006
UNION ALL
SELECT 
    '启用策略数（status=true）',
    COUNT(*) 
FROM "t_linked_strategy"
WHERE id >= 7001 AND id <= 7006 AND status = true
UNION ALL
SELECT 
    '告警类型策略数（threat_type=alarmType）',
    COUNT(*) 
FROM "t_linked_strategy"
WHERE id >= 7001 AND id <= 7006 AND threat_type = 'alarmType';

-- 按设备类型统计
SELECT 
    link_device_type AS "设备类型",
    COUNT(*) AS "设备数量",
    COUNT(DISTINCT strategy_id) AS "关联策略数"
FROM "t_strategy_device_rel"
WHERE id >= 1001 AND id <= 1008
GROUP BY link_device_type
ORDER BY "设备数量" DESC;

-- 按策略统计设备
SELECT 
    tls.strategy_name AS "策略名称",
    tls.threat_level AS "威胁等级",
    tls.status AS "策略状态",
    COUNT(tsd.id) AS "关联设备数",
    STRING_AGG(tsd.link_device_type, ',') AS "设备类型列表"
FROM "t_linked_strategy" tls
LEFT JOIN "t_strategy_device_rel" tsd ON tls.id = tsd.strategy_id
WHERE tls.id >= 7001 AND tls.id <= 7006
GROUP BY tls.strategy_name, tls.threat_level, tls.status
ORDER BY "关联设备数" DESC;

-- ==========================================
-- 5. 测试方法数据覆盖验证
-- ==========================================
-- ✅ test1_insert: 可以插入新记录（strategy_id=7001）
-- ✅ test2_batchInsert: 可以批量插入（strategy_id=7001, 7002）
-- ✅ test3_update: id=1001 存在，可以更新
-- ✅ test4_batchInsertOrUpdate: strategy_id=7001, device_id=dev_fw_001 存在（更新），strategy_id=7005 存在（插入）
-- ✅ test5_deleteRelByStrategyId: strategy_id=7005 有2条记录（1006, 1007），可以删除
-- ✅ test6_deleteRelByStrategyIdAndDeviceId: strategy_id=7001, device_id=dev_fw_001 存在（id=1001），可以删除
-- ✅ test7_selectById: id=1001 存在，可以查询
-- ✅ test8_getAlarmStrategyList: threat_type='alarmType' 且 status=true 的策略有 7001, 7002, 7004, 7005, 7006，都有对应的设备关联
-- ✅ test9_findDeviceByStrateId: strategy_id=7001 有2条记录（1001, 1002），可以查询
-- ✅ test10_findStrategyIdByDeviceId: device_id=dev_fw_001 有2条记录（1001, 1008），对应 strategy_id=7001, 7006
-- ✅ test11_getDeviceCount: strategy_id=7001 有2条记录，count=2
-- ✅ test12_updateDeviceIpAndId: device_id=dev_fw_001 存在（id=1001），可以更新

-- ==========================================
-- 测试说明
-- ==========================================
-- ⚠️ 注意：
-- 1. strategy_id 关联 t_linked_strategy.id
-- 2. getAlarmStrategyList 查询条件：threat_type='alarmType' AND status=true
-- 3. 表结构字段：id, strategy_id, device_id, link_device_ip, link_device_type, area, area_data, agents, action, action_config, app_id
-- 4. 唯一约束：(strategy_id, device_id, action)
-- 5. 一个策略可以关联多个设备（1对多关系）
-- 6. 一个设备可以关联多个策略（多对多关系）