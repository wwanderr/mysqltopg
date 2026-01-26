/*
 * Flyway Migration: Setup Foreign Data Wrapper for bigdata_web
 * Generated: 2026-01-22
 * Purpose: Configure FDW to connect to remote bigdata_web database
 */

-- ============================================
-- 配置说明
-- ============================================
-- 本脚本配置到 bigdata_web 数据库的外部数据包装器（FDW）
-- 需要访问的远程表：
--   - t_asset_info
--   - t_ailpha_network_segment
--   - t_ailpha_security_zone
--   - t_vulnerability_info
--   - t_third_auth

-- ⚠️ 执行前请修改以下配置信息：
--   1. host: bigdata_web 数据库的 IP 地址（第30行）
--   2. port: bigdata_web 数据库的端口（第31行）
--   3. user: 连接用户名（第41行）
--   4. password: 连接密码（第42行）

-- ============================================
-- 步骤1: 安装 postgres_fdw 扩展
-- ============================================
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

-- ============================================
-- 步骤2: 创建外部服务器
-- ============================================
-- 如果已存在，先删除（幂等性）
DROP SERVER IF EXISTS bigdata_web_server CASCADE;

CREATE SERVER bigdata_web_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (
        host '192.168.1.100',        -- ⚠️ 修改为 bigdata_web 数据库的实际 IP
        port '5432',                 -- ⚠️ 修改为实际端口
        dbname 'bigdata_web',
        fetch_size '1000'            -- 批量获取优化
    );

-- ============================================
-- 步骤3: 创建用户映射
-- ============================================
-- 为当前数据库的所有用户创建映射（可根据需要调整）
CREATE USER MAPPING IF NOT EXISTS FOR PUBLIC
    SERVER bigdata_web_server
    OPTIONS (
        user 'bigdata_user',         -- ⚠️ 修改为 bigdata_web 的实际用户名
        password 'bigdata_password'  -- ⚠️ 修改为实际密码
    );

-- ============================================
-- 步骤4: 创建本地 schema
-- ============================================
CREATE SCHEMA IF NOT EXISTS bigdata_web;

-- ============================================
-- 步骤5: 导入外部表
-- ============================================
-- 先删除已存在的外部表（如果有）
DROP FOREIGN TABLE IF EXISTS bigdata_web.t_asset_info CASCADE;
DROP FOREIGN TABLE IF EXISTS bigdata_web.t_ailpha_network_segment CASCADE;
DROP FOREIGN TABLE IF EXISTS bigdata_web.t_ailpha_security_zone CASCADE;
DROP FOREIGN TABLE IF EXISTS bigdata_web.t_vulnerability_info CASCADE;
DROP FOREIGN TABLE IF EXISTS bigdata_web.t_third_auth CASCADE;

-- 导入指定的外部表
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

-- ============================================
-- 步骤6: 添加注释说明
-- ============================================
COMMENT ON SCHEMA bigdata_web IS '外部数据包装器 - 连接到 bigdata_web 数据库';
COMMENT ON SERVER bigdata_web_server IS 'FDW 服务器 - bigdata_web 数据库连接';

COMMENT ON FOREIGN TABLE bigdata_web.t_asset_info IS '外部表 - 资产信息表';
COMMENT ON FOREIGN TABLE bigdata_web.t_ailpha_network_segment IS '外部表 - 网络段表';
COMMENT ON FOREIGN TABLE bigdata_web.t_ailpha_security_zone IS '外部表 - 安全区域表';
COMMENT ON FOREIGN TABLE bigdata_web.t_vulnerability_info IS '外部表 - 漏洞信息表';
COMMENT ON FOREIGN TABLE bigdata_web.t_third_auth IS '外部表 - 第三方认证表';

-- ============================================
-- 完成
-- ============================================
-- FDW 配置完成
-- 现在可以在 SQL 中使用 bigdata_web.table_name 访问远程表
