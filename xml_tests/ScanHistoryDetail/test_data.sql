-- ================================================================
-- 深度测试数据：ScanHistoryDetail（扫描历史详情）+ 关联策略表
-- 主表: t_scan_history_detail (15个字段 + 3个ENUM类型)
-- 关联表: t_linked_strategy (用于LEFT JOIN)
-- 生成时间: 2026-01-28
-- ================================================================

-- ================================================================
-- 先准备关联表数据：t_linked_strategy
-- ================================================================
DELETE FROM "t_linked_strategy" WHERE id IN (6001, 6002, 6003);

INSERT INTO "t_linked_strategy" (
    "id", "strategy_name", "link_device_type", "link_device_ip", 
    "action", "is_enable", "create_time", "update_time"
) VALUES
(6001, '病毒扫描策略-A', 'EDR', '10.0.1.100', 'virusScan', 1, CURRENT_TIMESTAMP - INTERVAL '90 days', CURRENT_TIMESTAMP),
(6002, '网站后门检测策略-B', 'WAF', '10.0.2.200', 'siteScan', 1, CURRENT_TIMESTAMP - INTERVAL '60 days', CURRENT_TIMESTAMP),
(6003, '漏洞补丁扫描策略-C', 'SCANNER', '10.0.3.300', 'vulScan', 0, CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP);

-- ================================================================
-- 主表：t_scan_history_detail（10条测试数据）
-- ================================================================
DELETE FROM "t_scan_history_detail" WHERE id >= 8001 AND id <= 8010;

INSERT INTO "t_scan_history_detail" (
    "id", "strategy_id", "node_ip", "device_ip", 
    "scan_time", "scan_scope", "scan_path", "scan_type",
    "scan_object_num", "scan_result_num", "scan_total_num",
    "status", "start_time", "end_time", "source", "task_id"
) VALUES

-- ==========================================
-- 场景1：病毒扫描（全盘，已完成，手动触发）
-- ==========================================
(8001, 6001, '192.168.10.50', '10.0.1.100',
 CURRENT_TIMESTAMP - INTERVAL '10 days', 'full'::t_scan_history_detail_scan_scope, NULL, 'virus'::t_scan_history_detail_scan_type,
 5000, 15, 5000,
 '扫描完成'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '10 days', CURRENT_TIMESTAMP - INTERVAL '10 days' + INTERVAL '2 hours', 'manual', 'TASK-001'),

-- ==========================================
-- 场景2：病毒扫描（自定义路径，正在扫描，自动触发）
-- ==========================================
(8002, 6001, '192.168.10.51', '10.0.1.100',
 CURRENT_TIMESTAMP - INTERVAL '5 days', 'custom'::t_scan_history_detail_scan_scope, '/home/user/downloads', 'virus'::t_scan_history_detail_scan_type,
 1200, 3, 1200,
 '正在扫描'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '5 days', NULL, 'auto', 'TASK-002'),

-- ==========================================
-- 场景3：网站后门检测（全盘，已完成）
-- ==========================================
(8003, 6002, '10.20.30.40', '10.0.2.200',
 CURRENT_TIMESTAMP - INTERVAL '7 days', 'full'::t_scan_history_detail_scan_scope, NULL, 'site'::t_scan_history_detail_scan_type,
 800, 5, 800,
 '扫描完成'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '7 days' + INTERVAL '1 hour', 'manual', 'TASK-003'),

-- ==========================================
-- 场景4：网站后门检测（自定义路径，扫描失败）
-- ==========================================
(8004, 6002, '10.20.30.41', '10.0.2.200',
 CURRENT_TIMESTAMP - INTERVAL '3 days', 'custom'::t_scan_history_detail_scan_scope, '/var/www/html', 'site'::t_scan_history_detail_scan_type,
 200, 0, 200,
 '扫描失败'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '3 days' + INTERVAL '10 minutes', 'auto', 'TASK-004'),

-- ==========================================
-- 场景5：漏洞补丁扫描（全盘，已完成）
-- ==========================================
(8005, 6003, '172.16.0.100', '10.0.3.300',
 CURRENT_TIMESTAMP - INTERVAL '2 days', 'full'::t_scan_history_detail_scan_scope, NULL, 'vulnerability'::t_scan_history_detail_scan_type,
 3000, 20, 3000,
 '扫描完成'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP - INTERVAL '2 days' + INTERVAL '3 hours', 'manual', 'TASK-005'),

-- ==========================================
-- 场景6：病毒扫描（全盘，扫描失败）
-- ==========================================
(8006, 6001, '192.168.20.100', '10.0.1.100',
 CURRENT_TIMESTAMP - INTERVAL '1 day', 'full'::t_scan_history_detail_scan_scope, NULL, 'virus'::t_scan_history_detail_scan_type,
 4500, 0, 4500,
 '扫描失败'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '1 day' + INTERVAL '5 minutes', 'auto', 'TASK-006'),

-- ==========================================
-- 场景7：漏洞补丁扫描（自定义，正在扫描）
-- ==========================================
(8007, 6003, '172.16.0.101', '10.0.3.300',
 CURRENT_TIMESTAMP - INTERVAL '12 hours', 'custom'::t_scan_history_detail_scan_scope, '/opt/app', 'vulnerability'::t_scan_history_detail_scan_type,
 600, 5, NULL,
 '正在扫描'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '12 hours', NULL, 'manual', 'TASK-007'),

-- ==========================================
-- 场景8：网站后门（全盘，已完成）
-- ==========================================
(8008, 6002, '10.20.30.42', '10.0.2.200',
 CURRENT_TIMESTAMP - INTERVAL '20 days', 'full'::t_scan_history_detail_scan_scope, NULL, 'site'::t_scan_history_detail_scan_type,
 1000, 10, 1000,
 '扫描完成'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_TIMESTAMP - INTERVAL '20 days' + INTERVAL '1 hour 30 minutes', 'auto', 'TASK-008'),

-- ==========================================
-- 场景9：病毒扫描（自定义，已完成）
-- ==========================================
(8009, 6001, '192.168.30.200', '10.0.1.100',
 CURRENT_TIMESTAMP - INTERVAL '30 days', 'custom'::t_scan_history_detail_scan_scope, '/tmp', 'virus'::t_scan_history_detail_scan_type,
 300, 2, 300,
 '扫描完成'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '30 days' + INTERVAL '20 minutes', 'manual', 'TASK-009'),

-- ==========================================
-- 场景10：漏洞补丁扫描（全盘，扫描失败）
-- ==========================================
(8010, 6003, '172.16.0.102', '10.0.3.300',
 CURRENT_TIMESTAMP - INTERVAL '60 days', 'full'::t_scan_history_detail_scan_scope, NULL, 'vulnerability'::t_scan_history_detail_scan_type,
 2000, 0, 2000,
 '扫描失败'::t_scan_history_detail_status, CURRENT_TIMESTAMP - INTERVAL '60 days', CURRENT_TIMESTAMP - INTERVAL '60 days' + INTERVAL '2 minutes', 'auto', 'TASK-010');

SELECT setval('"t_scan_history_detail_id_seq"', 8010, true);

-- ================================================================
-- 验证数据统计
-- ================================================================
SELECT 
    scan_type AS "扫描类型",
    COUNT(*) AS "数量",
    STRING_AGG(DISTINCT status::text, ', ') AS "状态"
FROM t_scan_history_detail
WHERE id >= 8001 AND id <= 8010
GROUP BY scan_type;

SELECT 
    status AS "状态",
    COUNT(*) AS "数量",
    STRING_AGG(DISTINCT source, ', ') AS "来源"
FROM t_scan_history_detail
WHERE id >= 8001 AND id <= 8010
GROUP BY status;

SELECT 
    tshd.strategy_id AS "策略ID",
    tls.strategy_name AS "策略名称",
    COUNT(*) AS "扫描次数"
FROM t_scan_history_detail tshd
LEFT JOIN t_linked_strategy tls ON tshd.strategy_id = tls.id
WHERE tshd.id >= 8001 AND tshd.id <= 8010
GROUP BY tshd.strategy_id, tls.strategy_name;
