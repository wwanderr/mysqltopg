-- Mirror Test: TSevAgentConfig
-- 依赖表：
-- - t_sev_agent_config
-- - t_sev_agent_rule_closed
-- - t_sev_agent_type_rule_closed
--
-- DDL 参考：
-- - V20260130110517371__create_t_sev_agent_config.sql
-- - V20260130110517372__create_t_sev_agent_rule_closed.sql
-- - V20260130110517373__create_t_sev_agent_type_rule_closed.sql

-- 1) 清理
DELETE FROM t_sev_agent_rule_closed WHERE rule_closed_id IN (5001, 5002, 5003);
DELETE FROM t_sev_agent_type_rule_closed WHERE id IN (5001, 5002, 5003);
DELETE FROM t_sev_agent_config WHERE agent_type IN ('APT', 'EDR') AND config_key LIKE 'demo.config.%';

-- 2) 准备 t_sev_agent_config
-- 目标：
-- - selectOneByAgentTypeAndConfigKey('APT','demo.config.key') 命中一条记录
-- - getLastVersion('APT') 返回最大的 config_version = 3002
INSERT INTO t_sev_agent_config (
  id, agent_type, config_version, config_key, config_content, create_time, update_time
) VALUES
  (4001, 'APT', 3001, 'demo.config.key',  '{"k":"v1"}', CURRENT_TIMESTAMP - INTERVAL '3 day', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  (4002, 'APT', 3002, 'demo.config.key',  '{"k":"v2"}', CURRENT_TIMESTAMP - INTERVAL '2 day', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  (4003, 'APT', 1000, 'other.config.key', '{"k":"v3"}', CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP),
  (4004, 'EDR', 2000, 'demo.config.key',  '{"k":"edr"}', CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP);

-- 3) 准备 t_sev_agent_type_rule_closed
-- 目标：
-- - getAllClosedRuleIds('AGENT001','APT') 返回 RULE-1 和 RULE-2
INSERT INTO t_sev_agent_type_rule_closed (
  id, agent_type, rule_id, remarks, update_history_alarm, data, create_time, update_time, is_delete
) VALUES
  (5001, 'APT', 'RULE-1', '测试规则1', false, NULL, CURRENT_TIMESTAMP - INTERVAL '3 day', CURRENT_TIMESTAMP - INTERVAL '2 day', false),
  (5002, 'APT', 'RULE-2', '测试规则2', true,  NULL, CURRENT_TIMESTAMP - INTERVAL '2 day', CURRENT_TIMESTAMP - INTERVAL '1 day', false),
  (5003, 'EDR', 'RULE-EDR', 'EDR 规则', false, NULL, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP, false);

-- 4) 准备 t_sev_agent_rule_closed
-- 目标：
-- - getLastRuleClosedVersion('AGENT001') 返回 9002（来自 agent_code=null 的“通用规则”）
-- - getAllClosedRuleIds 需要 rule_closed_id = 5001,5002
INSERT INTO t_sev_agent_rule_closed (
  id, rule_closed_id, agent_code, is_delete, config_version
) VALUES
  (6001, 5001, 'AGENT001', false, 8001),  -- 专属规则
  (6002, 5002, NULL,       false, 9002),  -- 通用规则（更大版本）
  (6003, 5003, 'AGENT002', false, 7000); -- 其他探针

-- 5) 校验（可选）
-- selectOneByAgentTypeAndConfigKey('APT','demo.config.key') 期望返回 id=4001 或 4002（limit 1，按物理顺序）
-- getLastVersion('APT') 期望返回 3002
-- getLastRuleClosedVersion('AGENT001') 期望返回 9002
-- getAllClosedRuleIds('AGENT001','APT') 期望返回 ['RULE-1','RULE-2']（顺序不强依赖）
SELECT 'cfg_APT' AS tag, agent_type, config_key, config_version FROM t_sev_agent_config WHERE agent_type='APT';
SELECT 'rule_closed' AS tag, rule_closed_id, agent_code, is_delete, config_version FROM t_sev_agent_rule_closed WHERE rule_closed_id IN (5001,5002,5003);
SELECT 'type_rule' AS tag, id, agent_type, rule_id, is_delete FROM t_sev_agent_type_rule_closed WHERE id IN (5001,5002,5003);

