-- ================================================================
-- 测试数据：KillProcessHistory（进程终止下发记录表）
-- 表: t_process_kill_history
-- 生成时间: 2026-01-28
-- ================================================================

-- 清理测试数据
DELETE FROM "t_process_kill_history" WHERE id >= 4001 AND id <= 4005;

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
);

-- 更新序列
SELECT setval('"t_process_kill_history_id_seq"', 4005, true);

-- ================================================================
-- 验证数据
-- ================================================================
-- SELECT * FROM "t_process_kill_history" WHERE id >= 4001 AND id <= 4005 ORDER BY id;
