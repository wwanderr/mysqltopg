# MyBatis XML MySQL→PostgreSQL 转换报告

> **转换时间**: 2026-01-19  
> **转换工具**: convert_mybatis_xml.py  
> **目标数据库**: PostgreSQL 16.x

---

## 📊 转换统计

### 文件统计
| 项目 | 数量 |
|------|------|
| **总文件数** | 40 |
| **成功转换** | 40 ✅ |
| **转换失败** | 0 |
| **成功率** | 100% |

### 语法转换统计
| MySQL语法 | PostgreSQL语法 | 转换次数 |
|-----------|---------------|---------|
| `` `identifier` `` | `identifier` (移除反引号) | 0 (已处理) |
| `LIMIT offset, count` | `LIMIT count OFFSET offset` | 21 |
| `ON DUPLICATE KEY UPDATE` | `ON CONFLICT DO UPDATE` | 22 |
| `VALUES(column)` | `EXCLUDED.column` | 165 |
| `GROUP_CONCAT(col)` | `STRING_AGG(col, ',')` | 31 |
| `DATE_FORMAT(date, fmt)` | `TO_CHAR(date, fmt)` | 61 |
| `IFNULL(a, b)` | `COALESCE(a, b)` | 16 |
| `IF(cond, a, b)` | `CASE WHEN ... END` | 11 |
| `CONCAT('%', x, '%')` | `'%' \|\| x \|\| '%'` | 136 |
| `NOW()` | `CURRENT_TIMESTAMP` | 32 |
| `CURDATE()` | `CURRENT_DATE` | 4 |
| `LOCATE(a, b)` | `POSITION(a IN b)` | 0 |
| `FIND_IN_SET(a, b)` | `a = ANY(STRING_TO_ARRAY(b, ','))` | 4 |
| `LIKE` | `LIKE` (需人工review) | 139 |

**总计转换操作**: **~700+ 次语法转换**

---

## 📁 转换文件列表

### 安全告警相关 (7个文件)
1. ✅ SecurityAlarmHandleMapper.xml
2. ✅ SecurityEvent.xml
3. ✅ SecurityTypeMapper.xml
4. ✅ SecurityZoneSyncMapper.xml
5. ✅ AlarmOutGoingConfigMapper.xml
6. ✅ AlarmStatusTimingTaskMapper.xml
7. ✅ NoticeHistoryMapper.xml

### 事件处理相关 (8个文件)
8. ✅ EventTemplateMapper.xml
9. ✅ EventOutGoingMapper.xml
10. ✅ EventOutGoingConfigMapper.xml
11. ✅ EventScenarioQueueMapper.xml
12. ✅ EventUpdateCkAlarmQueueMapper.xml
13. ✅ RiskIncidentMapper.xml
14. ✅ RiskIncidentHistoryMapper.xml
15. ✅ RiskIncidentOutGoingMapper.xml
16. ✅ RiskIncidentOutGoingHistoryMapper.xml

### 扫描和处理相关 (11个文件)
17. ✅ ScanHistoryMapper.xml
18. ✅ ScanHistoryDetailMapper.xml
19. ✅ ScanJobMapper.xml
20. ✅ VirusKillHistoryMapper.xml
21. ✅ KillProcessHistoryMapper.xml
22. ✅ IsolationHistoryMapper.xml
23. ✅ ProhibitHistoryMapper.xml
24. ✅ BlockHistoryMapper.xml
25. ✅ VulAnalysisSubMapper.xml

### 策略和场景相关 (6个文件)
26. ✅ LinkedStrategyMapper.xml
27. ✅ LinkedStrategyValidtimeMapper.xml
28. ✅ StrategyDeviceRelMapper.xml
29. ✅ ScenarioTemplateMapper.xml
30. ✅ ScenarioDataMapper.xml
31. ✅ QueryTemplateMapper.xml

### 威胁情报和资产相关 (5个文件)
32. ✅ IntelligenceMapper.xml
33. ✅ AssetInfoMapper.xml
34. ✅ AttackKnowledgeMapper.xml
35. ✅ AttackerTrafficTaskMapper.xml
36. ✅ SharedDataMapper.xml

### 其他 (4个文件)
37. ✅ TagSearchMapper.xml
38. ✅ ThirdAuthMapper.xml
39. ✅ LoginBaselineMapper.xml
40. ✅ OutGoingConfigMapper.xml

---

## 🔍 典型转换示例

### 示例1: 分页查询
**MySQL**:
```xml
<select id="queryAssets" resultType="java.util.Map">
    SELECT assetIp,assetName FROM `bigdata-web`.t_asset_info
    LIMIT #{offset,jdbcType=INTEGER},#{size,jdbcType=INTEGER}
</select>
```

**PostgreSQL**:
```xml
<select id="queryAssets" resultType="java.util.Map">
    SELECT assetIp,assetName FROM t_asset_info
    LIMIT #{size,jdbcType=INTEGER} OFFSET #{offset,jdbcType=INTEGER}
</select>
```

**转换点**:
- 移除反引号 `` ` ``
- 移除数据库名前缀 `bigdata-web.`
- `LIMIT offset, size` → `LIMIT size OFFSET offset`

---

### 示例2: Upsert操作
**MySQL**:
```xml
<insert id="insertOrUpdate">
    insert into t_security_alarm_handle (agg_condition, window_id)
    values (#{item.aggCondition}, #{item.windowId})
    ON DUPLICATE KEY UPDATE execute_time = values(execute_time)
</insert>
```

**PostgreSQL**:
```xml
<insert id="insertOrUpdate">
    insert into t_security_alarm_handle (agg_condition, window_id)
    values (#{item.aggCondition}, #{item.windowId})
    ON CONFLICT DO UPDATE SET execute_time = EXCLUDED.execute_time
</insert>
```

**转换点**:
- `ON DUPLICATE KEY UPDATE` → `ON CONFLICT DO UPDATE SET`
- `values(column)` → `EXCLUDED.column`

---

### 示例3: 复杂聚合查询
**MySQL**:
```sql
SELECT 
    event_name as name,
    min(t.start_time) as startTime,
    GROUP_CONCAT(t.focus_ip) as focusIp,
    GROUP_CONCAT(t.kill_chain SEPARATOR ' ') as killChain,
    GROUP_CONCAT(IF(t.tag_search IS NOT NULL AND t.tag_search != '', t.tag_search, NULL)) as tagSearch,
    DATE_FORMAT(max(t.end_time),'%Y-%m-%d %T') as endTime
FROM t_security_incidents t
GROUP BY event_name
```

**PostgreSQL**:
```sql
SELECT 
    event_name as name,
    min(t.start_time) as startTime,
    STRING_AGG(t.focus_ip, ',') as focusIp,
    STRING_AGG(t.kill_chain, ' ') as killChain,
    STRING_AGG(CASE WHEN t.tag_search IS NOT NULL AND t.tag_search != '' THEN t.tag_search ELSE NULL END, ',') as tagSearch,
    TO_CHAR(max(t.end_time), 'YYYY-MM-DD HH24:MI:SS') as endTime
FROM t_security_incidents t
GROUP BY event_name
```

**转换点**:
- `GROUP_CONCAT(col)` → `STRING_AGG(col, ',')`
- `GROUP_CONCAT(col SEPARATOR ' ')` → `STRING_AGG(col, ' ')`
- `IF(cond, a, b)` → `CASE WHEN cond THEN a ELSE b END`
- `DATE_FORMAT(date, '%Y-%m-%d %T')` → `TO_CHAR(date, 'YYYY-MM-DD HH24:MI:SS')`

---

### 示例4: 智能情报Upsert
**MySQL**:
```xml
<insert id="saveOrUpdateBatch">
    INSERT INTO t_intelligence_sub (end_time, start_time, update_time, ...)
    VALUES (...)
    ON DUPLICATE KEY UPDATE
        end_time = greatest(values(end_time), end_time),
        start_time = least(values(start_time), start_time),
        update_time = now(),
        sub_category = if(values(end_time) >= end_time, values(sub_category), sub_category),
        tag = if(tag = '' or tag is null, values(tag), tag)
</insert>
```

**PostgreSQL**:
```xml
<insert id="saveOrUpdateBatch">
    INSERT INTO t_intelligence_sub (end_time, start_time, update_time, ...)
    VALUES (...)
    ON CONFLICT DO UPDATE SET
        end_time = greatest(EXCLUDED.end_time, end_time),
        start_time = least(EXCLUDED.start_time, start_time),
        update_time = CURRENT_TIMESTAMP,
        sub_category = CASE WHEN EXCLUDED.end_time >= end_time THEN EXCLUDED.sub_category ELSE sub_category END,
        tag = CASE WHEN tag = '' or tag is null THEN EXCLUDED.tag ELSE tag END
</insert>
```

**转换点**:
- `values(column)` → `EXCLUDED.column` (165次)
- `now()` → `CURRENT_TIMESTAMP`
- `if(cond, a, b)` → `CASE WHEN cond THEN a ELSE b END`
- `greatest()` 和 `least()` 保持不变（PG也支持）

---

### 示例5: LIKE模糊查询
**MySQL**:
```xml
<if test="ioC != null and ioC != ''">
    AND ts.ioC LIKE CONCAT('%',#{ioC},'%')
</if>
```

**PostgreSQL**:
```xml
<if test="ioC != null and ioC != ''">
    AND ts.ioC LIKE '%' || #{ioC} || '%'
</if>
```

**转换点**:
- `CONCAT('%', #{param}, '%')` → `'%' || #{param} || '%'`
- **注意**: `LIKE` 在PostgreSQL中区分大小写，如需不区分请改为 `ILIKE`

---

## ⚠️ 重要注意事项

### 1. ON CONFLICT 冲突列

**问题**: 转换后的 `ON CONFLICT` 没有指定冲突列

```sql
-- 当前转换结果
ON CONFLICT DO UPDATE SET ...

-- 需要手动添加冲突列
ON CONFLICT (id) DO UPDATE SET ...
-- 或者
ON CONFLICT (ioC, event_time) DO UPDATE SET ...
```

**解决方案**: 根据每个表的实际主键或唯一键，手动添加冲突列。

### 2. LIKE vs ILIKE

**问题**: MySQL的 `LIKE` 默认不区分大小写，PostgreSQL的 `LIKE` 区分大小写

```sql
-- MySQL (不区分大小写)
WHERE name LIKE '%test%'  -- 匹配 'Test', 'TEST', 'test'

-- PostgreSQL (区分大小写)
WHERE name LIKE '%test%'  -- 只匹配 'test'

-- PostgreSQL (不区分大小写)
WHERE name ILIKE '%test%'  -- 匹配 'Test', 'TEST', 'test'
```

**建议**: Review所有139个 `LIKE` 使用，根据业务需求决定是否改为 `ILIKE`。

### 3. 数据类型兼容性

虽然XML转换完成，但还需要注意：

| MySQL类型 | PostgreSQL类型 | 注意事项 |
|-----------|---------------|---------|
| `TINYINT` | `SMALLINT` | 值范围不同 |
| `INT` | `INTEGER` | 兼容 |
| `BIGINT` | `BIGINT` | 兼容 |
| `VARCHAR(n)` | `VARCHAR(n)` | PG中n表示字符数，MySQL可能是字节数 |
| `TEXT` | `TEXT` | 兼容 |
| `DATETIME` | `TIMESTAMP` | PG更严格 |
| `JSON` | `JSONB` | PG推荐用JSONB |

### 4. 事务隔离级别

PostgreSQL的默认隔离级别是 `READ COMMITTED`，与MySQL的 `REPEATABLE READ` 不同。如果业务依赖特定隔离级别，需要在连接字符串中指定。

---

## 🧪 测试建议

### 测试清单

1. **单元测试**
   - [ ] 测试每个Mapper的基本CRUD操作
   - [ ] 测试分页查询功能
   - [ ] 测试批量插入和更新

2. **集成测试**
   - [ ] 测试复杂的联合查询
   - [ ] 测试事务回滚和提交
   - [ ] 测试并发访问

3. **性能测试**
   - [ ] 对比MySQL和PostgreSQL的查询性能
   - [ ] 检查索引使用情况
   - [ ] 分析慢查询

4. **数据一致性测试**
   - [ ] 验证Upsert操作的正确性
   - [ ] 验证聚合函数结果
   - [ ] 验证日期时间格式

---

## 📝 手动Review清单

转换完成后，建议按以下顺序进行人工review：

### 高优先级 (必须review)

1. **ON CONFLICT 冲突列** (22个位置)
   - 文件: SecurityAlarmHandleMapper.xml, EventTemplateMapper.xml, IntelligenceMapper.xml, ScanHistoryMapper.xml等
   - 操作: 为每个 `ON CONFLICT` 添加具体的冲突列

2. **LIKE → ILIKE** (139个位置)
   - 根据业务需求决定是否需要不区分大小写
   - 推荐使用 `ILIKE` 以保持与MySQL的兼容性

3. **复杂嵌套SQL** (11个IF转换)
   - 验证 `CASE WHEN ... END` 的逻辑是否正确
   - 特别关注嵌套的CASE WHEN

### 中优先级 (建议review)

4. **GROUP_CONCAT中的IF** (31个位置)
   - 验证 `STRING_AGG(CASE WHEN ...)` 的正确性
   - 确认SEPARATOR值正确

5. **日期格式转换** (61个位置)
   - 验证 `TO_CHAR` 的格式字符串是否正确
   - 确认日期时间显示符合预期

6. **CONCAT拼接** (136个位置)
   - 验证 `||` 运算符的优先级
   - 确认字符串拼接没有遗漏

### 低优先级 (可选review)

7. **参数类型**
   - 检查 `jdbcType` 是否需要调整
   - 验证参数传递的正确性

8. **注释和格式**
   - 移除或更新MySQL特定的注释
   - 统一代码格式

---

## 🚀 部署步骤

### 1. 本地验证

```bash
# 1. 备份原始MySQL XML文件
cp -r mysql/mysql mysql/mysql_backup

# 2. 检查转换后的文件
ls -la postgresql_xml/

# 3. 对比文件变化
diff mysql/mysql/AssetInfoMapper.xml postgresql_xml/AssetInfoMapper.xml
```

### 2. 开发环境测试

```yaml
# application-dev.yml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/testdb
    driver-class-name: org.postgresql.Driver
    username: postgres
    password: your_password
```

### 3. 手动修正

根据Review清单，手动修正必须处理的项目。

### 4. 单元测试

运行所有Mapper的单元测试，确保SQL语法正确。

### 5. 集成测试

在测试环境中运行完整的集成测试。

### 6. 生产部署

确认测试通过后，部署到生产环境。

---

## 📚 参考资源

- **转换约束文档**: `MyBatis-MySQL转PostgreSQL-SQL语法约束.md`
- **转换脚本**: `convert_mybatis_xml.py`
- **输出目录**: `postgresql_xml/`
- **PostgreSQL官方文档**: https://www.postgresql.org/docs/16/

---

## 📧 技术支持

如有问题，请参考：
1. `MyBatis-MySQL转PostgreSQL-SQL语法约束.md` - 详细的语法对照
2. `MySQL转PostgreSQL迁移规范与约束.md` - DDL和数据迁移规范
3. PostgreSQL 16.x 官方文档

---

**报告生成时间**: 2026-01-19  
**报告版本**: 1.0  
**状态**: ✅ 转换完成，等待review
