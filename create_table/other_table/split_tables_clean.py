#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
将 V20260204212300__init_table.sql 中的建表语句拆分为单个文件
每个表一个文件，格式：V{timestamp}__create_{table_name}.sql
"""

import re
import os
from datetime import datetime

# 输入文件
input_file = 'V20260204212300__init_table.sql'
# 输出目录
output_dir = 'migrations'
# 基础时间戳（从原文件名提取）
base_timestamp = '20260204212300'

def extract_table_content(content, table_name):
    """提取单个表的完整内容，精确提取，避免重复"""
    # 找到 "-- Table structure for table_name"
    table_structure_pattern = rf'--\s*Table structure for\s+{re.escape(table_name)}'
    table_match = re.search(table_structure_pattern, content)
    
    if not table_match:
        return None
    
    start_pos = table_match.start()
    
    # 找到下一个 "-- Table structure for" 或 "-- Type structure for"
    next_table_pattern = r'--\s*Table structure for\s+(\w+)'
    next_type_pattern = r'--\s*Type structure for\s+(\w+)'
    
    search_start = start_pos + 1
    end_pos = len(content)
    
    # 找到下一个表结构
    for match in re.finditer(next_table_pattern, content[search_start:]):
        if match.group(1) != table_name:
            end_pos = min(end_pos, search_start + match.start())
            break
    
    # 找到下一个类型结构
    for match in re.finditer(next_type_pattern, content[search_start:]):
        end_pos = min(end_pos, search_start + match.start())
        break
    
    # 提取表结构部分
    table_section = content[start_pos:end_pos]
    
    # 构建全词匹配模式：表名后必须跟着引号、空格、分号等，不能跟着字母数字下划线
    # 匹配 "table_name" 或 table_name（后面跟着非字母数字下划线字符）
    table_name_pattern = rf'(?:"{re.escape(table_name)}"|{re.escape(table_name)}(?![a-zA-Z0-9_]))'
    
    # 用于去重的集合
    seen_statements = set()
    
    # 在表结构部分查找 DROP TABLE 语句（通常在 CREATE TABLE 之前）
    drop_pattern = rf'DROP\s+TABLE\s+IF\s+EXISTS\s+"?{re.escape(table_name)}"?;'
    drop_match = re.search(drop_pattern, table_section, re.IGNORECASE)
    
    result_lines = []
    
    # 添加 DROP TABLE
    if drop_match:
        drop_line = drop_match.group(0).strip()
        result_lines.append(drop_line)
    
    # 提取 CREATE TABLE 语句（完整的多行语句）
    create_pattern = rf'(?s)(CREATE\s+TABLE\s+"?{re.escape(table_name)}"?\s*\(.*?\)\s*;)'
    create_match = re.search(create_pattern, table_section, re.IGNORECASE | re.DOTALL)
    if create_match:
        create_stmt = create_match.group(1).strip()
        result_lines.append(create_stmt)
    
    # 提取 ALTER TABLE OWNER（只提取一次）
    alter_owner_pattern = rf'ALTER\s+TABLE\s+"?{re.escape(table_name)}"?\s+OWNER\s+TO\s+[^;]+;'
    alter_owner_match = re.search(alter_owner_pattern, table_section, re.IGNORECASE)
    if alter_owner_match:
        alter_owner_stmt = alter_owner_match.group(0).strip()
        result_lines.append(alter_owner_stmt)
    
    # 提取 COMMENT 语句（去重）
    comment_pattern = rf'COMMENT\s+(?:ON\s+TABLE|ON\s+COLUMN)\s+"?{re.escape(table_name)}"?[^;]+;'
    comment_matches = re.findall(comment_pattern, table_section, re.IGNORECASE)
    seen_comments = set()
    for comment in comment_matches:
        # 标准化注释语句用于去重
        normalized = re.sub(r'\s+', ' ', comment.strip())
        if normalized not in seen_comments:
            result_lines.append(comment.strip())
            seen_comments.add(normalized)
    
    # 提取 BEGIN/COMMIT（如果有数据插入）
    begin_commit_pattern = r'BEGIN;\s*COMMIT;'
    begin_commit_match = re.search(begin_commit_pattern, table_section, re.IGNORECASE | re.DOTALL)
    if begin_commit_match:
        result_lines.append(begin_commit_match.group(0).strip())
    
    # 在整个文件中查找序列（table_name_id_seq）
    seq_pattern = rf'(?s)(DROP\s+SEQUENCE\s+IF\s+EXISTS\s+"?{re.escape(table_name)}_id_seq.*?ALTER\s+SEQUENCE\s+"?{re.escape(table_name)}_id_seq"[^;]+;)(?=\s*(?:--|DROP|CREATE))'
    seq_match = re.search(seq_pattern, content, re.IGNORECASE | re.DOTALL)
    if seq_match:
        seq_content = seq_match.group(1).strip()
        result_lines.append(seq_content)
    
    # 在整个文件中查找函数（on_update_current_timestamp_table_name）
    func_pattern = rf'(?s)(DROP\s+FUNCTION\s+IF\s+EXISTS\s+"?on_update_current_timestamp_{re.escape(table_name)}"?.*?ALTER\s+FUNCTION\s+"?on_update_current_timestamp_{re.escape(table_name)}"[^;]+;)(?=\s*(?:--|DROP|CREATE))'
    func_match = re.search(func_pattern, content, re.IGNORECASE | re.DOTALL)
    if func_match:
        func_content = func_match.group(1).strip()
        result_lines.append(func_content)
    
    # 在整个文件中查找触发器（使用全词匹配）
    trigger_pattern = rf'(?s)(CREATE\s+TRIGGER[^;]+?{table_name_pattern}[^;]+;)(?=\s*(?:--|CREATE|ALTER|$))'
    trigger_match = re.search(trigger_pattern, content, re.IGNORECASE | re.DOTALL)
    if trigger_match:
        trigger_stmt = trigger_match.group(1).strip()
        normalized = re.sub(r'\s+', ' ', trigger_stmt)
        if normalized not in seen_statements:
            result_lines.append(trigger_stmt)
            seen_statements.add(normalized)
    
    # 在整个文件中查找主键约束（Primary Key structure for table table_name）
    # 匹配从注释开始到 ALTER TABLE 语句结束
    primary_key_pattern = rf'--\s*Primary\s+Key\s+structure\s+for\s+table\s+{re.escape(table_name)}(?![a-zA-Z0-9_]).*?(ALTER\s+TABLE\s+{table_name_pattern}[^;]*ADD\s+CONSTRAINT[^;]*PRIMARY\s+KEY[^;]*;)'
    primary_key_match = re.search(primary_key_pattern, content, re.IGNORECASE | re.DOTALL)
    if primary_key_match:
        pk_stmt = primary_key_match.group(1).strip()
        normalized = re.sub(r'\s+', ' ', pk_stmt)
        if normalized not in seen_statements:
            result_lines.append(pk_stmt)
            seen_statements.add(normalized)
    
    # 在整个文件中查找其他约束（ADD CONSTRAINT，但不包括 PRIMARY KEY，因为上面已经处理了）
    constraint_pattern = rf'(ALTER\s+TABLE\s+{table_name_pattern}[^;]*ADD\s+CONSTRAINT[^;]*(?!PRIMARY\s+KEY)[^;]*;)'
    constraint_matches = re.findall(constraint_pattern, content, re.IGNORECASE | re.DOTALL)
    for match in constraint_matches:
        normalized = re.sub(r'\s+', ' ', match.strip())
        if normalized not in seen_statements:
            result_lines.append(match.strip())
            seen_statements.add(normalized)
    
    # 在整个文件中查找索引（Indexes structure for table table_name）
    # 匹配从注释开始到索引定义结束（包括多行）
    index_section_pattern = rf'--\s*Indexes\s+structure\s+for\s+table\s+{re.escape(table_name)}(?![a-zA-Z0-9_]).*?(CREATE\s+(?:UNIQUE\s+)?INDEX[^;]*?{table_name_pattern}[^;]*?;)'
    index_section_match = re.search(index_section_pattern, content, re.IGNORECASE | re.DOTALL)
    if index_section_match:
        index_stmt = index_section_match.group(1).strip()
        normalized = re.sub(r'\s+', ' ', index_stmt)
        if normalized not in seen_statements:
            result_lines.append(index_stmt)
            seen_statements.add(normalized)
    
    # 也查找不在 Indexes structure 注释下的索引（备用查找，避免遗漏）
    standalone_index_pattern = rf'(CREATE\s+(?:UNIQUE\s+)?INDEX[^;]*?{table_name_pattern}[^;]*?;)'
    standalone_index_matches = re.findall(standalone_index_pattern, content, re.IGNORECASE | re.DOTALL)
    for match in standalone_index_matches:
        normalized = re.sub(r'\s+', ' ', match.strip())
        if normalized not in seen_statements:
            result_lines.append(match.strip())
            seen_statements.add(normalized)
    
    return '\n\n'.join(result_lines) if result_lines else None

def main():
    # 读取输入文件
    print(f"Reading {input_file}...")
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 创建输出目录
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"Created output directory: {output_dir}")
    else:
        # 清空目录
        for file in os.listdir(output_dir):
            os.remove(os.path.join(output_dir, file))
        print(f"Cleared output directory: {output_dir}")
    
    # 提取所有表名（使用全词匹配）
    table_structure_pattern = r'--\s*Table structure for\s+(\w+)'
    table_names = []
    for match in re.finditer(table_structure_pattern, content):
        table_name = match.group(1)
        if table_name not in table_names:
            table_names.append(table_name)
    
    print(f"Found {len(table_names)} tables")
    
    # 为每个表生成文件
    # 获取当前日期和时间
    now = datetime.now()
    # 格式：YYYYMMDDHHMM + 两位序号
    # 例如：20260209140400 (2026年02月09日14:04分 + 00序号)
    base_timestamp_new = now.strftime('%Y%m%d%H%M')
    
    for idx, table_name in enumerate(table_names):
        # 生成时间戳（当前日期时间 + 两位序号）
        timestamp = f"{base_timestamp_new}{idx:02d}"
        filename = f"V{timestamp}__create_{table_name}.sql"
        filepath = os.path.join(output_dir, filename)
        
        # 提取该表的完整定义
        table_content = extract_table_content(content, table_name)
        
        if not table_content:
            print(f"Warning: Could not extract content for {table_name}")
            continue
        
        # 写入文件
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(f"""/*
 * Table: {table_name}
 * Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
 * Source: {input_file}
 */

{table_content}
""")
        
        print(f"Generated: {filename}")
    
    print(f"\nDone! Generated {len(table_names)} files in {output_dir}/")

if __name__ == '__main__':
    main()
