-- ============================================
-- 测试数据：NoticeHistory（通知历史）
-- 主表：t_notice_history
-- 关联表：t_linked_strategy
-- 生成时间：2026-01-26
-- ============================================

-- ==========================================
-- 1. 先插入关联表 t_linked_strategy 数据
-- ==========================================
DELETE FROM "t_linked_strategy" WHERE id >= 6001 AND id <= 6005;

INSERT INTO "t_linked_strategy" (
    "id", "strategy_name", "auto_handle", "threat_type", "threat_type_config",
    "threat_level", "alarm_results", "status", "source", "template_id",
    "create_time", "update_time"
) VALUES 
(6001, 'APT攻击告警通知策略', true, 'alarmType', '/AdvancedThreat/APT',
'Critical', 'OK,Failed', true, 'auto', 201,
CURRENT_TIMESTAMP - INTERVAL '15 days', CURRENT_TIMESTAMP - INTERVAL '10 days'),

(6002, '勒索软件告警通知策略', true, 'alarmType', '/Malware/Ransomware',
'Critical,High', 'Failed', true, 'auto', 202,
CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_TIMESTAMP - INTERVAL '15 days'),

(6003, '端口扫描告警通知策略', true, 'alarmType', '/Scan/PortScan',
'High,Medium', 'OK', true, 'auto', 203,
CURRENT_TIMESTAMP - INTERVAL '25 days', CURRENT_TIMESTAMP - INTERVAL '20 days'),

(6004, '系统报表推送策略', false, 'report', 'daily_report',
'Info', 'OK', true, 'manual', 204,
CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '25 days'),

(6005, 'SSL证书到期提醒策略', false, 'notice', 'cert_monitor',
'Low', 'OK', true, 'manual', 205,
CURRENT_TIMESTAMP - INTERVAL '35 days', CURRENT_TIMESTAMP - INTERVAL '30 days');

SELECT setval('t_linked_strategy_id_seq', (SELECT MAX(id) FROM t_linked_strategy), true);

-- ==========================================
-- 2. 插入主表 t_notice_history 数据
-- ==========================================
DELETE FROM "t_notice_history" WHERE id >= 1001 AND id <= 1005;

INSERT INTO "t_notice_history" (
    "id", "user_id", "contact_type", "contact_at", "start_time_min",
    "count", "alert_content", "failure_msg", "device_id", "status",
    "event_ids", "modify_by", "create_time", "update_time", "strategy_id"
) VALUES 

-- ==========================================
-- 场景1：高危告警邮件通知（成功）- 关联策略6001
-- ==========================================
(1001, 1001, 'email', CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours 5 minutes',
3, '【严重】检测到APT攻击，攻击源：203.0.113.88，目标：192.168.10.50。请立即处理！',
NULL, 'dev_fw_001', true, '1001,1002,1003', 'admin',
CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours', 6001),

-- ==========================================
-- 场景2：短信告警通知（成功）- 关联策略6002
-- ==========================================
(1002, 1002, 'sms', CURRENT_TIMESTAMP - INTERVAL '12 hours', CURRENT_TIMESTAMP - INTERVAL '12 hours 10 minutes',
5, '【紧急】勒索软件传播尝试，已自动拦截。详情请登录查看。',
NULL, 'dev_ids_001', true, '1004,1005,1006,1007,1008', 'system',
CURRENT_TIMESTAMP - INTERVAL '12 hours', CURRENT_TIMESTAMP - INTERVAL '12 hours', 6002),

-- ==========================================
-- 场景3：钉钉群机器人通知（失败）- 关联策略6003
-- ==========================================
(1003, 1003, 'dingtalk', CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '5 hours 15 minutes',
152, '【安全通知】时间：2026-01-26 05:30，事件：端口扫描，来源：185.220.101.30，状态：已确认',
'发送失败：webhook超时，错误码：ETIMEDOUT', 'dev_ids_002', false, '1009,1010,1011', 'admin',
CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '4 hours 50 minutes', 6003),

-- ==========================================
-- 场景4：系统报表定时推送（成功）- 关联策略6004
-- ==========================================
(1004, 1004, 'email', CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '1 day',
1, '每日安全态势报告 - 2026-01-26：告警事件25起，已处理22起，处理中3起，封禁IP15个，安全评分85分。',
NULL, 'system', true, NULL, 'system',
CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '1 day', 6004),

-- ==========================================
-- 场景5：企业微信通知（成功）- 关联策略6005
-- ==========================================
(1005, 1005, 'wechat', CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours 5 minutes',
1, '【提醒】SSL证书即将过期：域名 example.com 的SSL证书将于3天后（2026-01-29）过期，请及时续期。',
NULL, 'system', true, NULL, 'admin',
CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours', 6005);

SELECT setval('t_notice_history_id_seq', (SELECT MAX(id) FROM t_notice_history), true);

-- ==========================================
-- 验证：关联查询测试
-- ==========================================
SELECT 
    tnh.id AS "通知ID",
    tls.strategy_name AS "策略名称",
    tnh.user_id AS "接收用户ID",
    tnh.contact_type AS "联系方式",
    tnh.count AS "事件数量",
    CASE WHEN tnh.status THEN '成功' ELSE '失败' END AS "发送状态",
    tls.threat_level AS "威胁等级",
    CASE WHEN tls.auto_handle THEN '自动' ELSE '手动' END AS "处置方式",
    TO_CHAR(tnh.contact_at, 'YYYY-MM-DD HH24:MI:SS') AS "通知时间"
FROM "t_linked_strategy" tls
RIGHT JOIN "t_notice_history" tnh ON tls.id = tnh.strategy_id
WHERE tnh.id >= 1001 AND tnh.id <= 1005
ORDER BY tnh.contact_at DESC;

-- ==========================================
-- 统计信息
-- ==========================================
SELECT 
    '通知历史总数' AS "统计项",
    COUNT(*) AS "数量"
FROM "t_notice_history"
WHERE id >= 1001 AND id <= 1005
UNION ALL
SELECT 
    '关联策略数',
    COUNT(*) 
FROM "t_linked_strategy"
WHERE id >= 6001 AND id <= 6005
UNION ALL
SELECT 
    '发送成功数',
    COUNT(*) 
FROM "t_notice_history"
WHERE id >= 1001 AND id <= 1005 AND status = true
UNION ALL
SELECT 
    '发送失败数',
    COUNT(*) 
FROM "t_notice_history"
WHERE id >= 1001 AND id <= 1005 AND status = false;

-- 按联系方式统计
SELECT 
    contact_type AS "联系方式",
    COUNT(*) AS "通知数量",
    SUM(CASE WHEN status THEN 1 ELSE 0 END) AS "成功",
    SUM(CASE WHEN NOT status THEN 1 ELSE 0 END) AS "失败",
    ROUND(SUM(CASE WHEN status THEN 1 ELSE 0 END)::numeric / NULLIF(COUNT(*), 0) * 100, 2) AS "成功率%"
FROM "t_notice_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY contact_type
ORDER BY "通知数量" DESC;

-- 按策略统计
SELECT 
    tls.strategy_name AS "策略名称",
    tls.threat_level AS "威胁等级",
    COUNT(tnh.id) AS "通知次数",
    SUM(CASE WHEN tnh.status THEN 1 ELSE 0 END) AS "成功次数",
    SUM(tnh.count) AS "总事件数"
FROM "t_linked_strategy" tls
LEFT JOIN "t_notice_history" tnh ON tls.id = tnh.strategy_id
WHERE tls.id >= 6001 AND tls.id <= 6005
GROUP BY tls.strategy_name, tls.threat_level
ORDER BY "通知次数" DESC;

-- ==========================================
-- 测试说明
-- ==========================================
-- ✅ getNoticeListCount: 查询通知数量（RIGHT JOIN t_linked_strategy）
-- ✅ getNoticeHistory: 查询通知历史（RIGHT JOIN t_linked_strategy）
-- ✅ countLaunchTimesByStrategyId: 按策略ID统计触发次数
-- ✅ getIdsByStrategyId: 按策略ID获取通知ID列表
-- ✅ 所有查询依赖 t_linked_strategy 的关联数据！
--
-- ⚠️ 注意：
-- 1. strategy_id 关联 t_linked_strategy.id
-- 2. contact_type 是枚举类型：sms, email, dingtalk, predict, order, firewall, wechat
-- 3. status: true=成功, false=失败
-- 4. count: 聚合的事件数量
-- 5. event_ids: 关联的事件ID列表（逗号分隔）
