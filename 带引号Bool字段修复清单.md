# 带引号 Bool 字段修复清单

**统计**: 2 个文件，3 处需要修复

## postgresql_xml_manual\LinkedStrategyValidtimeMapper.xml

共 2 处:

1. 行 78: `"status" = 1` → `"status" = true`
2. 行 102: `"status" = 1` → `"status" = true`

## postgresql_xml_manual\SecurityEvent.xml

共 1 处:

1. 行 986: `"enable" = 1` → `"enable" = true`

