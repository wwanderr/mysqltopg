-- ============================================
-- PostgreSQL FDW 跨库查询配置脚本
-- bigdata_web 数据库连接配置
-- ============================================

-- ⚠️ 请先修改以下配置信息 ⚠️
-- 1. host: bigdata_web 数据库的 IP 地址
-- 2. port: bigdata_web 数据库的端口（通常是 5432）
-- 3. user: 连接用户名
-- 4. password: 连接密码

-- ============================================
-- 步骤1: 安装 postgres_fdw 扩展
-- ============================================
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

\echo '✅ 步骤1完成: postgres_fdw 扩展已安装'

-- ============================================
-- 步骤2: 创建外部服务器
-- ============================================
-- 如果已存在，先删除
DROP SERVER IF EXISTS bigdata_web_server CASCADE;

CREATE SERVER bigdata_web_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (
        host '192.168.1.100',        -- ⚠️ 修改为实际 IP 地址
        port '5432',                 -- ⚠️ 修改为实际端口
        dbname 'bigdata_web',
        fetch_size '1000'            -- 批量获取优化
    );

\echo '✅ 步骤2完成: 外部服务器已创建'

-- ============================================
-- 步骤3: 创建用户映射
-- ============================================
-- 如果已存在，先删除
DROP USER MAPPING IF EXISTS FOR current_user SERVER bigdata_web_server;

CREATE USER MAPPING FOR current_user
    SERVER bigdata_web_server
    OPTIONS (
        user 'bigdata_user',         -- ⚠️ 修改为实际用户名
        password 'bigdata_password'  -- ⚠️ 修改为实际密码
    );

\echo '✅ 步骤3完成: 用户映射已创建'

-- ============================================
-- 步骤4: 创建本地 schema
-- ============================================
CREATE SCHEMA IF NOT EXISTS bigdata_web;

\echo '✅ 步骤4完成: bigdata_web schema 已创建'

-- ============================================
-- 步骤5: 导入外部表
-- ============================================
IMPORT FOREIGN SCHEMA public
    LIMIT TO (
        t_asset_info,
        t_ailpha_network_segment,
        t_ailpha_security_zone,
        t_vulnerability_info,
        t_third_auth
    )
    FROM SERVER bigdata_web_server
    INTO bigdata_web;

\echo '✅ 步骤5完成: 外部表已导入'

-- ============================================
-- 步骤6: 验证配置
-- ============================================
\echo ''
\echo '=========================================='
\echo '配置验证'
\echo '=========================================='

-- 显示导入的外部表
\echo ''
\echo '已导入的外部表:'
SELECT 
    foreign_table_schema AS schema, 
    foreign_table_name AS table_name
FROM information_schema.foreign_tables 
WHERE foreign_table_schema = 'bigdata_web'
ORDER BY foreign_table_name;

-- ============================================
-- 步骤7: 测试查询
-- ============================================
\echo ''
\echo '=========================================='
\echo '测试查询'
\echo '=========================================='

-- 测试1: 统计各表记录数
\echo ''
\echo '表记录数统计:'
SELECT 't_asset_info' AS table_name, COUNT(*) AS record_count 
FROM bigdata_web.t_asset_info
UNION ALL
SELECT 't_ailpha_network_segment', COUNT(*) 
FROM bigdata_web.t_ailpha_network_segment
UNION ALL
SELECT 't_ailpha_security_zone', COUNT(*) 
FROM bigdata_web.t_ailpha_security_zone
UNION ALL
SELECT 't_vulnerability_info', COUNT(*) 
FROM bigdata_web.t_vulnerability_info
UNION ALL
SELECT 't_third_auth', COUNT(*) 
FROM bigdata_web.t_third_auth;

-- 测试2: 测试 JOIN 查询（来自 SecurityZoneSyncMapper.xml）
\echo ''
\echo '测试跨表查询（前10条）:'
SELECT 
    ti.assetIp, 
    f."name" as security_zone_name, 
    f.id as zone_id
FROM bigdata_web.t_asset_info ti
RIGHT JOIN bigdata_web.t_ailpha_network_segment e
    ON e.relation_type='SECURITY_ZONE' 
    AND ti.assetIpNum BETWEEN e.first_ip AND e.last_ip
LEFT JOIN bigdata_web.t_ailpha_security_zone f 
    ON e.relation_id = f.id
WHERE f.id IS NOT NULL
LIMIT 10;

-- ============================================
-- 完成
-- ============================================
\echo ''
\echo '=========================================='
\echo '✅ FDW 配置完成！'
\echo '=========================================='
\echo ''
\echo '现在你的应用可以直接使用 bigdata_web.table_name 进行查询'
\echo 'XML 文件无需任何修改！'
\echo ''
