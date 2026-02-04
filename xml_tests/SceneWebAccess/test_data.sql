-- 测试数据：SceneWebAccess（场景Web访问临时数据）
-- 表名：t_scene_web_access_temp
-- 
-- 测试场景说明：
-- 1. 正常URL：event_count 总和 > 5 的 URL（用于测试 selectNormalUrlCount）
-- 2. 异常URL：event_count 总和 < 3 的 URL（用于测试 selectAbnormalUrlList）
-- 3. 不同主机名：用于测试 groupByDestHostName
-- 4. 时间范围：用于测试时间过滤和 deleteByCreateTime

-- 清理测试数据（删除测试主机名的数据）
DELETE FROM "t_scene_web_access_temp" 
WHERE "dest_host_name" IN ('test-host.example.com', 'test-host2.example.com', 'test-host3.example.com')
   OR "id" BETWEEN 10001 AND 10050;

-- 插入测试数据
-- 注意：id 字段需要手动指定（表没有序列），确保不冲突
-- create_time 使用 CURRENT_TIMESTAMP 或指定时间

-- ============================================
-- 测试数据组1：test-host.example.com（正常URL和异常URL混合）
-- ============================================

-- 正常URL 1：/api/user/login - 事件数量总和 = 10（> 5，属于正常URL）
INSERT INTO "t_scene_web_access_temp" ("id", "src_address", "dest_address", "request_url", "dest_host_name", "event_count", "create_time") VALUES
(10001, '192.168.1.10', '10.0.0.1', '/api/user/login', 'test-host.example.com', 5, CURRENT_TIMESTAMP - INTERVAL '2 days'),
(10002, '192.168.1.11', '10.0.0.1', '/api/user/login', 'test-host.example.com', 3, CURRENT_TIMESTAMP - INTERVAL '2 days'),
(10003, '192.168.1.12', '10.0.0.1', '/api/user/login', 'test-host.example.com', 2, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- 正常URL 2：/api/data/export - 事件数量总和 = 8（> 5，属于正常URL）
INSERT INTO "t_scene_web_access_temp" ("id", "src_address", "dest_address", "request_url", "dest_host_name", "event_count", "create_time") VALUES
(10004, '192.168.1.20', '10.0.0.1', '/api/data/export', 'test-host.example.com', 4, CURRENT_TIMESTAMP - INTERVAL '3 days'),
(10005, '192.168.1.21', '10.0.0.1', '/api/data/export', 'test-host.example.com', 4, CURRENT_TIMESTAMP - INTERVAL '2 days');

-- 异常URL 1：/api/admin/delete - 事件数量总和 = 2（< 3，属于异常URL）
INSERT INTO "t_scene_web_access_temp" ("id", "src_address", "dest_address", "request_url", "dest_host_name", "event_count", "create_time") VALUES
(10006, '192.168.1.30', '10.0.0.1', '/api/admin/delete', 'test-host.example.com', 1, CURRENT_TIMESTAMP - INTERVAL '4 days'),
(10007, '192.168.1.31', '10.0.0.1', '/api/admin/delete', 'test-host.example.com', 1, CURRENT_TIMESTAMP - INTERVAL '3 days');

-- 异常URL 2：/api/config/update - 事件数量总和 = 1（< 3，属于异常URL）
INSERT INTO "t_scene_web_access_temp" ("id", "src_address", "dest_address", "request_url", "dest_host_name", "event_count", "create_time") VALUES
(10008, '192.168.1.40', '10.0.0.1', '/api/config/update', 'test-host.example.com', 1, CURRENT_TIMESTAMP - INTERVAL '5 days');

-- 正常URL 3：/api/report/generate - 事件数量总和 = 6（> 5，属于正常URL）
INSERT INTO "t_scene_web_access_temp" ("id", "src_address", "dest_address", "request_url", "dest_host_name", "event_count", "create_time") VALUES
(10009, '192.168.1.50', '10.0.0.1', '/api/report/generate', 'test-host.example.com', 6, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- ============================================
-- 测试数据组2：test-host2.example.com（用于测试多主机统计）
-- ============================================

INSERT INTO "t_scene_web_access_temp" ("id", "src_address", "dest_address", "request_url", "dest_host_name", "event_count", "create_time") VALUES
(10010, '192.168.2.10', '10.0.0.2', '/api/user/info', 'test-host2.example.com', 3, CURRENT_TIMESTAMP - INTERVAL '2 days'),
(10011, '192.168.2.11', '10.0.0.2', '/api/user/info', 'test-host2.example.com', 2, CURRENT_TIMESTAMP - INTERVAL '1 day'),
(10012, '192.168.2.12', '10.0.0.2', '/api/data/list', 'test-host2.example.com', 4, CURRENT_TIMESTAMP - INTERVAL '3 days');

-- ============================================
-- 测试数据组3：test-host3.example.com（用于测试多主机统计）
-- ============================================

INSERT INTO "t_scene_web_access_temp" ("id", "src_address", "dest_address", "request_url", "dest_host_name", "event_count", "create_time") VALUES
(10013, '192.168.3.10', '10.0.0.3', '/api/system/status', 'test-host3.example.com', 5, CURRENT_TIMESTAMP - INTERVAL '2 days'),
(10014, '192.168.3.11', '10.0.0.3', '/api/system/status', 'test-host3.example.com', 3, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- ============================================
-- 测试数据组4：用于测试 deleteByCreateTime（30天前的数据）
-- ============================================

INSERT INTO "t_scene_web_access_temp" ("id", "src_address", "dest_address", "request_url", "dest_host_name", "event_count", "create_time") VALUES
(10015, '192.168.4.10', '10.0.0.1', '/api/old/data', 'test-host.example.com', 1, CURRENT_TIMESTAMP - INTERVAL '35 days'),
(10016, '192.168.4.11', '10.0.0.1', '/api/old/data', 'test-host.example.com', 1, CURRENT_TIMESTAMP - INTERVAL '32 days');

-- ============================================
-- 验证插入的数据
-- ============================================

-- 验证 test-host.example.com 的数据
SELECT 
    request_url,
    SUM(event_count) AS total_count,
    COUNT(*) AS record_count
FROM "t_scene_web_access_temp"
WHERE "dest_host_name" = 'test-host.example.com'
GROUP BY request_url
ORDER BY total_count DESC;

-- 验证所有主机名的统计
SELECT 
    dest_host_name,
    SUM(event_count) AS total_access_count,
    COUNT(DISTINCT request_url) AS url_count
FROM "t_scene_web_access_temp"
WHERE "dest_host_name" IN ('test-host.example.com', 'test-host2.example.com', 'test-host3.example.com')
GROUP BY dest_host_name
ORDER BY dest_host_name;

-- 说明：
-- 1. test-host.example.com 包含：
--    - 正常URL（event_count总和 > 5）：/api/user/login(10), /api/data/export(8), /api/report/generate(6)
--    - 异常URL（event_count总和 < 3）：/api/admin/delete(2), /api/config/update(1)
--    - 预期结果：selectNormalUrlCount(阈值=5) 应返回 3，selectAbnormalUrlList(阈值=3) 应返回 2个URL
-- 
-- 2. test-host2.example.com 和 test-host3.example.com 用于测试 groupByDestHostName
-- 
-- 3. 30天前的数据用于测试 deleteByCreateTime
