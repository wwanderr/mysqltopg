#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
检查所有测试模块的表名是否与 XML Mapper 一致
一一比对 test_data.sql 和 Mapper XML 中的表名
"""

import os
import re
from pathlib import Path
from collections import defaultdict

def extract_tables_from_sql(sql_file):
    """从 test_data.sql 中提取表名"""
    tables = set()
    try:
        with open(sql_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 查找 INSERT INTO 和 DELETE FROM 语句中的表名
        patterns = [
            r'INSERT\s+INTO\s+"?([a-z_]+)"?',
            r'DELETE\s+FROM\s+"?([a-z_]+)"?',
            r'UPDATE\s+"?([a-z_]+)"?',
            r'SELECT.*FROM\s+"?([a-z_]+)"?'
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, content, re.IGNORECASE)
            tables.update(matches)
        
    except Exception as e:
        print(f"Error reading {sql_file}: {e}")
    
    return tables

def extract_tables_from_xml(xml_file):
    """从 XML Mapper 中提取表名"""
    tables = set()
    try:
        with open(xml_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 查找所有 SQL 语句中的表名
        patterns = [
            r'INSERT\s+INTO\s+([a-z_]+)',
            r'DELETE\s+FROM\s+([a-z_]+)',
            r'UPDATE\s+([a-z_]+)',
            r'FROM\s+([a-z_]+)(?:\s+|,|$)',
            r'JOIN\s+([a-z_]+)'
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, content, re.IGNORECASE)
            # 过滤掉一些非表名的关键字
            filtered = [m for m in matches if m not in ['values', 'set', 'where', 'select']]
            tables.update(filtered)
        
    except Exception as e:
        print(f"Error reading {xml_file}: {e}")
    
    return tables

def main():
    """主函数"""
    base_dir = Path(__file__).parent
    xml_dir = base_dir.parent / 'postgresql_xml_manual'
    
    print("=" * 80)
    print("检查测试模块表名与 XML Mapper 是否一致")
    print("=" * 80)
    print()
    
    issues = []
    checked = 0
    
    # 遍历所有测试模块目录
    for module_dir in sorted(base_dir.iterdir()):
        if not module_dir.is_dir():
            continue
        
        module_name = module_dir.name
        test_data_file = module_dir / 'test_data.sql'
        xml_file = xml_dir / f'{module_name}Mapper.xml'
        
        # 跳过非模块目录
        if not test_data_file.exists():
            continue
        
        if not xml_file.exists():
            print(f"[WARN] {module_name}: XML Mapper not found")
            continue
        
        checked += 1
        
        # 提取表名
        sql_tables = extract_tables_from_sql(test_data_file)
        xml_tables = extract_tables_from_xml(xml_file)
        
        # 过滤掉序列名
        sql_tables = {t for t in sql_tables if not t.endswith('_seq')}
        xml_tables = {t for t in xml_tables if not t.endswith('_seq')}
        
        # 比较表名
        if sql_tables and xml_tables:
            sql_only = sql_tables - xml_tables
            xml_only = xml_tables - sql_tables
            
            if sql_only or xml_only:
                print(f"[ERROR] {module_name}:")
                if sql_only:
                    print(f"   test_data.sql tables: {', '.join(sorted(sql_only))}")
                if xml_only:
                    print(f"   XML Mapper tables:    {', '.join(sorted(xml_only))}")
                issues.append({
                    'module': module_name,
                    'sql_tables': sql_only,
                    'xml_tables': xml_only
                })
                print()
            else:
                print(f"[OK] {module_name}: Matched ({', '.join(sorted(sql_tables))})")
        elif not sql_tables:
            print(f"[WARN] {module_name}: No tables found in test_data.sql")
        elif not xml_tables:
            print(f"[WARN] {module_name}: No tables found in XML Mapper")
    
    print()
    print("=" * 80)
    print(f"Check completed!")
    print(f"  Checked: {checked} modules")
    print(f"  Issues found: {len(issues)} modules")
    print("=" * 80)
    
    if issues:
        print()
        print("Modules need fixing:")
        for issue in issues:
            print(f"  - {issue['module']}")
        print()
        print("Fix steps:")
        print("  1. Check table names in XML Mapper")
        print("  2. Verify correct table name in DDL SQL")
        print("  3. Update test_data.sql with correct table names")
        print("  4. Update test data in Controller")

if __name__ == '__main__':
    main()
