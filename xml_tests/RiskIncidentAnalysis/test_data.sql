-- RiskIncidentAnalysis 测试数据
-- 对应表: t_risk_incidents_analysis
-- 生成时间: 2026-02-02

-- 清理现有测试数据
TRUNCATE TABLE t_risk_incidents_analysis CASCADE;

-- 重置序列
ALTER SEQUENCE t_risk_incidents_analysis_id_seq RESTART WITH 10001;

-- 插入测试数据
INSERT INTO t_risk_incidents_analysis (
    id,
    risk_incidents_event_code,
    status,
    core_risks,
    popular_interpretation,
    critical_dangerpoint,
    attack_objective,
    attack_disposal_suggestions,
    attack_info,
    run_error,
    last_run_time,
    last_run_time_consuming,
    incidents_end_time,
    create_time,
    update_time
) VALUES
-- 测试数据1：todo状态
(10001, 'RI-2026-001', 'todo', 
 '存在高级持续性威胁，攻击者可能获取敏感数据', 
 '黑客通过精心策划的攻击，试图窃取您的重要信息',
 '核心服务器暴露在互联网，缺乏必要的安全防护',
 '获取企业核心数据库访问权限',
 '1. 立即隔离受影响主机；2. 修改所有管理员密码；3. 启用多因素认证',
 '{"attack_chain": ["侦察", "初始访问", "持久化", "提权"], "ttps": ["T1078", "T1059"]}',
 NULL,
 '2026-01-28 10:00:00',
 12500,
 '2026-01-28 09:55:00',
 '2026-01-28 10:00:00',
 '2026-01-28 10:00:00'),

-- 测试数据2：doing状态
(10002, 'RI-2026-002', 'doing',
 '发现SQL注入漏洞，可能导致数据库被篡改',
 '系统存在严重漏洞，攻击者可能修改或窃取数据库信息',
 'Web应用未对用户输入进行严格过滤',
 '获取并篡改业务数据',
 '1. 立即下线受影响服务；2. 修复代码中的SQL注入点；3. 审查数据库日志',
 '{"vulnerability": "SQL Injection", "cvss_score": 8.5}',
 NULL,
 '2026-01-28 11:30:00',
 8200,
 '2026-01-28 11:25:00',
 '2026-01-28 11:30:00',
 '2026-01-28 11:35:00'),

-- 测试数据3：done状态
(10003, 'RI-2026-003', 'done',
 'C&C通信检测，主机已被植入后门',
 '您的设备正在与恶意服务器通信，可能已被远程控制',
 '缺乏出站流量监控，恶意通信未被及时发现',
 '建立远程控制通道，执行后续攻击',
 '1. 断网隔离受感染主机；2. 清除后门程序；3. 重新安装系统并恢复数据',
 '{"c2_server": "203.0.113.50", "protocol": "HTTPS"}',
 NULL,
 '2026-01-28 14:00:00',
 15600,
 '2026-01-28 13:50:00',
 '2026-01-28 14:00:00',
 '2026-01-28 14:10:00'),

-- 测试数据4：error状态（包含run_error）
(10004, 'RI-2026-004', 'error',
 '横向移动攻击分析',
 '攻击者在内网中横向移动，试图扩大攻击范围',
 '内网主机间缺乏隔离，攻击者可自由移动',
 '控制更多内网主机，寻找高价值目标',
 '1. 启用网络分段；2. 限制主机间通信；3. 部署EDR监控',
 '{"techniques": ["Pass-the-Hash", "RDP"], "affected_hosts": 5}',
 'AI分析超时：模型加载失败',
 '2026-01-28 15:30:00',
 NULL,
 '2026-01-28 15:20:00',
 '2026-01-28 15:30:00',
 '2026-01-28 15:31:00'),

-- 测试数据5：todo状态（用于插入测试）
(10005, 'RI-2026-005', 'todo',
 '文件加密勒索攻击',
 '攻击者加密了您的重要文件，并要求支付赎金',
 '未定期备份数据，缺乏勒索软件防护',
 '加密文件并勒索比特币',
 '1. 不要支付赎金；2. 从备份恢复数据；3. 部署反勒索软件工具',
 '{"ransomware_family": "WannaCry", "encrypted_files": 1250}',
 NULL,
 NULL,
 NULL,
 '2026-01-28 16:00:00',
 '2026-01-28 16:00:00',
 NULL);

-- 验证插入
SELECT COUNT(*) as record_count FROM t_risk_incidents_analysis;
SELECT id, risk_incidents_event_code, status FROM t_risk_incidents_analysis ORDER BY id;
