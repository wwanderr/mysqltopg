-- ============================================
-- 测试数据：Intelligence（威胁情报）
-- 主表：t_intelligence_sub (威胁情报汇总表)
-- 关联表：t_intelligence_sub_asset (威胁情报资产关联表)
-- 生成时间：2026-01-26
-- ============================================

-- ==========================================
-- 1. 先插入主表 t_intelligence_sub 数据
-- ==========================================
DELETE FROM "t_intelligence_sub" WHERE id >= 1001 AND id <= 1005;

INSERT INTO "t_intelligence_sub" (
    "id", "ioc", "sub_category", "alarm_name", "threat_severity",
    "counts", "tag", "alarm_status", "event_time",
    "start_time", "end_time", "update_time", "asset_count"
) VALUES 

-- ==========================================
-- 场景1：僵尸网络C&C服务器（高危，3个受影响资产）
-- ==========================================
(1001, '203.0.113.50', '/Malware/BotTrojWorm', '僵尸网络C&C通信检测', 7,
150, 'botnet_c2', 0, CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '10 minutes',
CURRENT_TIMESTAMP - INTERVAL '10 minutes', 3),

-- ==========================================
-- 场景2：钓鱼域名（高危，2个受影响资产）
-- ==========================================
(1002, 'evil-phishing-site.com', '/SuspTraffic/Phishing', '钓鱼网站访问检测', 7,
25, 'phishing', 1, CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour',
CURRENT_TIMESTAMP - INTERVAL '1 hour', 2),

-- ==========================================
-- 场景3：恶意软件分发站点（中危，已处置）
-- ==========================================
(1003, '198.51.100.88', '/Malware/Ransomware', '勒索软件下载检测', 6,
5, 'malware_dist', 2, CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '20 hours',
CURRENT_TIMESTAMP - INTERVAL '20 hours', 1),

-- ==========================================
-- 场景4：扫描器IP（低危，大量资产受影响）
-- ==========================================
(1004, '185.220.101.10', '/Scan/PortScan', '端口扫描行为检测', 3,
500, 'scanner', 0, CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '30 minutes',
CURRENT_TIMESTAMP - INTERVAL '30 minutes', 5),

-- ==========================================
-- 场景5：APT组织基础设施（极高危，1个关键资产）
-- ==========================================
(1005, '192.0.2.200', '/AdvancedThreat/APT', 'APT攻击基础设施检测', 7,
10, 'apt_critical', 1, CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '10 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours',
CURRENT_TIMESTAMP - INTERVAL '2 hours', 1);

SELECT setval('t_intelligence_sub_id_seq', (SELECT MAX(id) FROM t_intelligence_sub), true);

-- ==========================================
-- 2. 插入关联表 t_intelligence_sub_asset 数据
-- ==========================================
DELETE FROM "t_intelligence_sub_asset" WHERE id >= 2001 AND id <= 2012;

INSERT INTO "t_intelligence_sub_asset" (
    "id", "ioc", "asset_ip", "event_time",
    "start_time", "end_time", "alarm_status", "counts",
    "tag", "security_zone", "create_time", "update_time"
) VALUES 

-- ==========================================
-- IoC 1: 僵尸网络C&C - 3个受影响资产
-- ==========================================
(2001, '203.0.113.50', '192.168.10.50', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '10 minutes',
0, 80, 'botnet_c2', 'DMZ区', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '10 minutes'),

(2002, '203.0.113.50', '192.168.10.51', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes', CURRENT_TIMESTAMP - INTERVAL '20 minutes',
0, 45, 'botnet_c2', 'DMZ区', CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes', CURRENT_TIMESTAMP - INTERVAL '20 minutes'),

(2003, '203.0.113.50', '192.168.10.52', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '15 minutes',
0, 25, 'botnet_c2', 'DMZ区', CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '15 minutes'),

-- ==========================================
-- IoC 2: 钓鱼域名 - 2个受影响资产
-- ==========================================
(2004, 'evil-phishing-site.com', '192.168.20.100', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour',
1, 15, 'phishing', '办公区', CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour'),

(2005, 'evil-phishing-site.com', '192.168.20.101', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '4 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours',
1, 10, 'phishing', '办公区', CURRENT_TIMESTAMP - INTERVAL '4 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours'),

-- ==========================================
-- IoC 3: 恶意软件分发 - 1个受影响资产（已处置）
-- ==========================================
(2006, '198.51.100.88', '192.168.30.50', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '20 hours',
2, 5, 'malware_dist', '服务器区', CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '20 hours'),

-- ==========================================
-- IoC 4: 扫描器IP - 5个受影响资产
-- ==========================================
(2007, '185.220.101.10', '192.168.40.10', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '1 hour',
0, 100, 'scanner', '生产区', CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '1 hour'),

(2008, '185.220.101.10', '192.168.40.11', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '2 hours',
0, 100, 'scanner', '生产区', CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '2 hours'),

(2009, '185.220.101.10', '192.168.40.12', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '3 hours',
0, 100, 'scanner', '生产区', CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '3 hours'),

(2010, '185.220.101.10', '192.168.40.13', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '4 hours',
0, 100, 'scanner', '生产区', CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '4 hours'),

(2011, '185.220.101.10', '192.168.40.14', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '30 minutes',
0, 100, 'scanner', '生产区', CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP - INTERVAL '30 minutes'),

-- ==========================================
-- IoC 5: APT基础设施 - 1个关键资产（正在处置）
-- ==========================================
(2012, '192.0.2.200', '192.168.50.100', CURRENT_DATE,
CURRENT_TIMESTAMP - INTERVAL '10 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours',
1, 10, 'apt_critical', '核心区', CURRENT_TIMESTAMP - INTERVAL '10 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours');

SELECT setval('t_intelligence_sub_asset_id_seq', (SELECT MAX(id) FROM t_intelligence_sub_asset), true);

-- ==========================================
-- 3. 为 subList 关联的资产/安全域表补充最小测试数据
--    关联表：t_asset_info, t_ailpha_network_segment, t_ailpha_security_zone
--    仅覆盖上面 t_intelligence_sub_asset 中出现的资产IP
-- ==========================================

-- 清理相关测试数据
DELETE FROM "t_asset_info"
WHERE asset_ip IN (
    '192.168.10.50','192.168.10.51','192.168.10.52',
    '192.168.20.100','192.168.20.101',
    '192.168.30.50',
    '192.168.40.10','192.168.40.11','192.168.40.12','192.168.40.13','192.168.40.14',
    '192.168.50.100'
);

DELETE FROM "t_ailpha_network_segment"
WHERE relation_type = 'SECURITY_ZONE'
  AND relation_id IN ('SEC_DMZ','SEC_OFFICE','SEC_SERVER','SEC_PROD','SEC_CORE');

DELETE FROM "t_ailpha_security_zone"
WHERE id IN ('SEC_DMZ','SEC_OFFICE','SEC_SERVER','SEC_PROD','SEC_CORE');

-- t_ailpha_security_zone：定义几个简单的安全域
INSERT INTO "t_ailpha_security_zone"(id, name, description, icon_path, tag)
VALUES
('SEC_DMZ',    'DMZ区',    'Intelligence 测试数据', NULL, NULL),
('SEC_OFFICE', '办公区',   'Intelligence 测试数据', NULL, NULL),
('SEC_SERVER', '服务器区', 'Intelligence 测试数据', NULL, NULL),
('SEC_PROD',   '生产区',   'Intelligence 测试数据', NULL, NULL),
('SEC_CORE',   '核心区',   'Intelligence 测试数据', NULL, NULL);

-- t_asset_info：为每个资产IP补充基础信息
INSERT INTO "t_asset_info" (
    asset_ip, asset_name, asset_type, asset_tags, "source", asset_ip_num
) VALUES
('192.168.10.50', 'C2-Web-01',     'Server',        '["威胁情报测试"]', '1', '192.168.10.50'),
('192.168.10.51', 'C2-Web-02',     'Server',        '["威胁情报测试"]', '1', '192.168.10.51'),
('192.168.10.52', 'C2-Web-03',     'Server',        '["威胁情报测试"]', '1', '192.168.10.52'),
('192.168.20.100','Phishing-01',   'Server',        '["钓鱼站点"]',     '1', '192.168.20.100'),
('192.168.20.101','Phishing-02',   'Server',        '["钓鱼站点"]',     '1', '192.168.20.101'),
('192.168.30.50', 'Malware-Host',  'Server',        '["恶意软件分发"]', '1', '192.168.30.50'),
('192.168.40.10', 'Scanner-01',    'Server',        '["扫描器"]',       '1', '192.168.40.10'),
('192.168.40.11', 'Scanner-02',    'Server',        '["扫描器"]',       '1', '192.168.40.11'),
('192.168.40.12', 'Scanner-03',    'Server',        '["扫描器"]',       '1', '192.168.40.12'),
('192.168.40.13', 'Scanner-04',    'Server',        '["扫描器"]',       '1', '192.168.40.13'),
('192.168.40.14', 'Scanner-05',    'Server',        '["扫描器"]',       '1', '192.168.40.14'),
('192.168.50.100','APT-Target-01', 'CriticalHost',  '["APT关键资产"]',  '1', '192.168.50.100');

-- t_ailpha_network_segment：为上述资产IP建立 SECURITY_ZONE 映射
INSERT INTO "t_ailpha_network_segment" (
    ip_type, relation_type, relation_id, first_ip, last_ip, network_type, content, "order"
) VALUES
('IPv4','SECURITY_ZONE','SEC_DMZ',    '192.168.10.50','192.168.10.52','IP','192.168.10.50-52',0),
('IPv4','SECURITY_ZONE','SEC_OFFICE', '192.168.20.100','192.168.20.101','IP','192.168.20.100-101',0),
('IPv4','SECURITY_ZONE','SEC_SERVER', '192.168.30.50','192.168.30.50','IP','192.168.30.50',0),
('IPv4','SECURITY_ZONE','SEC_PROD',   '192.168.40.10','192.168.40.14','IP','192.168.40.10-14',0),
('IPv4','SECURITY_ZONE','SEC_CORE',   '192.168.50.100','192.168.50.100','IP','192.168.50.100',0);

-- ==========================================
-- 验证：关联查询测试
-- ==========================================
SELECT 
    ts.id AS "情报ID",
    ts.ioc AS "IoC",
    ts.alarm_name AS "告警名称",
    ts.threat_severity AS "威胁等级",
    ts.counts AS "总次数",
    ts.asset_count AS "受影响资产数",
    ts.tag AS "标签",
    CASE ts.alarm_status
        WHEN 0 THEN '待处理'
        WHEN 1 THEN '处理中'
        WHEN 2 THEN '已处置'
        ELSE '未知'
    END AS "处置状态",
    TO_CHAR(ts.end_time, 'YYYY-MM-DD HH24:MI:SS') AS "最后发生时间"
FROM "t_intelligence_sub" ts
WHERE ts.id >= 1001 AND ts.id <= 1005
ORDER BY ts.threat_severity DESC, ts.end_time DESC;

-- 验证关联资产
SELECT 
    ta.ioc AS "IoC",
    ta.asset_ip AS "资产IP",
    ta.security_zone AS "安全域",
    ta.counts AS "次数",
    ta.tag AS "标签",
    CASE ta.alarm_status
        WHEN 0 THEN '待处理'
        WHEN 1 THEN '处理中'
        WHEN 2 THEN '已处置'
        ELSE '未知'
    END AS "处置状态",
    TO_CHAR(ta.end_time, 'YYYY-MM-DD HH24:MI:SS') AS "最后发生时间"
FROM "t_intelligence_sub_asset" ta
WHERE ta.id >= 2001 AND ta.id <= 2012
ORDER BY ta.ioc, ta.asset_ip;

-- ==========================================
-- 统计信息
-- ==========================================
SELECT 
    '威胁情报总数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_intelligence_sub"
WHERE id >= 1001 AND id <= 1005
UNION ALL
SELECT 
    '受影响资产总数',
    COUNT(*) 
FROM "t_intelligence_sub_asset"
WHERE id >= 2001 AND id <= 2012
UNION ALL
SELECT 
    '待处理情报数',
    COUNT(*) 
FROM "t_intelligence_sub"
WHERE id >= 1001 AND id <= 1005 AND alarm_status = 0;

-- 按威胁等级统计
SELECT 
    CASE threat_severity
        WHEN 7 THEN '高危'
        WHEN 6 THEN '中危'
        WHEN 3 THEN '低危'
        ELSE '未知'
    END AS "威胁等级",
    COUNT(*) AS "情报数量",
    SUM(asset_count) AS "受影响资产数",
    SUM(counts) AS "总告警次数"
FROM "t_intelligence_sub"
WHERE id >= 1001 AND id <= 1005
GROUP BY threat_severity
ORDER BY threat_severity DESC;

-- 按安全域统计受影响资产
SELECT 
    security_zone AS "安全域",
    COUNT(*) AS "受影响资产数",
    SUM(counts) AS "告警次数"
FROM "t_intelligence_sub_asset"
WHERE id >= 2001 AND id <= 2012
GROUP BY security_zone
ORDER BY "告警次数" DESC;

-- ==========================================
-- 测试说明
-- ==========================================
-- ✅ saveOrUpdateBatch: 批量插入或更新情报（支持 ON CONFLICT）
-- ✅ insertIoCAsset: 批量插入资产关联（支持 ON CONFLICT）
-- ✅ list/listCount: 查询情报列表和统计（支持跨天聚合 isCrossDay）
-- ✅ subList/subListCount: 查询资产列表和统计
-- ✅ updateList: 批量更新情报处置状态
-- ✅ updateAssetList: 批量更新资产处置状态
-- ✅ updateListFromAsset: 从资产状态更新情报状态
-- ✅ proportion: 按类型统计占比
-- ✅ top5: 查询TOP5威胁情报
-- ✅ updateTag: 更新情报标签
-- ✅ updateAssetTag: 更新资产标签
--
-- ⚠️ 注意：
-- 1. **ioc** 字段名（小写，注意Mapper中写的是 ioC）
-- 2. threat_severity: 7=高危, 6=中危, 3=低危
-- 3. alarm_status: 0=待处理, 1=处理中, 2=已处置
-- 4. event_time: DATE类型（仅日期）
-- 5. 唯一约束：(event_time, ioc) 和 (ioc, asset_ip, event_time)
-- 6. asset_count: 从 t_intelligence_sub_asset 统计得出
