-- 测试数据：AlarmStatusTimingTask（告警状态定时任务）
DELETE FROM "t_alarm_status_timing_task" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_alarm_status_timing_task" ("id", "task_type", "alarm_status", "remarks", "operator", "condition", "create_time", "task_end_time", "associated_field") VALUES 
(1001, 'auto_close', 'open', '自动关闭30天前的已处理告警', 'system', '{"days": 30, "handled": true}', CURRENT_TIMESTAMP - INTERVAL '60 days', NULL, '{"field": "create_time"}'),
(1002, 'auto_archive', 'closed', '自动归档90天前的已关闭告警', 'system', '{"days": 90, "status": "closed"}', CURRENT_TIMESTAMP - INTERVAL '90 days', NULL, '{"field": "close_time"}'),
(1003, 'manual_review', 'monitoring', '手动审查监控中的告警', 'admin', '{"status": "monitoring"}', CURRENT_TIMESTAMP - INTERVAL '7 days', CURRENT_TIMESTAMP + INTERVAL '23 days', '{"field": "status"}');

SELECT setval('"t_alarm_status_timing_task_id_seq"', 1003, true);
