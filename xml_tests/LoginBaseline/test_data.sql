-- ================================================================
-- 测试数据：LoginBaseline（登录基线）
-- 表: t_scene_login_baseline
-- 生成时间: 2026-01-28
-- ================================================================

-- 清理测试数据
DELETE FROM "t_scene_login_baseline" 
WHERE dest_address IN ('192.168.100.10', '192.168.100.11', '192.168.100.12', '192.168.100.13', '192.168.100.14');

-- ================================================================
-- 插入测试数据
-- ================================================================

INSERT INTO "t_scene_login_baseline" (
    "dest_address",
    "src_user_name",
    "last_login_time",
    "city_counts",
    "city_array",
    "create_time",
    "update_time"
) VALUES
-- 场景1: 管理员用户 - 多城市登录
(
    '192.168.100.10',
    'admin',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    '{"Beijing": 150, "Shanghai": 80, "Shenzhen": 30}',
    'Beijing,Shanghai,Shenzhen',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
),

-- 场景2: 普通用户 - 单一城市登录
(
    '192.168.100.11',
    'analyst001',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    '{"Beijing": 200}',
    'Beijing',
    CURRENT_TIMESTAMP - INTERVAL '20 days',
    CURRENT_TIMESTAMP - INTERVAL '2 hours'
),

-- 场景3: 运维用户 - 三城市登录
(
    '192.168.100.12',
    'operator',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    '{"Guangzhou": 120, "Hangzhou": 100, "Chengdu": 90}',
    'Guangzhou,Hangzhou,Chengdu',
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes'
),

-- 场景4: 测试用户 - 两城市登录
(
    '192.168.100.13',
    'tester',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes',
    '{"Shanghai": 50, "Nanjing": 30}',
    'Shanghai,Nanjing',
    CURRENT_TIMESTAMP - INTERVAL '15 days',
    CURRENT_TIMESTAMP - INTERVAL '10 minutes'
),

-- 场景5: 审计用户 - 固定城市登录
(
    '192.168.100.14',
    'auditor',
    CURRENT_TIMESTAMP - INTERVAL '5 minutes',
    '{"Beijing": 300}',
    'Beijing',
    CURRENT_TIMESTAMP - INTERVAL '45 days',
    CURRENT_TIMESTAMP - INTERVAL '5 minutes'
)
ON CONFLICT (dest_address, src_user_name) 
DO UPDATE SET 
    last_login_time = EXCLUDED.last_login_time,
    city_counts = EXCLUDED.city_counts,
    city_array = EXCLUDED.city_array,
    update_time = EXCLUDED.update_time;

-- ================================================================
-- 说明
-- ================================================================
-- 表名: t_scene_login_baseline (注意是 scene_ 前缀)
--
-- 主键: (dest_address, src_user_name)
--   - dest_address: 目的IP
--   - src_user_name: 用户名
--
-- city_counts: JSON数据，记录各城市登录次数
--   格式: {"城市1": 次数1, "城市2": 次数2, ...}
--
-- city_array: 排名前三的城市数组
--   格式: "城市1,城市2,城市3"
--
-- ================================================================
-- 验证数据
-- ================================================================
-- SELECT * FROM "t_scene_login_baseline" 
-- WHERE dest_address IN ('192.168.100.10', '192.168.100.11', '192.168.100.12', '192.168.100.13', '192.168.100.14')
-- ORDER BY dest_address;
