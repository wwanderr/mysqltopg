# 深度修复计划 - 从LinkedStrategyValidtime开始

**创建时间**: 2026-01-28  
**修复原则**: 不求快，但求准  
**总数**: 24个测试模块

---

## 📋 修复清单（按字母顺序）

### ✅ 已深度修复（5个）

- [x] 1. **LinkedStrategy** (14方法) - 已完成深度参数覆盖
- [x] 2. **LinkedStrategyValidtime** (3方法) - 已完成关联表数据
- [x] 3. **LoginBaseline** (3方法) - 已完成
- [x] 4. **NoticeHistory** (5方法) - 已完成choose分支测试
- [x] 5. **ProhibitHistory** (37方法) - 已完成大模块简化

---

### 🔄 待深度修复（19个）

#### 【第一批：标准模块 - 6个】

- [ ] 6. **OutGoingConfig** (7方法)
  - XML路径: `postgresql_xml_manual/OutGoingConfigMapper.xml`
  - 需检查: 查询参数、关联表
  
- [ ] 7. **QueryTemplate** (3方法) ✅ 已有基础版
  - 需增强: 参数丰富度
  
- [ ] 8. **ScanHistory** (1方法) ✅ 已有基础版
  - 需检查: 批量插入字段完整性
  
- [ ] 9. **ScanHistoryDetail** (5方法)
  - 需检查: 详细查询参数
  
- [ ] 10. **ScenarioData** (1方法) ✅ 已有基础版
  - 需检查: upsert字段
  
- [ ] 11. **ScenarioTemplate** (1方法) ✅ 已有基础版
  - 需检查: 批量插入

---

#### 【第二批：核心业务模块 - 4个】⭐⭐⭐

- [ ] 12. **RiskIncident** (21方法) 🔥 **最大模块**
  - XML: 1003行，复杂查询多
  - 需要: 完整test_data.sql
  - 关联表: 需检查所有JOIN
  
- [ ] 13. **RiskIncidentHistory** (12方法) 🔥 **当前问题模块**
  - 问题: test_data.sql只有7个字段，需要20+字段
  - 问题: 测试参数空HashMap
  - 需要: 完全重写
  
- [ ] 14. **RiskIncidentOutGoing** (15方法) 🔥
  - 需检查: 外发配置参数
  
- [ ] 15. **RiskIncidentOutGoingHistory** (9方法) 🔥
  - 需检查: 历史查询参数

---

#### 【第三批：联动模块 - 5个】

- [ ] 16. **SecurityAlarmHandle** (1方法) ✅ 已有基础版
  
- [ ] 17. **SecurityEvent** (5方法)
  - 需检查: 事件查询参数
  
- [ ] 18. **SecurityType** (1方法) ✅ 已完成
  
- [ ] 19. **SecurityZoneSync** (1方法) ✅ 已完成
  
- [ ] 20. **SharedData** (1方法) ✅ 已完成

---

#### 【第四批：设备关联 - 4个】

- [ ] 21. **StrategyDeviceRel** (12方法) ✅ 已完成
  
- [ ] 22. **TagSearch** (1方法) ✅ 已完成
  
- [ ] 23. **ThirdAuth** (3方法) ✅ 已完成choose分支
  
- [ ] 24. **VirusKillHistory** (1方法) ✅ 已完成

---

### 🔥 需要深度修复的模块（剩余9个）

1. **OutGoingConfig** (7方法)
2. **ScanHistoryDetail** (5方法)
3. **RiskIncident** (21方法) - 最复杂
4. **RiskIncidentHistory** (12方法) - 当前问题
5. **RiskIncidentOutGoing** (15方法)
6. **RiskIncidentOutGoingHistory** (9方法)
7. **SecurityEvent** (5方法)
8. **VulAnalysisSub** (19方法) - 未在上面列表中，需要添加
9. 其他需要增强的简单模块

---

## 🎯 修复标准（每个模块必须满足）

### 1. test_data.sql 完整性
```sql
-- ✅ 必须包含XML中所有用到的字段
-- ✅ 如果有CASE WHEN枚举，必须包含所有枚举值的测试数据
-- ✅ 如果有JOIN，必须为所有关联表创建数据
-- ✅ 测试数据要覆盖边界情况（空值、特殊值）
```

### 2. TestController 参数覆盖
```java
// ✅ XML中每个<if>条件都要测试
// ✅ XML中每个<foreach>都要测试集合参数
// ✅ XML中每个<choose>的所有分支都要测试
// ✅ 所有方法必须有try-catch
// ✅ 测试方法名清晰，与XML方法对应
```

### 3. 关联表数据
```sql
-- 示例：LinkedStrategy需要t_strategy_device_rel
-- ✅ 检查XML中所有LEFT JOIN / INNER JOIN
-- ✅ 为每个JOIN的表创建匹配数据
-- ✅ 数据要能触发JOIN的各种情况（有匹配、无匹配）
```

### 4. 修复报告
```markdown
# {模块名} 深度修复报告

## 修复内容
- ✅ test_data.sql: 字段从X个增加到Y个
- ✅ 关联表: 添加了t_xxx, t_yyy数据
- ✅ 参数覆盖: XML的Z个参数全部测试
- ✅ 分支测试: choose/if/foreach全覆盖

## 测试方法详情
| 方法 | 参数数 | 关联表 | 特殊逻辑 |
|-----|-------|--------|---------|
| xxx | 8个 | t_yyy | choose分支 |
```

---

## 📝 执行流程（每个模块）

### Step 1: 分析XML (5分钟)
```bash
# 1. 统计方法数
grep -c "select id=\|insert id=\|update id=\|delete id=" XXXMapper.xml

# 2. 检查关联表
grep -i "LEFT JOIN\|INNER JOIN" XXXMapper.xml

# 3. 列出所有参数
grep -o "#{[^}]*}" XXXMapper.xml | sort -u
```

### Step 2: 检查DDL (3分钟)
```bash
# 找到对应的建表SQL
ls create_table/migrations_ultimate/*{table_name}*.sql

# 确认所有字段、类型、枚举
```

### Step 3: 修复test_data.sql (15分钟)
```sql
-- 1. 删除旧数据
DELETE FROM "t_xxx" WHERE id >= 测试ID范围;

-- 2. 插入完整数据（所有字段）
INSERT INTO "t_xxx" (
    -- 列出DDL中的所有字段
) VALUES
-- 至少5条测试数据，覆盖各种情况

-- 3. 如果有关联表，也要插入
INSERT INTO "t_yyy" ...
```

### Step 4: 重写TestController (20分钟)
```java
// 1. 每个XML方法对应一个测试方法
@GetMapping("/{xmlMethodName}")
public String test{XmlMethodName}() {
    try {
        // 2. 设置所有参数
        Map<String, Object> params = new HashMap<>();
        params.put("param1", "value1");
        params.put("param2", Arrays.asList("v1", "v2")); // foreach
        params.put("param3", ...);
        
        // 3. 测试choose分支（如果有）
        // 先测试when分支
        // 再测试otherwise分支
        
        // 4. 返回结果
        return "SUCCESS: ...";
    } catch (Exception e) {
        // 统一异常处理
    }
}
```

### Step 5: 生成修复报告 (5分钟)

### Step 6: 验证 (5分钟)
```bash
# 1. 检查linter错误
# 2. 运行curl测试（可选）
curl http://localhost:8080/test/{module}/{method}
```

---

## 🚀 开始执行

**从第6个模块开始**: OutGoingConfig

**预计时间**: 每个模块30-60分钟，9个核心模块需要6-9小时

**完成标志**: 每个模块的修复报告中明确列出：
- test_data.sql字段数量
- 参数覆盖百分比
- 关联表数量
- 测试方法数量

---

## ✅ 验收标准

修复完成后，每个模块必须能回答：

1. ✅ XML中有几个方法？TestController中有几个？是否一致？
2. ✅ XML中有哪些查询参数？是否全部测试？
3. ✅ XML中有哪些关联表？test_data.sql中是否全部有数据？
4. ✅ XML中有哪些条件分支？是否全部覆盖？
5. ✅ 测试数据是否包含DDL中所有重要字段？

---

**准备开始修复？请确认，我将从第6个模块 OutGoingConfig 开始深度修复！**
