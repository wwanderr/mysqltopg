-- Mirror Test: TSevAgentEvents
-- 依赖表：
-- - t_sev_agent_events
--
-- DDL 参考：
-- - V20260130110517371__create_t_sev_agent_config.sql （其中包含 t_sev_agent_events 的建表）

-- 1) 清理
DELETE FROM t_sev_agent_events
WHERE agent_code IN ('EVT_AGENT_1', 'EVT_AGENT_2', 'EVT_AGENT_3');

-- 2) 准备测试数据
-- 目标：
-- - deleteByAgentCodeIn(['EVT_AGENT_1','EVT_AGENT_2']) 只能删掉对应 agent 的记录
-- - 保留 EVT_AGENT_3，用来验证 deleteByAgentCodeIn 不会误删其他 agent

INSERT INTO t_sev_agent_events (
  id, agent_code, event_type, status, result, message, data, event_time
) VALUES
  -- EVT_AGENT_1：2 条记录
  (7001, 'EVT_AGENT_1', 'upgrade',      'begin',  true,  'start upgrade',       '{"step":1}', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  (7002, 'EVT_AGENT_1', 'upgrade',      'finish', true,  'upgrade finished',    '{"step":2}', CURRENT_TIMESTAMP - INTERVAL '1 day'),

  -- EVT_AGENT_2：3 条记录
  (7003, 'EVT_AGENT_2', 'reloadConfig', 'begin',  true,  'reload begin',        '{"k":"v1"}', CURRENT_TIMESTAMP - INTERVAL '3 day'),
  (7004, 'EVT_AGENT_2', 'reloadConfig', 'finish', false, 'reload failed',       '{"k":"v2"}', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  (7005, 'EVT_AGENT_2', 'upgrade',      'finish', true,  'upgrade finished 2',  '{"k":"v3"}', CURRENT_TIMESTAMP - INTERVAL '1 day'),

  -- EVT_AGENT_3：2 条记录（deleteByAgentCodeIn 不会删，用来验证差异）
  (7006, 'EVT_AGENT_3', 'upgrade',      'begin',  true,  'other agent start',   NULL,        CURRENT_TIMESTAMP - INTERVAL '1 day'),
  (7007, 'EVT_AGENT_3', 'upgrade',      'finish', true,  'other agent finish',  NULL,        CURRENT_TIMESTAMP);

-- 3) 校验（可选）
-- 初始总记录数：7 条
-- - EVT_AGENT_1: 2
-- - EVT_AGENT_2: 3
-- - EVT_AGENT_3: 2
SELECT 'before' AS tag, agent_code, COUNT(*) AS cnt
FROM t_sev_agent_events
WHERE agent_code IN ('EVT_AGENT_1','EVT_AGENT_2','EVT_AGENT_3')
GROUP BY agent_code
ORDER BY agent_code;

