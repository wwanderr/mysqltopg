-- ============================================
-- 测试数据：EventOutGoingConfig（事件外发配置）
-- 表：t_event_out_going_config
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_event_out_going_config" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_event_out_going_config" (
    "id", "sub_category", "threat_severity", "alarm_results", "enable", 
    "mapping_config_path", "last_send_time", "last_send_result", "cause_of_failure", 
    "is_del", "send_count", "succeed_count", "create_time", "update_time"
) VALUES 

-- 场景1：高危和严重事件外发 - 启用中
(1001, '["SQL注入", "命令注入", "远程代码执行"]', '["high", "critical"]', '["成功", "失败"]', 1, 
'/config/mapping/high-severity-events.json', 
CURRENT_TIMESTAMP - INTERVAL '2 hours', '成功', NULL, 0, 
150, 148, 
CURRENT_TIMESTAMP - INTERVAL '180 days', CURRENT_TIMESTAMP - INTERVAL '2 hours'),

-- 场景2：DDoS攻击事件外发 - 启用中
(1002, '["DDoS", "流量攻击", "洪水攻击"]', '["medium", "high", "critical"]', '["成功", "部分成功"]', 1, 
'/config/mapping/ddos-events.json', 
CURRENT_TIMESTAMP - INTERVAL '1 hour', '成功', NULL, 0, 
85, 83, 
CURRENT_TIMESTAMP - INTERVAL '90 days', CURRENT_TIMESTAMP - INTERVAL '1 hour'),

-- 场景3：恶意软件事件外发 - 启用中，但最近发送失败
(1003, '["木马", "病毒", "勒索软件", "后门"]', '["high", "critical"]', '["已隔离", "已清除"]', 1, 
'/config/mapping/malware-events.json', 
CURRENT_TIMESTAMP - INTERVAL '30 minutes', '失败', '目标服务器连接超时', 0, 
42, 38, 
CURRENT_TIMESTAMP - INTERVAL '60 days', CURRENT_TIMESTAMP - INTERVAL '30 minutes'),

-- 场景4：测试配置 - 已禁用
(1004, '["端口扫描", "暴力破解"]', '["low", "medium"]', '["已拦截"]', 0, 
'/config/mapping/test-events.json', 
CURRENT_TIMESTAMP - INTERVAL '7 days', '成功', NULL, 0, 
10, 10, 
CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '7 days'),

-- 场景5：待删除配置 - 准备删除
(1005, '["数据泄露", "敏感信息外传"]', '["critical"]', '["已阻断"]', 0, 
'/config/mapping/exfiltration-events.json', 
CURRENT_TIMESTAMP - INTERVAL '15 days', '成功', NULL, 0, 
25, 24, 
CURRENT_TIMESTAMP - INTERVAL '200 days', CURRENT_TIMESTAMP - INTERVAL '15 days');

-- 重置序列
SELECT setval('t_event_out_going_config_id_seq', (SELECT MAX(id) FROM t_event_out_going_config), true);

-- 验证插入结果
SELECT 
    id, 
    sub_category, 
    threat_severity, 
    enable, 
    last_send_time, 
    last_send_result, 
    send_count, 
    succeed_count,
    is_del
FROM "t_event_out_going_config"
WHERE id >= 1001 AND id <= 1005
ORDER BY id;
