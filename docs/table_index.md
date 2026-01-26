# 📋 MySQL to PostgreSQL 表索引文档

> **源文件**: bigdata-web-data.sql  
> **表总数**: 214 张表  
> **创建时间**: 2026-01-14  
> **批次划分**: 每20张表一个文件，共11个批次

---

## 表索引列表

| 表ID | 表名 | 批次 | 源文件行号 | 状态 |
|------|------|------|-----------|------|
| T001 | ailpha_aiAnalysis_algorithm | BATCH_01 | 23-32 | ⏳ 待转换 |
| T002 | ailpha_aiAnalysis_data | BATCH_01 | 45-54 | ⏳ 待转换 |
| T003 | ailpha_aiAnalysis_scene | BATCH_01 | 63-72 | ⏳ 待转换 |
| T004 | ailpha_metric | BATCH_01 | 85-100 | ⏳ 待转换 |
| T005 | ailpha_model | BATCH_01 | 109-137 | ⏳ 待转换 |
| T006 | ailpha_model_change | BATCH_01 | 146-157 | ⏳ 待转换 |
| T007 | ailpha_model_factory | BATCH_01 | 166-175 | ⏳ 待转换 |
| T008 | ailpha_model_user_status | BATCH_01 | 184-192 | ⏳ 待转换 |
| T009 | ailpha_sub_metric | BATCH_01 | 201-219 | ⏳ 待转换 |
| T010 | ailpha_topology | BATCH_01 | 228-240 | ⏳ 待转换 |
| T011 | dictionary_file_md5 | BATCH_01 | 249-257 | ⏳ 待转换 |
| T012 | engine_change | BATCH_01 | 266-280 | ⏳ 待转换 |
| T013 | ice_attack | BATCH_01 | 289-296 | ⏳ 待转换 |
| T014 | ice_label | BATCH_01 | 305-313 | ⏳ 待转换 |
| T015 | ice_tag | BATCH_01 | 322-331 | ⏳ 待转换 |
| T016 | ice_tag_order | BATCH_01 | 340-346 | ⏳ 待转换 |
| T017 | oauth_client_details | BATCH_01 | 355-370 | ⏳ 待转换 |
| T018 | patrol_comp_alert | BATCH_01 | 379-393 | ⏳ 待转换 |
| T019 | reputation | BATCH_01 | 402-408 | ⏳ 待转换 |
| T020 | schema_version | BATCH_01 | 417-827 | ⏳ 待转换 |
| T021-T214 | ... | ... | ... | ⏳ 待提取 |

---

## 批次分配

| 批次编号 | 表ID范围 | 表数量 | 输出文件 | 状态 |
|---------|---------|--------|----------|------|
| BATCH_01 | T001-T020 | 20 | output/batch_01_tables_001-020.sql | ⏳ 待转换 |
| BATCH_02 | T021-T040 | 20 | output/batch_02_tables_021-040.sql | ⏳ 待转换 |
| BATCH_03 | T041-T060 | 20 | output/batch_03_tables_041-060.sql | ⏳ 待转换 |
| BATCH_04 | T061-T080 | 20 | output/batch_04_tables_061-080.sql | ⏳ 待转换 |
| BATCH_05 | T081-T100 | 20 | output/batch_05_tables_081-100.sql | ⏳ 待转换 |
| BATCH_06 | T101-T120 | 20 | output/batch_06_tables_101-120.sql | ⏳ 待转换 |
| BATCH_07 | T121-T140 | 20 | output/batch_07_tables_121-140.sql | ⏳ 待转换 |
| BATCH_08 | T141-T160 | 20 | output/batch_08_tables_141-160.sql | ⏳ 待转换 |
| BATCH_09 | T161-T180 | 20 | output/batch_09_tables_161-180.sql | ⏳ 待转换 |
| BATCH_10 | T181-T200 | 20 | output/batch_10_tables_181-200.sql | ⏳ 待转换 |
| BATCH_11 | T201-T214 | 14 | output/batch_11_tables_201-214.sql | ⏳ 待转换 |

---

## 状态图例

- ⏳ 待转换
- 🔄 转换中
- ✅ 已完成
- ⚠️ 需要手动处理
- ❌ 转换失败

---

## 备注

- 每个批次转换完成后更新状态
- 遇到问题的表需要在备注列中说明
- 所有外键约束在最后统一处理
