-- ============================================
-- 测试数据：SecurityZoneSync（安全域同步）
-- 关联表：t_asset_info, t_ailpha_network_segment, t_ailpha_security_zone
-- SQL查询：RIGHT JOIN + LEFT JOIN（3表关联）
-- 生成时间：2026-01-28（深度修复）
-- ============================================

-- ==========================================
-- 表1：t_ailpha_security_zone（安全域主表）
-- ==========================================
DELETE FROM bigdata_web.t_ailpha_security_zone WHERE id >= 101 AND id <= 103;

INSERT INTO bigdata_web.t_ailpha_security_zone ("id", "name") VALUES
(101, '生产环境安全域'),
(102, '办公网络安全域'),
(103, '测试环境安全域');

-- ==========================================
-- 表2：t_ailpha_network_segment（网段表）
-- ==========================================
DELETE FROM bigdata_web.t_ailpha_network_segment WHERE id >= 201 AND id <= 205;

INSERT INTO bigdata_web.t_ailpha_network_segment 
("id", "relation_type", "relation_id", "first_ip", "last_ip") VALUES
(201, 'SECURITY_ZONE', 101, inet_aton('192.168.1.0'), inet_aton('192.168.1.255')),  -- 生产环境
(202, 'SECURITY_ZONE', 102, inet_aton('192.168.10.0'), inet_aton('192.168.10.255')), -- 办公网络
(203, 'SECURITY_ZONE', 102, inet_aton('192.168.11.0'), inet_aton('192.168.11.255')), -- 办公网络（第2段）
(204, 'SECURITY_ZONE', 103, inet_aton('192.168.100.0'), inet_aton('192.168.100.255')), -- 测试环境
(205, 'OTHER_TYPE', 999, inet_aton('10.0.0.0'), inet_aton('10.0.0.255')); -- 非安全域（不会被查询到）

-- ==========================================
-- 表3：t_asset_info（资产表）
-- ==========================================
DELETE FROM bigdata_web.t_asset_info WHERE "assetIp" IN ('192.168.1.50', '192.168.1.100', '192.168.10.20', '192.168.11.30', '192.168.100.50');

INSERT INTO bigdata_web.t_asset_info ("asset_ip", "asset_ip_num") VALUES
('192.168.1.50', '192.168.1.50'),    -- 生产环境资产
('192.168.1.100', '192.168.1.100'),  -- 生产环境资产
('192.168.10.20', '192.168.10.20'),  -- 办公网络资产
('192.168.11.30', '192.168.11.30'),  -- 办公网络资产（第2段）
('192.168.100.50', '192.168.100.50'); -- 测试环境资产

-- ==========================================
-- 验证查询：模拟XML中的查询逻辑
-- ==========================================
SELECT
    ti."assetIp" AS "资产IP",
    f."name" AS "安全域名称",
    f.id AS "安全域ID"
FROM
    bigdata_web.t_asset_info ti
RIGHT JOIN bigdata_web.t_ailpha_network_segment e
    ON e.relation_type = 'SECURITY_ZONE' AND ti."assetIpNum" BETWEEN e.first_ip AND e.last_ip
LEFT JOIN bigdata_web.t_ailpha_security_zone f ON e.relation_id = f.id
WHERE f.id IS NOT NULL
ORDER BY f.id, ti."assetIp";

-- ==========================================
-- 预期结果说明
-- ==========================================
-- 生产环境安全域 (ID=101): 192.168.1.50, 192.168.1.100 (2个资产)
-- 办公网络安全域 (ID=102): 192.168.10.20, 192.168.11.30 (2个资产)
-- 测试环境安全域 (ID=103): 192.168.100.50 (1个资产)
-- 总计：5个资产分布在3个安全域
