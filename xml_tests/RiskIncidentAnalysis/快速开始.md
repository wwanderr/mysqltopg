# RiskIncidentAnalysis 测试快速开始指南

## 一、模块说明

**Mapper类型**: 仅继承BaseMapper，无自定义方法  
**测试方法数**: 5个（BaseMapper提供的CRUD方法）  
**主表**: `t_risk_incidents_analysis`

---

## 二、测试前准备

### 1. 执行测试数据SQL

```bash
psql -U dbapp -d your_database -f test_data.sql
```

**插入数据**:
- 5条测试记录（ID: 10001-10005）
- 覆盖所有status状态：todo, doing, done, error
- 包含完整的19个字段

---

## 三、测试接口列表

### 基础CRUD测试

| 序号 | 测试方法 | URL | 描述 |
|-----|---------|-----|------|
| 1 | selectById | `/test/riskIncidentAnalysis/selectById` | 查询ID=10001的记录 |
| 2 | insert | `/test/riskIncidentAnalysis/insert` | 插入新记录（event_code: RI-TEST-2026-999） |
| 3 | updateById | `/test/riskIncidentAnalysis/updateById` | 更新ID=10001的status和core_risks |
| 4 | deleteById | `/test/riskIncidentAnalysis/deleteById` | 删除ID=10002的记录 |
| 5 | selectList | `/test/riskIncidentAnalysis/selectList` | 查询所有记录 |

---

## 四、快速测试

### 方式1：浏览器访问

```
http://localhost:8080/test/riskIncidentAnalysis/selectById
http://localhost:8080/test/riskIncidentAnalysis/insert
http://localhost:8080/test/riskIncidentAnalysis/updateById
http://localhost:8080/test/riskIncidentAnalysis/deleteById
http://localhost:8080/test/riskIncidentAnalysis/selectList
```

### 方式2：curl命令

```bash
# 1. 查询
curl http://localhost:8080/test/riskIncidentAnalysis/selectById

# 2. 插入
curl http://localhost:8080/test/riskIncidentAnalysis/insert

# 3. 更新
curl http://localhost:8080/test/riskIncidentAnalysis/updateById

# 4. 删除
curl http://localhost:8080/test/riskIncidentAnalysis/deleteById

# 5. 查询所有
curl http://localhost:8080/test/riskIncidentAnalysis/selectList
```

---

## 五、预期结果

### 1. selectById
```
SUCCESS: RI-2026-001
```

### 2. insert
```
SUCCESS: 插入成功, ID=10006
```

### 3. updateById
```
SUCCESS: 更新 1 条记录
```

### 4. deleteById
```
SUCCESS: 删除 1 条记录
```

### 5. selectList
```
SUCCESS: 共 5 条记录
```

---

## 六、表结构说明

| 字段名 | 类型 | 说明 |
|--------|------|------|
| id | int8 | 主键，自增 |
| risk_incidents_event_code | varchar(128) | 风险事件编号（必填） |
| status | varchar(10) | 状态：todo/doing/done/error（必填） |
| core_risks | text | 核心风险 |
| popular_interpretation | text | 通俗解读 |
| critical_dangerpoint | text | 关键危险点 |
| attack_objective | text | 攻击目标 |
| attack_disposal_suggestions | text | 处置建议 |
| attack_info | text | 攻击信息 |
| run_error | text | 运行错误 |
| last_run_time | timestamp(6) | 最后运行时间 |
| last_run_time_consuming | int8 | 运行耗时（毫秒） |
| incidents_end_time | timestamp(6) | 事件结束时间 |
| create_time | timestamp(6) | 创建时间（自动） |
| update_time | timestamp(6) | 更新时间 |

---

## 七、测试数据示例

```sql
-- ID: 10001 (todo状态，包含完整分析信息)
risk_incidents_event_code: RI-2026-001
status: todo
core_risks: 存在高级持续性威胁，攻击者可能获取敏感数据
popular_interpretation: 黑客通过精心策划的攻击，试图窃取您的重要信息

-- ID: 10002 (doing状态，SQL注入场景)
risk_incidents_event_code: RI-2026-002
status: doing
core_risks: 发现SQL注入漏洞，可能导致数据库被篡改

-- ID: 10003 (done状态，C&C通信)
risk_incidents_event_code: RI-2026-003
status: done

-- ID: 10004 (error状态，包含run_error)
risk_incidents_event_code: RI-2026-004
status: error
run_error: AI分析超时：模型加载失败

-- ID: 10005 (todo状态，勒索攻击)
risk_incidents_event_code: RI-2026-005
status: todo
```

---

## 八、注意事项

1. **仅BaseMapper方法**: 此Mapper无自定义方法，仅测试MyBatis-Plus提供的基础CRUD
2. **主键自增**: id字段使用序列自增，插入时无需指定
3. **必填字段**: risk_incidents_event_code 和 status 为必填字段
4. **默认值**: status默认为'todo'，create_time自动设置为当前时间

---

## 九、常见问题

### Q1: 插入失败，提示"违反非空约束"
**A**: 检查是否提供了 `risk_incidents_event_code` 和 `status` 字段

### Q2: 查询返回null
**A**: 检查测试数据是否已插入，可执行 `test_data.sql` 重新插入

### Q3: 序列值冲突
**A**: 执行以下SQL重置序列：
```sql
SELECT setval('t_risk_incidents_analysis_id_seq', 10005, true);
```

---

## 十、测试完成清单

- [ ] 执行 test_data.sql 插入测试数据
- [ ] 测试 selectById（查询ID=10001）
- [ ] 测试 insert（插入新记录）
- [ ] 测试 updateById（更新ID=10001）
- [ ] 测试 selectList（查询所有）
- [ ] 测试 deleteById（删除ID=10002）
- [ ] 验证所有测试返回"SUCCESS"
- [ ] 检查控制台日志无异常

---

**生成时间**: 2026-02-02  
**状态**: 就绪，可开始测试
