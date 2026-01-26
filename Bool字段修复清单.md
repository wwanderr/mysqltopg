# Bool字段修复清单

## 📊 扫描结果汇总

**扫描范围**: 53个建表SQL文件  
**包含bool字段的表**: 14个  
**需要修复的XML文件**: 7个  

---

## ✅ 已修复

| XML文件 | 表 | Bool字段 | 修复状态 |
|---------|-----|----------|----------|
| EventTemplateMapper.xml | t_event_template | incident_type, enable | ✅ 已修复 |

---

## ⚠️ 待修复清单

### 1. EventScenarioQueueMapper.xml
- **表**: t_event_scenario_queue  
- **Bool字段**: is_job_commit  
- **问题**: 直接用整数比较  
- **修复**: `WHERE is_job_commit = 1` → `WHERE is_job_commit = true`

### 2. RiskIncidentMapper.xml
- **表**: t_event_template  
- **Bool字段**: incident_type, enable  
- **问题**: 直接用整数比较  
- **修复**: 查询条件改为 `true/false`

### 3. RiskIncidentOutGoingHistoryMapper.xml
- **表**: t_event_template  
- **Bool字段**: incident_type, enable  
- **问题**: 直接用整数比较  
- **修复**: 查询条件改为 `true/false`

### 4. RiskIncidentOutGoingMapper.xml
- **表**: t_event_template  
- **Bool字段**: incident_type, enable  
- **问题**: 直接用整数比较  
- **修复**: 查询条件改为 `true/false`

### 5. SecurityEvent.xml
- **表**: t_event_thread  
- **Bool字段**: is_delete  
- **问题**: 直接用整数比较  
- **修复**: `WHERE is_delete = 0` → `WHERE is_delete = false`

### 6. EventUpdateCkAlarmQueueMapper.xml
- **表**: t_event_update_ck_alarm_queue  
- **Bool字段**: is_ck_sync  
- **问题**: 直接用整数比较  
- **修复**: 查询条件改为 `true/false`

### 7. StrategyDeviceRelMapper.xml
- **表**: t_linked_strategy  
- **Bool字段**: auto_handle, status  
- **问题**: 直接用整数比较  
- **修复**: 查询条件改为 `true/false`

---

## 📋 所有包含Bool字段的表

| 表名 | Bool字段 | 对应XML | 是否需要修复 |
|------|----------|---------|-------------|
| t_attacker_traffic_task | is_init | AttackerTrafficTaskMapper.xml | ✅ 无问题 |
| t_event_scenario_queue | is_job_commit | EventScenarioQueueMapper.xml | ⚠️ 需要修复 |
| t_event_template | incident_type, enable | EventTemplateMapper.xml等7个 | ✅ EventTemplateMapper已修复<br>⚠️ 其他3个需要修复 |
| t_event_thread | is_delete | SecurityEvent.xml | ⚠️ 需要修复 |
| t_event_update_ck_alarm_queue | is_ck_sync | EventUpdateCkAlarmQueueMapper.xml | ⚠️ 需要修复 |
| t_linked_strategy | auto_handle, status | LinkedStrategyMapper.xml等6个 | ⚠️ StrategyDeviceRelMapper需要修复 |
| t_notice_history | status | NoticeHistoryMapper.xml | ✅ 无问题 |
| t_out_going_config | is_system_ca | EventOutGoingConfigMapper.xml | ✅ 无问题 |
| t_prohibit_domain_history | status | LinkedStrategyValidtimeMapper.xml等 | ✅ 无问题 |
| t_prohibit_history | status | LinkedStrategyValidtimeMapper.xml等 | ✅ 无问题 |
| t_scene_rule_info | is_open, default_switch | - | ℹ️ 无XML |
| t_security_alarm_handle | result | SecurityAlarmHandleMapper.xml | ✅ 无问题 |
| t_security_types | is_enable | SecurityTypeMapper.xml | ✅ 无问题 |
| xdr_schema_version | success | - | ℹ️ 无XML |

---

## 🔧 修复方法

### 场景1: 插入/更新时传入Integer值到bool字段

**问题代码**:
```xml
<insert>
  INSERT INTO table_name (bool_field) 
  VALUES (#{boolField,jdbcType=INTEGER})
</insert>
```

**修复后**:
```xml
<insert>
  INSERT INTO table_name (bool_field) 
  VALUES ((#{boolField,jdbcType=INTEGER}::int)::boolean)
</insert>
```

### 场景2: WHERE条件中使用整数比较bool字段

**问题代码**:
```xml
<select>
  SELECT * FROM table_name WHERE bool_field = 1
</select>
```

**修复后**:
```xml
<select>
  SELECT * FROM table_name WHERE bool_field = true
</select>
```

### 场景3: UPDATE时设置bool字段

**问题代码**:
```xml
<update>
  UPDATE table_name SET bool_field = #{value,jdbcType=INTEGER}
</update>
```

**修复后**:
```xml
<update>
  UPDATE table_name SET bool_field = (#{value,jdbcType=INTEGER}::int)::boolean
</update>
```

---

## 📝 修复步骤

### 批量修复建议

1. **备份所有XML文件**
   ```bash
   cd C:\Users\wcss\Desktop\mysqlToPg\postgresql_xml_manual
   mkdir backup_before_bool_fix
   copy *.xml backup_before_bool_fix\
   ```

2. **逐个修复待修复的7个文件**
   - EventScenarioQueueMapper.xml
   - RiskIncidentMapper.xml
   - RiskIncidentOutGoingHistoryMapper.xml
   - RiskIncidentOutGoingMapper.xml
   - SecurityEvent.xml
   - EventUpdateCkAlarmQueueMapper.xml
   - StrategyDeviceRelMapper.xml

3. **验证修复**
   - 运行检查脚本: `python check_bool_fields.py`
   - 确认"需要修复"数量为0

4. **测试**
   - 部署修复后的XML
   - 执行相关功能测试
   - 验证bool字段的CRUD操作

---

## 🎯 修复优先级

| 优先级 | XML文件 | 原因 |
|--------|---------|------|
| P0 | SecurityEvent.xml | 核心安全事件功能 |
| P1 | RiskIncidentMapper.xml | 风险事件主表 |
| P1 | EventScenarioQueueMapper.xml | 事件场景队列 |
| P2 | EventUpdateCkAlarmQueueMapper.xml | 告警队列更新 |
| P2 | StrategyDeviceRelMapper.xml | 策略设备关联 |
| P3 | RiskIncidentOutGoingMapper.xml | 风险事件外发 |
| P3 | RiskIncidentOutGoingHistoryMapper.xml | 风险事件外发历史 |

---

## ✅ 验证清单

- [ ] 备份所有XML文件
- [ ] 修复 EventScenarioQueueMapper.xml
- [ ] 修复 RiskIncidentMapper.xml
- [ ] 修复 RiskIncidentOutGoingHistoryMapper.xml
- [ ] 修复 RiskIncidentOutGoingMapper.xml
- [ ] 修复 SecurityEvent.xml
- [ ] 修复 EventUpdateCkAlarmQueueMapper.xml
- [ ] 修复 StrategyDeviceRelMapper.xml
- [ ] 重新运行检查脚本
- [ ] 部署测试环境验证
- [ ] 执行回归测试

---

**生成时间**: 2026-01-22  
**工具**: check_bool_fields.py  
**报告文件**: bool_fields_report.txt
