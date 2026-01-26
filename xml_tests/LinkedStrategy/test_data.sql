-- ============================================
-- 测试数据：LinkedStrategy（联动策略）
-- 表：t_linked_strategy
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_linked_strategy" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_linked_strategy" (
    "id",
    "block_ip",
    "direction",
    "node_id",
    "node_ip",
    "nta_name",
    "create_time",
    "strategy_name",
    "is_auto",
    "link_device_ip",
    "link_device_type",
    "device_id",
    "strategy_type",
    "source_link",
    "node_type",
    "is_system_ca",
    "is_open"
) VALUES 

-- ==========================================
-- 场景1：自动封禁恶意IP策略（系统策略，已开启）
-- ==========================================
(
    1001,
    '0.0.0.0/0',  -- 所有IP
    'INPUT',
    'node_fw_main',
    '192.168.1.10',
    'firewall-main',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    '自动封禁暴力破解IP',
    true,  -- 自动执行
    '192.168.1.10',
    'firewall',
    'dev_fw_001',
    'auto_block',
    'threat_intelligence',
    'firewall',
    true,  -- 系统级策略
    true   -- 已开启
),

-- ==========================================
-- 场景2：手动封禁高危IP策略（用户策略，已开启）
-- ==========================================
(
    1002,
    'manual_input',  -- 手动输入
    'INPUT,OUTPUT',
    'node_ids_main',
    '192.168.1.20',
    'ids-sensor-main',
    CURRENT_TIMESTAMP - INTERVAL '15 days',
    '手动封禁APT攻击源',
    false,  -- 手动执行
    '192.168.1.20',
    'ids',
    'dev_ids_001',
    'manual_block',
    'security_analyst',
    'ids',
    false,  -- 用户策略
    true
),

-- ==========================================
-- 场景3：联动告警自动隔离策略（系统策略，已开启）
-- ==========================================
(
    1003,
    'dynamic',  -- 动态IP
    'FORWARD',
    'node_waf_01',
    '192.168.2.10',
    'waf-gateway',
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    'WAF检测到SQL注入自动隔离',
    true,
    '192.168.2.10',
    'waf',
    'dev_waf_001',
    'auto_isolate',
    'waf_detection',
    'waf',
    true,
    true
),

-- ==========================================
-- 场景4：定时解除封禁策略（用户策略，已关闭）
-- ==========================================
(
    1004,
    'scheduled',
    'INPUT',
    'node_fw_backup',
    '192.168.1.11',
    'firewall-backup',
    CURRENT_TIMESTAMP - INTERVAL '90 days',
    '定时解除测试环境封禁',
    true,
    '192.168.1.11',
    'firewall',
    'dev_fw_002',
    'scheduled_unblock',
    'scheduler',
    'firewall',
    false,
    false  -- 已关闭
),

-- ==========================================
-- 场景5：跨设备联动策略（系统策略，已开启）
-- ==========================================
(
    1005,
    '0.0.0.0/0',
    'INPUT,OUTPUT,FORWARD',
    'node_multi',
    '192.168.1.0/24',
    'multi-device-policy',
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    '多设备协同防护',
    true,
    '192.168.1.10,192.168.1.20,192.168.2.10',  -- 多个设备
    'firewall,ids,waf',
    'dev_multi_001',
    'multi_device',
    'correlation_engine',
    'multi',
    true,
    true
);

-- 重置序列
SELECT setval('"t_linked_strategy_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    strategy_name,
    strategy_type,
    CASE WHEN is_auto THEN '自动' ELSE '手动' END AS execute_mode,
    CASE WHEN is_system_ca THEN '系统' ELSE '用户' END AS strategy_level,
    CASE WHEN is_open THEN '已开启' ELSE '已关闭' END AS status,
    link_device_type,
    direction
FROM "t_linked_strategy"
WHERE id >= 1001 AND id <= 1005
ORDER BY is_system_ca DESC, is_open DESC, create_time DESC;

-- 按策略类型统计
SELECT 
    strategy_type AS "策略类型",
    COUNT(*) AS "数量",
    SUM(CASE WHEN is_open THEN 1 ELSE 0 END) AS "已开启",
    SUM(CASE WHEN is_auto THEN 1 ELSE 0 END) AS "自动执行"
FROM "t_linked_strategy"
WHERE id >= 1001 AND id <= 1005
GROUP BY strategy_type
ORDER BY "数量" DESC;

-- 按设备类型统计
SELECT 
    UNNEST(STRING_TO_ARRAY(link_device_type, ',')) AS "设备类型",
    COUNT(*) AS "策略数量"
FROM "t_linked_strategy"
WHERE id >= 1001 AND id <= 1005
GROUP BY "设备类型"
ORDER BY "策略数量" DESC;
