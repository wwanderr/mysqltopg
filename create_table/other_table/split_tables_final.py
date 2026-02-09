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

def find_table_end(content, table_name, start_pos):
    """找到表的结束位置"""
    # 查找下一个 "-- Table structure for" 或 "-- Type structure for"
    next_table_pattern = r'--\s*Table structure for\s+(\w+)'
    next_type_pattern = r'--\s*Type structure for\s+(\w+)'
    
    # 从 start_pos 之后开始查找
    search_start = start_pos + 1
    
    # 找到下一个表结构
    next_table_match = None
    for match in re.finditer(next_table_pattern, content[search_start:]):
        if match.group(1) != table_name:
            next_table_match = match
            break
    
    # 找到下一个类型结构
    next_type_match = None
    for match in re.finditer(next_type_pattern, content[search_start:]):
        next_type_match = match
        break
    
    # 取最近的一个
    end_pos = len(content)
    if next_table_match:
        end_pos = min(end_pos, search_start + next_table_match.start())
    if next_type_match:
        end_pos = min(end_pos, search_start + next_type_match.start())
    
    return end_pos

def extract_table_content(content, table_name):
    """提取单个表的完整内容"""
    # 使用全词匹配来找到表名
    word_boundary_pattern = rf'\b{re.escape(table_name)}\b'
    
    # 找到 "-- Table structure for table_name"
    table_structure_pattern = rf'--\s*Table structure for\s+{re.escape(table_name)}'
    table_match = re.search(table_structure_pattern, content)
    
    if not table_match:
        return None
    
    start_pos = table_match.start()
    end_pos = find_table_end(content, table_name, start_pos)
    
    # 提取表结构部分
    table_section = content[start_pos:end_pos].strip()
    
    # 向前查找 DROP TABLE 语句（在表结构之前）
    drop_pattern = rf'(?s)(DROP\s+TABLE\s+IF\s+EXISTS\s+"?{re.escape(table_name)}"?;)(?=\s*CREATE\s+TABLE)'
    drop_match = re.search(drop_pattern, content[:start_pos], re.IGNORECASE)
    
    result_parts = []
    seen_statements = set()  # 用于去重
    
    # 添加 DROP TABLE
    if drop_match:
        drop_stmt = drop_match.group(1).strip()
        if drop_stmt not in seen_statements:
            result_parts.append(drop_stmt)
            seen_statements.add(drop_stmt)
    
    # 提取 CREATE TABLE 语句
    create_pattern = rf'(?s)(CREATE\s+TABLE\s+"?{re.escape(table_name)}"?.*?)(?=\n\n--|$)'
    create_match = re.search(create_pattern, table_section, re.IGNORECASE | re.DOTALL)
    if create_match:
        create_stmt = create_match.group(1).strip()
        # 清理 CREATE TABLE 语句，移除末尾的分号（如果有）
        if create_stmt.endswith(';'):
            create_stmt = create_stmt[:-1].strip()
        result_parts.append(create_stmt + ';')
    
    # 提取 ALTER TABLE OWNER（去重）
    alter_owner_pattern = rf'ALTER\s+TABLE\s+"?{re.escape(table_name)}"?\s+OWNER\s+TO.*?;'
    alter_owner_matches = re.findall(alter_owner_pattern, table_section, re.IGNORECASE)
    for match in alter_owner_matches:
        if match not in seen_statements:
            result_parts.append(match)
            seen_statements.add(match)
    
    # 提取 COMMENT 语句（去重）
    comment_pattern = rf'COMMENT\s+(?:ON\s+TABLE|ON\s+COLUMN)\s+"?{re.escape(table_name)}"?.*?;'
    comment_matches = re.findall(comment_pattern, table_section, re.IGNORECASE)
    for match in comment_matches:
        if match not in seen_statements:
            result_parts.append(match)
            seen_statements.add(match)
    
    # 提取 BEGIN/COMMIT（如果有数据插入）
    begin_commit_pattern = r'BEGIN;\s*COMMIT;'
    begin_commit_match = re.search(begin_commit_pattern, table_section, re.IGNORECASE | re.DOTALL)
    if begin_commit_match:
        begin_commit_stmt = begin_commit_match.group(0).strip()
        if begin_commit_stmt not in seen_statements:
            result_parts.append(begin_commit_stmt)
            seen_statements.add(begin_commit_stmt)
    
    # 在整个文件中查找序列（table_name_id_seq）
    seq_pattern = rf'(?s)(DROP\s+SEQUENCE\s+IF\s+EXISTS\s+"?{re.escape(table_name)}_id_seq.*?ALTER\s+SEQUENCE\s+"?{re.escape(table_name)}_id_seq".*?)(?=\n\n--\s*Table structure for|\n\n--\s*Type structure for|$)'
    seq_match = re.search(seq_pattern, content, re.IGNORECASE | re.DOTALL)
    if seq_match:
        seq_content = seq_match.group(1).strip()
        # 只取序列相关的部分，去掉其他内容
        seq_lines = []
        in_seq = False
        for line in seq_content.split('\n'):
            if re.search(rf'{re.escape(table_name)}_id_seq', line, re.IGNORECASE):
                in_seq = True
                seq_lines.append(line)
            elif in_seq:
                if line.strip().startswith('--') and 'sequence' not in line.lower():
                    break
                seq_lines.append(line)
                if line.strip().endswith(';') and 'ALTER SEQUENCE' in line.upper():
                    break
        if seq_lines:
            seq_stmt = '\n'.join(seq_lines).strip()
            if seq_stmt not in seen_statements:
                result_parts.append(seq_stmt)
                seen_statements.add(seq_stmt)
    
    # 在整个文件中查找函数（on_update_current_timestamp_table_name）
    func_pattern = rf'(?s)(DROP\s+FUNCTION\s+IF\s+EXISTS\s+"?on_update_current_timestamp_{re.escape(table_name)}"?.*?ALTER\s+FUNCTION\s+"?on_update_current_timestamp_{re.escape(table_name)}"?.*?)(?=\n\n--\s*Table structure for|\n\n--\s*Type structure for|$)'
    func_match = re.search(func_pattern, content, re.IGNORECASE | re.DOTALL)
    if func_match:
        func_content = func_match.group(1).strip()
        # 只取函数相关的部分
        func_lines = []
        in_func = False
        for line in func_content.split('\n'):
            if re.search(rf'on_update_current_timestamp_{re.escape(table_name)}', line, re.IGNORECASE):
                in_func = True
                func_lines.append(line)
            elif in_func:
                if line.strip().startswith('--') and 'function' not in line.lower():
                    break
                func_lines.append(line)
                if line.strip().endswith(';') and 'ALTER FUNCTION' in line.upper():
                    break
        if func_lines:
            func_stmt = '\n'.join(func_lines).strip()
            if func_stmt not in seen_statements:
                result_parts.append(func_stmt)
                seen_statements.add(func_stmt)
    
    # 在表结构部分查找触发器
    trigger_pattern = rf'(?s)(CREATE\s+TRIGGER.*?"?{re.escape(table_name)}"?.*?)(?=\n\n--|$)'
    trigger_match = re.search(trigger_pattern, table_section, re.IGNORECASE | re.DOTALL)
    if trigger_match:
        trigger_stmt = trigger_match.group(1).strip()
        if trigger_stmt not in seen_statements:
            result_parts.append(trigger_stmt)
            seen_statements.add(trigger_stmt)
    
    # 在表结构部分查找约束（PRIMARY KEY、INDEX等）
    constraint_pattern = rf'(?s)(ALTER\s+TABLE\s+"?{re.escape(table_name)}"?.*?ADD\s+CONSTRAINT.*?)(?=\n\n--|$)'
    constraint_matches = re.findall(constraint_pattern, table_section, re.IGNORECASE | re.DOTALL)
    for match in constraint_matches:
        constraint_stmt = match.strip()
        if constraint_stmt not in seen_statements:
            result_parts.append(constraint_stmt)
            seen_statements.add(constraint_stmt)
    
    # 查找索引
    index_pattern = rf'(?s)(CREATE\s+(?:UNIQUE\s+)?INDEX.*?"?{re.escape(table_name)}"?.*?)(?=\n\n--|$)'
    index_matches = re.findall(index_pattern, table_section, re.IGNORECASE | re.DOTALL)
    for match in index_matches:
        index_stmt = match.strip()
        if index_stmt not in seen_statements:
            result_parts.append(index_stmt)
            seen_statements.add(index_stmt)
    
    return '\n\n'.join(result_parts) if result_parts else None

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
    # 先找到所有 "-- Table structure for" 注释
    table_structure_pattern = r'--\s*Table structure for\s+(\w+)'
    table_names = []
    for match in re.finditer(table_structure_pattern, content):
        table_name = match.group(1)
        if table_name not in table_names:
            table_names.append(table_name)
    
    print(f"Found {len(table_names)} tables")
    
    # 为每个表生成文件
    for idx, table_name in enumerate(table_names):
        # 生成时间戳（递增秒数）
        timestamp = f"{base_timestamp}{idx:02d}"
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
