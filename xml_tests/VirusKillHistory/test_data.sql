-- ============================================
-- 测试数据：VirusKillHistory（病毒查杀历史）
-- 主表：t_virus_kill_history
-- 根据 DDL 修复字段：strategy_id/strategy_name/node_ip/node_id/os_str/device_ip/device_id/device_type/action/hashes/source/last_occur_time/create_time/update_time
-- ============================================

DELETE FROM "t_virus_kill_history" WHERE id >= 9001 AND id <= 9010;

INSERT INTO "t_virus_kill_history" (
    "id",
    "strategy_id",
    "strategy_name",
    "node_ip",
    "node_id",
    "os_str",
    "device_ip",
    "device_id",
    "device_type",
    "action",
    "hashes",
    "source",
    "last_occur_time",
    "create_time",
    "update_time"
) VALUES

-- 场景1：manual + Windows + node_ip 模糊匹配
(9001, 9001, '病毒查杀策略-A', '10.10.1.10', 'node-001', 'Windows', '192.168.10.10', 'dev-edr-001', 'edr', '病毒查杀', 'hash-aaa,hash-bbb', 'manual',
 CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP - INTERVAL '30 minutes'),

-- 场景2：auto + Linux
(9002, 9002, '病毒查杀策略-B', '10.10.1.11', 'node-002', 'Linux', '192.168.10.11', 'dev-edr-002', 'edr', '病毒查杀', 'hash-ccc', 'auto',
 CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours'),

-- 场景3：同策略多条记录，覆盖 countLaunchTimesByStrategyId 聚合
(9003, 9001, '病毒查杀策略-A', '10.10.1.12', 'node-003', 'Windows', '192.168.10.12', 'dev-edr-003', 'edr', '病毒查杀', 'hash-ddd', 'manual',
 CURRENT_TIMESTAMP - INTERVAL '10 minutes', CURRENT_TIMESTAMP - INTERVAL '10 minutes', CURRENT_TIMESTAMP - INTERVAL '10 minutes'),

-- 场景4：不同 device_ip，用于 like(device_ip) 命中
(9004, 9001, '病毒查杀策略-A', '10.10.2.10', 'node-004', 'Windows', '192.168.20.10', 'dev-edr-004', 'edr', '病毒查杀', 'hash-eee', 'manual',
 CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '1 day');

SELECT setval('"t_virus_kill_history_id_seq"', (SELECT MAX(id) FROM "t_virus_kill_history"), true);
