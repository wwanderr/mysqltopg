-- ============================================
-- 测试数据：EventOutGoing（事件外发数据）
-- 表：t_event_out_going_data
-- 字段数：36（DDL完整覆盖）
-- 生成时间：2026-01-28（深度修复）
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_event_out_going_data" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据（36个字段完整）
INSERT INTO "t_event_out_going_data" (
    "id", "event_code", "category", "sub_category", "threat_severity", "incident_name", 
    "event_description", "start_time", "end_time", "attacker", "victim", 
    "dest_address", "src_address", "request_url", "request_domain", "dest_port", 
    "dest_geo_region", "dest_geo_city", "dest_geo_county", "src_port", 
    "src_geo_region", "src_geo_city", "src_geo_county", "alarm_result", 
    "event_count", "kill_chain", "mirror_category", "focus", "focus_ip", 
    "tag_search", "alarm", "time_part", "create_time", "update_time", 
    "incident_description", "incident_suggestion"
) VALUES 

-- 场景1：DDoS攻击事件
(1001, 'EVT-DDOS-20260126-001', 'Network Attack', 'DDoS', 'high', 'DDoS洪水攻击', 
'检测到大规模DDoS攻击，目标服务器遭受SYN洪水攻击', 
CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour', 
'10.0.0.100,10.0.0.101,10.0.0.102', '192.168.1.10', 
'192.168.1.10', '10.0.0.100', NULL, NULL, 80, 
'广东省', '深圳市', '中国', 12345, 
'浙江省', '杭州市', '中国', '攻击成功导致服务中断', 
15000, 'Reconnaissance,Resource Development', 'DDoS攻击', 'server', '192.168.1.10', 
'DDoS,网络攻击,高危', '原始告警数据...', CURRENT_DATE, 
CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour 30 minutes',
'攻击者使用僵尸网络发起大规模DDoS攻击，导致Web服务器响应缓慢', 
'建议启用DDoS防护，配置流量清洗设备，限制单IP连接数'),

-- 场景2：SQL注入攻击
(1002, 'EVT-SQLI-20260126-002', 'Web Attack', 'SQL Injection', 'critical', 'SQL注入攻击尝试', 
'检测到针对Web应用的SQL注入攻击尝试', 
CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '3 hours', 
'203.0.113.50', '192.168.1.20', 
'192.168.1.20', '203.0.113.50', 'http://example.com/login?user=admin'' OR 1=1--', 'example.com', 8080, 
'北京市', '北京市', '中国', 54321, 
'北京市', '北京市', '中国', '攻击被WAF拦截', 
5, 'Initial Access,Execution', 'SQL注入', 'webapp', '192.168.1.20', 
'SQL注入,Web攻击,严重', '原始告警数据...', CURRENT_DATE, 
CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '2 hours 50 minutes',
'攻击者尝试通过SQL注入绕过登录验证', 
'建议升级WAF规则，对输入参数进行严格过滤，使用预编译SQL语句'),

-- 场景3：恶意软件传播
(1003, 'EVT-MALWARE-20260126-003', 'Malware', 'Trojan', 'high', '木马病毒传播', 
'检测到木马病毒通过邮件附件传播', 
CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '4 hours', 
'198.51.100.25', '192.168.1.30', 
'192.168.1.30', '198.51.100.25', NULL, 'malicious-server.evil', 443, 
'上海市', '上海市', '中国', 49876, 
'上海市', '上海市', '中国', '已隔离', 
1, 'Initial Access,Execution,Persistence', '恶意软件', 'endpoint', '192.168.1.30', 
'恶意软件,木马,高危', '原始告警数据...', CURRENT_DATE, 
CURRENT_TIMESTAMP - INTERVAL '5 hours', CURRENT_TIMESTAMP - INTERVAL '4 hours 20 minutes',
'终端用户打开恶意邮件附件，触发木马下载', 
'建议隔离受感染主机，更新防病毒软件，对全网进行扫描'),

-- 场景4：暴力破解攻击
(1004, 'EVT-BRUTE-20260126-004', 'Authentication Attack', 'Brute Force', 'medium', 'SSH暴力破解', 
'检测到针对SSH服务的暴力破解尝试', 
CURRENT_TIMESTAMP - INTERVAL '6 hours', CURRENT_TIMESTAMP - INTERVAL '5 hours', 
'45.33.32.156', '192.168.1.40', 
'192.168.1.40', '45.33.32.156', NULL, NULL, 22, 
'浙江省', '杭州市', '中国', 62345, 
'浙江省', '杭州市', '中国', '尝试失败', 
250, 'Credential Access', '暴力破解', 'server', '192.168.1.40', 
'暴力破解,SSH,中危', '原始告警数据...', CURRENT_DATE, 
CURRENT_TIMESTAMP - INTERVAL '6 hours', CURRENT_TIMESTAMP - INTERVAL '5 hours 15 minutes',
'攻击者尝试使用字典攻击破解SSH密码，所有尝试均失败', 
'建议禁用root远程登录，使用密钥认证，配置fail2ban防护'),

-- 场景5：数据泄露事件
(1005, 'EVT-LEAK-20260126-005', 'Data Breach', 'Exfiltration', 'critical', '敏感数据外传', 
'检测到大量敏感数据被传输到外部服务器', 
CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '23 hours', 
'192.168.1.50', '203.0.113.100', 
'203.0.113.100', '192.168.1.50', 'https://attacker-server.com/upload', 'attacker-server.com', 443, 
'广东省', '深圳市', '中国', 51234, 
'广东省', '深圳市', '中国', '数据已外传', 
1, 'Collection,Exfiltration', '数据泄露', 'database', '192.168.1.50', 
'数据泄露,严重,敏感信息', '原始告警数据...', CURRENT_DATE - INTERVAL '1 day', 
CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '23 hours',
'内部主机向外部服务器传输了500MB加密文件，疑似数据窃取', 
'建议立即断开涉事主机网络，调查数据泄露范围，加强DLP策略');
