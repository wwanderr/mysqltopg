-- ============================================
-- 测试数据：EventScenarioQueue（事件场景队列）
-- 表：t_event_scenario_queue
-- 关联表：t_security_incidents
-- 生成时间：2026-01-26
-- ============================================

-- ==========================================
-- 1. 先插入关联表 t_security_incidents 的数据
-- ==========================================
DELETE FROM "t_security_incidents" 
WHERE event_code IN ('EVT-2026-001', 'EVT-2026-002', 'EVT-2026-003', 'EVT-2026-004', 'EVT-2026-005');

INSERT INTO "t_security_incidents" (
    "id", "event_code", "template_id", "template_code", "event_name", "category", "sub_category",
    "threat_severity", "attacker", "victim", "start_time", "end_time", 
    "counts", "alarm_status", "alarm_results", "kill_chain", "attack_conclusion",
    "focus", "focus_ip", "is_scenario", "create_time", "update_time"
) VALUES 

-- 场景1：APT攻击事件
(5001, 'EVT-2026-001', 1001, 'TMPL-APT', 'APT-28高级持续威胁攻击', 'Advanced Threat', 'APT Attack',
'critical', '192.168.1.100', '192.168.1.200', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP,
25, 'pending', '部分成功', 'Reconnaissance,Initial Access,Execution', 'APT-28组织针对企业内网发起的定向攻击',
'server', '192.168.1.200', 1, CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP),

-- 场景2：横向移动攻击
(5002, 'EVT-2026-002', 1002, 'TMPL-LATERAL', '内网横向移动攻击', 'Network Attack', 'Lateral Movement',
'high', '192.168.1.101', '192.168.1.201', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP,
15, 'pending', '尝试中', 'Lateral Movement,Credential Access', '攻击者在内网中进行横向移动，尝试获取更多权限',
'network', '192.168.1.201', 1, CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP),

-- 场景3：数据外泄事件
(5003, 'EVT-2026-003', 1003, 'TMPL-EXFIL', '敏感数据外传', 'Data Exfiltration', 'Sensitive Data Leak',
'critical', '192.168.1.102', '192.168.1.202', CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours',
1, 'handled', '已阻断', 'Exfiltration', '检测到内部主机向外部服务器传输大量敏感数据',
'database', '192.168.1.102', 1, CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours'),

-- 场景4：旧事件（用于测试清理）
(5004, 'EVT-2026-004', 1004, 'TMPL-OLD', '历史扫描事件', 'Network Attack', 'Port Scan',
'medium', '192.168.1.103', '192.168.1.203', CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '7 days' + INTERVAL '2 hours',
500, 'handled', '已拦截', 'Reconnaissance', '端口扫描攻击已被防火墙拦截',
'server', '192.168.1.203', 1, CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '7 days'),

-- 场景5：多IP扫描事件
(5005, 'EVT-2026-005', 1005, 'TMPL-SCAN', '大规模端口扫描', 'Network Attack', 'Port Scan',
'high', '192.168.1.104', '192.168.1.204', CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP,
1000, 'pending', '进行中', 'Reconnaissance', '检测到针对内网多个IP的大规模端口扫描',
'server', '192.168.1.204', 1, CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP);

-- 重置 t_security_incidents 序列
SELECT setval('t_security_incidents_id_seq', (SELECT MAX(id) FROM t_security_incidents), true);

-- ==========================================
-- 2. 插入事件场景队列数据
-- ==========================================
DELETE FROM "t_event_scenario_queue" 
WHERE event_code IN ('EVT-2026-001', 'EVT-2026-002', 'EVT-2026-003', 'EVT-2026-004', 'EVT-2026-005');

INSERT INTO "t_event_scenario_queue" (
    "focus_ip", "target_ip", "event_code", "scenario_template_id",
    "src_address", "dest_address", "start_time", "end_time", 
    "alarm_info", "time_part", "is_job_commit", "create_time"
) VALUES 

-- 场景1：未提交的APT攻击场景（is_job_commit=false）
('192.168.1.100', '192.168.1.200', 'EVT-2026-001', 1001,
'192.168.1.100', '192.168.1.200', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP,
'[{"windowId":"W001","aggCondition":"APT攻击特征","eventId":"5001","endTime":"2026-01-26 10:00:00"}]',
TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD'), false, CURRENT_TIMESTAMP - INTERVAL '2 hours'),

-- 场景2：未提交的横向移动场景（is_job_commit=false）
('192.168.1.101', '192.168.1.201', 'EVT-2026-002', 1002,
'192.168.1.101', '192.168.1.201', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP,
'[{"windowId":"W002","aggCondition":"横向移动特征","eventId":"5002","endTime":"2026-01-26 11:00:00"}]',
TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD'), false, CURRENT_TIMESTAMP - INTERVAL '1 hour'),

-- 场景3：已提交的数据外泄场景（is_job_commit=true）
('192.168.1.102', '192.168.1.202', 'EVT-2026-003', 1003,
'192.168.1.102', '192.168.1.202', CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours',
'[{"windowId":"W003","aggCondition":"数据外泄特征","eventId":"5003","endTime":"2026-01-26 07:00:00"}]',
TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD'), true, CURRENT_TIMESTAMP - INTERVAL '5 hours'),

-- 场景4：旧数据（7天前，已提交，用于测试清理）
('192.168.1.103', '192.168.1.203', 'EVT-2026-004', 1004,
'192.168.1.103', '192.168.1.203', CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '7 days' + INTERVAL '2 hours',
'[{"windowId":"W004","aggCondition":"端口扫描特征","eventId":"5004"}]',
TO_CHAR(CURRENT_TIMESTAMP - INTERVAL '7 days', 'YYYY-MM-DD'), true, CURRENT_TIMESTAMP - INTERVAL '7 days'),

-- 场景5：多IP扫描场景（未提交）
('192.168.1.104', '192.168.1.204', 'EVT-2026-005', 1005,
'192.168.1.104', '192.168.1.204', CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP,
'[{"windowId":"W005","aggCondition":"大规模扫描特征","eventId":"5005","endTime":"2026-01-26 11:30:00"}]',
TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD'), false, CURRENT_TIMESTAMP - INTERVAL '30 minutes');

-- ==========================================
-- 验证：关联查询测试
-- ==========================================
SELECT 
    t.focus_ip AS "关注IP",
    t.target_ip AS "目标IP",
    t.event_code AS "事件Code",
    i.event_name AS "事件名称",
    i.threat_severity AS "威胁等级",
    CASE WHEN t.is_job_commit THEN '已提交' ELSE '未提交' END AS "提交状态",
    TO_CHAR(t.create_time, 'YYYY-MM-DD HH24:MI:SS') AS "创建时间"
FROM "t_event_scenario_queue" t
INNER JOIN "t_security_incidents" i ON t.event_code = i.event_code
WHERE t.event_code IN ('EVT-2026-001', 'EVT-2026-002', 'EVT-2026-003', 'EVT-2026-004', 'EVT-2026-005')
ORDER BY t.create_time DESC;

-- ==========================================
-- 统计信息
-- ==========================================
SELECT 
    '场景队列总数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_event_scenario_queue"
WHERE event_code LIKE 'EVT-2026-%'
UNION ALL
SELECT 
    '关联事件数',
    COUNT(*) 
FROM "t_security_incidents"
WHERE event_code LIKE 'EVT-2026-%'
UNION ALL
SELECT 
    '未提交队列数',
    COUNT(*) 
FROM "t_event_scenario_queue"
WHERE event_code LIKE 'EVT-2026-%' AND is_job_commit = false;

-- ==========================================
-- 测试说明
-- ==========================================
-- ✅ selectLast: 查询未提交的场景（EVT-2026-001, EVT-2026-002, EVT-2026-005）
--    需要 INNER JOIN t_security_incidents，所以必须有关联数据
--
-- ✅ insertIgnore: 插入时如果主键冲突会被忽略
--    主键：(focus_ip, target_ip, event_code, scenario_template_id)
--
-- ✅ updateSyncSuccessBatch: 批量更新提交状态
--    将指定的场景标记为已提交（is_job_commit=true）
--
-- ✅ tryClean: 清理旧数据
--    删除7天前且已提交的记录（EVT-2026-004）
--
-- ⚠️ 注意：所有测试依赖 t_security_incidents 表的关联数据！
