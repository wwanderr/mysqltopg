-- ================================================================
-- 测试数据：IsolationHistory（主机隔离下发记录表）
-- 表: t_isolation_history
-- 生成时间: 2026-01-28
-- ================================================================

-- 清理测试数据
DELETE FROM "t_isolation_history" WHERE id >= 3001 AND id <= 3020;

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
),

-- ================================================================
-- 新增测试数据：用于 selectPage 和 delete 测试
-- ================================================================

-- 场景6: 用于测试 selectPage - 不同的 nodeIp 模式
(
    3006,
    2001,
    '终端隔离策略-勒索软件防护',
    '10.0.0.100',
    'node-test-006',
    'Windows 10',
    '10.0.1.10',
    'device-test-006',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    'auto'
),

-- 场景7: 用于测试 selectPage - 不同的 deviceIp 模式
(
    3007,
    2002,
    '终端隔离策略-异常行为检测',
    '192.168.50.205',
    'node-test-007',
    'Linux',
    '172.16.0.10',
    'device-test-007',
    'endpoint',
    '主机取消隔离',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    'manual'
),

-- 场景8: 用于测试 selectPage - 不同的 strategyName
(
    3008,
    2004,
    '自定义策略-测试A',
    '192.168.50.206',
    'node-test-008',
    'Windows Server',
    '192.168.1.14',
    'device-test-008',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '6 hours',
    CURRENT_TIMESTAMP - INTERVAL '6 hours',
    CURRENT_TIMESTAMP - INTERVAL '6 hours',
    'template'
),

-- 场景9: 用于测试 selectPage - 不同的 action 值
(
    3009,
    2001,
    '终端隔离策略-勒索软件防护',
    '192.168.50.207',
    'node-test-009',
    'Windows 10',
    '192.168.1.15',
    'device-test-009',
    'endpoint',
    '主机取消隔离',
    CURRENT_TIMESTAMP - INTERVAL '8 hours',
    CURRENT_TIMESTAMP - INTERVAL '8 hours',
    CURRENT_TIMESTAMP - INTERVAL '8 hours',
    'auto'
),

-- 场景10: 用于测试 selectPage - 不同的 source 值
(
    3010,
    2002,
    '终端隔离策略-异常行为检测',
    '192.168.50.208',
    'node-test-010',
    'Linux',
    '192.168.1.16',
    'device-test-010',
    'endpoint',
    '未知',
    CURRENT_TIMESTAMP - INTERVAL '10 hours',
    CURRENT_TIMESTAMP - INTERVAL '10 hours',
    CURRENT_TIMESTAMP - INTERVAL '10 hours',
    'template'
),

-- 场景11: 用于测试 delete - 特定条件组合1
(
    3011,
    2001,
    '终端隔离策略-勒索软件防护',
    '192.168.50.200',  -- 与 3001 相同的 nodeIp，用于测试删除
    'node-test-011',
    'Windows 10',
    '192.168.1.10',  -- 与 3001 相同的 deviceIp
    'device-test-011',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    'auto'
),

-- 场景12: 用于测试 delete - 特定条件组合2
(
    3012,
    2002,
    '终端隔离策略-异常行为检测',
    '192.168.50.201',
    'node-test-012',
    'Linux',
    '192.168.1.11',
    'device-test-012',
    'endpoint',
    '主机取消隔离',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    'manual'
),

-- 场景13: 用于测试 delete - 多个 action 值
(
    3013,
    2003,
    '终端隔离策略-高危漏洞响应',
    '192.168.50.209',
    'node-test-013',
    'Windows 10',
    '192.168.1.17',
    'device-test-013',
    'endpoint',
    '未知',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    'template'
),

-- 场景14: 用于测试 delete - 多个 source 值
(
    3014,
    2001,
    '终端隔离策略-勒索软件防护',
    '192.168.50.210',
    'node-test-014',
    'Linux',
    '192.168.1.18',
    'device-test-014',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    'auto'
),

-- 场景15: 用于测试时间范围查询 - 较旧的数据
(
    3015,
    2002,
    '终端隔离策略-异常行为检测',
    '192.168.50.211',
    'node-test-015',
    'Windows Server',
    '192.168.1.19',
    'device-test-015',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    'manual'
),

-- 场景16: 用于测试时间范围查询 - 最新的数据
(
    3016,
    2003,
    '终端隔离策略-高危漏洞响应',
    '192.168.50.212',
    'node-test-016',
    'Windows 10',
    '192.168.1.20',
    'device-test-016',
    'endpoint',
    '主机取消隔离',
    CURRENT_TIMESTAMP - INTERVAL '1 minute',
    CURRENT_TIMESTAMP - INTERVAL '1 minute',
    CURRENT_TIMESTAMP - INTERVAL '1 minute',
    'auto'
),

-- 场景17-20: 用于测试分页查询 - 创建更多数据
(
    3017,
    2001,
    '终端隔离策略-勒索软件防护',
    '192.168.50.213',
    'node-test-017',
    'Linux',
    '192.168.1.21',
    'device-test-017',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    'auto'
),
(
    3018,
    2002,
    '终端隔离策略-异常行为检测',
    '192.168.50.214',
    'node-test-018',
    'Windows 10',
    '192.168.1.22',
    'device-test-018',
    'endpoint',
    '主机取消隔离',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    'manual'
),
(
    3019,
    2003,
    '终端隔离策略-高危漏洞响应',
    '192.168.50.215',
    'node-test-019',
    'Linux',
    '192.168.1.23',
    'device-test-019',
    'endpoint',
    '主机一键隔离',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    'template'
),
(
    3020,
    2001,
    '终端隔离策略-勒索软件防护',
    '192.168.50.216',
    'node-test-020',
    'Windows Server',
    '192.168.1.24',
    'device-test-020',
    'endpoint',
    '未知',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    'auto'
);

-- 更新序列
SELECT setval('"t_isolation_history_id_seq"', 3020, true);

-- ================================================================
-- 验证数据
-- ================================================================

-- 验证插入的数据总数
SELECT COUNT(*) AS total_count FROM "t_isolation_history" WHERE id >= 3001 AND id <= 3020;

-- 按 action 分组统计
SELECT action, COUNT(*) AS count 
FROM "t_isolation_history" 
WHERE id >= 3001 AND id <= 3020 
GROUP BY action 
ORDER BY action;

-- 按 source 分组统计
SELECT source, COUNT(*) AS count 
FROM "t_isolation_history" 
WHERE id >= 3001 AND id <= 3020 
GROUP BY source 
ORDER BY source;

-- 按 strategy_id 分组统计
SELECT strategy_id, COUNT(*) AS count 
FROM "t_isolation_history" 
WHERE id >= 3001 AND id <= 3020 
GROUP BY strategy_id 
ORDER BY strategy_id;

-- 查看所有测试数据（可选，数据较多时建议注释掉）
-- SELECT * FROM "t_isolation_history" WHERE id >= 3001 AND id <= 3020 ORDER BY id;

-- ================================================================
-- 测试数据说明
-- ================================================================
-- 1. 基础数据（3001-3005）：原有测试数据，用于基础功能测试
-- 2. selectPage 测试数据（3006-3010）：覆盖不同的查询条件
--    - 不同的 nodeIp、deviceIp 模式
--    - 不同的 strategyName、action、source 值
-- 3. delete 测试数据（3011-3014）：用于测试删除功能
--    - 包含与基础数据相同的条件组合
--    - 覆盖不同的 action 和 source 值
-- 4. 时间范围测试数据（3015-3016）：用于测试时间过滤
--    - 较旧的数据（10天前）
--    - 最新的数据（1分钟前）
-- 5. 分页测试数据（3017-3020）：用于测试分页功能
--    - 创建更多数据以测试分页效果
