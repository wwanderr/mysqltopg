# LoginBaseline 修复报告

**时间**: 2026-01-28  
**状态**: ✅ 完成

## 修复内容

### 测试Controller (LoginBaselineTestController.java)
- ✅ 3个测试方法，对应3个XML方法
- ✅ 修正字段名：destAddress, srcUserName, lastLoginTime, cityCounts, cityArray
- ✅ `insertOrUpdate`: 测试批量插入（foreach）
- ✅ `queryByPrimaryKey`: 测试批量查询（foreach + IN）
- ✅ 所有方法包含异常处理

## 测试方法

| 方法 | 测试内容 |
|-----|---------|
| cleanOvertimeData | 清理超时数据（overtimeHour参数） |
| insertOrUpdate | 批量插入/更新（foreach批量操作） |
| queryByPrimaryKey | 批量查询（foreach IN查询） |

## 使用说明

```bash
curl http://localhost:8080/test/loginBaseline/insertOrUpdate
curl http://localhost:8080/test/loginBaseline/queryByPrimaryKey
```
