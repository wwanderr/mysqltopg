# NoticeHistory 修复报告

**时间**: 2026-01-28  
**状态**: ✅ 完成

## 修复内容

### 测试Controller (NoticeHistoryTestController.java)
- ✅ 5个测试方法，对应5个XML方法
- ✅ `countLaunchTimesByStrategyId`: 测试foreach + GROUP BY
- ✅ `batchInsert`: 测试批量插入（foreach）
- ✅ `getNoticeListCount`: 测试所有查询参数（7个参数）
- ✅ `getNoticeHistory`: 测试所有查询参数 + choose分支（默认排序/自定义排序）
- ✅ `getIdsByStrategyId`: 简单查询
- ✅ 所有方法包含异常处理

## 测试方法

| 方法 | 测试内容 |
|-----|---------|
| countLaunchTimesByStrategyId | foreach + GROUP BY统计 |
| batchInsert | 批量插入（foreach） |
| getNoticeListCount | 所有查询参数（7个）|
| getNoticeHistory | 所有参数 + choose排序分支 |
| getIdsByStrategyId | 根据strategyId查询 |

## 关键测试点
- **choose分支**: orderByStr为null时默认排序，有值时自定义排序
- **RIGHT JOIN**: 关联t_linked_strategy表
- **foreach**: 批量插入和IN查询

## 使用说明

```bash
curl http://localhost:8080/test/noticeHistory/getNoticeHistory
curl http://localhost:8080/test/noticeHistory/batchInsert
```
