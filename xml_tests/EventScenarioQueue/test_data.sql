-- 测试数据：EventScenarioQueue（事件场景队列）
DELETE FROM "t_event_scenario_queue" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_event_scenario_queue" ("id", "event_id", "scenario_type", "queue_status", "priority", "create_time", "process_time", "result") VALUES 
(1001, 1001, 'apt_detection', 'completed', 10, CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes', '{"matched": true, "score": 95}'),
(1002, 1002, 'ransomware_detection', 'completed', 9, CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours 30 minutes', '{"matched": true, "score": 88}'),
(1003, 1003, 'data_exfiltration', 'pending', 8, CURRENT_TIMESTAMP - INTERVAL '30 minutes', NULL, NULL);

SELECT setval('"t_event_scenario_queue_id_seq"', 1003, true);
