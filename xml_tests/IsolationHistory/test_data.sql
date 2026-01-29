-- ================================================================
-- 测试数据：IsolationHistory（主机隔离下发记录表）
-- 表: t_isolation_history
-- 生成时间: 2026-01-28
-- ================================================================

-- 清理测试数据
DELETE FROM "t_isolation_history" WHERE id >= 3001 AND id <= 3005;

-- ================================================================
-- 插入测试数据
-- ================================================================

INSERT INTO "t_isolation_history" (
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
    "last_occur_time",
    "create_time",
    "update_time",
    "source"
) VALUES
-- 场景1: 勒索软件感染 - 主机隔离
(
    3001,
    2001,
    '终端隔离策略-勒索软件防护',
    '192.168.50.200',
    'node-win-001',
    'Windows 10 Enterprise',
    '192.168.1.10',
    'device-edr-001',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    'auto'
),

-- 场景2: 僵尸网络通信 - 主机隔离后又取消
(
    3002,
    2001,
    '终端隔离策略-勒索软件防护',
    '192.168.50.201',
    'node-win-002',
    'Windows Server 2019',
    '192.168.1.10',
    'device-edr-001',
    'endpoint',
    '主机取消隔离',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    'auto'
),

-- 场景3: 异常外连行为 - 手动隔离
(
    3003,
    2002,
    '终端隔离策略-异常行为检测',
    '192.168.50.202',
    'node-linux-001',
    'CentOS 7.9',
    '192.168.1.11',
    'device-edr-002',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    'manual'
),

-- 场景4: 多次隔离操作 - Linux服务器
(
    3004,
    2003,
    '终端隔离策略-高危漏洞响应',
    '192.168.50.203',
    'node-linux-002',
    'Ubuntu 20.04 LTS',
    '192.168.1.12',
    'device-edr-003',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    'template'
),

-- 场景5: 未知动作 - 测试枚举默认值
(
    3005,
    2003,
    '终端隔离策略-高危漏洞响应',
    '192.168.50.204',
    'node-mac-001',
    'macOS Monterey',
    '192.168.1.13',
    'device-edr-004',
    'endpoint',
    '未知',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes',
    'manual'
);

-- 更新序列
SELECT setval('"t_isolation_history_id_seq"', 3005, true);

-- ================================================================
-- 验证数据
-- ================================================================
-- SELECT * FROM "t_isolation_history" WHERE id >= 3001 AND id <= 3005 ORDER BY id;
