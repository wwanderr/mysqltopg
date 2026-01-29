# StrategyDeviceRel 修复报告

**时间**: 2026-01-28  
**状态**: ✅ 完成

## 修复内容
- ✅ 12个测试方法，对应12个XML方法
- ✅ 测试CRUD全流程
- ✅ 批量操作测试（batchInsert, batchInsertOrUpdate）

## 测试方法

| 方法 | 说明 |
|-----|------|
| insert | 单条插入 |
| batchInsert | 批量插入 |
| update | 更新 |
| batchInsertOrUpdate | 批量upsert |
| deleteRelByStrategyId | 按策略ID删除 |
| deleteRelByStrategyIdAndDeviceId | 按策略+设备删除 |
| selectById | 按ID查询 |
| getAlarmStrategyList | 告警策略列表 |
| selectByStrategyId | 按策略ID查询 |
| selectByDeviceId | 按设备ID查询 |
| getRelsByStrategyIds | 按策略ID列表查询 |
| updateDeviceIdAndIp | 更新设备信息 |

## 使用
```bash
curl http://localhost:8080/test/strategyDeviceRel/batchInsert
```

**注意**: 已有完整测试，验证通过。
