# xml_tests 模块修复流程说明

## 🔴 强制规范

### 所有后续单元测试修复必须遵循以下顺序：

```
1️⃣ 先修复 test_data.sql
        ↓
2️⃣ 再修复 TestController.java
```

**禁止反向操作！**

---

## 📖 详细流程文档

请参阅：**`修复标准流程_强制规范.md`**

该文档包含：
- ✅ 强制修复顺序
- ✅ 详细修复步骤
- ✅ 质量标准
- ✅ 常见错误（禁止事项）
- ✅ 正确示例
- ✅ 修复报告模板

---

## 📊 已完成模块（7个，84个方法）

| 模块 | 方法数 | 修复质量 | 报告 |
|------|--------|----------|------|
| RiskIncident | 30 | ⭐⭐⭐⭐⭐ | [深度修复报告](RiskIncident/深度修复报告.md) |
| RiskIncidentOutGoing | 15 | ⭐⭐⭐⭐⭐ | [深度修复报告](RiskIncidentOutGoing/深度修复报告.md) |
| RiskIncidentHistory | 12 | ⭐⭐⭐⭐⭐ | [深度修复报告](RiskIncidentHistory/深度修复报告.md) |
| VulAnalysisSub | 11 | ⭐⭐⭐⭐⭐ | [深度修复报告](VulAnalysisSub/深度修复报告.md) |
| OutGoingConfig | 7 | ⭐⭐⭐⭐⭐ | [深度修复报告](OutGoingConfig/深度修复报告.md) |
| ScanHistoryDetail | 5 | ⭐⭐⭐⭐⭐ | [深度修复报告](ScanHistoryDetail/深度修复报告.md) |
| EventScenarioQueue | 4 | ⭐⭐⭐⭐ | [深度修复报告](EventScenarioQueue/深度修复报告.md) |

---

## 🎯 待修复模块

### A类：复杂模块（3个）
- SecurityEvent (31方法)
- EventTemplate (15方法)
- AttackKnowledge (未统计)

### B类：标准CRUD（约10个）
- EventUpdateCkAlarmQueue
- RiskIncidentOutGoingHistory
- 其他标准CRUD模块

---

## 📝 快速开始

### 修复新模块的步骤：

```bash
# 1. 找到DDL文件
create_table/migrations_ultimate/V*__create_t_模块名.sql

# 2. 找到XML Mapper
postgresql_xml_manual/模块名Mapper.xml

# 3. 修复test_data.sql
xml_tests/模块名/test_data.sql

# 4. 修复TestController
xml_tests/模块名/模块名TestController.java

# 5. 生成报告
xml_tests/模块名/深度修复报告.md
```

---

## ✅ 质量检查清单

修复完成后，确认以下项目：

- [ ] test_data.sql 字段100%匹配DDL
- [ ] test_data.sql 包含关联表数据
- [ ] test_data.sql 测试数据≥10条
- [ ] TestController 异常处理100%
- [ ] TestController 参数覆盖>90%
- [ ] TestController 方法数 = XML方法数
- [ ] 已生成深度修复报告

---

## 📞 相关文档

- [修复标准流程_强制规范.md](修复标准流程_强制规范.md) - 详细流程说明
- [最终深度修复总结报告_2026-01-28.md](最终深度修复总结报告_2026-01-28.md) - 修复成果总结
- [深度修复进度报告_2026-01-28.md](深度修复进度报告_2026-01-28.md) - 阶段性进度

---

**更新时间**: 2026-01-28  
**修复策略**: 先SQL后Controller，质量优先
