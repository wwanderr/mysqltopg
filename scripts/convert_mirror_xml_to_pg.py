#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
将 mirror 目录中的 MySQL XML 文件转换为 PostgreSQL XML 文件
结合建表语句中的列类型进行 CAST 转换
"""

import os
import re
from pathlib import Path
from collections import defaultdict

# 目录路径
MIRROR_XML_DIR = Path(r"C:\Users\wcss\Desktop\mysqlToPg\mysql\mirror")
MIRROR_DDL_DIR = Path(r"C:\Users\wcss\Desktop\mysqlToPg\create_table\mirror")
OUTPUT_DIR = Path(r"C:\Users\wcss\Desktop\mysqlToPg\mysql\mirror_pg_xml")

# 表名到建表语句文件的映射
TABLE_TO_DDL = {
    't_threat_intelligence_analysis': 'V20260130110517369__create_t_threat_intelligence_analysis.sql',
    't_sev_agent_info': 'V20260130110517370__create_t_sev_agent_info.sql',
    't_sev_agent_config': 'V20260130110517371__create_t_sev_agent_config.sql',
    't_sev_agent_rule_closed': 'V20260130110517372__create_t_sev_agent_rule_closed.sql',
    't_sev_agent_type_rule_closed': 'V20260130110517373__create_t_sev_agent_type_rule_closed.sql',
    't_sev_agent_events': 'V20260130110517374__create_t_sev_agent_events.sql',
    't_sev_agent_license': 'V20260130110517375__create_t_sev_agent_license.sql',
    't_sev_agent_monitor': 'V20260130110517376__create_t_sev_agent_monitor.sql',
    't_sev_agent_package': 'V20260130110517377__create_t_sev_agent_package.sql',
    't_sev_agent_type': 'V20260130110517378__create_t_sev_agent_type.sql',
    't_organization': 'V20260130110517379__create_t_organization.sql',
}

def parse_ddl_column_types():
    """解析建表语句，获取列名和类型"""
    column_types = defaultdict(dict)  # {table_name: {column_name: type}}
    
    for table_name, ddl_file in TABLE_TO_DDL.items():
        ddl_path = MIRROR_DDL_DIR / ddl_file
        if not ddl_path.exists():
            continue
        
        try:
            with open(ddl_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # 匹配 CREATE TABLE 后的表名
            table_match = re.search(r'CREATE\s+TABLE\s+["\']?(\w+)["\']?', content, re.IGNORECASE)
            if not table_match:
                continue
            
            # 匹配列定义
            # 格式: "column_name" type ...
            pattern = r'"(\w+)"\s+(\w+(?:\([^)]+\))?)'
            matches = re.finditer(pattern, content)
            
            for match in matches:
                col_name = match.group(1).lower()
                col_type = match.group(2).lower()
                # 简化类型（去掉长度等）
                if col_type.startswith('varchar') or col_type.startswith('text'):
                    col_type = 'varchar'
                elif col_type.startswith('int'):
                    col_type = 'int'
                elif col_type.startswith('float') or col_type.startswith('double'):
                    col_type = 'float'
                elif col_type.startswith('bool'):
                    col_type = 'bool'
                elif col_type.startswith('date'):
                    col_type = 'date'
                elif col_type.startswith('timestamp'):
                    col_type = 'timestamp'
                
                column_types[table_name][col_name] = col_type
        
        except Exception as e:
            print(f"Error parsing {ddl_file}: {e}")
    
    return column_types

def convert_mysql_to_pg_sql(sql, column_types=None):
    """将 MySQL SQL 转换为 PostgreSQL SQL"""
    if column_types is None:
        column_types = {}
    
    # 1. 删除 MySQL 特定的 session 设置
    sql = re.sub(r'set\s+session\s+group_concat_max_len\s*=\s*[^;]+;', '', sql, flags=re.IGNORECASE)
    
    # 2. concat('%', ...) -> '%' || ... || '%'
    # 处理 concat('%', param, '%')
    sql = re.sub(r"concat\s*\(\s*'%'\s*,\s*([^,)]+)\s*,\s*'%'\s*\)", r"'%' || \1 || '%'", sql, flags=re.IGNORECASE)
    # 处理 concat(param, '%')
    sql = re.sub(r"concat\s*\(\s*([^,)]+)\s*,\s*'%'\s*\)", r"\1 || '%'", sql, flags=re.IGNORECASE)
    # 处理 concat('%', param)
    sql = re.sub(r"concat\s*\(\s*'%'\s*,\s*([^)]+)\s*\)", r"'%' || \1", sql, flags=re.IGNORECASE)
    
    # 3. ifnull -> COALESCE
    sql = re.sub(r'ifnull\s*\(', 'COALESCE(', sql, flags=re.IGNORECASE)
    
    # 4. UNIX_TIMESTAMP(...)*1000 -> EXTRACT(EPOCH FROM ...)::bigint * 1000
    sql = re.sub(r'UNIX_TIMESTAMP\s*\(([^)]+)\)\s*\*\s*1000', r'EXTRACT(EPOCH FROM \1)::bigint * 1000', sql, flags=re.IGNORECASE)
    
    # 5. date_add(now(), INTERVAL ...) -> now() + INTERVAL '...'
    sql = re.sub(r"date_add\s*\(\s*now\s*\(\s*\)\s*,\s*INTERVAL\s+(\d+)\s+(day|month|hour|minute|week)\s*\)", r"now() + INTERVAL '\1 \2'", sql, flags=re.IGNORECASE)
    
    # 6. date_sub(now(), INTERVAL ...) -> now() - INTERVAL '...'
    # 处理 date_sub(now(), INTERVAL n + 1 minute) 这种复杂情况
    sql = re.sub(r"date_sub\s*\(\s*now\s*\(\s*\)\s*,\s*INTERVAL\s+([^)]+)\s*\)", r"now() - INTERVAL '\1'", sql, flags=re.IGNORECASE)
    # 处理简单的 date_sub(now(), INTERVAL n day)
    sql = re.sub(r"date_sub\s*\(\s*now\s*\(\s*\)\s*,\s*INTERVAL\s+(\d+)\s+(day|month|hour|minute|week)\s*\)", r"now() - INTERVAL '\1 \2'", sql, flags=re.IGNORECASE)
    
    # 7. @rank := @rank + 1 -> ROW_NUMBER() OVER()
    # 需要找到对应的 SELECT 语句
    if '@rank' in sql:
        sql = re.sub(r'@rank\s*:=\s*@rank\s*\+\s*1\s+as\s+`?no`?', 'ROW_NUMBER() OVER() as no', sql, flags=re.IGNORECASE)
        sql = re.sub(r',\s*\(SELECT\s+@rank\s*:=\s*0\)\s+rn', '', sql, flags=re.IGNORECASE)
    
    # 8. limit #{page.offset} offset #{page.size} -> LIMIT #{page.size} OFFSET #{page.offset}
    # 注意：MySQL 的 limit offset, size 对应 PostgreSQL 的 LIMIT size OFFSET offset
    sql = re.sub(r'limit\s+#\{page\.offset\}\s+offset\s+#\{page\.size\}', 'LIMIT #{page.size} OFFSET #{page.offset}', sql, flags=re.IGNORECASE)
    
    # 9. limit 1,1 -> LIMIT 1 OFFSET 1
    sql = re.sub(r'limit\s+(\d+)\s*,\s*(\d+)', r'LIMIT \2 OFFSET \1', sql, flags=re.IGNORECASE)
    
    # 10. delete ... from -> delete from
    sql = re.sub(r'delete\s+(\w+)\s+from\s+(\w+)', r'delete from \2', sql, flags=re.IGNORECASE)
    
    # 11. insert IGNORE -> INSERT ... ON CONFLICT DO NOTHING
    # 需要找到主键或唯一索引，这里简化处理
    sql = re.sub(r'insert\s+IGNORE\s+into\s+(\w+)', r'insert into \1', sql, flags=re.IGNORECASE)
    # 注意：ON CONFLICT 需要根据实际表结构添加，这里先移除 IGNORE
    
    # 12. MINUTE(...) -> EXTRACT(MINUTE FROM ...)
    sql = re.sub(r'MINUTE\s*\(([^)]+)\)', r'EXTRACT(MINUTE FROM \1)', sql, flags=re.IGNORECASE)
    
    # 13. hour(...) -> EXTRACT(HOUR FROM ...)
    sql = re.sub(r'hour\s*\(([^)]+)\)', r'EXTRACT(HOUR FROM \1)', sql, flags=re.IGNORECASE)
    
    # 14. date(...) -> DATE(...) (PostgreSQL 也支持)
    # 保持不变
    
    # 15. lpad(...) -> LPAD(...) (PostgreSQL 也支持)
    # 保持不变
    
    # 16. floor(...) -> FLOOR(...) (PostgreSQL 也支持)
    # 保持不变
    
    # 17. curdate() -> CURRENT_DATE
    sql = re.sub(r'curdate\s*\(\)', 'CURRENT_DATE', sql, flags=re.IGNORECASE)
    
    # 18. current_timestamp() -> CURRENT_TIMESTAMP
    sql = re.sub(r'current_timestamp\s*\(\)', 'CURRENT_TIMESTAMP', sql, flags=re.IGNORECASE)
    
    # 19. group_concat(...) -> STRING_AGG(...)
    # group_concat(distinct col) -> STRING_AGG(DISTINCT col, ',')
    sql = re.sub(r'group_concat\s*\(\s*distinct\s+([^)]+)\s*\)', r"STRING_AGG(DISTINCT \1, ',')", sql, flags=re.IGNORECASE)
    # group_concat(col) -> STRING_AGG(col, ',')
    sql = re.sub(r'group_concat\s*\(([^)]+)\)', r"STRING_AGG(\1, ',')", sql, flags=re.IGNORECASE)
    
    # 20. 处理日期类型比较（expire_time 是 date 类型）
    # 如果比较的是 timestamp 和 date，需要 CAST
    # expire_time > now() -> expire_time > CURRENT_DATE
    sql = re.sub(r'expire_time\s*>\s*now\s*\(\)', 'expire_time > CURRENT_DATE', sql, flags=re.IGNORECASE)
    sql = re.sub(r'expire_time\s*<\s*now\s*\(\)', 'expire_time < CURRENT_DATE', sql, flags=re.IGNORECASE)
    sql = re.sub(r'expire_time\s*>\s*date_add\s*\(now\s*\(\),\s*INTERVAL\s+(\d+)\s+(day|month)\s*\)', 
                 r"expire_time > CURRENT_DATE + INTERVAL '\1 \2'", sql, flags=re.IGNORECASE)
    sql = re.sub(r'expire_time\s*<\s*date_add\s*\(now\s*\(\),\s*INTERVAL\s+(\d+)\s+(day|month)\s*\)', 
                 r"expire_time < CURRENT_DATE + INTERVAL '\1 \2'", sql, flags=re.IGNORECASE)
    
    # 21. 处理 BETWEEN 中的日期
    sql = re.sub(r'between\s+curdate\s*\(\s*\)\s+and\s+current_timestamp\s*\(\)', 
                 'BETWEEN CURRENT_DATE AND CURRENT_TIMESTAMP', sql, flags=re.IGNORECASE)
    
    # 22. 处理 WHERE agent_code = null -> WHERE agent_code IS NULL
    sql = re.sub(r'where\s+(\w+)\s*=\s*null\b', r'where \1 IS NULL', sql, flags=re.IGNORECASE)
    sql = re.sub(r'and\s+(\w+)\s*=\s*null\b', r'and \1 IS NULL', sql, flags=re.IGNORECASE)
    
    # 23. 处理反引号（PostgreSQL 使用双引号，但 MyBatis 中通常不需要）
    # 保持反引号，MyBatis 会处理
    
    return sql

def convert_xml_file(xml_file, column_types):
    """转换单个 XML 文件"""
    try:
        with open(xml_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 提取所有 SQL 语句（在 <select>, <insert>, <update>, <delete> 标签中）
        # 使用更精确的正则匹配
        patterns = [
            (r'(<select[^>]*>)(.*?)(</select>)', 'select'),
            (r'(<insert[^>]*>)(.*?)(</insert>)', 'insert'),
            (r'(<update[^>]*>)(.*?)(</update>)', 'update'),
            (r'(<delete[^>]*>)(.*?)(</delete>)', 'delete'),
            (r'(<sql[^>]*id="[^"]*">)(.*?)(</sql>)', 'sql'),
        ]
        
        def replace_sql(match):
            tag_open = match.group(1)
            sql_content = match.group(2)
            tag_close = match.group(3)
            
            # 转换 SQL
            converted_sql = convert_mysql_to_pg_sql(sql_content, column_types)
            
            return tag_open + converted_sql + tag_close
        
        for pattern, tag_type in patterns:
            content = re.sub(pattern, replace_sql, content, flags=re.DOTALL | re.IGNORECASE)
        
        return content
    
    except Exception as e:
        print(f"Error converting {xml_file}: {e}")
        return None

def main():
    print("=" * 80)
    print("转换 Mirror XML 文件从 MySQL 到 PostgreSQL")
    print("=" * 80)
    
    # 创建输出目录
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    print(f"\n输出目录: {OUTPUT_DIR}")
    
    # 解析建表语句中的列类型
    print("\n解析建表语句中的列类型...")
    column_types = parse_ddl_column_types()
    print(f"已解析 {len(column_types)} 个表的列类型")
    
    # 转换所有 XML 文件
    xml_files = list(MIRROR_XML_DIR.glob("*.xml"))
    print(f"\n找到 {len(xml_files)} 个 XML 文件")
    
    converted_count = 0
    for xml_file in xml_files:
        print(f"\n转换: {xml_file.name}")
        
        converted_content = convert_xml_file(xml_file, column_types)
        if converted_content:
            output_file = OUTPUT_DIR / xml_file.name
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(converted_content)
            print(f"  -> 已保存到: {output_file.name}")
            converted_count += 1
        else:
            print(f"  -> 转换失败")
    
    print("\n" + "=" * 80)
    print(f"转换完成！共转换 {converted_count}/{len(xml_files)} 个文件")
    print("=" * 80)

if __name__ == "__main__":
    main()
