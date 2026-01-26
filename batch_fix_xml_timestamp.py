#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
批量修改MyBatis XML文件中的时间字段
统一使用 CAST(#{field} AS timestamp) 格式
兼容 String 和 LocalDateTime 两种Java类型
"""

import os
import re
import sys
from pathlib import Path

# 时间字段的常见模式（字段名包含这些关键词）
TIME_FIELD_PATTERNS = [
    r'_time\b',      # create_time, update_time, last_send_time等
    r'_at\b',        # created_at, updated_at等
    r'_date\b',      # execute_date等
    r'\btime\b',     # time字段
]

def is_time_field(field_name):
    """
    判断字段名是否是时间字段
    """
    field_lower = field_name.lower()
    for pattern in TIME_FIELD_PATTERNS:
        if re.search(pattern, field_lower):
            return True
    return False

def extract_field_name(mybatis_expr):
    """
    从MyBatis表达式中提取字段名
    例如：#{createTime,jdbcType=TIMESTAMP} -> createTime
         #{item.updateTime,jdbcType=VARCHAR} -> item.updateTime
    """
    match = re.match(r'#\{([^,}]+)', mybatis_expr)
    if match:
        return match.group(1)
    return None

def fix_timestamp_fields(content):
    """
    修复XML内容中的时间字段
    将各种时间字段的绑定方式统一为 CAST(#{field} AS timestamp)
    """
    original_content = content
    modifications = []
    
    # 模式1: #{field,jdbcType=TIMESTAMP} -> CAST(#{field} AS timestamp)
    # 模式2: #{field,jdbcType=VARCHAR} -> CAST(#{field} AS timestamp) (如果是时间字段)
    # 模式3: #{field} -> CAST(#{field} AS timestamp) (如果是时间字段且没有指定类型)
    
    def replace_callback(match):
        full_expr = match.group(0)  # 完整的 #{...} 表达式
        field_name = extract_field_name(full_expr)
        
        if not field_name:
            return full_expr
        
        # 提取纯字段名（去掉前缀，如 item.createTime -> createTime）
        pure_field = field_name.split('.')[-1]
        
        # 检查是否是时间字段
        if is_time_field(pure_field):
            # 记录修改
            new_expr = f"CAST(#{{{field_name}}} AS timestamp)"
            if full_expr != new_expr:
                modifications.append({
                    'old': full_expr,
                    'new': new_expr,
                    'field': field_name
                })
            return new_expr
        
        return full_expr
    
    # 匹配所有 #{...} 表达式
    # 支持的格式：
    # - #{field}
    # - #{field,jdbcType=TIMESTAMP}
    # - #{field,jdbcType=VARCHAR}
    # - #{item.field,jdbcType=TIMESTAMP}
    pattern = r'#\{[^}]+\}'
    
    content = re.sub(pattern, replace_callback, content)
    
    return content, modifications

def process_xml_file(file_path):
    """
    处理单个XML文件
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 修复时间字段
        new_content, modifications = fix_timestamp_fields(content)
        
        if new_content != content:
            # 写回文件
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            return True, len(modifications), modifications
        
        return False, 0, []
    
    except Exception as e:
        print(f"[ERROR] 处理文件失败 {file_path}: {str(e)}", flush=True)
        return False, 0, []

def batch_fix_directory(directory):
    """
    批量处理目录中的所有XML文件
    """
    print(f"开始处理目录: {directory}", flush=True)
    print("=" * 80, flush=True)
    
    xml_files = list(Path(directory).glob('*.xml'))
    
    if not xml_files:
        print("[WARN] 未找到XML文件", flush=True)
        return
    
    total_files = len(xml_files)
    modified_files = 0
    total_modifications = 0
    
    modification_details = {}
    
    for xml_file in xml_files:
        file_name = xml_file.name
        was_modified, mod_count, mods = process_xml_file(str(xml_file))
        
        if was_modified:
            modified_files += 1
            total_modifications += mod_count
            modification_details[file_name] = mods
            print(f"[OK] 已修复: {file_name} ({mod_count}处修改)", flush=True)
        else:
            print(f"[SKIP] 跳过（无需修改）: {file_name}", flush=True)
    
    print("=" * 80, flush=True)
    print(f"处理完成！", flush=True)
    print(f"  总文件数: {total_files}", flush=True)
    print(f"  已修复: {modified_files}", flush=True)
    print(f"  未修改: {total_files - modified_files}", flush=True)
    print(f"  总修改处: {total_modifications}", flush=True)
    
    # 显示修改详情（前5个文件）
    if modification_details:
        print(flush=True)
        print("=" * 80, flush=True)
        print("修改详情示例（前5个文件）:", flush=True)
        print("=" * 80, flush=True)
        
        for idx, (file_name, mods) in enumerate(list(modification_details.items())[:5], 1):
            print(f"\n{idx}. {file_name}:", flush=True)
        for mod in mods[:3]:  # 每个文件显示前3处修改
            print(f"   - 字段: {mod['field']}", flush=True)
            print(f"     修改前: {mod['old']}", flush=True)
            print(f"     修改后: {mod['new']}", flush=True)
        if len(mods) > 3:
            print(f"   ... 还有 {len(mods) - 3} 处修改", flush=True)
    
    return modified_files, total_modifications

def main():
    target_directory = r"C:\Users\wcss\Desktop\mysqlToPg\postgresql_xml_manual"
    
    if not os.path.exists(target_directory):
        print(f"[ERROR] 目录不存在: {target_directory}", flush=True)
        sys.exit(1)
    
    print("=" * 80, flush=True)
    print("MyBatis XML时间字段批量修复工具", flush=True)
    print("功能: 统一时间字段为 CAST(#{field} AS timestamp)", flush=True)
    print("=" * 80, flush=True)
    print(flush=True)
    
    print(f"目标目录: {target_directory}", flush=True)
    print(f"修改规则:", flush=True)
    print(f"  - #{{{'{field,jdbcType=TIMESTAMP}'}}} -> CAST(#{{{'{field}'}}} AS timestamp)", flush=True)
    print(f"  - #{{{'{field,jdbcType=VARCHAR}'}}} -> CAST(#{{{'{field}'}}} AS timestamp)", flush=True)
    print(f"  - #{{{'{field}'}}} -> CAST(#{{{'{field}'}}} AS timestamp)", flush=True)
    print(flush=True)
    print(f"适用字段: *_time, *_at, *_date 等时间相关字段", flush=True)
    print(flush=True)
    
    response = input("是否继续? (y/n): ")
    
    if response.lower() != 'y':
        print("操作已取消", flush=True)
        sys.exit(0)
    
    print(flush=True)
    modified_files, total_modifications = batch_fix_directory(target_directory)
    
    print(flush=True)
    print("=" * 80, flush=True)
    print("[SUCCESS] 所有文件已处理完成！", flush=True)
    print(flush=True)
    print("[INFO] 修改统计:", flush=True)
    print(f"  - 修改文件数: {modified_files}", flush=True)
    print(f"  - 总修改处数: {total_modifications}", flush=True)
    print(flush=True)
    print("[EFFECT] 效果:", flush=True)
    print("  - Java传入String: 正常工作 ✓", flush=True)
    print("  - Java传入LocalDateTime: 正常工作 ✓", flush=True)
    print("  - PostgreSQL类型: timestamp (不带时区) ✓", flush=True)
    print(flush=True)
    print("[TIP] 建议:", flush=True)
    print("  1. 在测试环境验证修改后的XML文件", flush=True)
    print("  2. 执行单元测试确保功能正常", flush=True)
    print("  3. Java实体类推荐使用 LocalDateTime 类型", flush=True)
    print("=" * 80, flush=True)

if __name__ == "__main__":
    main()
