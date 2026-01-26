#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
批量转换剩余的XML文件 - 手动精确转换版本
"""

import os
import re

def convert_xml_content(content):
    """手动精确转换XML内容"""
    
    # 1. 移除反引号
    content = content.replace('`', '')
    
    # 2. NOW() → CURRENT_TIMESTAMP
    content = re.sub(r'\bNOW\s*\(\s*\)', 'CURRENT_TIMESTAMP', content, flags=re.IGNORECASE)
    
    # 3. CURDATE() → CURRENT_DATE  
    content = re.sub(r'\bCURDATE\s*\(\s*\)', 'CURRENT_DATE', content, flags=re.IGNORECASE)
    
    # 4. Date() → DATE()
    content = re.sub(r'\bDate\s*\(', 'DATE(', content)
    
    # 5. LIMIT offset, limit → LIMIT limit OFFSET offset
    content = re.sub(
        r'LIMIT\s+(#\{[^}]+\}|[^\s,]+)\s*,\s*(#\{[^}]+\}|[^\s,\n<]+)',
        lambda m: f'LIMIT {m.group(2)} OFFSET {m.group(1)}',
        content,
        flags=re.IGNORECASE
    )
    
    # 6. INSERT IGNORE → INSERT ... ON CONFLICT DO NOTHING
    content = re.sub(
        r'INSERT\s+IGNORE\s+INTO',
        'INSERT INTO',
        content,
        flags=re.IGNORECASE
    )
    # 添加 ON CONFLICT DO NOTHING（需要在VALUES后面）
    if 'INSERT INTO' in content and 'ON CONFLICT' not in content and 'insert ignore' in content.lower():
        content = re.sub(
            r'(</foreach>\s*)(?!</insert>)',
            r'\1\n        ON CONFLICT DO NOTHING',
            content,
            flags=re.IGNORECASE
        )
    
    # 7. ON DUPLICATE KEY UPDATE → ON CONFLICT DO UPDATE
    content = re.sub(
        r'ON\s+DUPLICATE\s+KEY\s+UPDATE',
        'ON CONFLICT (id) DO UPDATE SET',
        content,
        flags=re.IGNORECASE
    )
    
    # 8. values(column) → EXCLUDED.column  
    content = re.sub(
        r'\bvalues\s*\(\s*([a-zA-Z0-9_]+)\s*\)',
        lambda m: f'EXCLUDED.{m.group(1)}',
        content,
        flags=re.IGNORECASE
    )
    
    # 9. IFNULL → COALESCE
    content = re.sub(r'\bIFNULL\s*\(', 'COALESCE(', content, flags=re.IGNORECASE)
    
    # 10. CONCAT('%', x, '%') → '%' || x || '%'
    # 简单处理CONCAT用于LIKE的情况
    content = re.sub(
        r"CONCAT\s*\(\s*'%'\s*,\s*([^,)]+)\s*,\s*'%'\s*\)",
        r"'%' || \1 || '%'",
        content,
        flags=re.IGNORECASE
    )
    
    # 11. GROUP_CONCAT → STRING_AGG
    content = re.sub(
        r'GROUP_CONCAT\s*\(\s*([^)]+?)\s+SEPARATOR\s+(["\'])([^"\']+)\2\s*\)',
        lambda m: f"STRING_AGG({m.group(1)}, '{m.group(3)}')",
        content,
        flags=re.IGNORECASE
    )
    content = re.sub(
        r'GROUP_CONCAT\s*\(\s*([^)]+?)\s*\)',
        lambda m: f"STRING_AGG({m.group(1)}, ',')",
        content,
        flags=re.IGNORECASE
    )
    
    # 12. DATE_FORMAT → TO_CHAR
    def convert_date_format(m):
        date_expr = m.group(1)
        fmt = m.group(2)
        # 转换格式
        fmt = fmt.replace('%Y', 'YYYY').replace('%y', 'YY')
        fmt = fmt.replace('%m', 'MM').replace('%d', 'DD')
        fmt = fmt.replace('%H', 'HH24').replace('%h', 'HH12')
        fmt = fmt.replace('%i', 'MI').replace('%s', 'SS')
        fmt = fmt.replace('%T', 'HH24:MI:SS')
        return f"TO_CHAR({date_expr}, '{fmt}')"
    
    content = re.sub(
        r"DATE_FORMAT\s*\(\s*([^,]+?)\s*,\s*['\"]([^'\"]+)['\"]\s*\)",
        convert_date_format,
        content,
        flags=re.IGNORECASE
    )
    
    # 13. TRUNCATE TABLE
    content = re.sub(r'\btruncate\s+table\b', 'TRUNCATE TABLE', content, flags=re.IGNORECASE)
    
    # 14. DELETE FROM ... JOIN → DELETE FROM ... USING
    content = re.sub(
        r'DELETE\s+(\w+)\s+FROM\s+(\w+)\s+\1\s+(LEFT|RIGHT|INNER)?\s*JOIN',
        r'DELETE FROM \2\nUSING',
        content,
        flags=re.IGNORECASE
    )
    
    # 15. LIKE → ILIKE (可选，根据需求)
    # content = re.sub(r'\bLIKE\b', 'ILIKE', content)
    
    return content

def main():
    source_dir = r'C:\Users\wcss\Desktop\mysqlToPg\mysql\mysql'
    output_dir = r'C:\Users\wcss\Desktop\mysqlToPg\postgresql_xml_manual'
    
    # 已完成的文件列表
    completed = [
        'AlarmOutGoingConfigMapper.xml',
        'AlarmStatusTimingTaskMapper.xml',
        'AssetInfoMapper.xml',
        'AttackerTrafficTaskMapper.xml',
        'AttackKnowledgeMapper.xml',
        'BlockHistoryMapper.xml',
        'EventOutGoingConfigMapper.xml',
        'EventOutGoingMapper.xml',
        'EventScenarioQueueMapper.xml',
        'EventTemplateMapper.xml',
    ]
    
    # 获取所有XML文件
    all_files = [f for f in os.listdir(source_dir) if f.endswith('.xml')]
    remaining_files = [f for f in all_files if f not in completed]
    
    print(f"总文件数: {len(all_files)}")
    print(f"已完成: {len(completed)}")
    print(f"剩余: {len(remaining_files)}")
    print("\n开始转换剩余文件...")
    
    for idx, filename in enumerate(remaining_files, 1):
        source_path = os.path.join(source_dir, filename)
        output_path = os.path.join(output_dir, filename)
        
        try:
            with open(source_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # 转换
            converted = convert_xml_content(content)
            
            # 写入
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(converted)
            
            print(f"[{idx}/{len(remaining_files)}] ✓ {filename}")
        
        except Exception as e:
            print(f"[{idx}/{len(remaining_files)}] ✗ {filename}: {e}")
    
    print(f"\n完成！共转换 {len(remaining_files)} 个文件")
    print(f"输出目录: {output_dir}")

if __name__ == '__main__':
    main()
