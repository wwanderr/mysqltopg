#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
批量将PostgreSQL建表SQL中的 timestamptz 替换为 timestamp
解决Java获取时间时带有时区后缀（+08）的问题
"""

import os
import re
import sys

def fix_timestamptz_in_file(file_path):
    """
    将单个SQL文件中的 timestamptz 替换为 timestamp
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # 替换 timestamptz(6) -> timestamp(6)
        content = re.sub(r'\btimestamptz\(6\)', 'timestamp(6)', content, flags=re.IGNORECASE)
        
        # 替换 timestamptz -> timestamp (没有括号的情况)
        content = re.sub(r'\btimestamptz\b(?!\()', 'timestamp', content, flags=re.IGNORECASE)
        
        # 替换 TIMESTAMPTZ(6) -> TIMESTAMP(6)
        content = re.sub(r'\bTIMESTAMPTZ\(6\)', 'TIMESTAMP(6)', content)
        
        # 替换 TIMESTAMPTZ -> TIMESTAMP (没有括号的情况)
        content = re.sub(r'\bTIMESTAMPTZ\b(?!\()', 'TIMESTAMP', content)
        
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False
    
    except Exception as e:
        print(f"❌ 处理文件失败 {file_path}: {str(e)}")
        return False

def batch_fix_directory(directory):
    """
    批量处理目录中的所有SQL文件
    """
    print(f"开始处理目录: {directory}", flush=True)
    print("=" * 80, flush=True)
    
    fixed_count = 0
    total_count = 0
    
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.sql'):
                file_path = os.path.join(root, file)
                total_count += 1
                
                if fix_timestamptz_in_file(file_path):
                    fixed_count += 1
                    print(f"[OK] 已修复: {file}", flush=True)
                else:
                    print(f"[SKIP] 跳过（无需修改）: {file}", flush=True)
    
    print("=" * 80, flush=True)
    print(f"处理完成！", flush=True)
    print(f"  总文件数: {total_count}", flush=True)
    print(f"  已修复: {fixed_count}", flush=True)
    print(f"  未修改: {total_count - fixed_count}", flush=True)

def main():
    # 要处理的目录
    target_directory = r"C:\Users\wcss\Desktop\mysqlToPg\create_table\migrations_ultimate"
    
    if not os.path.exists(target_directory):
        print(f"❌ 目录不存在: {target_directory}")
        sys.exit(1)
    
    print("=" * 80)
    print("PostgreSQL时间类型修复工具")
    print("功能: timestamptz → timestamp")
    print("=" * 80)
    print()
    
    # 确认操作
    print(f"即将修改目录: {target_directory}")
    print(f"操作: 将所有 timestamptz 替换为 timestamp")
    print()
    response = input("是否继续? (y/n): ")
    
    if response.lower() != 'y':
        print("操作已取消")
        sys.exit(0)
    
    print()
    batch_fix_directory(target_directory)
    
    print()
    print("=" * 80)
    print("[SUCCESS] 所有文件已处理完成！")
    print()
    print("[INFO] 修改说明:")
    print("  - timestamptz(6) -> timestamp(6)")
    print("  - timestamptz -> timestamp")
    print()
    print("[EFFECT] 效果:")
    print("  修改前: 2024-01-15 14:30:00+08 (带时区)")
    print("  修改后: 2024-01-15 14:30:00 (不带时区)")
    print()
    print("[TIP] Java代码建议:")
    print("  使用 LocalDateTime 类型接收时间字段")
    print("  示例: private LocalDateTime createTime;")
    print("=" * 80)

if __name__ == "__main__":
    main()
