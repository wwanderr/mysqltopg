#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
验证MyBatis XML文件中时间字段的CAST修复情况
"""

import os
import re
from pathlib import Path

def check_xml_file(file_path):
    """
    检查单个XML文件中的时间字段是否已正确修复
    返回: (是否通过, 未修复的字段列表, CAST使用情况)
    """
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 时间字段模式
    time_patterns = [
        r'.*time$', r'.*Time$', r'.*_at$', r'.*At$',
        r'.*_date$', r'.*Date$', r'^time$'
    ]
    
    # 查找所有 #{...} 表达式
    param_pattern = r'#\{([^}]+)\}'
    params = re.findall(param_pattern, content)
    
    # 未使用CAST的时间字段
    uncasted_time_fields = []
    # 已使用CAST的时间字段
    casted_time_fields = []
    
    for param in params:
        # 检查是否在CAST中
        cast_pattern = rf'CAST\(#\{{{re.escape(param)}\}}'
        if re.search(cast_pattern, content):
            # 提取字段名
            field_match = re.match(r'([^,}]+)', param)
            if field_match:
                field_name = field_match.group(1).split('.')[-1]
                # 检查是否是时间字段
                for pattern in time_patterns:
                    if re.search(pattern, field_name, re.IGNORECASE):
                        casted_time_fields.append(param)
                        break
        else:
            # 提取字段名和jdbcType
            field_match = re.match(r'([^,}]+)(?:,.*?jdbcType=(\w+))?', param)
            if field_match:
                field_name = field_match.group(1).split('.')[-1]
                jdbc_type = field_match.group(2)
                
                # 检查是否是时间字段
                is_time_field = False
                for pattern in time_patterns:
                    if re.search(pattern, field_name, re.IGNORECASE):
                        is_time_field = True
                        break
                
                if is_time_field:
                    uncasted_time_fields.append({
                        'param': param,
                        'field': field_name,
                        'jdbcType': jdbc_type
                    })
    
    is_passed = len(uncasted_time_fields) == 0
    return is_passed, uncasted_time_fields, casted_time_fields

def verify_directory(directory):
    """
    验证目录中所有XML文件
    """
    print("=" * 80)
    print("MyBatis XML时间字段修复验证")
    print("=" * 80)
    print()
    
    xml_files = sorted(list(Path(directory).glob('*.xml')))
    
    if not xml_files:
        print("[WARN] 未找到XML文件")
        return
    
    total_files = len(xml_files)
    passed_files = 0
    failed_files = 0
    
    failed_details = {}
    
    for xml_file in xml_files:
        file_name = xml_file.name
        is_passed, uncasted, casted = check_xml_file(str(xml_file))
        
        if is_passed:
            passed_files += 1
            if casted:
                print(f"[PASS] {file_name} - {len(casted)}个时间字段已使用CAST")
            else:
                print(f"[PASS] {file_name} - 无时间字段")
        else:
            failed_files += 1
            failed_details[file_name] = uncasted
            print(f"[FAIL] {file_name} - {len(uncasted)}个时间字段未使用CAST")
    
    print()
    print("=" * 80)
    print("验证结果统计")
    print("=" * 80)
    print(f"总文件数: {total_files}")
    print(f"通过: {passed_files} (OK)")
    print(f"失败: {failed_files} (需要修复)")
    print(f"通过率: {passed_files/total_files*100:.1f}%")
    
    if failed_details:
        print()
        print("=" * 80)
        print("失败文件详情")
        print("=" * 80)
        for file_name, uncasted in failed_details.items():
            print(f"\n{file_name}:")
            for item in uncasted:
                print(f"  - 字段: {item['field']}")
                print(f"    完整参数: #{{{item['param']}}}")
                if item['jdbcType']:
                    print(f"    jdbcType: {item['jdbcType']}")
                print(f"    建议修复: CAST(#{{{item['param'].split(',')[0]}}} AS timestamp)")
    
    print()
    print("=" * 80)
    if failed_files == 0:
        print("[SUCCESS] 所有文件验证通过！")
    else:
        print(f"[WARNING] {failed_files}个文件需要修复")
    print("=" * 80)

def main():
    target_directory = r"C:\Users\wcss\Desktop\mysqlToPg\postgresql_xml_manual"
    
    if not os.path.exists(target_directory):
        print(f"[ERROR] 目录不存在: {target_directory}")
        return
    
    verify_directory(target_directory)

if __name__ == "__main__":
    main()
