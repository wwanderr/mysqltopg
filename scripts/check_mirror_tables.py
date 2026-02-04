#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
检查 mirror 目录中 XML 文件涉及的表和建表语句的对应关系
"""

import os
import re
from pathlib import Path
from collections import defaultdict

# 目录路径
MIRROR_XML_DIR = Path(r"C:\Users\wcss\Desktop\mysqlToPg\mysql\mirror")
MIRROR_DDL_DIR = Path(r"C:\Users\wcss\Desktop\mysqlToPg\create_table\mirror")

def extract_tables_from_xml(xml_file):
    """从 XML 文件中提取所有表名"""
    tables = set()
    try:
        with open(xml_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 匹配 from/into/update/join 后的表名
        patterns = [
            r'from\s+(\w+\.)?(\w+)',
            r'into\s+(\w+\.)?(\w+)',
            r'update\s+(\w+\.)?(\w+)',
            r'join\s+(\w+\.)?(\w+)',
        ]
        
        for pattern in patterns:
            matches = re.finditer(pattern, content, re.IGNORECASE)
            for match in matches:
                # 取最后一个组（表名）
                table_name = match.groups()[-1]
                # 过滤掉关键字和无效表名
                if table_name and not table_name.startswith('@') and table_name not in ['id', 'select', 'where', 'from', 'into', 'update', 'join']:
                    tables.add(table_name.lower())
    
    except Exception as e:
        print(f"Error reading {xml_file}: {e}")
    
    return tables

def extract_table_from_ddl(ddl_file):
    """从 DDL 文件中提取表名"""
    table_name = None
    try:
        with open(ddl_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 匹配 CREATE TABLE 后的表名
        match = re.search(r'CREATE\s+TABLE\s+["\']?(\w+)["\']?', content, re.IGNORECASE)
        if match:
            table_name = match.group(1).lower()
    
    except Exception as e:
        print(f"Error reading {ddl_file}: {e}")
    
    return table_name

def main():
    print("=" * 80)
    print("检查 mirror 目录中 XML 文件和建表语句的对应关系")
    print("=" * 80)
    
    # 1. 收集 XML 文件中的所有表
    xml_tables = defaultdict(set)  # {xml_file: {tables}}
    all_xml_tables = set()
    
    print("\n1. 扫描 XML 文件中的表...")
    for xml_file in MIRROR_XML_DIR.glob("*.xml"):
        tables = extract_tables_from_xml(xml_file)
        xml_tables[xml_file.name] = tables
        all_xml_tables.update(tables)
        if tables:
            print(f"  {xml_file.name}: {sorted(tables)}")
    
    # 2. 收集 DDL 文件中的表
    ddl_tables = {}  # {table_name: ddl_file}
    
    print("\n2. 扫描建表语句文件...")
    for ddl_file in MIRROR_DDL_DIR.glob("*.sql"):
        if ddl_file.name == "mirror22.sql":
            # 大文件，单独处理
            continue
        table_name = extract_table_from_ddl(ddl_file)
        if table_name:
            ddl_tables[table_name] = ddl_file.name
            print(f"  {ddl_file.name}: {table_name}")
    
    # 3. 检查 mirror22.sql 中的表
    print("\n3. 检查 mirror22.sql 中的表...")
    mirror22_tables = set()
    try:
        with open(MIRROR_DDL_DIR / "mirror22.sql", 'r', encoding='utf-8') as f:
            content = f.read()
        matches = re.finditer(r'CREATE\s+TABLE\s+["\']?(\w+)["\']?', content, re.IGNORECASE)
        for match in matches:
            table_name = match.group(1).lower()
            mirror22_tables.add(table_name)
        print(f"  mirror22.sql 中包含 {len(mirror22_tables)} 个表")
    except Exception as e:
        print(f"  Error reading mirror22.sql: {e}")
    
    # 4. 对比分析
    print("\n" + "=" * 80)
    print("4. 对比分析结果")
    print("=" * 80)
    
    # XML 中涉及的表
    print(f"\nXML 文件中涉及的表（共 {len(all_xml_tables)} 个）:")
    for table in sorted(all_xml_tables):
        print(f"  - {table}")
    
    # DDL 中定义的表
    all_ddl_tables = set(ddl_tables.keys()) | mirror22_tables
    print(f"\n建表语句中定义的表（共 {len(all_ddl_tables)} 个）:")
    for table in sorted(all_ddl_tables):
        print(f"  - {table}")
    
    # 找出缺漏
    missing_in_ddl = all_xml_tables - all_ddl_tables
    extra_in_ddl = all_ddl_tables - all_xml_tables
    
    print(f"\n" + "=" * 80)
    print("5. 缺漏分析")
    print("=" * 80)
    
    if missing_in_ddl:
        print(f"\n[ERROR] XML 中涉及但缺少建表语句的表（{len(missing_in_ddl)} 个）:")
        for table in sorted(missing_in_ddl):
            # 找出哪些 XML 文件使用了这个表
            used_in = [name for name, tables in xml_tables.items() if table in tables]
            print(f"  - {table} (在 {', '.join(used_in)} 中使用)")
    else:
        print("\n[OK] 所有 XML 中涉及的表都有对应的建表语句")
    
    if extra_in_ddl:
        print(f"\n[WARN] 建表语句中存在但 XML 中未使用的表（{len(extra_in_ddl)} 个）:")
        for table in sorted(extra_in_ddl):
            print(f"  - {table}")
    
    # 6. 视图检查
    print(f"\n" + "=" * 80)
    print("6. 视图检查")
    print("=" * 80)
    views = {t for t in all_xml_tables if 'view' in t}
    if views:
        print(f"\n[WARN] XML 中使用了视图（{len(views)} 个）:")
        for view in sorted(views):
            used_in = [name for name, tables in xml_tables.items() if view in tables]
            print(f"  - {view} (在 {', '.join(used_in)} 中使用)")
        print("\n注意：视图需要单独创建，不在建表语句中")
    
    # 7. 生成报告
    print(f"\n" + "=" * 80)
    print("7. 生成详细报告")
    print("=" * 80)
    
    report = []
    report.append("# Mirror 模块表对应关系检查报告\n")
    report.append(f"**检查时间**: {Path(__file__).stat().st_mtime}\n\n")
    
    report.append("## XML 文件列表\n")
    for xml_file in sorted(MIRROR_XML_DIR.glob("*.xml")):
        tables = xml_tables.get(xml_file.name, set())
        report.append(f"- **{xml_file.name}** ({len(tables)} 个表)")
        for table in sorted(tables):
            has_ddl = table in all_ddl_tables
            is_view = 'view' in table
            status = "[OK]" if has_ddl or is_view else "[MISSING]"
            report.append(f"  - {status} `{table}`")
        report.append("")
    
    report.append("\n## 建表语句文件列表\n")
    for table, ddl_file in sorted(ddl_tables.items()):
        report.append(f"- **{ddl_file}**: `{table}`")
    
    if mirror22_tables:
        report.append(f"\n- **mirror22.sql**: {len(mirror22_tables)} 个表")
    
    report.append("\n## 缺漏汇总\n")
    if missing_in_ddl:
        report.append(f"\n### 缺少建表语句的表（{len(missing_in_ddl)} 个）\n")
        for table in sorted(missing_in_ddl):
            used_in = [name for name, tables in xml_tables.items() if table in tables]
            report.append(f"- `{table}` (在 {', '.join(used_in)} 中使用)")
    else:
        report.append("\n[OK] 所有表都有对应的建表语句\n")
    
    # 保存报告
    report_file = Path(r"C:\Users\wcss\Desktop\mysqlToPg\docs\mirror_table_check_report.md")
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(report))
    
    print(f"\n[OK] 详细报告已保存到: {report_file}")
    
    return missing_in_ddl, views

if __name__ == "__main__":
    missing, views = main()
