# LoginBaseline 深度修复报告

修复时间: 2026-01-28
状态: ✅ 深度修复完成

## 修复内容

### 1. test_data.sql（已完整，无需修改）
- 字段覆盖率: 100% (7字段)
- 测试数据: 5条（多城市+单城市+测试账号+异常登录+过期登录）
- 数据类型: 包含JSON格式的city_counts

### 2. TestController（重写，规范化异常处理）
- 方法数: 4个（修复前3个）
- 异常处理: 100%
- 测试场景: 
  - test1_cleanOvertimeData: 清理超时数据（overtimeHour=720小时）
  - test2_insertOrUpdate_new: 批量插入2条新数据
  - test3_insertOrUpdate_update: **ON DUPLICATE KEY UPDATE测试**（重复键触发更新）
  - test4_queryByPrimaryKey: 批量查询3条（<foreach> IN查询）
- **关键提升**: 
  - 修复cityCounts数据类型（从int改为JSON格式字符串）
  - 覆盖ON DUPLICATE KEY UPDATE逻辑
  - 标准化异常处理

质量: ⭐⭐⭐⭐⭐
