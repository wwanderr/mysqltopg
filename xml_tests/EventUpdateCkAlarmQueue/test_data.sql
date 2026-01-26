-- 测试数据：EventUpdateCkAlarmQueue（事件更新CK告警队列）
DELETE FROM "t_event_update_ck_alarm_queue" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_event_update_ck_alarm_queue" ("id", "event_id", "update_type", "update_content", "queue_status", "retry_count", "create_time", "update_time") VALUES 
(1001, 1001, 'status_sync', '{"status": "confirmed"}', 'completed', 0, CURRENT_TIMESTAMP - INTERVAL '1 hour', CURRENT_TIMESTAMP - INTERVAL '50 minutes'),
(1002, 1002, 'level_sync', '{"level": "critical"}', 'completed', 0, CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour 50 minutes'),
(1003, 1003, 'full_sync', '{"full_data": true}', 'failed', 3, CURRENT_TIMESTAMP - INTERVAL '30 minutes', CURRENT_TIMESTAMP - INTERVAL '25 minutes');

SELECT setval('"t_event_update_ck_alarm_queue_id_seq"', 1003, true);
