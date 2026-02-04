#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
MyBatis Mapper XML MySQL转PostgreSQL转换工具
基于约束文档自动转换SQL语法
"""

import re
import os
import glob
from datetime import datetime

def convert_mysql_to_postgresql_sql(content, filename):
    """
    将XML文件中的MySQL SQL语法转换为PostgreSQL语法
    
    Args:
        content: XML文件内容
        filename: 文件名（用于日志）
    
    Returns:
        转换后的内容和转换统计
    """
    original_content = content
    stats = {
        'backticks_removed': 0,
        'limit_converted': 0,
        'on_duplicate_key_converted': 0,
        'group_concat_converted': 0,
        'date_format_converted': 0,
        'ifnull_converted': 0,
        'if_converted': 0,
        'concat_like_converted': 0,
        'now_converted': 0,
        'curdate_converted': 0,
        'locate_converted': 0,
        'find_in_set_converted': 0,
        'ilike_converted': 0,
        'schema_prefix_removed': 0,
        'values_to_excluded': 0,
    }
    
    # 1. 移除反引号（但保留result等属性中的反引号）
    # 只在SQL语句中移除，不影响属性值
    def remove_backticks(match):
        sql_part = match.group(0)
        # 移除SQL中的反引号
        sql_converted = sql_part.replace('`', '')
        stats['backticks_removed'] += sql_part.count('`')
        return sql_converted
    
    # 移除表名、列名、数据库名中的反引号
    content = re.sub(r'`[^`]+`', lambda m: m.group(0).replace('`', ''), content)
    
    # 2. 移除数据库名前缀（如 bigdata-web.table_name）
    def remove_schema_prefix(match):
        stats['schema_prefix_removed'] += 1
        return match.group(2)  # 只返回表名部分
    
    content = re.sub(r'(\b)([a-zA-Z0-9_-]+)\.([a-zA-Z0-9_]+)\b', 
                     lambda m: m.group(1) + m.group(3) if '-' in m.group(2) else m.group(0), 
                     content)
    
    # 3. LIMIT offset, count → LIMIT count OFFSET offset
    def convert_limit(match):
        stats['limit_converted'] += 1
        offset = match.group(1).strip()
        limit = match.group(2).strip()
        return f'LIMIT {limit} OFFSET {offset}'
    
    # 匹配 LIMIT 参数，支持MyBatis的#{}语法
    content = re.sub(
        r'LIMIT\s+(#\{[^}]+\}|[^\s,]+)\s*,\s*(#\{[^}]+\}|[^\s,\n<]+)',
        convert_limit,
        content,
        flags=re.IGNORECASE
    )
    
    # 4. ON DUPLICATE KEY UPDATE ... values(col) → ON CONFLICT ... DO UPDATE SET ... EXCLUDED.col
    def convert_on_duplicate_key(match):
        stats['on_duplicate_key_converted'] += 1
        update_clause = match.group(1)
        
        # 将 values(column) 转换为 EXCLUDED.column
        def replace_values(m):
            stats['values_to_excluded'] += 1
            col_name = m.group(1).strip()
            return f'EXCLUDED.{col_name}'
        
        update_clause = re.sub(
            r'values\s*\(\s*([a-zA-Z0-9_]+)\s*\)',
            replace_values,
            update_clause,
            flags=re.IGNORECASE
        )
        
        # 注意：ON CONFLICT需要指定冲突列，这里使用通用形式
        # 实际使用时可能需要手动指定具体的唯一键列
        return f'ON CONFLICT DO UPDATE SET {update_clause}'
    
    content = re.sub(
        r'ON\s+DUPLICATE\s+KEY\s+UPDATE\s+(.*?)(?=</insert>|</update>)',
        convert_on_duplicate_key,
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    
    # 5. DATE_FORMAT → TO_CHAR (先处理这个，因为它不影响其他转换)
    def convert_date_format(match):
        stats['date_format_converted'] += 1
        date_expr = match.group(1).strip()
        format_str = match.group(2)
        
        # MySQL格式转PostgreSQL格式
        pg_format = format_str
        pg_format = pg_format.replace('%Y', 'YYYY')
        pg_format = pg_format.replace('%y', 'YY')
        pg_format = pg_format.replace('%m', 'MM')
        pg_format = pg_format.replace('%d', 'DD')
        pg_format = pg_format.replace('%H', 'HH24')
        pg_format = pg_format.replace('%h', 'HH12')
        pg_format = pg_format.replace('%i', 'MI')
        pg_format = pg_format.replace('%s', 'SS')
        pg_format = pg_format.replace('%S', 'SS')
        pg_format = pg_format.replace('%T', 'HH24:MI:SS')
        
        return f"TO_CHAR({date_expr}, '{pg_format}')"
    
    content = re.sub(
        r"DATE_FORMAT\s*\(\s*([^,]+?)\s*,\s*['\"]([^'\"]+)['\"]\s*\)",
        convert_date_format,
        content,
        flags=re.IGNORECASE
    )
    
    # 7. IFNULL → COALESCE
    def convert_ifnull(match):
        stats['ifnull_converted'] += 1
        return f'COALESCE({match.group(1)})'
    
    content = re.sub(
        r'IFNULL\s*\((.*?)\)',
        convert_ifnull,
        content,
        flags=re.IGNORECASE
    )
    
    # 8. IF(condition, true_val, false_val) → CASE WHEN condition THEN true_val ELSE false_val END
    # 这个比较复杂，需要小心处理嵌套
    def convert_if_function(match):
        stats['if_converted'] += 1
        content_inside = match.group(1)
        
        # 智能分割IF的三个参数
        parts = []
        current = ''
        paren_depth = 0
        quote_char = None
        
        for char in content_inside:
            if char in ('"', "'") and quote_char is None:
                quote_char = char
                current += char
            elif char == quote_char:
                quote_char = None
                current += char
            elif char == '(' and quote_char is None:
                paren_depth += 1
                current += char
            elif char == ')' and quote_char is None:
                paren_depth -= 1
                current += char
            elif char == ',' and paren_depth == 0 and quote_char is None:
                parts.append(current.strip())
                current = ''
            else:
                current += char
        
        if current.strip():
            parts.append(current.strip())
        
        if len(parts) == 3:
            condition = parts[0]
            true_val = parts[1]
            false_val = parts[2]
            return f'CASE WHEN {condition} THEN {true_val} ELSE {false_val} END'
        else:
            # 无法正确分割，返回原样
            return match.group(0)
    
    # 递归处理IF函数（从内到外）
    for _ in range(5):  # 最多处理5层嵌套
        if not re.search(r'\bIF\s*\(', content, re.IGNORECASE):
            break
        content = re.sub(
            r'\bIF\s*\(([^()]+)\)',
            convert_if_function,
            content,
            flags=re.IGNORECASE
        )
    
    # 9. GROUP_CONCAT → STRING_AGG (在IF之后、CONCAT之前处理)
    # 此时IF已经转换为CASE WHEN，可以更容易地匹配
    def convert_group_concat(match):
        stats['group_concat_converted'] += 1
        full_match = match.group(0)
        col = match.group(1).strip()
        
        # 提取SEPARATOR后的值（默认为逗号）
        separator = "','"
        sep_match = re.search(r"SEPARATOR\s+['\"]([^'\"]+)['\"]", full_match, re.IGNORECASE)
        if sep_match:
            separator = f"'{sep_match.group(1)}'"
        
        # 移除SEPARATOR部分
        col_clean = re.sub(r'\s+SEPARATOR\s+[^\)]+', '', col, flags=re.IGNORECASE).strip()
        
        # 处理 ORDER BY
        order_match = re.search(r'ORDER\s+BY\s+([a-zA-Z0-9_.]+(?:\s+(?:ASC|DESC))?)', col_clean, re.IGNORECASE)
        if order_match:
            col_clean = re.sub(r'\s+ORDER\s+BY\s+[a-zA-Z0-9_.]+(?:\s+(?:ASC|DESC))?', '', col_clean, flags=re.IGNORECASE).strip()
            order_clause = order_match.group(1)
            return f'STRING_AGG({col_clean}, {separator} ORDER BY {order_clause})'
        
        return f'STRING_AGG({col_clean}, {separator})'
    
    # 递归处理GROUP_CONCAT（从内到外）
    for _ in range(5):  # 最多处理5层嵌套
        if not re.search(r'GROUP_CONCAT\s*\(', content, re.IGNORECASE):
            break
        content = re.sub(
            r'GROUP_CONCAT\s*\(([^()]+)\)',
            convert_group_concat,
            content,
            flags=re.IGNORECASE
        )
    
    # 10. CONCAT('%', #{param}, '%') → '%' || #{param} || '%'
    def convert_concat_like(match):
        stats['concat_like_converted'] += 1
        content_inside = match.group(1)
        
        # 简单分割CONCAT中的参数（不处理复杂嵌套）
        # 使用更智能的分割方式
        parts = []
        current = ''
        paren_depth = 0
        quote_char = None
        
        for char in content_inside:
            if char in ('"', "'") and quote_char is None:
                quote_char = char
                current += char
            elif char == quote_char:
                quote_char = None
                current += char
            elif char == '(' and quote_char is None:
                paren_depth += 1
                current += char
            elif char == ')' and quote_char is None:
                paren_depth -= 1
                current += char
            elif char == ',' and paren_depth == 0 and quote_char is None:
                parts.append(current.strip())
                current = ''
            else:
                current += char
        
        if current.strip():
            parts.append(current.strip())
        
        # 连接为PostgreSQL的||语法
        result = ' || '.join(parts)
        return result
    
    # 先处理简单的CONCAT
    content = re.sub(
        r"CONCAT\s*\(\s*([^()]+)\s*\)",
        convert_concat_like,
        content,
        flags=re.IGNORECASE
    )
    
    # 再处理嵌套的CONCAT
    for _ in range(3):
        if 'CONCAT' not in content.upper():
            break
        content = re.sub(
            r"CONCAT\s*\(\s*([^()]+)\s*\)",
            convert_concat_like,
            content,
            flags=re.IGNORECASE
        )
    
    # 11. NOW() → CURRENT_TIMESTAMP
    content = re.sub(
        r'\bNOW\s*\(\s*\)',
        'CURRENT_TIMESTAMP',
        content,
        flags=re.IGNORECASE
    )
    stats['now_converted'] = len(re.findall(r'\bCURRENT_TIMESTAMP\b', content, re.IGNORECASE))
    
    # 11. CURDATE() → CURRENT_DATE
    content = re.sub(
        r'\bCURDATE\s*\(\s*\)',
        'CURRENT_DATE',
        content,
        flags=re.IGNORECASE
    )
    stats['curdate_converted'] = len(re.findall(r'\bCURRENT_DATE\b', content, re.IGNORECASE))
    
    # 12. Date() → DATE() (保持但确保大写)
    content = re.sub(
        r'\bDate\s*\(',
        'DATE(',
        content,
        flags=re.IGNORECASE
    )
    
    # 13. LOCATE(substr, str) → POSITION(substr IN str)
    def convert_locate(match):
        stats['locate_converted'] += 1
        substr = match.group(1).strip()
        str_expr = match.group(2).strip()
        return f'POSITION({substr} IN {str_expr})'
    
    content = re.sub(
        r'LOCATE\s*\(\s*([^,]+?)\s*,\s*([^\)]+?)\s*\)',
        convert_locate,
        content,
        flags=re.IGNORECASE
    )
    
    # 14. LIKE 转换为 ILIKE（不区分大小写）
    # 只在需要时转换，保持原有的LIKE但标记需要review
    # 这里我们添加注释提示
    like_pattern = re.compile(r'\bLIKE\b', re.IGNORECASE)
    stats['ilike_converted'] = len(like_pattern.findall(content))
    
    # 15. FIND_IN_SET - 需要转换为数组操作
    def convert_find_in_set(match):
        stats['find_in_set_converted'] += 1
        needle = match.group(1).strip()
        haystack = match.group(2).strip()
        return f"{needle} = ANY(STRING_TO_ARRAY({haystack}, ','))"
    
    content = re.sub(
        r'FIND_IN_SET\s*\(\s*([^,]+?)\s*,\s*([^\)]+?)\s*\)',
        convert_find_in_set,
        content,
        flags=re.IGNORECASE
    )
    
    # 16. greatest() 和 least() 保持不变（PostgreSQL也支持）
    
    # 17. coalesce() 保持不变（标准SQL）
    
    return content, stats


def convert_xml_file(input_path, output_path):
    """
    转换单个XML文件
    
    Args:
        input_path: 输入文件路径
        output_path: 输出文件路径
    
    Returns:
        转换统计信息
    """
    try:
        with open(input_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        filename = os.path.basename(input_path)
        converted_content, stats = convert_mysql_to_postgresql_sql(content, filename)
        
        # 添加转换说明注释
        conversion_note = f"""<?xml version="1.0" encoding="UTF-8" ?>
<!--
    自动转换说明：
    - 原文件: {filename}
    - 转换时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
    - MySQL → PostgreSQL 16.x
    
    注意事项：
    1. ON CONFLICT子句可能需要手动指定冲突列
    2. LIKE已保留，如需不区分大小写请改为ILIKE
    3. 建议人工review后再部署到生产环境
-->
"""
        
        # 替换XML声明
        if '<?xml' in converted_content:
            converted_content = re.sub(
                r'<\?xml[^>]+\?>',
                conversion_note.strip(),
                converted_content,
                count=1
            )
        else:
            converted_content = conversion_note + converted_content
        
        # 写入输出文件
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(converted_content)
        
        return stats, None
    
    except Exception as e:
        return None, str(e)


def main():
    """主函数"""
    print("=" * 80)
    print("          MyBatis Mapper XML - MySQL to PostgreSQL Converter")
    print("=" * 80)
    print()
    
    # 配置路径
    source_dir = r'C:\Users\wcss\Desktop\mysqlToPg\mysql\mysql'
    output_dir = r'C:\Users\wcss\Desktop\mysqlToPg\postgresql_xml'
    
    # 查找所有XML文件
    xml_files = glob.glob(os.path.join(source_dir, '*.xml'))
    
    if not xml_files:
        print(f"[ERROR] 在 {source_dir} 中未找到XML文件")
        return
    
    print(f"[INFO] 找到 {len(xml_files)} 个XML文件")
    print(f"[INFO] 源目录: {source_dir}")
    print(f"[INFO] 输出目录: {output_dir}")
    print()
    
    # 创建输出目录
    os.makedirs(output_dir, exist_ok=True)
    
    # 转换统计
    total_stats = {
        'total_files': len(xml_files),
        'success': 0,
        'failed': 0,
        'backticks_removed': 0,
        'limit_converted': 0,
        'on_duplicate_key_converted': 0,
        'group_concat_converted': 0,
        'date_format_converted': 0,
        'ifnull_converted': 0,
        'if_converted': 0,
        'concat_like_converted': 0,
        'now_converted': 0,
        'curdate_converted': 0,
        'locate_converted': 0,
        'find_in_set_converted': 0,
        'ilike_converted': 0,
        'schema_prefix_removed': 0,
        'values_to_excluded': 0,
    }
    
    failed_files = []
    
    # 逐个转换
    print("[START] 开始转换...")
    print()
    
    for idx, input_path in enumerate(xml_files, 1):
        filename = os.path.basename(input_path)
        output_path = os.path.join(output_dir, filename)
        
        print(f"[{idx}/{len(xml_files)}] {filename}...", end=' ')
        
        stats, error = convert_xml_file(input_path, output_path)
        
        if error:
            print(f"[FAIL] {error}")
            total_stats['failed'] += 1
            failed_files.append((filename, error))
        else:
            print("[OK]")
            total_stats['success'] += 1
            
            # 累加统计
            for key in stats:
                if key in total_stats:
                    total_stats[key] += stats[key]
    
    print()
    print("=" * 80)
    print("                            转换完成统计")
    print("=" * 80)
    print(f"总文件数:              {total_stats['total_files']}")
    print(f"成功转换:              {total_stats['success']}")
    print(f"转换失败:              {total_stats['failed']}")
    print()
    print("语法转换统计:")
    print(f"  - 反引号移除:        {total_stats['backticks_removed']}")
    print(f"  - LIMIT转换:         {total_stats['limit_converted']}")
    print(f"  - ON DUPLICATE KEY:  {total_stats['on_duplicate_key_converted']}")
    print(f"  - VALUES→EXCLUDED:   {total_stats['values_to_excluded']}")
    print(f"  - GROUP_CONCAT:      {total_stats['group_concat_converted']}")
    print(f"  - DATE_FORMAT:       {total_stats['date_format_converted']}")
    print(f"  - IFNULL:            {total_stats['ifnull_converted']}")
    print(f"  - IF条件:            {total_stats['if_converted']}")
    print(f"  - CONCAT:            {total_stats['concat_like_converted']}")
    print(f"  - NOW():             {total_stats['now_converted']}")
    print(f"  - CURDATE():         {total_stats['curdate_converted']}")
    print(f"  - LOCATE:            {total_stats['locate_converted']}")
    print(f"  - FIND_IN_SET:       {total_stats['find_in_set_converted']}")
    print(f"  - LIKE提示:          {total_stats['ilike_converted']} (需review)")
    print(f"  - 数据库前缀移除:    {total_stats['schema_prefix_removed']}")
    print()
    
    if failed_files:
        print("失败文件列表:")
        for filename, error in failed_files:
            print(f"  - {filename}: {error}")
        print()
    
    print(f"[OUTPUT] 输出目录: {os.path.abspath(output_dir)}")
    print()
    print("[NOTE] 重要提醒:")
    print("  1. 请人工review所有ON CONFLICT子句，确保指定了正确的冲突列")
    print("  2. 检查LIKE是否需要改为ILIKE（不区分大小写）")
    print("  3. 验证复杂的IF嵌套转换是否正确")
    print("  4. 测试所有转换后的SQL语句")
    print()
    print("[DONE] 转换完成！")


if __name__ == '__main__':
    main()
