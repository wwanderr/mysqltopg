-- ================================================================
-- 测试数据：KillProcessHistory（进程终止下发记录表）
-- 表: t_process_kill_history
-- 生成时间: 2026-01-28
-- ================================================================

-- 清理测试数据
DELETE FROM "t_process_kill_history" WHERE id >= 4001 AND id <= 4020;

-- ================================================================
-- 插入测试数据
-- ================================================================

INSERT INTO "t_process_kill_history" (
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
    "process_id",
    "image",
    "last_occur_time",
    "create_time",
    "update_time",
    "source"
) VALUES
-- 场景1: 勒索软件进程查杀
(
    4001,
    2001,
    '进程终止策略-勒索软件防护',
    '192.168.50.200',
    'node-win-001',
    'Windows 10 Enterprise',
    '192.168.1.10',
    'device-edr-001',
    'endpoint',
    '病毒查杀',
    '1234',
    'C:\Temp\malware.exe',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    'auto'
),

-- 场景2: 挖矿木马进程查杀
(
    4002,
    2001,
    '进程终止策略-勒索软件防护',
    '192.168.50.201',
    'node-win-002',
    'Windows Server 2019',
    '192.168.1.10',
    'device-edr-001',
    'endpoint',
    '病毒查杀',
    '5678',
    'C:\Users\Public\miner.exe',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    'auto'
),

-- 场景3: 手动查杀可疑进程
(
    4003,
    2002,
    '进程终止策略-异常行为检测',
    '192.168.50.202',
    'node-linux-001',
    'CentOS 7.9',
    '192.168.1.11',
    'device-edr-002',
    'endpoint',
    '病毒查杀',
    '9012',
    '/tmp/suspicious',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    'manual'
),

-- 场景4: Linux恶意脚本查杀
(
    4004,
    2003,
    '进程终止策略-高危漏洞响应',
    '192.168.50.203',
    'node-linux-002',
    'Ubuntu 20.04 LTS',
    '192.168.1.12',
    'device-edr-003',
    'endpoint',
    '病毒查杀',
    '3456',
    '/var/tmp/evil.sh',
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    'template'
),

-- 场景5: 未知类型进程查杀
(
    4005,
    2003,
    '进程终止策略-高危漏洞响应',
    '192.168.50.204',
    'node-mac-001',
    'macOS Monterey',
    '192.168.1.13',
    'device-edr-004',
    'endpoint',
    '未知',
    '7890',
    '/Applications/Unknown.app/Contents/MacOS/suspicious',
    CURRENT_TIMESTAMP - INTERVAL '5 minutes',
    CURRENT_TIMESTAMP - INTERVAL '5 minutes',
    CURRENT_TIMESTAMP - INTERVAL '5 minutes',
    'manual'
),

-- ================================================================
-- 新增测试数据：用于 selectPage 和 delete 测试
-- ================================================================

-- 场景6: 用于测试 selectPage - 不同的 nodeIp 模式
(
    4006,
    2001,
    '进程终止策略-勒索软件防护',
    '10.0.0.100',
    'node-test-006',
    'Windows 10',
    '10.0.1.10',
    'device-test-006',
    'endpoint',
    '病毒查杀',
    '1111',
    'C:\\test\\test1.exe',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    'auto'
),

-- 场景7: 用于测试 selectPage - 不同的 deviceIp 模式
(
    4007,
    2002,
    '进程终止策略-异常行为检测',
    '192.168.50.205',
    'node-test-007',
    'Linux',
    '172.16.0.10',
    'device-test-007',
    'endpoint',
    '病毒查杀',
    '2222',
    '/tmp/test2.sh',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    'manual'
),

-- 场景8: 用于测试 selectPage - 不同的 strategyName
(
    4008,
    2004,
    '自定义策略-测试A',
    '192.168.50.206',
    'node-test-008',
    'Windows Server',
    '192.168.1.14',
    'device-test-008',
    'endpoint',
    '病毒查杀',
    '3333',
    'C:\\Program Files\\test3.exe',
    CURRENT_TIMESTAMP - INTERVAL '6 hours',
    CURRENT_TIMESTAMP - INTERVAL '6 hours',
    CURRENT_TIMESTAMP - INTERVAL '6 hours',
    'template'
),

-- 场景9: 用于测试 selectPage - 不同的 image 路径
(
    4009,
    2001,
    '进程终止策略-勒索软件防护',
    '192.168.50.207',
    'node-test-009',
    'Windows 10',
    '192.168.1.15',
    'device-test-009',
    'endpoint',
    '病毒查杀',
    '4444',
    'D:\\malware\\trojan.exe',
    CURRENT_TIMESTAMP - INTERVAL '8 hours',
    CURRENT_TIMESTAMP - INTERVAL '8 hours',
    CURRENT_TIMESTAMP - INTERVAL '8 hours',
    'auto'
),

-- 场景10: 用于测试 selectPage - 不同的 processId
(
    4010,
    2002,
    '进程终止策略-异常行为检测',
    '192.168.50.208',
    'node-test-010',
    'Linux',
    '192.168.1.16',
    'device-test-010',
    'endpoint',
    '未知',
    '5555',
    '/usr/bin/test4',
    CURRENT_TIMESTAMP - INTERVAL '10 hours',
    CURRENT_TIMESTAMP - INTERVAL '10 hours',
    CURRENT_TIMESTAMP - INTERVAL '10 hours',
    'manual'
),

-- 场景11: 用于测试 delete - 特定条件组合1
(
    4011,
    2001,
    '进程终止策略-勒索软件防护',
    '192.168.50.200',  -- 与 4001 相同的 nodeIp，用于测试删除
    'node-test-011',
    'Windows 10',
    '192.168.1.10',  -- 与 4001 相同的 deviceIp
    'device-test-011',
    'endpoint',
    '病毒查杀',
    '6666',
    'C:\\test\\delete1.exe',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    'auto'
),

-- 场景12: 用于测试 delete - 特定条件组合2
(
    4012,
    2002,
    '进程终止策略-异常行为检测',
    '192.168.50.201',
    'node-test-012',
    'Linux',
    '192.168.1.11',
    'device-test-012',
    'endpoint',
    '病毒查杀',
    '7777',
    '/tmp/delete2.sh',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    'manual'
),

-- 场景13: 用于测试 delete - 多个 action 值
(
    4013,
    2003,
    '进程终止策略-高危漏洞响应',
    '192.168.50.209',
    'node-test-013',
    'Windows 10',
    '192.168.1.17',
    'device-test-013',
    'endpoint',
    '未知',
    '8888',
    'C:\\test\\delete3.exe',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    'template'
),

-- 场景14: 用于测试 delete - 多个 source 值
(
    4014,
    2001,
    '进程终止策略-勒索软件防护',
    '192.168.50.210',
    'node-test-014',
    'Linux',
    '192.168.1.18',
    'device-test-014',
    'endpoint',
    '病毒查杀',
    '9999',
    '/var/tmp/delete4.sh',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    'auto'
),

-- 场景15: 用于测试时间范围查询 - 较旧的数据
(
    4015,
    2002,
    '进程终止策略-异常行为检测',
    '192.168.50.211',
    'node-test-015',
    'Windows Server',
    '192.168.1.19',
    'device-test-015',
    'endpoint',
    '病毒查杀',
    '1010',
    'C:\\old\\old1.exe',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    'manual'
),

-- 场景16: 用于测试时间范围查询 - 最新的数据
(
    4016,
    2003,
    '进程终止策略-高危漏洞响应',
    '192.168.50.212',
    'node-test-016',
    'Windows 10',
    '192.168.1.20',
    'device-test-016',
    'endpoint',
    '病毒查杀',
    '2020',
    'C:\\recent\\recent1.exe',
    CURRENT_TIMESTAMP - INTERVAL '1 minute',
    CURRENT_TIMESTAMP - INTERVAL '1 minute',
    CURRENT_TIMESTAMP - INTERVAL '1 minute',
    'auto'
),

-- 场景17-20: 用于测试分页查询 - 创建更多数据
(
    4017,
    2001,
    '进程终止策略-勒索软件防护',
    '192.168.50.213',
    'node-test-017',
    'Linux',
    '192.168.1.21',
    'device-test-017',
    'endpoint',
    '病毒查杀',
    '3030',
    '/tmp/page1.sh',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    'auto'
),
(
    4018,
    2002,
    '进程终止策略-异常行为检测',
    '192.168.50.214',
    'node-test-018',
    'Windows 10',
    '192.168.1.22',
    'device-test-018',
    'endpoint',
    '未知',
    '4040',
    'C:\\page2.exe',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    'manual'
),
(
    4019,
    2003,
    '进程终止策略-高危漏洞响应',
    '192.168.50.215',
    'node-test-019',
    'Linux',
    '192.168.1.23',
    'device-test-019',
    'endpoint',
    '病毒查杀',
    '5050',
    '/var/page3.sh',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    'template'
),
(
    4020,
    2001,
    '进程终止策略-勒索软件防护',
    '192.168.50.216',
    'node-test-020',
    'Windows Server',
    '192.168.1.24',
    'device-test-020',
    'endpoint',
    '病毒查杀',
    '6060',
    'D:\\page4.exe',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours',
    'auto'
);

-- 更新序列
SELECT setval('"t_process_kill_history_id_seq"', 4020, true);

-- ================================================================
-- 验证数据
-- ================================================================

-- 验证插入的数据总数
SELECT COUNT(*) AS total_count FROM "t_process_kill_history" WHERE id >= 4001 AND id <= 4020;

-- 按 action 分组统计
SELECT action, COUNT(*) AS count 
FROM "t_process_kill_history" 
WHERE id >= 4001 AND id <= 4020 
GROUP BY action 
ORDER BY action;

-- 按 source 分组统计
SELECT source, COUNT(*) AS count 
FROM "t_process_kill_history" 
WHERE id >= 4001 AND id <= 4020 
GROUP BY source 
ORDER BY source;

-- 按 strategy_id 分组统计
SELECT strategy_id, COUNT(*) AS count 
FROM "t_process_kill_history" 
WHERE id >= 4001 AND id <= 4020 
GROUP BY strategy_id 
ORDER BY strategy_id;

-- 查看所有测试数据（可选，数据较多时建议注释掉）
-- SELECT * FROM "t_process_kill_history" WHERE id >= 4001 AND id <= 4020 ORDER BY id;

-- ================================================================
-- 测试数据说明
-- ================================================================
-- 1. 基础数据（4001-4005）：原有测试数据，用于基础功能测试
-- 2. selectPage 测试数据（4006-4010）：覆盖不同的查询条件
--    - 不同的 nodeIp、deviceIp 模式
--    - 不同的 strategyName、image、processId
--    - 不同的 action 和 source 值
-- 3. delete 测试数据（4011-4014）：用于测试删除功能
--    - 包含与基础数据相同的条件组合
--    - 覆盖不同的 action 和 source 值
-- 4. 时间范围测试数据（4015-4016）：用于测试时间过滤
--    - 较旧的数据（10天前）
--    - 最新的数据（1分钟前）
-- 5. 分页测试数据（4017-4020）：用于测试分页功能
--    - 创建更多数据以测试分页效果
