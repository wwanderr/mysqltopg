-- ============================================
-- 测试数据：StrategyDeviceRel（策略设备关联）
-- 表：t_strategy_device_rel
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_strategy_device_rel" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_strategy_device_rel" (
    "id",
    "strategy_id",
    "device_id",
    "device_ip",
    "device_type",
    "device_name",
    "bind_status",
    "last_sync_time",
    "sync_result",
    "create_time",
    "update_time"
) VALUES 

(
    1001,
    5001,
    'dev_fw_001',
    '192.168.1.10',
    'firewall',
    'Firewall-Main',
    'bound',
    CURRENT_TIMESTAMP - INTERVAL '5 minutes',
    'success',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '5 minutes'
),

(
    1002,
    5001,
    'dev_ids_001',
    '192.168.1.20',
    'ids',
    'IDS-Sensor-01',
    'bound',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes',
    'success',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes'
),

(
    1003,
    5002,
    'dev_waf_001',
    '192.168.2.10',
    'waf',
    'WAF-Gateway',
    'bound',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    'success',
    CURRENT_TIMESTAMP - INTERVAL '15 days',
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
),

(
    1004,
    5003,
    'dev_fw_002',
    '192.168.1.11',
    'firewall',
    'Firewall-Backup',
    'unbound',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    'device_offline',
    CURRENT_TIMESTAMP - INTERVAL '90 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days'
),

(
    1005,
    5004,
    'dev_edr_001',
    '192.168.3.10',
    'edr',
    'EDR-Agent-Manager',
    'bound',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    'success',
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes'
);

SELECT setval('"t_strategy_device_rel_id_seq"', 1005, true);

SELECT 
    id,
    strategy_id AS "策略ID",
    device_name AS "设备名称",
    device_type AS "设备类型",
    bind_status AS "绑定状态",
    sync_result AS "同步结果"
FROM "t_strategy_device_rel"
WHERE id >= 1001 AND id <= 1005
ORDER BY bind_status DESC, last_sync_time DESC;
