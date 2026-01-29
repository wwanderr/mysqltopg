# Intelligence 修复报告

**时间**: 2026-01-28  
**状态**: ✅ 完成

## 修复内容
- ✅ 14个测试方法，对应14个XML方法
- ✅ 全部添加异常处理
- ✅ 参数覆盖完整

## 测试方法

| 方法 | 参数 | 说明 |
|-----|------|------|
| saveOrUpdateBatch | - | 批量upsert威胁情报 |
| insertIoCAsset | - | 插入IoC资产关联 |
| listCount | startTime, endTime | 查询情报数量 |
| list | startTime, endTime, offset, limit | 查询情报列表 |
| updateAssetList | ioC, eventTime | 更新资产列表 |
| updateListFromAsset | ioC, eventTime | 从资产更新列表 |
| updateList | ioC, eventTime, alarmStatus | 更新情报列表 |
| partExport | startTime, endTime, offset, limit | 部分导出 |
| proportion | startTime, endTime | 查询比例分布 |
| top5 | startTime, endTime | 查询Top5 |
| subListCount | ioC, startTime, endTime | 查询子列表数量 |
| subList | ioC, startTime, endTime, offset, limit | 查询子列表 |
| updateTag | - | 更新标签 |
| updateAssetTag | - | 更新资产标签 |

## 使用
```bash
curl http://localhost:8080/test/intelligence/list
```
