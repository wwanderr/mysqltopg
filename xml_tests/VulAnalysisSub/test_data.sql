-- ============================================
-- 测试数据：VulAnalysisSub（漏洞分析订阅）
-- 表：t_vul_analysis_sub
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_vul_analysis_sub" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_vul_analysis_sub" (
    "id",
    "vul_id",
    "vul_name",
    "vul_level",
    "vul_type",
    "cve_id",
    "affected_asset",
    "status",
    "fix_suggestion",
    "discovery_time",
    "fix_time",
    "fix_status",
    "responsible_person",
    "remarks",
    "create_time",
    "update_time"
) VALUES 

(
    1001,
    'VUL-2026-001',
    'Apache Log4j2 远程代码执行漏洞',
    'critical',
    'RCE',
    'CVE-2021-44228',
    '{"ips": ["192.168.1.50", "192.168.1.51"], "count": 2}',
    'confirmed',
    '立即升级Log4j至2.17.1或更高版本，或使用临时缓解措施禁用JNDI lookup',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    NULL,
    'fixing',
    'IT部门-张三',
    '已通知相关责任人，正在升级中',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
),

(
    1002,
    'VUL-2026-002',
    'Windows SMBv3 拒绝服务漏洞',
    'high',
    'DoS',
    'CVE-2020-0796',
    '{"ips": ["192.168.2.100", "192.168.2.101", "192.168.2.102"], "count": 3}',
    'confirmed',
    '安装Microsoft安全补丁KB4551762，或禁用SMBv3压缩功能',
    CURRENT_TIMESTAMP - INTERVAL '15 days',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    'fixed',
    'IT部门-李四',
    '已完成补丁安装并验证',
    CURRENT_TIMESTAMP - INTERVAL '15 days',
    CURRENT_TIMESTAMP - INTERVAL '10 days'
),

(
    1003,
    'VUL-2026-003',
    'Nginx目录遍历漏洞',
    'medium',
    'Information Disclosure',
    'CVE-2023-XXXX',
    '{"ips": ["192.168.3.10"], "count": 1}',
    'under_review',
    '升级Nginx到最新版本或配置正确的访问控制',
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    NULL,
    'pending',
    'Web运维-王五',
    '正在评估影响范围',
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days'
),

(
    1004,
    'VUL-2026-004',
    'MySQL权限提升漏洞',
    'high',
    'Privilege Escalation',
    'CVE-2024-YYYY',
    '{"ips": ["192.168.4.50", "192.168.4.51"], "count": 2}',
    'confirmed',
    '升级MySQL至修复版本，并审查用户权限配置',
    CURRENT_TIMESTAMP - INTERVAL '20 days',
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    'fixed',
    '数据库管理员-赵六',
    '已升级并加固权限配置',
    CURRENT_TIMESTAMP - INTERVAL '20 days',
    CURRENT_TIMESTAMP - INTERVAL '5 days'
),

(
    1005,
    'VUL-2026-005',
    'OpenSSL弱加密算法',
    'low',
    'Weak Crypto',
    'CVE-2022-ZZZZ',
    '{"ips": ["192.168.5.0/24"], "count": 10}',
    'accepted_risk',
    '禁用弱加密算法，强制使用TLS 1.2及以上版本',
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    NULL,
    'accepted',
    '安全团队',
    '经评估，风险可接受，计划在下次维护窗口修复',
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    CURRENT_TIMESTAMP - INTERVAL '30 days'
);

SELECT setval('"t_vul_analysis_sub_id_seq"', 1005, true);

SELECT 
    id,
    vul_name AS "漏洞名称",
    vul_level AS "级别",
    cve_id AS "CVE编号",
    status AS "状态",
    fix_status AS "修复状态",
    responsible_person AS "责任人"
FROM "t_vul_analysis_sub"
WHERE id >= 1001 AND id <= 1005
ORDER BY 
    CASE vul_level
        WHEN 'critical' THEN 1
        WHEN 'high' THEN 2
        WHEN 'medium' THEN 3
        WHEN 'low' THEN 4
    END,
    discovery_time DESC;
