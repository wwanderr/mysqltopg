-- ============================================
-- 测试数据：SecurityType（安全类型）
-- 主表：t_security_types (8个字段)
-- 关联表：t_event_template (queryTypes 方法查询此表)
-- 根据反编译接口修复：2026-01-28
-- ============================================

-- ==========================================
-- 1. 先插入关联表 t_event_template 数据
-- 说明：queryTypes() 方法从 t_event_template 查询 DISTINCT incident_sub_class_type 和 incident_class_type
-- ==========================================
DELETE FROM "t_event_template" WHERE id >= 6001 AND id <= 6010;

INSERT INTO "t_event_template" (
    "id",
    "incident_name",
    "incident_rule_type",
    "incident_class_type",
    "incident_sub_class_type",
    "incident_type",
    "incident_cond",
    "incident_description",
    "incident_suggestion",
    "conclusion",
    "focus",
    "enable",
    "priority",
    "update_time"
) VALUES

-- ==========================================
-- 场景1：Web攻击 - SQL注入
-- ==========================================
(
    6001,
    'SQL注入攻击检测',
    'Web攻击',
    '/webAttackIncident',
    '/webAttackIncident/sqlInjection',
    true,
    'sql_injection_pattern_detected',
    '检测到SQL注入攻击尝试',
    '建议：1.检查输入验证；2.使用参数化查询；3.更新WAF规则',
    'SQL注入攻击已拦截',
    'target_ip',
    true,
    5,
    CURRENT_TIMESTAMP
),

-- ==========================================
-- 场景2：Web攻击 - XSS
-- ==========================================
(
    6002,
    'XSS跨站脚本攻击',
    'Web攻击',
    '/webAttackIncident',
    '/webAttackIncident/xss',
    true,
    'xss_pattern_detected',
    '检测到XSS跨站脚本攻击',
    '建议：1.转义用户输入；2.启用CSP策略；3.更新防护规则',
    'XSS攻击已拦截',
    'target_ip',
    true,
    4,
    CURRENT_TIMESTAMP
),

-- ==========================================
-- 场景3：恶意软件 - 木马
-- ==========================================
(
    6003,
    '木马检测',
    '恶意软件',
    '/malwareIncident',
    '/malwareIncident/trojan',
    true,
    'trojan_signature_detected',
    '检测到木马程序',
    '建议：1.隔离受感染主机；2.全盘扫描；3.更新病毒库',
    '木马已清除',
    'target_ip',
    true,
    6,
    CURRENT_TIMESTAMP
),

-- ==========================================
-- 场景4：恶意软件 - 勒索软件
-- ==========================================
(
    6004,
    '勒索软件检测',
    '恶意软件',
    '/malwareIncident',
    '/malwareIncident/ransomware',
    true,
    'ransomware_encryption_detected',
    '检测到勒索软件活动',
    '建议：1.立即隔离；2.检查备份；3.联系安全团队',
    '勒索软件活动已阻止',
    'target_ip',
    true,
    7,
    CURRENT_TIMESTAMP
),

-- ==========================================
-- 场景5：网络攻击 - 横向移动
-- ==========================================
(
    6005,
    '横向移动攻击',
    '横向移动',
    '/networkAttackIncident',
    '/networkAttackIncident/lateralMovement',
    true,
    'lateral_movement_detected',
    '检测到横向移动行为',
    '建议：1.隔离跳板机；2.检查域控；3.监控网络流量',
    '横向移动已阻止',
    'src_ip',
    true,
    8,
    CURRENT_TIMESTAMP
),

-- ==========================================
-- 场景6：数据外泄 - 异常外连
-- ==========================================
(
    6006,
    '数据外泄检测',
    '数据外泄',
    '/dataExfiltration',
    '/dataExfiltration/abnormalOutbound',
    true,
    'abnormal_outbound_detected',
    '检测到异常外连行为',
    '建议：1.阻断外连；2.分析传输内容；3.检查主机进程',
    '数据外泄已阻止',
    'src_ip',
    true,
    9,
    CURRENT_TIMESTAMP
),

-- ==========================================
-- 场景7：命令控制 - C&C通信
-- ==========================================
(
    6007,
    'C&C通信检测',
    '命令控制',
    '/commandControl',
    '/commandControl/c2Communication',
    true,
    'c2_communication_detected',
    '检测到C&C通信',
    '建议：1.阻断通信；2.分析通信内容；3.检查受控主机',
    'C&C通信已阻断',
    'src_ip',
    true,
    10,
    CURRENT_TIMESTAMP
),

-- ==========================================
-- 场景8：暴力破解 - SSH
-- ==========================================
(
    6008,
    'SSH暴力破解',
    '暴力破解',
    '/bruteForceIncident',
    '/bruteForceIncident/ssh',
    true,
    'ssh_brute_force_detected',
    '检测到SSH暴力破解尝试',
    '建议：1.限制登录次数；2.启用密钥认证；3.封禁攻击IP',
    'SSH暴力破解已阻止',
    'src_ip',
    true,
    3,
    CURRENT_TIMESTAMP
),

-- ==========================================
-- 场景9：暴力破解 - RDP
-- ==========================================
(
    6009,
    'RDP暴力破解',
    '暴力破解',
    '/bruteForceIncident',
    '/bruteForceIncident/rdp',
    true,
    'rdp_brute_force_detected',
    '检测到RDP暴力破解尝试',
    '建议：1.限制登录次数；2.启用网络级身份验证；3.封禁攻击IP',
    'RDP暴力破解已阻止',
    'src_ip',
    true,
    3,
    CURRENT_TIMESTAMP
),

-- ==========================================
-- 场景10：端口扫描
-- ==========================================
(
    6010,
    '端口扫描检测',
    '端口扫描',
    '/reconnaissanceIncident',
    '/reconnaissanceIncident/portScan',
    true,
    'port_scan_detected',
    '检测到端口扫描行为',
    '建议：1.监控扫描源；2.限制端口访问；3.加强防火墙规则',
    '端口扫描已记录',
    'src_ip',
    true,
    2,
    CURRENT_TIMESTAMP
);

SELECT setval('"t_event_template_id_seq"', (SELECT MAX(id) FROM "t_event_template"), true);

-- ==========================================
-- 2. 插入主表 t_security_types 数据
-- ==========================================
DELETE FROM "t_security_types" WHERE id >= 6001 AND id <= 6005;

-- 插入测试数据（完整8个字段）
INSERT INTO "t_security_types" (
    "id",
    "sub_category",
    "category",
    "mirror_sub_category",
    "mirror_category",
    "sub_category_name",
    "category_name",
    "is_enable"
) VALUES

-- ==========================================
-- 场景1：恶意软件检测
-- ==========================================
(
    6001,
    '/malwareIncident/trojan',
    '/malwareIncident',
    'malware_detection',
    'malware',
    '恶意软件检测',
    '恶意软件',
    true
),

-- ==========================================
-- 场景2：勒索软件检测
-- ==========================================
(
    6002,
    '/malwareIncident/ransomware',
    '/malwareIncident',
    'ransomware_detection',
    'malware',
    '勒索软件检测',
    '恶意软件',
    true
),

-- ==========================================
-- 场景3：横向移动
-- ==========================================
(
    6003,
    '/networkAttackIncident/lateralMovement',
    '/networkAttackIncident',
    'lateral_movement',
    'intrusion',
    '横向移动',
    '入侵行为',
    true
),

-- ==========================================
-- 场景4：数据外泄
-- ==========================================
(
    6004,
    '/dataExfiltration/abnormalOutbound',
    '/dataExfiltration',
    'data_exfiltration',
    'exfiltration',
    '数据外泄',
    '数据泄露',
    true
),

-- ==========================================
-- 场景5：C&C通信（已禁用）
-- ==========================================
(
    6005,
    '/commandControl/c2Communication',
    '/commandControl',
    'c2_communication',
    'command_control',
    'C&C通信',
    '命令控制',
    false
);

SELECT setval('"t_security_types_id_seq"', 6005, true);

-- ==========================================
-- 3. 验证：t_event_template 数据（用于 queryTypes 查询）
-- ==========================================
SELECT 
    incident_class_type AS "事件类型",
    incident_sub_class_type AS "事件子类型",
    COUNT(*) AS "模板数量"
FROM "t_event_template"
WHERE id >= 6001 AND id <= 6010
GROUP BY incident_class_type, incident_sub_class_type
ORDER BY incident_class_type, incident_sub_class_type;

-- ==========================================
-- 4. 验证：t_security_types 数据（按类型统计）
-- ==========================================
SELECT 
    category_name AS "类型",
    COUNT(*) AS "子类型数量",
    SUM(CASE WHEN is_enable = true THEN 1 ELSE 0 END) AS "启用数量"
FROM "t_security_types"
WHERE id >= 6001 AND id <= 6005
GROUP BY category_name
ORDER BY category_name;

-- ==========================================
-- 验证：按启用状态统计
-- ==========================================
SELECT 
    CASE is_enable
        WHEN true THEN '已启用'
        ELSE '已禁用'
    END AS "状态",
    COUNT(*) AS "数量"
FROM "t_security_types"
WHERE id >= 6001 AND id <= 6005
GROUP BY is_enable;
