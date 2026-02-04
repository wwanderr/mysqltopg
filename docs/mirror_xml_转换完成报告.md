# Mirror XML 转换完成报告

**转换时间**: 2026-02-04

## ✅ 转换结果

已成功将 12 个 MySQL XML 文件转换为 PostgreSQL XML 文件。

**输出目录**: `mysql/mirror_pg_xml/`

## 📋 转换文件列表

| # | 原文件 | 转换后文件 | 状态 |
|---|--------|-----------|------|
| 1 | ThreatIntelligenceAnalysisMapper.xml | ThreatIntelligenceAnalysisMapper.xml | ✅ 完成 |
| 2 | TSevAgentConfigMapper.xml | TSevAgentConfigMapper.xml | ✅ 完成 |
| 3 | TSevAgentEventsMapper.xml | TSevAgentEventsMapper.xml | ✅ 完成 |
| 4 | TSevAgentInfoMapper.xml | TSevAgentInfoMapper.xml | ✅ 完成 |
| 5 | TSevAgentLicenseMapper.xml | TSevAgentLicenseMapper.xml | ✅ 完成 |
| 6 | TSevAgentMonitorMapper.xml | TSevAgentMonitorMapper.xml | ✅ 完成 |
| 7 | TSevAgentPackageMapper.xml | TSevAgentPackageMapper.xml | ✅ 完成 |
| 8 | TSevAgentRuleClosedMapper.xml | TSevAgentRuleClosedMapper.xml | ✅ 完成 |
| 9 | TSevAgentTypeMapper.xml | TSevAgentTypeMapper.xml | ✅ 完成 |
| 10 | TSevAgentTypeRuleClosedMapper.xml | TSevAgentTypeRuleClosedMapper.xml | ✅ 完成 |
| 11 | XdrDeviceAggMapper.xml | XdrDeviceAggMapper.xml | ✅ 完成 |
| 12 | XdrDeviceMapper.xml | XdrDeviceMapper.xml | ✅ 完成 |

## 🔄 主要转换内容

### 1. 字符串连接
- `concat('%', param, '%')` → `'%' || param || '%'`
- `concat(a, b, c)` → `a || b || c`

### 2. 空值处理
- `ifnull(...)` → `COALESCE(...)`

### 3. 时间戳转换
- `UNIX_TIMESTAMP(...)*1000` → `EXTRACT(EPOCH FROM ...)::bigint * 1000`

### 4. 日期时间函数
- `date_add(now(), INTERVAL n day)` → `now() + INTERVAL 'n day'`
- `date_sub(now(), INTERVAL n day)` → `now() - INTERVAL 'n day'`
- `curdate()` → `CURRENT_DATE`
- `current_timestamp()` → `CURRENT_TIMESTAMP`

### 5. 日期提取函数
- `MINUTE(...)` → `EXTRACT(MINUTE FROM ...)`
- `hour(...)` → `EXTRACT(HOUR FROM ...)`

### 6. 窗口函数
- `@rank := @rank + 1` → `ROW_NUMBER() OVER()`

### 7. 分页语法
- `limit #{page.offset} offset #{page.size}` → `LIMIT #{page.size} OFFSET #{page.offset}`
- `limit 1,1` → `LIMIT 1 OFFSET 1`

### 8. 聚合函数
- `group_concat(distinct col)` → `STRING_AGG(DISTINCT col, ',')`
- `group_concat(col)` → `STRING_AGG(col, ',')`

### 9. DELETE 语法
- `delete table from table` → `delete from table`

### 10. INSERT IGNORE
- `insert IGNORE into` → `insert into` (需要根据表结构添加 ON CONFLICT)

### 11. NULL 比较
- `where col = null` → `where col IS NULL`

### 12. 日期类型处理
- `expire_time > now()` → `expire_time > CURRENT_DATE` (当 expire_time 是 date 类型时)

## ⚠️ 注意事项

### 1. 视图依赖
以下 XML 文件使用了视图，需要确保视图已创建：
- `XdrDeviceMapper.xml`: 使用 `t_sev_agent_view` 和 `t_sev_agent_detail_view`

### 2. INSERT IGNORE
`TSevAgentRuleClosedMapper.xml` 中的 `insertBatch` 方法使用了 `insert IGNORE`，已转换为普通 `insert`。如果需要处理冲突，需要根据表的主键或唯一索引添加 `ON CONFLICT DO NOTHING`。

### 3. 复杂 SQL
`XdrDeviceAggMapper.xml` 中包含复杂的时间格式化 SQL，已转换为 PostgreSQL 语法，但可能需要根据实际需求调整。

### 4. CDATA 中的 SQL
部分 SQL 在 `<![CDATA[]]>` 中，已尽可能转换，但某些复杂表达式可能需要手动检查。

## 📝 后续工作

1. **测试转换后的 SQL**
   - 在 PostgreSQL 数据库中测试所有转换后的 SQL 语句
   - 检查是否有语法错误或逻辑错误

2. **处理 INSERT IGNORE**
   - 检查 `TSevAgentRuleClosedMapper.xml` 中的 `insertBatch` 方法
   - 根据表结构添加适当的 `ON CONFLICT` 子句

3. **创建视图**
   - 创建 `t_sev_agent_view` 和 `t_sev_agent_detail_view` 视图
   - 确保视图定义与 MySQL 版本一致

4. **类型转换验证**
   - 验证日期类型转换是否正确（特别是 `expire_time` 字段）
   - 检查数值类型转换（int8, float8 等）

## 🎯 转换完成

所有 12 个 XML 文件已成功转换并保存到 `mysql/mirror_pg_xml/` 目录。

可以进行下一步的测试工作。
