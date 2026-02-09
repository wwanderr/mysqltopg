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

def extract_table_blocks(content):
    """提取每个表的完整定义块"""
    # 匹配模式：从 "-- Table structure for" 开始，到下一个 "-- Table structure for" 或文件结束
    pattern = r'(?s)(--\s*Table structure for\s+(\w+).*?(?=--\s*Table structure for|$))'
    
    matches = list(re.finditer(pattern, content))
    table_blocks = []
    
    for i, match in enumerate(matches):
        table_name = match.group(2)
        start_pos = match.start()
        
        # 找到下一个表的开始位置，或者文件结束
        if i + 1 < len(matches):
            end_pos = matches[i + 1].start()
        else:
            end_pos = len(content)
        
        # 提取这个表的完整内容
        table_content = content[start_pos:end_pos].strip()
        
        # 需要包含表相关的所有内容：
        # 1. DROP TABLE（如果存在）
        # 2. CREATE TABLE
        # 3. ALTER TABLE
        # 4. COMMENT
        # 5. 序列、触发器、约束等
        
        # 向前查找 DROP TABLE 语句
        drop_pattern = rf'(?s)(DROP\s+TABLE\s+IF\s+EXISTS\s+"?{re.escape(table_name)}"?;.*?)(?=--\s*Table structure for|CREATE\s+TABLE)'
        drop_match = re.search(drop_pattern, content[:start_pos], re.IGNORECASE)
        if drop_match:
            drop_content = drop_match.group(1)
            # 检查是否包含在 table_content 中
            if drop_content not in table_content:
                table_content = drop_content + '\n\n' + table_content
        
        # 向后查找相关的 ALTER、COMMENT、序列、触发器等
        # 这些通常在 CREATE TABLE 之后
        # 我们已经在 end_pos 之前包含了，但需要确保包含所有相关内容
        
        table_blocks.append((table_name, table_content))
    
    return table_blocks

def extract_table_with_dependencies(content, table_name):
    """提取表及其所有依赖（序列、触发器、函数等）"""
    # 使用全词匹配来找到表名
    # 例如 "t_comm" 不会匹配 "t_comm_history"
    word_boundary_pattern = rf'\b{re.escape(table_name)}\b'
    
    # 找到所有包含该表名的部分
    # 1. DROP TABLE IF EXISTS "table_name"
    # 2. CREATE TABLE "table_name"
    # 3. ALTER TABLE "table_name"
    # 4. COMMENT ON TABLE/COLUMN "table_name"
    # 5. 序列：table_name_id_seq
    # 6. 触发器：on_update_current_timestamp_table_name
    # 7. 函数：on_update_current_timestamp_table_name()
    
    blocks = []
    
    # 查找 DROP TABLE
    drop_pattern = rf'(?s)(DROP\s+TABLE\s+IF\s+EXISTS\s+"?{re.escape(table_name)}"?;.*?)(?=\n\n|\n--|$)'
    drop_match = re.search(drop_pattern, content, re.IGNORECASE)
    if drop_match:
        blocks.append(drop_match.group(1).strip())
    
    # 查找 CREATE TABLE 及其后续内容（直到下一个表或明显的分隔）
    create_pattern = rf'(?s)(CREATE\s+TABLE\s+"?{re.escape(table_name)}"?.*?)(?=\n\n--\s*Table structure for|\n\n--\s*Records of|\n\n--\s*[A-Z]|$)'
    create_match = re.search(create_pattern, content, re.IGNORECASE)
    if create_match:
        create_content = create_match.group(1)
        # 继续查找后续的 ALTER TABLE、COMMENT 等
        start_pos = create_match.end()
        
        # 查找 ALTER TABLE 语句（直到下一个表结构开始）
        alter_pattern = rf'(?s)(ALTER\s+TABLE\s+"?{re.escape(table_name)}"?.*?)(?=\n\n--\s*Table structure for|\n\n--\s*Records of|$)'
        alter_matches = list(re.finditer(alter_pattern, content[start_pos:start_pos+5000], re.IGNORECASE))
        if alter_matches:
            create_content += '\n' + alter_matches[0].group(1)
        
        blocks.append(create_content.strip())
    
    # 查找 COMMENT 语句
    comment_pattern = rf'(?s)(COMMENT\s+(?:ON\s+TABLE|ON\s+COLUMN)\s+"?{re.escape(table_name)}"?.*?;)(?=\n\n|$)'
    comment_matches = re.findall(comment_pattern, content, re.IGNORECASE)
    if comment_matches:
        blocks.extend(comment_matches)
    
    # 查找序列（table_name_id_seq）
    seq_pattern = rf'(?s)(DROP\s+SEQUENCE\s+IF\s+EXISTS\s+"?{re.escape(table_name)}_id_seq.*?ALTER\s+SEQUENCE\s+"?{re.escape(table_name)}_id_seq.*?)(?=\n\n--|$)'
    seq_match = re.search(seq_pattern, content, re.IGNORECASE | re.DOTALL)
    if seq_match:
        blocks.append(seq_match.group(1).strip())
    
    # 查找函数（on_update_current_timestamp_table_name）
    func_pattern = rf'(?s)(DROP\s+FUNCTION\s+IF\s+EXISTS\s+"?on_update_current_timestamp_{re.escape(table_name)}"?.*?ALTER\s+FUNCTION\s+"?on_update_current_timestamp_{re.escape(table_name)}"?.*?)(?=\n\n--|$)'
    func_match = re.search(func_pattern, content, re.IGNORECASE | re.DOTALL)
    if func_match:
        blocks.append(func_match.group(1).strip())
    
    # 查找触发器
    trigger_pattern = rf'(?s)(CREATE\s+TRIGGER.*?"?{re.escape(table_name)}"?.*?)(?=\n\n--|$)'
    trigger_match = re.search(trigger_pattern, content, re.IGNORECASE | re.DOTALL)
    if trigger_match:
        blocks.append(trigger_match.group(1).strip())
    
    return '\n\n'.join(blocks)

def main():
    # 读取输入文件
    print(f"Reading {input_file}...")
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 创建输出目录
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"Created output directory: {output_dir}")
    
    # 提取所有表名（使用全词匹配）
    # 先找到所有 CREATE TABLE 语句
    create_table_pattern = r'CREATE\s+TABLE\s+"?(\w+)"?'
    table_names = []
    for match in re.finditer(create_table_pattern, content, re.IGNORECASE):
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
        # 找到该表在文件中的位置
        table_pattern = rf'(?s)(--\s*Table structure for\s+{re.escape(table_name)}.*?)(?=--\s*Table structure for|$)'
        table_match = re.search(table_pattern, content)
        
        if not table_match:
            print(f"Warning: Could not find table structure for {table_name}")
            continue
        
        # 提取该表的完整内容
        table_start = table_match.start()
        
        # 找到下一个表的开始位置
        next_table_pattern = rf'--\s*Table structure for\s+(\w+)'
        next_match = None
        for m in re.finditer(next_table_pattern, content[table_start+1:]):
            if m.group(1) != table_name:
                next_match = m
                break
        
        if next_match:
            table_end = table_start + 1 + next_match.start()
        else:
            table_end = len(content)
        
        table_content = content[table_start:table_end].strip()
        
        # 向前查找 DROP TABLE
        drop_pattern = rf'(?s)(DROP\s+TABLE\s+IF\s+EXISTS\s+"?{re.escape(table_name)}"?;)(?=\s*CREATE\s+TABLE)'
        drop_match = re.search(drop_pattern, content[:table_start], re.IGNORECASE)
        if drop_match:
            drop_content = drop_match.group(1)
            if drop_content not in table_content:
                table_content = drop_content + '\n\n' + table_content
        
        # 查找相关的序列、函数、触发器（在整个文件中）
        # 序列
        seq_pattern = rf'(?s)(DROP\s+SEQUENCE\s+IF\s+EXISTS\s+"?{re.escape(table_name)}_id_seq.*?ALTER\s+SEQUENCE\s+"?{re.escape(table_name)}_id_seq".*?)(?=\n\n--\s*Table structure for|\n\n--\s*Type structure for|$)'
        seq_match = re.search(seq_pattern, content, re.IGNORECASE | re.DOTALL)
        if seq_match and seq_match.group(1) not in table_content:
            table_content += '\n\n' + seq_match.group(1).strip()
        
        # 函数
        func_pattern = rf'(?s)(DROP\s+FUNCTION\s+IF\s+EXISTS\s+"?on_update_current_timestamp_{re.escape(table_name)}"?.*?ALTER\s+FUNCTION\s+"?on_update_current_timestamp_{re.escape(table_name)}"?.*?)(?=\n\n--\s*Table structure for|\n\n--\s*Type structure for|$)'
        func_match = re.search(func_pattern, content, re.IGNORECASE | re.DOTALL)
        if func_match and func_match.group(1) not in table_content:
            table_content += '\n\n' + func_match.group(1).strip()
        
        # 触发器
        trigger_pattern = rf'(?s)(CREATE\s+TRIGGER.*?"?{re.escape(table_name)}"?.*?)(?=\n\n--\s*Table structure for|\n\n--\s*Type structure for|$)'
        trigger_match = re.search(trigger_pattern, content, re.IGNORECASE | re.DOTALL)
        if trigger_match and trigger_match.group(1) not in table_content:
            table_content += '\n\n' + trigger_match.group(1).strip()
        
        # 查找该表的 PRIMARY KEY、INDEX 等约束（在表定义之后）
        constraint_pattern = rf'(?s)(ALTER\s+TABLE\s+"?{re.escape(table_name)}"?.*?ADD\s+CONSTRAINT.*?)(?=\n\n--\s*Table structure for|\n\n--\s*Type structure for|$)'
        constraint_matches = re.findall(constraint_pattern, content, re.IGNORECASE | re.DOTALL)
        for constraint in constraint_matches:
            if constraint.strip() not in table_content:
                table_content += '\n\n' + constraint.strip()
        
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
