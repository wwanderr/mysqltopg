# 项目文档结构说明

## 📁 目录结构

```
mysqlToPg/
│
├── README.md                    # 项目主文档
│
├── scripts/                     # 🔧 所有脚本文件
│   ├── organize_docs.py        # 文档整理脚本
│   ├── convert_mybatis_xml.py  # MyBatis XML 转换脚本
│   ├── convert_mysql_to_pg.py  # MySQL 转 PostgreSQL 脚本
│   └── ... (其他工具脚本)
│
├── docs/                        # 📚 项目文档
│   ├── archive/                 # 📦 历史文档归档
│   │   └── ... (所有历史修复报告和进度文档)
│   │
│   ├── conversion_progress.md           # DDL 转换进度
│   ├── conversion_summary_report.md     # DDL 转换总结
│   ├── mybatis_xml_conversion_report.md # MyBatis XML 转换报告
│   ├── primary_key_conversion_guide.md  # 主键转换指南
│   ├── table_index.md                   # 表索引文档
│   ├── 项目文档整理说明.md              # 文档整理说明
│   ├── 整理完成报告.md                  # 整理完成报告
│   └── README_文档结构.md               # 本文件
│
└── xml_tests/                   # 🧪 测试代码
    ├── README.md                # 测试说明文档
    │
    ├── docs/                    # 📖 测试相关文档
    │   ├── reports/             # 📊 修复报告目录
    │   │   ├── 修复报告_*.md    # 各模块修复报告
    │   │   ├── 深度修复报告_*.md # 深度修复报告
    │   │   └── ... (其他进度和总结报告)
    │   │
    │   └── guides/              # 📘 使用指南目录
    │       └── 快速开始_*.md    # 各模块快速开始指南
    │
    └── [模块名]/                # 各测试模块目录
        ├── *Mapper.java         # Mapper 接口
        ├── *TestController.java # 测试控制器
        ├── test_data.sql        # 测试数据
        └── ... (其他测试相关文件)
```

## 🔍 快速查找

### 查找脚本
所有 Python 脚本都在 `scripts/` 目录下

### 查找文档
- **修复报告**：`xml_tests/docs/reports/`
- **使用指南**：`xml_tests/docs/guides/`
- **历史文档**：`docs/archive/`
- **项目文档**：`docs/`（根目录）

### 查找测试代码
- **Mapper 接口**：`xml_tests/[模块名]/*Mapper.java`
- **测试控制器**：`xml_tests/[模块名]/*TestController.java`
- **测试数据**：`xml_tests/[模块名]/test_data.sql`

## 📝 文档分类说明

### 1. scripts/ - 脚本文件
包含所有用于转换、修复、验证的 Python 脚本

### 2. docs/archive/ - 历史文档归档
包含所有历史修复过程中的报告和文档，用于参考

### 3. xml_tests/docs/reports/ - 修复报告
包含各模块的修复报告、进度报告、问题汇总等

### 4. xml_tests/docs/guides/ - 使用指南
包含各模块的快速开始指南和使用说明

## 🗑️ 已清理的文件

- ✅ 所有备份文件（*.backup）
- ✅ 重复的文档
- ✅ 过时的临时文件

## 📅 最后更新

整理完成时间：2026-02-04
