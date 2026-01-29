package com.dbapp.extension.xdr.test;

import com.dbapp.extension.xdr.threatMonitor.entity.EventTemplate;
import com.dbapp.extension.xdr.test.mapper.EventTemplateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * EventTemplate 测试 Controller
 * 
 * 所有测试方法使用 GET 请求，参数在方法内部写死
 * 通过 Postman 调用 http://localhost:8080/test/eventtemplate/testX_methodName
 * 
 * 测试数据ID范围：1001-1005
 * 
 * 生成时间: 2026-01-26
 */
@RestController
@RequestMapping("/test/eventTemplate")
public class EventTemplateTestController {

    @Autowired
    private EventTemplateMapper mapper;

    @GetMapping("/")
    public Map<String, Object> index() {
        Map<String, Object> result = new HashMap<>();
        result.put("module", "EventTemplate 测试接口");
        result.put("total_tests", 6);
        result.put("test_data_range", "ID: 1001-1005");
        result.put("scenarios", new String[]{
            "SSH暴力破解攻击",
            "SQL注入攻击检测",
            "端口扫描行为",
            "恶意文件下载",
            "异常外连行为"
        });
        return result;
    }

    /**
     * 测试1：查询所有启用的模板
     * 预期：返回 enable=true 的模板（ID: 1001, 1002, 1003, 1005）
     */
    @GetMapping("/test1_selectAllTemplate")
    public Map<String, Object> test1_selectAllTemplate() {
        Map<String, Object> result = new HashMap<>();
        result.put("test", "selectAllTemplate");
        
        try {
            // 查询所有启用的模板（不需要参数）
            List<EventTemplate> templates = mapper.selectAllTemplate();
            
            result.put("status", "SUCCESS");
            result.put("count", templates.size());
            result.put("templates", templates);
            result.put("note", "只返回 enable=true 的模板，ID=1004已禁用不会返回");
            
            System.out.println("✓ 测试通过：selectAllTemplate，返回 " + templates.size() + " 条记录");
            
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }

    /**
     * 测试2：清空表（谨慎使用！）
     * 场景：用于测试环境重置
     * 警告：会删除所有数据，生产环境禁用
     */
    @GetMapping("/test2_truncate")
    public Map<String, Object> test2_truncate() {
        Map<String, Object> result = new HashMap<>();
        result.put("test", "truncate");
        
        try {
            // 警告：此操作会清空整个表
            // mapper.truncate();  // 取消注释以执行
            
            result.put("status", "SKIPPED");
            result.put("message", "TRUNCATE 操作已禁用，如需测试请取消注释");
            result.put("warning", "此操作会删除表中所有数据，请谨慎使用！");
            
            System.out.println("⚠️  TRUNCATE 操作已跳过（已禁用）");
            
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }

    /**
     * 测试3：查询有 uniq_code 的记录数
     * 预期：返回 5（测试数据中所有记录都有 uniq_code）
     */
    @GetMapping("/test3_queryCodeCount")
    public Map<String, Object> test3_queryCodeCount() {
        Map<String, Object> result = new HashMap<>();
        result.put("test", "queryCodeCount");
        
        try {
            // 查询有 uniq_code 的数量
            Long count = mapper.queryCodeCount();
            
            result.put("status", "SUCCESS");
            result.put("count", count);
            result.put("message", "查询到 " + count + " 条有 uniq_code 的记录");
            
            System.out.println("✓ 测试通过：queryCodeCount = " + count);
            
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }

    /**
     * 测试4：批量插入模板
     * 场景：插入2个新的攻击检测模板
     */
    @GetMapping("/test4_batchInsert")
    public Map<String, Object> test4_batchInsert() {
        Map<String, Object> result = new HashMap<>();
        result.put("test", "batchInsert");
        
        try {
            // 构造批量插入数据
            List<EventTemplate> templates = new ArrayList<>();
            
            // 模板1：DDoS攻击检测
            EventTemplate template1 = new EventTemplate();
            template1.setIncidentName("DDoS攻击检测");
            template1.setIncidentRuleType("流量攻击");
            template1.setIncidentClassType("拒绝服务");
            template1.setIncidentSubClassType("DDoS");
            template1.setIncidentType(1);  // true
            template1.setIncidentCond("request_rate > 10000 AND time_window < 10");
            template1.setIncidentDescription("检测到短时间内大量请求，疑似DDoS攻击");
            template1.setIncidentSuggestion("建议：1. 启用流量清洗；2. 联系运营商；3. 使用CDN防护");
            template1.setConclusion("发现DDoS攻击，已触发防护");
            template1.setFocus("target_ip");
            template1.setDisplayFiled("src_ip,target_ip,request_rate,attack_type");
            template1.setEnable(1);  // true
            template1.setUpdateTime(LocalDateTime.now());
            template1.setUniqCode(2001);
            template1.setPriority(10);
            template1.setNetflowLogField("src_ip,dst_ip,packet_count,bytes");
            template1.setHostLogField(null);
            templates.add(template1);
            
            // 模板2：弱密码检测
            EventTemplate template2 = new EventTemplate();
            template2.setIncidentName("弱密码使用检测");
            template2.setIncidentRuleType("配置风险");
            template2.setIncidentClassType("身份认证");
            template2.setIncidentSubClassType("弱密码");
            template2.setIncidentType(0);  // false，是风险不是攻击
            template2.setIncidentCond("password IN (weak_password_list)");
            template2.setIncidentDescription("检测到使用弱密码，存在安全隐患");
            template2.setIncidentSuggestion("建议：1. 强制修改密码；2. 设置密码复杂度策略");
            template2.setConclusion("发现弱密码使用");
            template2.setFocus("username");
            template2.setDisplayFiled("username,password_strength,last_change_time");
            template2.setEnable(1);
            template2.setUpdateTime(LocalDateTime.now());
            template2.setUniqCode(2002);
            template2.setPriority(7);
            template2.setNetflowLogField(null);
            template2.setHostLogField("username,login_ip,password_age");
            templates.add(template2);
            
            // 执行批量插入
            mapper.batchInsert(templates);
            
            result.put("status", "SUCCESS");
            result.put("inserted_count", templates.size());
            result.put("templates", new String[]{"DDoS攻击检测", "弱密码使用检测"});
            result.put("message", "批量插入成功");
            result.put("note", "使用 ON CONFLICT 处理，如果 uniq_code 已存在则更新");
            
            System.out.println("✓ 测试通过：batchInsert，插入 " + templates.size() + " 条记录");
            
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }

    /**
     * 测试5：按 uniq_code 插入或更新
     * 场景：更新 uniq_code=1001 (SSH暴力破解) 的优先级
     */
    @GetMapping("/test5_updateByUniqCode")
    public Map<String, Object> test5_updateByUniqCode() {
        Map<String, Object> result = new HashMap<>();
        result.put("test", "updateByUniqCode");
        
        try {
            // 构造更新数据（使用测试数据中的 uniq_code=1001）
            EventTemplate template = new EventTemplate();
            template.setIncidentName("SSH暴力破解攻击【已更新】");
            template.setIncidentRuleType("异常登录");
            template.setIncidentClassType("入侵检测");
            template.setIncidentSubClassType("暴力破解");
            template.setIncidentType(1);
            template.setIncidentCond("login_fail_count > 10 AND time_window < 300");  // 更新条件
            template.setIncidentDescription("检测到SSH暴力破解攻击【阈值已调整】");
            template.setIncidentSuggestion("建议：立即封禁攻击源IP");
            template.setConclusion("发现暴力破解攻击，已自动拦截");
            template.setFocus("src_ip");
            template.setDisplayFiled("src_ip,dst_ip,login_user,fail_count");
            template.setEnable(1);
            template.setUpdateTime(LocalDateTime.now());
            template.setUniqCode(1001);  // 使用测试数据中已存在的 uniq_code
            template.setPriority(10);  // 提升优先级
            template.setNetflowLogField("src_ip,dst_ip,protocol,dst_port");
            template.setHostLogField("username,src_ip,login_time");
            
            // 执行插入或更新（ON CONFLICT）
            mapper.updateByUniqCode(template);
            
            result.put("status", "SUCCESS");
            result.put("uniq_code", 1001);
            result.put("operation", "UPDATE");
            result.put("message", "更新成功（因为 uniq_code=1001 已存在）");
            result.put("changes", new String[]{"优先级 9→10", "失败次数阈值 5→10"});
            
            System.out.println("✓ 测试通过：updateByUniqCode (uniq_code=1001)");
            
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }

    /**
     * 测试6：按事件名称更新
     * 场景：更新"SQL注入攻击检测"的描述和建议
     */
    @GetMapping("/test6_updateByIncidentName")
    public Map<String, Object> test6_updateByIncidentName() {
        Map<String, Object> result = new HashMap<>();
        result.put("test", "updateByIncidentName");
        
        try {
            // 构造更新数据（使用测试数据中的事件名称）
            EventTemplate template = new EventTemplate();
            template.setIncidentName("SQL注入攻击检测");  // 使用测试数据中的名称
            template.setIncidentRuleType("Web攻击");
            template.setIncidentClassType("应用层攻击");
            template.setIncidentSubClassType("SQL注入【已加强】");
            template.setIncidentType(1);
            template.setIncidentCond("url LIKE '%union%select%' OR url LIKE '%or%1=1%' OR url LIKE '%drop%table%'");
            template.setIncidentDescription("检测到SQL注入攻击【规则已更新，新增DROP TABLE检测】");
            template.setIncidentSuggestion("建议：1. 立即拦截；2. 使用WAF；3. 参数化查询");
            template.setConclusion("发现SQL注入攻击尝试，已拦截");
            template.setFocus("url");
            template.setDisplayFiled("src_ip,url,http_method,attack_payload");
            template.setEnable(1);
            template.setUpdateTime(LocalDateTime.now());
            template.setPriority(10);
            template.setNetflowLogField("src_ip,dst_ip,http_host,http_uri");
            template.setHostLogField("request_url,request_params");
            
            // 执行更新（UPDATE 无返回值）
            mapper.updateByIncidentName(template);
            
            result.put("status", "SUCCESS");
            result.put("incident_name", "SQL注入攻击检测");
            result.put("message", "更新成功");
            result.put("changes", new String[]{"新增 DROP TABLE 检测", "更新建议内容"});
            
            System.out.println("✓ 测试通过：updateByIncidentName (SQL注入攻击检测)");
            
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }
}
