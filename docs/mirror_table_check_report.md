# Mirror 模块表对应关系检查报告

**检查时间**: 1770185271.5797436


## XML 文件列表

- **ThreatIntelligenceAnalysisMapper.xml** (2 个表)
  - [OK] `t_sev_agent_info`
  - [OK] `t_threat_intelligence_analysis`

- **TSevAgentConfigMapper.xml** (3 个表)
  - [OK] `t_sev_agent_config`
  - [OK] `t_sev_agent_rule_closed`
  - [OK] `t_sev_agent_type_rule_closed`

- **TSevAgentEventsMapper.xml** (1 个表)
  - [OK] `t_sev_agent_events`

- **TSevAgentInfoMapper.xml** (3 个表)
  - [OK] `t_sev_agent_info`
  - [OK] `t_sev_agent_monitor`
  - [OK] `updateinfo`

- **TSevAgentLicenseMapper.xml** (1 个表)
  - [OK] `t_sev_agent_license`

- **TSevAgentMonitorMapper.xml** (1 个表)
  - [OK] `t_sev_agent_monitor`

- **TSevAgentPackageMapper.xml** (1 个表)
  - [OK] `t_sev_agent_package`

- **TSevAgentRuleClosedMapper.xml** (1 个表)
  - [OK] `t_sev_agent_rule_closed`

- **TSevAgentTypeMapper.xml** (0 个表)

- **TSevAgentTypeRuleClosedMapper.xml** (3 个表)
  - [OK] `t_sev_agent_info`
  - [OK] `t_sev_agent_rule_closed`
  - [OK] `t_sev_agent_type_rule_closed`

- **XdrDeviceAggMapper.xml** (5 个表)
  - [OK] `t_organization`
  - [OK] `t_sev_agent_info`
  - [OK] `t_sev_agent_license`
  - [OK] `t_sev_agent_monitor`
  - [OK] `t_sev_agent_type`

- **XdrDeviceMapper.xml** (5 个表)
  - [OK] `t_sev_agent_detail_view`
  - [OK] `t_sev_agent_info`
  - [OK] `t_sev_agent_license`
  - [OK] `t_sev_agent_type`
  - [OK] `t_sev_agent_view`


## 建表语句文件列表

- **V20260130110517379__create_t_organization.sql**: `t_organization`
- **V20260130110517371__create_t_sev_agent_config.sql**: `t_sev_agent_config`
- **V20260130110517374__create_t_sev_agent_events.sql**: `t_sev_agent_events`
- **V20260130110517370__create_t_sev_agent_info.sql**: `t_sev_agent_info`
- **V20260130110517375__create_t_sev_agent_license.sql**: `t_sev_agent_license`
- **V20260130110517376__create_t_sev_agent_monitor.sql**: `t_sev_agent_monitor`
- **V20260130110517377__create_t_sev_agent_package.sql**: `t_sev_agent_package`
- **V20260130110517372__create_t_sev_agent_rule_closed.sql**: `t_sev_agent_rule_closed`
- **V20260130110517378__create_t_sev_agent_type.sql**: `t_sev_agent_type`
- **V20260130110517373__create_t_sev_agent_type_rule_closed.sql**: `t_sev_agent_type_rule_closed`
- **V20260130110517369__create_t_threat_intelligence_analysis.sql**: `t_threat_intelligence_analysis`

- **mirror22.sql**: 217 个表

## 缺漏汇总


### 缺少建表语句的表（2 个）

- `t_sev_agent_detail_view` (在 XdrDeviceMapper.xml 中使用)
- `t_sev_agent_view` (在 XdrDeviceMapper.xml 中使用)