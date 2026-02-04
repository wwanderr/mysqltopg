-- 测试数据：CommonConfig（通用配置）
-- 注意：使用 DELETE 语句清理测试数据，避免与生产数据冲突
-- 测试数据使用 prefix='test.common' 前缀，确保不会影响业务数据

-- 清理测试数据（如果存在）
DELETE FROM "t_common_config" WHERE "prefix" = 'test.common';

-- 插入测试数据
-- 注意：表结构字段为 prefix, configkey, configvalue
-- id 字段使用序列自动生成，不需要手动指定
INSERT INTO "t_common_config" ("prefix", "configkey", "configvalue") VALUES 
('test.common', 'demo.key', 'test-value-001'),
('test.common', 'demo.key2', 'test-value-002'),
('test.common', 'demo.key3', 'test-value-003'),
('style', 'title', '测试标题'),
('style', 'theme', 'dark'),
('test.common', 'sample.config', 'sample-value-123');

-- 验证插入的数据
SELECT * FROM "t_common_config" WHERE "prefix" = 'test.common' OR ("prefix" = 'style' AND "configkey" = 'title') ORDER BY "prefix", "configkey";

-- 说明：
-- 1. test.common.demo.key 用于测试 insertCommonConfig 和 updateCommonConfig
-- 2. style.title 用于测试 queryCommonConfig（如果业务数据中已有此配置，则能查询到）
-- 3. 其他测试数据用于覆盖不同的查询场景
