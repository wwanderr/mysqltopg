# -*- coding: utf-8 -*-
import re
import os
from collections import defaultdict

# 扫描所有建表SQL，找出bool字段
sql_dir = r'C:\Users\wcss\Desktop\mysqlToPg\create_table\migrations_ultimate'
xml_dir = r'C:\Users\wcss\Desktop\mysqlToPg\postgresql_xml_manual'

# 存储表名和bool字段的映射
table_bool_fields = defaultdict(list)

print("=" * 80)
print("正在扫描所有表的bool字段...")
print("=" * 80)

# 扫描所有SQL文件
for sql_file in os.listdir(sql_dir):
    if not sql_file.endswith('.sql'):
        continue
    
    filepath = os.path.join(sql_dir, sql_file)
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 提取表名
    table_match = re.search(r'CREATE TABLE "(\w+)"', content)
    if not table_match:
        continue
    
    table_name = table_match.group(1)
    
    # 查找bool字段
    bool_pattern = re.compile(r'"(\w+)"\s+bool[,\s]', re.IGNORECASE)
    for match in bool_pattern.finditer(content):
        field_name = match.group(1)
        table_bool_fields[table_name].append(field_name)

# 输出所有包含bool字段的表
print(f"\n找到 {len(table_bool_fields)} 个表包含bool字段:\n")

for table_name, fields in sorted(table_bool_fields.items()):
    print(f"表: {table_name}")
    print(f"  Bool字段: {', '.join(fields)}")
    
    # 查找对应的XML文件
    xml_files = []
    for xml_file in os.listdir(xml_dir):
        if xml_file.endswith('.xml'):
            xml_path = os.path.join(xml_dir, xml_file)
            with open(xml_path, 'r', encoding='utf-8') as f:
                xml_content = f.read()
                if table_name in xml_content:
                    xml_files.append(xml_file)
    
    if xml_files:
        print(f"  对应XML: {', '.join(xml_files)}")
        
        # 检查XML中是否有这些字段的INTEGER/VARCHAR用法
        for xml_file in xml_files:
            xml_path = os.path.join(xml_dir, xml_file)
            with open(xml_path, 'r', encoding='utf-8') as f:
                xml_content = f.read()
            
            issues = []
            for field in fields:
                # 检查是否使用了INTEGER或VARCHAR类型
                if re.search(rf'{field}[,\s]*=[,\s]*#\{{[^}}]*jdbcType=(INTEGER|VARCHAR)', xml_content, re.IGNORECASE):
                    issues.append(f"{field} (使用了INTEGER/VARCHAR)")
                elif re.search(rf'{field}\s*=\s*\d+', xml_content):
                    issues.append(f"{field} (直接用整数比较)")
            
            if issues:
                print(f"  [!] 需要修复: {xml_file}")
                for issue in issues:
                    print(f"      - {issue}")
    else:
        print(f"  [i] 未找到对应的XML文件")
    
    print()

print("=" * 80)
print("汇总报告")
print("=" * 80)

# 生成修复建议
print("\n需要检查和修复的XML文件列表:")
checked_xmls = set()

for table_name, fields in sorted(table_bool_fields.items()):
    for xml_file in os.listdir(xml_dir):
        if not xml_file.endswith('.xml'):
            continue
        
        xml_path = os.path.join(xml_dir, xml_file)
        with open(xml_path, 'r', encoding='utf-8') as f:
            xml_content = f.read()
        
        if table_name not in xml_content:
            continue
        
        needs_fix = False
        for field in fields:
            if re.search(rf'{field}[,\s]*=[,\s]*#\{{[^}}]*jdbcType=(INTEGER|VARCHAR)', xml_content, re.IGNORECASE):
                needs_fix = True
                break
            if re.search(rf'{field}\s*=\s*\d+', xml_content):
                needs_fix = True
                break
        
        if needs_fix and xml_file not in checked_xmls:
            print(f"  - {xml_file} (表: {table_name}, 字段: {', '.join(fields)})")
            checked_xmls.add(xml_file)

print(f"\n总计: {len(table_bool_fields)} 个表有bool字段")
print(f"需要修复: {len(checked_xmls)} 个XML文件")

print("\n" + "=" * 80)
print("修复模板")
print("=" * 80)
print("""
修复方法：

1. 插入/更新时的类型转换：
   修复前: #{fieldName,jdbcType=INTEGER}
   修复后: (#{fieldName,jdbcType=INTEGER}::int)::boolean

2. 查询条件中的整数比较：
   修复前: WHERE field_name = 1
   修复后: WHERE field_name = true
   
   修复前: WHERE field_name = 0
   修复后: WHERE field_name = false

3. resultMap不需要修改（MyBatis会自动转换）
""")
