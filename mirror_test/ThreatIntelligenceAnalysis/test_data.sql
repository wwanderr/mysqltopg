-- Mirror Test: ThreatIntelligenceAnalysis
-- 依赖表：
-- - t_sev_agent_info
-- - t_threat_intelligence_analysis
--
-- DDL 参考：
-- - create_table/mirror/V20260130110517370__create_t_sev_agent_info.sql
-- - create_table/mirror/V20260130110517369__create_t_threat_intelligence_analysis.sql

-- 1) 清理（注意外键约束时请按实际依赖顺序调整）
DELETE FROM t_threat_intelligence_analysis WHERE id IN (9001, 9002, 9003);
DELETE FROM t_sev_agent_info WHERE agent_code IN ('AGENT001', 'AGENT002');

-- 2) 准备 t_sev_agent_info（必填列：agent_code, agent_ip, agent_ip_num, agent_type, soft_version）
INSERT INTO t_sev_agent_info (
  id, agent_code, agent_name, agent_ip, agent_ip_num, agent_type, soft_version, status, regist_time
) VALUES
  (8001, 'AGENT001', '测试探针-1', '10.0.0.1', '0A000001', 'APT', '1.0.0', 'online', CURRENT_TIMESTAMP),
  (8002, 'AGENT002', '测试探针-2', '10.0.0.2', '0A000002', 'APT', '1.0.0', 'offline', CURRENT_TIMESTAMP);

-- 3) 准备 t_threat_intelligence_analysis（必填列：agent_code, file_name, file_type, md5）
INSERT INTO t_threat_intelligence_analysis (
  id, agent_code, file_name, file_type, uuid, server_id, md5, grade, result, score, deal_status, upload_time, finish_time, original, has_report
) VALUES
  (9001, 'AGENT001', 'sample-1.bin', 'bin', 'uuid-9001', NULL, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'high', 'ok', 90, 'analysising', CURRENT_TIMESTAMP - INTERVAL '1 day', NULL, '{"k":"v"}', false),
  (9002, 'AGENT002', 'sample-2.bin', 'bin', 'uuid-9002', NULL, 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', 'low',  'ok', 10, 'analysising', CURRENT_TIMESTAMP - INTERVAL '2 day', NULL, NULL, true),
  (9003, 'AGENT001', 'sample-3.exe', 'exe', 'uuid-9003', NULL, 'cccccccccccccccccccccccccccccccc', NULL,   NULL, NULL, 'analysising', CURRENT_TIMESTAMP, NULL, NULL, false);

-- 4) 校验（可选）
-- getServerById(9001) 期望返回 server=10.0.0.1, machineCode=AGENT001
-- getAptDeleteDtosByIds([9001,9002]) 期望返回 2 条
SELECT COUNT(*) AS cnt_agent FROM t_sev_agent_info WHERE agent_code IN ('AGENT001', 'AGENT002');
SELECT COUNT(*) AS cnt_analysis FROM t_threat_intelligence_analysis WHERE id IN (9001, 9002, 9003);

