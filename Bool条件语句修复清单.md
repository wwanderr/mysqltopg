# XML Bool 条件语句修复清单

**生成时间**: 2026-01-22

**统计**: 7 个文件，18 处需要修复

---

## 问题说明

在 PostgreSQL 中，bool 类型的字段在条件语句中应该使用 `true`/`false`，而不是 `1`/`0`。

### 错误示例

```xml
WHERE enable = 1
AND incident_type = 0
```

### 正确示例

```xml
WHERE enable = true
AND incident_type = false
```

---

## 修复清单

### postgresql_xml_manual\EventScenarioQueueMapper.xml

共 3 处问题:

#### 1. 行 34

- **表**: `t_event_scenario_queue`
- **字段**: `is_job_commit` (bool类型)
- **当前**: `is_job_commit=0`
- **建议**: `is_job_commit = false`

**原文**:
```xml
WHERE t.is_job_commit=0 ORDER BY t.create_time DESC LIMIT 1000
```

#### 2. 行 38

- **表**: `t_event_scenario_queue`
- **字段**: `is_job_commit` (bool类型)
- **当前**: `is_job_commit =1`
- **建议**: `is_job_commit = true`

**原文**:
```xml
UPDATE t_event_scenario_queue SET is_job_commit =1 WHERE (focus_ip, target_ip, event_code, scenario_template_id ) IN
```

#### 3. 行 49

- **表**: `t_event_scenario_queue`
- **字段**: `is_job_commit` (bool类型)
- **当前**: `is_job_commit=1`
- **建议**: `is_job_commit = true`

**原文**:
```xml
AND (t_event_scenario_queue.is_job_commit=1 OR i.event_code IS NULL)
```


### postgresql_xml_manual\EventUpdateCkAlarmQueueMapper.xml

共 2 处问题:

#### 1. 行 24

- **表**: `t_event_update_ck_alarm_queue`
- **字段**: `is_ck_sync` (bool类型)
- **当前**: `is_ck_sync=0`
- **建议**: `is_ck_sync = false`

**原文**:
```xml
WHERE is_ck_sync=0 ORDER BY create_time DESC LIMIT 1000
```

#### 2. 行 28

- **表**: `t_event_update_ck_alarm_queue`
- **字段**: `is_ck_sync` (bool类型)
- **当前**: `is_ck_sync =1`
- **建议**: `is_ck_sync = true`

**原文**:
```xml
UPDATE t_event_update_ck_alarm_queue SET is_ck_sync =1 WHERE (window_id , agg_condition ) IN
```


### postgresql_xml_manual\QueryTemplateMapper.xml

共 2 处问题:

#### 1. 行 33

- **表**: `t_event_template`
- **字段**: `enable` (bool类型)
- **当前**: `enable = 1`
- **建议**: `enable = true`

**原文**:
```xml
WHERE enable = 1
```

#### 2. 行 47

- **表**: `t_event_template`
- **字段**: `enable` (bool类型)
- **当前**: `enable = 1`
- **建议**: `enable = true`

**原文**:
```xml
WHERE enable = 1
```


### postgresql_xml_manual\RiskIncidentMapper.xml

共 2 处问题:

#### 1. 行 84

- **表**: `t_event_template`
- **字段**: `incident_type` (bool类型)
- **当前**: `incident_type = 1`
- **建议**: `incident_type = true`

**原文**:
```xml
where tet.incident_type = 1
```

#### 2. 行 110

- **表**: `t_event_template`
- **字段**: `incident_type` (bool类型)
- **当前**: `incident_type = 0`
- **建议**: `incident_type = false`

**原文**:
```xml
where tet.incident_type = 0
```


### postgresql_xml_manual\RiskIncidentOutGoingHistoryMapper.xml

共 2 处问题:

#### 1. 行 47

- **表**: `t_event_template`
- **字段**: `incident_type` (bool类型)
- **当前**: `incident_type = 1`
- **建议**: `incident_type = true`

**原文**:
```xml
where tet.incident_type = 1
```

#### 2. 行 70

- **表**: `t_event_template`
- **字段**: `incident_type` (bool类型)
- **当前**: `incident_type = 0`
- **建议**: `incident_type = false`

**原文**:
```xml
where tet.incident_type = 0
```


### postgresql_xml_manual\RiskIncidentOutGoingMapper.xml

共 2 处问题:

#### 1. 行 52

- **表**: `t_event_template`
- **字段**: `incident_type` (bool类型)
- **当前**: `incident_type = 1`
- **建议**: `incident_type = true`

**原文**:
```xml
where tet.incident_type = 1
```

#### 2. 行 75

- **表**: `t_event_template`
- **字段**: `incident_type` (bool类型)
- **当前**: `incident_type = 0`
- **建议**: `incident_type = false`

**原文**:
```xml
where tet.incident_type = 0
```


### postgresql_xml_manual\SecurityEvent.xml

共 5 处问题:

#### 1. 行 855

- **表**: `t_event_thread`
- **字段**: `is_delete` (bool类型)
- **当前**: `is_delete != 1`
- **建议**: `is_delete = true`

**原文**:
```xml
where t.time_part = #{timePart} and t.is_delete != 1 group by a.incident_name,a.id,a.incident_rule_type,a.priority,a.focus,a.incident_cond order by a.priority desc;
```

#### 2. 行 877

- **表**: `t_event_thread`
- **字段**: `is_delete` (bool类型)
- **当前**: `is_delete=1`
- **建议**: `is_delete = true`

**原文**:
```xml
update t_event_thread t set is_delete=1
```

#### 3. 行 879

- **表**: `t_event_thread`
- **字段**: `is_delete` (bool类型)
- **当前**: `is_delete=0`
- **建议**: `is_delete = false`

**原文**:
```xml
where t.template_id = a.id and t.time_part = #{timePart} and t.focus =#{focus} and t.focus_ip =#{focusIp} and a.priority &gt; #{priority} and t.is_delete=0
```

#### 4. 行 885

- **表**: `t_event_thread`
- **字段**: `is_delete` (bool类型)
- **当前**: `is_delete=0`
- **建议**: `is_delete = false`

**原文**:
```xml
where t.time_part = #{timePart} and t.focus =#{focus} and t.focus_ip =#{focusIp} and a.priority &gt; #{priority} and t.is_delete=0);
```

#### 5. 行 955

- **表**: `t_event_thread`
- **字段**: `is_delete` (bool类型)
- **当前**: `is_delete=0`
- **建议**: `is_delete = false`

**原文**:
```xml
where t.time_part = #{timePart} and t.focus =#{focus} and t.focus_ip =#{focusIp} and a.priority &gt; #{priority} and t.is_delete=0)
```


---

## 批量修复脚本

为了方便批量修复，以下是 Python 脚本示例:

```python
# TODO: 生成批量修复脚本
```
