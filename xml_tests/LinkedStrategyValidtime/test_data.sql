-- 测试数据：LinkedStrategyValidtime（联动策略有效期）
DELETE FROM "t_linked_strategy_validtime" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_linked_strategy_validtime" ("id", "strategy_id", "start_time", "end_time", "is_permanent", "repeat_type", "status", "create_time") VALUES 
(1001, 5001, CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP + INTERVAL '330 days', false, 'once', true, CURRENT_TIMESTAMP - INTERVAL '30 days'),
(1002, 5002, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '90 days', false, 'daily', true, CURRENT_TIMESTAMP - INTERVAL '15 days'),
(1003, 5003, NULL, NULL, true, 'none', true, CURRENT_TIMESTAMP - INTERVAL '60 days');

SELECT setval('"t_linked_strategy_validtime_id_seq"', 1003, true);
