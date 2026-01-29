-- ============================================
-- 测试数据：ScanHistory（扫描历史）
-- 主表：t_scan_history (16个字段，3个ENUM类型)
-- ENUM: node_os, virus_status, site_status, vulnerability_status
-- 生成时间：2026-01-28（深度修复）
-- ============================================

DELETE FROM "t_scan_history" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据（完整16个字段）
INSERT INTO "t_scan_history" (
    "id",
    "node_ip",
    "node_id",
    "node_os",
    "device_id",
    "device_ip",
    "device_type",
    "last_scan_time",
    "scan_times",
    "virus_status",
    "site_status",
    "vulnerability_status",
    "virus_result_num",
    "site_result_num",
    "vulnerability_result_num",
    "total_result_num"
) VALUES 

-- ==========================================
-- 场景1：Windows终端，所有扫描已完成
-- ==========================================
(
    1001,
    '192.168.10.100',
    'NODE-WIN-001',
    'Windows',
    'DEV-001',
    '192.168.1.1',
    'EDR',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    5,
    '扫描完成',
    '扫描完成',
    '扫描完成',
    3,
    2,
    15,
    20
),

-- ==========================================
-- 场景2：Linux终端，正在扫描
-- ==========================================
(
    1002,
    '192.168.10.200',
    'NODE-LNX-001',
    'Linux',
    'DEV-002',
    '192.168.1.2',
    'Scanner',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    1,
    '正在扫描',
    '正在扫描',
    '无下发记录',
    0,
    0,
    0,
    0
),

-- ==========================================
-- 场景3：Windows终端，扫描失败
-- ==========================================
(
    1003,
    '192.168.10.150',
    'NODE-WIN-002',
    'Windows',
    'DEV-003',
    '192.168.1.3',
    'EDR',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    10,
    '扫描失败',
    '扫描完成',
    '扫描完成',
    0,
    1,
    8,
    9
),

-- ==========================================
-- 场景4：Linux服务器，病毒扫描完成，其他无下发
-- ==========================================
(
    1004,
    '192.168.20.50',
    'NODE-LNX-002',
    'Linux',
    'DEV-004',
    '192.168.1.4',
    'Scanner',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    3,
    '扫描完成',
    '无下发记录',
    '无下发记录',
    5,
    0,
    0,
    5
),

-- ==========================================
-- 场景5：Windows服务器，多次扫描累计
-- ==========================================
(
    1005,
    '192.168.20.100',
    'NODE-WIN-003',
    'Windows',
    'DEV-005',
    '192.168.1.5',
    'EDR',
    CURRENT_TIMESTAMP - INTERVAL '24 hours',
    20,
    '扫描完成',
    '扫描完成',
    '扫描完成',
    10,
    5,
    25,
    40
);

SELECT setval('"t_scan_history_id_seq"', 1005, true);

-- ==========================================
-- 验证：按操作系统统计
-- ==========================================
SELECT 
    node_os AS "操作系统",
    COUNT(*) AS "终端数量",
    SUM(scan_times) AS "总扫描次数",
    SUM(total_result_num) AS "总发现数"
FROM "t_scan_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY node_os
ORDER BY node_os;

-- ==========================================
-- 验证：按扫描状态统计
-- ==========================================
SELECT 
    virus_status AS "病毒扫描状态",
    COUNT(*) AS "数量"
FROM "t_scan_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY virus_status
ORDER BY virus_status;
