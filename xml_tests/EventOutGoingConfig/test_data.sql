-- 测试数据：EventOutGoingConfig（事件外发配置）
DELETE FROM "t_event_out_going_config" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_event_out_going_config" ("id", "config_name", "out_going_type", "out_going_url", "auth_type", "auth_token", "is_enable", "filter_condition", "create_time", "update_time") VALUES 
(1001, 'SIEM集成', 'siem', 'https://siem.company.com/api', 'bearer', 'token_xxx123', true, '{"level": ["high", "critical"]}', CURRENT_TIMESTAMP - INTERVAL '180 days', CURRENT_TIMESTAMP - INTERVAL '10 days'),
(1002, '邮件告警', 'email', 'smtp://mail.company.com:587', 'basic', 'encrypted_auth', true, '{"level": ["critical"]}', CURRENT_TIMESTAMP - INTERVAL '200 days', CURRENT_TIMESTAMP - INTERVAL '5 days'),
(1003, 'Webhook通知（测试）', 'webhook', 'https://test.webhook.com', 'none', NULL, false, '{}', CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '30 days');

SELECT setval('"t_event_out_going_config_id_seq"', 1003, true);
