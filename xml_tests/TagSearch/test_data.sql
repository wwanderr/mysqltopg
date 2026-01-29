-- ================================================================
-- 测试数据：TagSearch（标签搜索）
-- 表: t_tag_search_list (注意表名)
-- 生成时间: 2026-01-28
-- ================================================================

-- 清理测试数据
DELETE FROM "t_tag_search_list" WHERE id >= 4001 AND id <= 4005;

-- 插入测试数据
INSERT INTO "t_tag_search_list" (
    "id", "tag_search", "name", "update_time"
) VALUES
(4001, 'APT攻击', 'APT Attack Detection', CURRENT_TIMESTAMP - INTERVAL '1 hour'),
(4002, '横向移动', 'Lateral Movement', CURRENT_TIMESTAMP - INTERVAL '2 hours'),
(4003, '数据外泄', 'Data Exfiltration', CURRENT_TIMESTAMP - INTERVAL '30 minutes'),
(4004, 'C&C通信', 'C2 Communication', CURRENT_TIMESTAMP - INTERVAL '15 minutes'),
(4005, '恶意软件', 'Malware Detection', CURRENT_TIMESTAMP - INTERVAL '5 minutes');

SELECT setval('"t_tag_search_list_id_seq"', 4005, true);

-- 说明: 表名为 t_tag_search_list
