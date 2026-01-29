-- ================================================================
-- 测试数据：SharedData（共享数据）
-- 表: t_security_incidents (注意: SharedDataMapper使用此表)
-- 生成时间: 2026-01-28
-- ================================================================

-- 清理测试数据
DELETE FROM "t_security_incidents" 
WHERE event_code IN ('SHARED-2026-001', 'SHARED-2026-002', 'SHARED-2026-003', 'SHARED-2026-004', 'SHARED-2026-005');

-- 插入测试数据
INSERT INTO "t_security_incidents" (
    "event_code",
    "update_ip_information",
    "start_time",
    "create_time"
) VALUES
-- 场景1: 今天的事件 - 包含IP更新信息
(
    'SHARED-2026-001',
    '{"updated_ips": ["10.0.0.100", "10.0.0.101"], "update_reason": "threat_detected"}',
    CURRENT_DATE::timestamp,
    CURRENT_TIMESTAMP
),

-- 场景2: 今天的事件 - 另一个IP更新
(
    'SHARED-2026-002',
    '{"updated_ips": ["192.168.1.50"], "update_reason": "vulnerability_found"}',
    CURRENT_DATE::timestamp + INTERVAL '1 hour',
    CURRENT_TIMESTAMP
),

-- 场景3: 今天的事件 - 大量IP更新
(
    'SHARED-2026-003',
    '{"updated_ips": ["172.16.0.10", "172.16.0.11", "172.16.0.12"], "update_reason": "scan_completed"}',
    CURRENT_DATE::timestamp + INTERVAL '2 hours',
    CURRENT_TIMESTAMP
),

-- 场景4: 今天的事件 - 空IP信息
(
    'SHARED-2026-004',
    '{}',
    CURRENT_DATE::timestamp + INTERVAL '3 hours',
    CURRENT_TIMESTAMP
),

-- 场景5: 昨天的事件 - 不应被查询到
(
    'SHARED-2026-005',
    '{"updated_ips": ["203.0.113.100"], "update_reason": "old_event"}',
    CURRENT_DATE::timestamp - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
);

-- ================================================================
-- 说明
-- ================================================================
-- SharedDataMapper.queryTodayUpdateIpInformation 方法:
--   查询条件: start_time::DATE = CURRENT_DATE
--   返回字段: event_code, update_ip_information
--
-- 注意: 
--   - 只会查询今天的记录 (start_time 是今天)
--   - 场景5的记录不会被查询到 (昨天的数据)
--
-- ================================================================
-- 验证数据
-- ================================================================
-- SELECT event_code, update_ip_information
-- FROM t_security_incidents
-- WHERE start_time::DATE = CURRENT_DATE
--   AND event_code LIKE 'SHARED-2026-%'
-- ORDER BY event_code;
