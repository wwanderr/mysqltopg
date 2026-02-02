# Mirror表DDL提取报告

**提取时间**: 2026-01-30  
**提取状态**: ✅ 完成  
**源文件**: `mirror22.sql` (3.25 MB)

---

## 📊 提取概览

从 `mysql/mirror` 目录的12个XML Mapper文件中，成功识别并提取了 **11个表** 的DDL语句。

### 提取的表列表

| 序号 | 表名 | 文件名 | 大小 | 字段数 | 说明 |
|------|------|--------|------|--------|------|
| 1 | `t_threat_intelligence_analysis` | V20260130110517369__create_t_threat_intelligence_analysis.sql | 4KB | 15 | 威胁情报分析表 |
| 2 | `t_sev_agent_info` | V20260130110517370__create_t_sev_agent_info.sql | 11KB | 18 | 探针信息表 |
| 3 | `t_sev_agent_config` | V20260130110517371__create_t_sev_agent_config.sql | 14KB | 7 | 探针配置表 |
| 4 | `t_sev_agent_rule_closed` | V20260130110517372__create_t_sev_agent_rule_closed.sql | 2.8KB | 5 | 探针规则关闭表 |
| 5 | `t_sev_agent_type_rule_closed` | V20260130110517373__create_t_sev_agent_type_rule_closed.sql | 5.6KB | 8 | 探针类型规则关闭表 |
| 6 | `t_sev_agent_events` | V20260130110517374__create_t_sev_agent_events.sql | 12.8KB | 7 | 探针事件表 |
| 7 | `t_sev_agent_license` | V20260130110517375__create_t_sev_agent_license.sql | 8.5KB | 11 | 探针许可证表 |
| 8 | `t_sev_agent_monitor` | V20260130110517376__create_t_sev_agent_monitor.sql | 6.6KB | 12 | 探针监控表 |
| 9 | `t_sev_agent_package` | V20260130110517377__create_t_sev_agent_package.sql | 4.8KB | 10 | 探针安装包表 |
| 10 | `t_sev_agent_type` | V20260130110517378__create_t_sev_agent_type.sql | 1.8KB | 6 | 探针类型表 |
| 11 | `t_organization` | V20260130110517379__create_t_organization.sql | 2.2KB | 6 | 组织表 |

---

## 📝 涉及的XML Mapper文件

| 文件名 | 涉及的主表 | 涉及的关联表 |
|--------|-----------|-------------|
| ThreatIntelligenceAnalysisMapper.xml | t_threat_intelligence_analysis | t_sev_agent_info |
| TSevAgentConfigMapper.xml | t_sev_agent_config | t_sev_agent_rule_closed, t_sev_agent_type_rule_closed |
| TSevAgentEventsMapper.xml | t_sev_agent_events | - |
| TSevAgentInfoMapper.xml | t_sev_agent_info | t_sev_agent_monitor, updateinfo |
| TSevAgentLicenseMapper.xml | t_sev_agent_license | - |
| TSevAgentMonitorMapper.xml | t_sev_agent_monitor | - |
| TSevAgentPackageMapper.xml | t_sev_agent_package | - |
| TSevAgentRuleClosedMapper.xml | t_sev_agent_rule_closed | - |
| TSevAgentTypeMapper.xml | t_sev_agent_type | - |
| TSevAgentTypeRuleClosedMapper.xml | t_sev_agent_type_rule_closed | t_sev_agent_rule_closed, t_sev_agent_info |
| XdrDeviceAggMapper.xml | - | t_sev_agent_type, t_sev_agent_info, t_sev_agent_monitor, t_organization, t_sev_agent_license |
| XdrDeviceMapper.xml | - | t_sev_agent_view (视图), t_sev_agent_detail_view (视图) |

---

## ✅ DDL文件结构

每个生成的SQL文件包含：

1. **CREATE SEQUENCE** - 序列定义
2. **DROP TABLE IF EXISTS** - 删除已存在的表
3. **CREATE TABLE** - 表结构定义
4. **ALTER TABLE OWNER** - 修改表所有者
5. **COMMENT ON COLUMN** - 字段注释
6. **Records 部分** - 空数据区域（BEGIN; COMMIT;）

**格式参考**: `migrations_ultimate` 目录的迁移文件格式

---

## 🎯 文件命名规则

```
V{timestamp}__create_{table_name}.sql
```

**示例**:
- `V20260130110517369__create_t_threat_intelligence_analysis.sql`
- `V20260130110517370__create_t_sev_agent_info.sql`

---

## 📂 输出位置

所有DDL文件已保存至:
```
C:\Users\wcss\Desktop\mysqlToPg\create_table\mirror\
```

---

## ⚠️ 注意事项

1. **Schema名称**: 所有表都在 `mirror` schema下
2. **序列依赖**: 每个表都依赖对应的序列（sequence）
3. **字段编码**: 使用 `pg_catalog.default` collation
4. **时间戳类型**: 使用 `timestamp` (不带时区的时间戳)
5. **ENUM类型**: 如 `t_threat_intelligence_tag_is_malice` 需要预先定义
6. **视图**: `t_sev_agent_view` 和 `t_sev_agent_detail_view` 未提取（需要单独处理）

---

## 🔧 使用建议

### 1. 执行顺序
建议按以下顺序执行SQL文件（考虑外键依赖）：

```sql
-- 1. 基础表（无外键依赖）
t_organization
t_sev_agent_type

-- 2. 探针相关表
t_sev_agent_info
t_sev_agent_monitor
t_sev_agent_license
t_sev_agent_config
t_sev_agent_package
t_sev_agent_events

-- 3. 规则相关表
t_sev_agent_type_rule_closed
t_sev_agent_rule_closed

-- 4. 威胁情报表
t_threat_intelligence_analysis
```

### 2. 执行前检查
```sql
-- 检查schema是否存在
CREATE SCHEMA IF NOT EXISTS mirror;

-- 检查ENUM类型是否存在
CREATE TYPE mirror.t_threat_intelligence_tag_is_malice AS ENUM ('true', 'false', 'undefined');
```

### 3. 视图处理
需要从 `mirror22.sql` 中手动提取以下视图：
- `t_sev_agent_view`
- `t_sev_agent_detail_view`

---

## 📊 统计信息

| 统计项 | 数值 |
|-------|------|
| 源SQL文件大小 | 3.25 MB |
| 提取的表数量 | 11 |
| 生成的文件数量 | 11 |
| 总字段数 | ~117 |
| Schema | mirror |

---

**生成工具**: `extract_mirror_tables.py`  
**生成时间**: 2026-01-30 11:05:17
