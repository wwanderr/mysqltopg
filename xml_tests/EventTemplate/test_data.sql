-- ============================================
-- 测试数据：EventTemplate（事件模板）
-- 表：t_event_template
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_event_template" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
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
    "display_filed",
    "enable",
    "update_time",
    "last_execute_time",
    "uniq_code",
    "incident_children",
    "priority",
    "netflow_log_field",
    "host_log_field"
) VALUES 

-- ==========================================
-- 场景1：暴力破解攻击检测（高优先级，已启用）
-- ==========================================
(
    1001,
    'SSH暴力破解攻击',
    '异常登录',
    '入侵检测',
    '暴力破解',
    true,  -- incident_type: 是否为事件类型
    'login_fail_count > 5 AND time_window < 300',
    '检测到来自同一IP在5分钟内SSH登录失败超过5次，疑似暴力破解攻击',
    '建议：1. 立即封禁攻击源IP；2. 检查账户安全策略；3. 启用双因素认证',
    '发现暴力破解攻击行为，已自动拦截',
    'src_ip',  -- 关注点：源IP
    'src_ip,dst_ip,login_user,fail_count,attack_time',
    true,  -- 已启用
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    100001,  -- uniq_code: int8 类型
    NULL,
    9,  -- 高优先级
    'src_ip,dst_ip,protocol,dst_port,timestamp',
    'username,src_ip,login_time,login_result'
),

-- ==========================================
-- 场景2：SQL注入攻击检测（严重，已启用）
-- ==========================================
(
    1002,
    'SQL注入攻击检测',
    'Web攻击',
    '应用层攻击',
    'SQL注入',
    true,
    'url LIKE ''%union%select%'' OR url LIKE ''%or%1=1%''',
    '检测到HTTP请求参数中包含SQL注入特征，可能导致数据库泄露',
    '建议：1. 检查Web应用输入过滤；2. 使用参数化查询；3. 限制数据库权限',
    '发现SQL注入攻击尝试，已拦截请求',
    'url',
    'src_ip,url,http_method,attack_payload,response_code',
    true,
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    100002,  -- uniq_code: int8 类型
    NULL,
    10,  -- 严重优先级
    'src_ip,dst_ip,http_host,http_uri,http_method',
    'request_url,request_params,response_code'
),

-- ==========================================
-- 场景3：端口扫描行为检测（中优先级，已启用）
-- ==========================================
(
    1003,
    '端口扫描行为',
    '扫描探测',
    '侦查行为',
    '端口扫描',
    false,  -- incident_type: 不是事件，是行为
    'unique_ports > 20 AND time_window < 60',
    '检测到来自同一源IP在1分钟内扫描超过20个不同端口，疑似端口扫描行为',
    '建议：1. 分析扫描目的；2. 评估资产暴露情况；3. 考虑加入黑名单',
    '发现端口扫描行为，正在监控',
    'src_ip',
    'src_ip,scanned_ports,scan_count,first_seen,last_seen',
    true,
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    100003,  -- uniq_code: int8 类型
    NULL,
    5,  -- 中等优先级
    'src_ip,dst_ip,dst_port,protocol,syn_flag',
    NULL
),

-- ==========================================
-- 场景4：恶意文件下载（高优先级，已禁用-测试中）
-- ==========================================
(
    1004,
    '恶意文件下载行为',
    '恶意软件',
    '恶意代码传播',
    '木马下载',
    true,
    'file_md5 IN (malware_hash_list) OR file_extension IN (''.exe'', ''.bat'', ''.ps1'')',
    '检测到用户下载已知恶意文件或可疑可执行文件',
    '建议：1. 立即隔离文件；2. 全盘扫描；3. 检查系统进程',
    '发现恶意文件下载，已阻止并隔离',
    'file_hash',
    'src_ip,file_name,file_hash,download_url,file_size',
    false,  -- 暂时禁用，正在测试
    CURRENT_TIMESTAMP - INTERVAL '15 days',
    NULL,  -- 从未执行过
    100004,  -- uniq_code: int8 类型
    NULL,
    8,
    'src_ip,dst_ip,http_url,file_name,file_size',
    'file_path,file_hash,download_time,process_name'
),

-- ==========================================
-- 场景5：异常外连行为（中优先级，已启用）
-- ==========================================
(
    1005,
    '内网主机异常外连',
    '异常流量',
    '横向移动',
    '外连行为',
    false,
    'dst_ip NOT IN (whitelist) AND connection_count > 100',
    '检测到内网主机向非白名单外部地址建立大量连接，可能存在数据外泄或C&C通信',
    '建议：1. 检查主机进程；2. 分析流量内容；3. 隔离可疑主机',
    '发现异常外连行为，建议调查',
    'src_ip',
    'src_ip,dst_ip,connection_count,data_volume,first_conn_time',
    true,
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    CURRENT_TIMESTAMP - INTERVAL '45 minutes',
    100005,  -- uniq_code: int8 类型
    NULL,
    6,
    'src_ip,dst_ip,dst_port,bytes_sent,bytes_received',
    'process_name,dst_domain,connection_time'
);

-- 重置序列
SELECT setval('"t_event_template_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    incident_name,
    incident_rule_type,
    priority,
    enable,
    incident_type,
    conclusion
FROM "t_event_template"
WHERE id >= 1001 AND id <= 1005
ORDER BY priority DESC, id;

-- 按类型统计
SELECT 
    incident_rule_type AS "规则类型",
    COUNT(*) AS "数量",
    SUM(CASE WHEN enable THEN 1 ELSE 0 END) AS "已启用"
FROM "t_event_template"
WHERE id >= 1001 AND id <= 1005
GROUP BY incident_rule_type
ORDER BY "数量" DESC;
