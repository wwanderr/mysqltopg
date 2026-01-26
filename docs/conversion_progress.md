# 🔄 MySQL to PostgreSQL 转换进度跟踪

> **开始时间**: 2026-01-14  
> **源数据库**: MySQL 5.7.43  
> **目标数据库**: PostgreSQL 16.x  
> **总表数**: 214 张

---

## 📊 总体进度

- **已完成**: 0 / 214 (0%)
- **进行中**: 0
- **待处理**: 214
- **有问题**: 0

---

## 批次1: BATCH_01 (表 001-020)

**状态**: ⏳ 待开始  
**表范围**: T001 - T020  
**表数量**: 20张  
**输出文件**: `output/batch_01_tables_001-020.sql`

### 表清单

- [ ] T001 - ailpha_aiAnalysis_algorithm
- [ ] T002 - ailpha_aiAnalysis_data
- [ ] T003 - ailpha_aiAnalysis_scene
- [ ] T004 - ailpha_metric
- [ ] T005 - ailpha_model
- [ ] T006 - ailpha_model_change
- [ ] T007 - ailpha_model_factory
- [ ] T008 - ailpha_model_user_status
- [ ] T009 - ailpha_sub_metric
- [ ] T010 - ailpha_topology
- [ ] T011 - dictionary_file_md5
- [ ] T012 - engine_change
- [ ] T013 - ice_attack
- [ ] T014 - ice_label
- [ ] T015 - ice_tag
- [ ] T016 - ice_tag_order
- [ ] T017 - oauth_client_details
- [ ] T018 - patrol_comp_alert
- [ ] T019 - reputation
- [ ] T020 - schema_version

### 转换记录
- 开始时间: 
- 完成时间: 
- 耗时: 
- 问题记录: 无

---

## 批次2: BATCH_02 (表 021-040)

**状态**: ⏳ 待开始  
**表范围**: T021 - T040  
**表数量**: 20张  
**输出文件**: `output/batch_02_tables_021-040.sql`

### 表清单
- [ ] T021-T040 (待提取)

---

## 批次3-11

*(待后续填充)*

---

## ⚠️ 需要特别注意的表

*转换过程中发现的特殊情况将记录在此*

---

## 📝 转换规则应用统计

### 数据类型转换
- INT/BIGINT(n) → INTEGER/BIGINT: 0次
- TINYINT(1) → BOOLEAN: 0次
- DATETIME → TIMESTAMP: 0次
- TEXT/MEDIUMTEXT → TEXT: 0次
- VARCHAR字符集处理: 0次

### 索引转换
- PRIMARY KEY: 0个
- UNIQUE INDEX: 0个
- 普通INDEX: 0个
- 需要添加NULLS FIRST/LAST: 0个

### 约束转换
- UNSIGNED → CHECK约束: 0个
- 外键约束: 0个
- 默认值调整: 0次

### 特殊处理
- ON UPDATE CURRENT_TIMESTAMP触发器: 0个
- ENUM类型转换: 0个
- 自定义函数需求: 0个

---

## 🔧 遇到的问题和解决方案

*此区域记录转换过程中遇到的特殊问题*

---

**最后更新**: 2026-01-14
