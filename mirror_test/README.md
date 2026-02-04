# Mirror 测试套件

**创建时间**: 2026-02-04

**测试套件数量**: 12

---

## 📋 测试套件列表

1. **ThreatIntelligenceAnalysis** - 威胁情报分析
   - 目录: `mirror_test\ThreatIntelligenceAnalysis`
   - Mapper: `ThreatIntelligenceAnalysisMapper.xml`
   - 表: `t_threat_intelligence_analysis`, `t_sev_agent_info`

2. **TSevAgentConfig** - SEV 代理配置
   - 目录: `mirror_test\TSevAgentConfig`
   - Mapper: `TSevAgentConfigMapper.xml`
   - 表: `t_sev_agent_config`, `t_sev_agent_rule_closed`, `t_sev_agent_type_rule_closed`

3. **TSevAgentEvents** - SEV 代理事件
   - 目录: `mirror_test\TSevAgentEvents`
   - Mapper: `TSevAgentEventsMapper.xml`
   - 表: `t_sev_agent_events`

4. **TSevAgentInfo** - SEV 代理信息
   - 目录: `mirror_test\TSevAgentInfo`
   - Mapper: `TSevAgentInfoMapper.xml`
   - 表: `t_sev_agent_info`, `t_sev_agent_monitor`, `updateinfo`

5. **TSevAgentLicense** - SEV 代理许可证
   - 目录: `mirror_test\TSevAgentLicense`
   - Mapper: `TSevAgentLicenseMapper.xml`
   - 表: `t_sev_agent_license`

6. **TSevAgentMonitor** - SEV 代理监控
   - 目录: `mirror_test\TSevAgentMonitor`
   - Mapper: `TSevAgentMonitorMapper.xml`
   - 表: `t_sev_agent_monitor`

7. **TSevAgentPackage** - SEV 代理包
   - 目录: `mirror_test\TSevAgentPackage`
   - Mapper: `TSevAgentPackageMapper.xml`
   - 表: `t_sev_agent_package`

8. **TSevAgentRuleClosed** - SEV 代理规则关闭
   - 目录: `mirror_test\TSevAgentRuleClosed`
   - Mapper: `TSevAgentRuleClosedMapper.xml`
   - 表: `t_sev_agent_rule_closed`

9. **TSevAgentType** - SEV 代理类型
   - 目录: `mirror_test\TSevAgentType`
   - Mapper: `TSevAgentTypeMapper.xml`
   - 表: (待确认)

10. **TSevAgentTypeRuleClosed** - SEV 代理类型规则关闭
    - 目录: `mirror_test\TSevAgentTypeRuleClosed`
    - Mapper: `TSevAgentTypeRuleClosedMapper.xml`
    - 表: `t_sev_agent_type_rule_closed`, `t_sev_agent_rule_closed`, `t_sev_agent_info`

11. **XdrDeviceAgg** - XDR 设备聚合
    - 目录: `mirror_test\XdrDeviceAgg`
    - Mapper: `XdrDeviceAggMapper.xml`
    - 表: `t_sev_agent_info`, `t_sev_agent_type`, `t_sev_agent_license`, `t_sev_agent_monitor`, `t_organization`

12. **XdrDevice** - XDR 设备
    - 目录: `mirror_test\XdrDevice`
    - Mapper: `XdrDeviceMapper.xml`
    - 表: `t_sev_agent_info`, `t_sev_agent_type`, `t_sev_agent_license`, `t_sev_agent_view`, `t_sev_agent_detail_view`
    - 注意: 包含视图 `t_sev_agent_view` 和 `t_sev_agent_detail_view`

---

## 🚀 快速开始

每个测试套件都包含：

1. `XxxTestController.java` - 测试 Controller (所有方法都是 GET)
2. `XxxMapper.java` - Mapper 接口
3. `test_data.sql` - 测试数据
4. `快速开始.md` - 详细使用说明（可选）

进入任意目录查看 `快速开始.md` 了解如何测试。

---

## 📊 表对应关系检查

所有 XML 文件中涉及的表都有对应的建表语句：

- ✅ 所有实体表都有对应的建表语句（在 `create_table/mirror/` 目录中）
- ⚠️  视图 `t_sev_agent_view` 和 `t_sev_agent_detail_view` 需要单独创建（不在建表语句中）
- ✅ `updateinfo` 表在 `mirror22.sql` 中定义

详细检查报告请查看: `docs/mirror_table_check_report.md`

---

## 📝 测试生成说明

测试将按照以下步骤生成：

1. 分析 XML 文件，提取所有方法
2. 根据反编译的 Mapper 接口（如果有）修正方法签名
3. 生成 Mapper 接口文件
4. 生成 TestController 文件（所有方法都是 GET 接口）
5. 根据表结构生成测试数据 SQL
6. 确保测试数据覆盖所有查询场景

---

## 🔍 相关文件位置

- **XML 文件**: `mysql/mirror/`
- **建表语句**: `create_table/mirror/`
- **检查报告**: `docs/mirror_table_check_report.md`
