-- t_attack_knowledge 测试数据
-- ATT&CK框架相关攻击知识测试数据

-- 清空表（可选）
TRUNCATE TABLE t_attack_knowledge RESTART IDENTITY CASCADE;

-- 插入战术级别数据（Tactics - level='tactic'）
INSERT INTO t_attack_knowledge 
(technique_code, technique_name, technique_name_ch, parent_code, "level", os, perspective, device_type, sort)
VALUES
-- 战术1: Initial Access (初始访问)
('TA0001', 'Initial Access', '初始访问', '', 'tactic', 'Windows,Linux', 'enterprise', 'endpoint,server', 1),

-- 战术2: Execution (执行)
('TA0002', 'Execution', '执行', '', 'tactic', 'Windows,Linux,macOS', 'enterprise', 'endpoint', 2),

-- 战术3: Persistence (持久化)
('TA0003', 'Persistence', '持久化', '', 'tactic', 'Windows', 'enterprise', 'endpoint,server', 3);

-- 插入技术级别数据（Techniques - level='technique'）
INSERT INTO t_attack_knowledge 
(technique_code, technique_name, technique_name_ch, parent_code, "level", os, perspective, device_type, sort)
VALUES
-- TA0001下的技术：Exploit Public-Facing Application
('T1190', 'Exploit Public-Facing Application', '利用面向公众的应用程序', 'TA0001', 'technique', 'Windows,Linux', 'enterprise', 'server', 1),

-- TA0001下的技术：Phishing
('T1566', 'Phishing', '钓鱼攻击', 'TA0001', 'technique', 'Windows,Linux,macOS', 'enterprise', 'endpoint', 2),

-- TA0002下的技术：Command and Scripting Interpreter
('T1059', 'Command and Scripting Interpreter', '命令和脚本解释器', 'TA0002', 'technique', 'Windows,Linux,macOS', 'enterprise', 'endpoint,server', 1),

-- TA0002下的技术：User Execution
('T1204', 'User Execution', '用户执行', 'TA0002', 'technique', 'Windows,macOS', 'enterprise', 'endpoint', 2),

-- TA0003下的技术：Boot or Logon Autostart Execution
('T1547', 'Boot or Logon Autostart Execution', '开机或登录自启动执行', 'TA0003', 'technique', 'Windows', 'enterprise', 'endpoint', 1),

-- TA0003下的技术：Create or Modify System Process
('T1543', 'Create or Modify System Process', '创建或修改系统进程', 'TA0003', 'technique', 'Windows,Linux', 'enterprise', 'endpoint,server', 2);

-- 插入子技术级别数据（Sub-techniques - level='sub-technique'）
INSERT INTO t_attack_knowledge 
(technique_code, technique_name, technique_name_ch, parent_code, "level", os, perspective, device_type, sort)
VALUES
-- T1059的子技术：PowerShell
('T1059.001', 'PowerShell', 'PowerShell脚本', 'T1059', 'sub-technique', 'Windows', 'enterprise', 'endpoint,server', 1),

-- T1059的子技术：Bash
('T1059.004', 'Unix Shell', 'Unix Shell脚本', 'T1059', 'sub-technique', 'Linux,macOS', 'enterprise', 'endpoint,server', 2),

-- T1566的子技术：Spearphishing Attachment
('T1566.001', 'Spearphishing Attachment', '鱼叉式钓鱼附件', 'T1566', 'sub-technique', 'Windows,Linux,macOS', 'enterprise', 'endpoint', 1),

-- T1566的子技术：Spearphishing Link
('T1566.002', 'Spearphishing Link', '鱼叉式钓鱼链接', 'T1566', 'sub-technique', 'Windows,Linux,macOS', 'all', 'endpoint', 2);

-- 验证查询
SELECT '数据插入完成' as status;
SELECT COUNT(*) as total_count FROM t_attack_knowledge;
SELECT "level", COUNT(*) as count FROM t_attack_knowledge GROUP BY "level";
