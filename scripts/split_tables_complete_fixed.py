# -*- coding: utf-8 -*-
import re
import os
from datetime import datetime

sql_file_path = r'C:\Users\wcss\Desktop\mysqlToPg\create_table\xdr22.sql'
output_dir = r'C:\Users\wcss\Desktop\mysqlToPg\create_table\migrations_complete_final'

os.makedirs(output_dir, exist_ok=True)

with open(sql_file_path, 'r', encoding='utf-8') as f:
    content = f.read()

print("开始解析SQL文件...")

# 提取所有TYPE定义
type_pattern = re.compile(
    r'-- ----------------------------\n-- Type structure for (\S+)\n-- ----------------------------\n(.*?)(?=\n-- ----)',
    re.DOTALL
)
types = {}
for match in type_pattern.finditer(content):
    type_name = match.group(1)
    type_def = match.group(2).strip()
    types[type_name] = f"-- ----------------------------\n-- Type structure for {type_name}\n-- ----------------------------\n{type_def}"

print(f"找到 {len(types)} 个类型定义")

# 提取所有SEQUENCE定义
sequence_pattern = re.compile(
    r'-- ----------------------------\n-- Sequence structure for (\S+)\n-- ----------------------------\n(.*?)(?=\n-- ----)',
    re.DOTALL
)
sequences = {}
for match in sequence_pattern.finditer(content):
    seq_name = match.group(1)
    seq_def = match.group(2).strip()
    sequences[seq_name] = f"-- ----------------------------\n-- Sequence structure for {seq_name}\n-- ----------------------------\n{seq_def}"

print(f"找到 {len(sequences)} 个序列定义")

# 提取所有表的基本定义（Table structure + Records）
table_pattern = re.compile(
    r'-- ----------------------------\n-- Table structure for (\S+)\n-- ----------------------------\n(.*?)(?=\n-- ----------------------------\n-- (Table structure|Alter sequences|Function structure|Indexes|Primary Key|Uniques|Foreign Keys|Triggers structure|$))',
    re.DOTALL
)

tables_basic = {}
for match in table_pattern.finditer(content):
    table_name = match.group(1)
    table_def = match.group(2).strip()
    tables_basic[table_name] = table_def

print(f"找到 {len(tables_basic)} 个表定义")

# 提取每个表的 ALTER SEQUENCE OWNED BY 设置
alter_seq_owned_pattern = re.compile(
    r'-- ----------------------------\n-- Alter sequences owned by\n-- ----------------------------\n(ALTER SEQUENCE "([^"]+)"\nOWNED BY "[^"]*"\..*?;\nSELECT setval\(.*?;)',
    re.DOTALL
)

table_alter_sequences = {}
for match in alter_seq_owned_pattern.finditer(content):
    seq_content = match.group(1).strip()
    seq_name = match.group(2)
    
    # 从序列名推断表名
    table_name = seq_name.replace('_id_seq', '')
    
    if table_name not in table_alter_sequences:
        table_alter_sequences[table_name] = []
    
    table_alter_sequences[table_name].append(
        f"-- ----------------------------\n-- Alter sequences owned by\n-- ----------------------------\n{seq_content}"
    )

print(f"找到 {len(table_alter_sequences)} 个表的序列所有权设置")

# 提取所有表的约束定义
constraint_patterns = [
    (r'-- Indexes structure for table (\S+)\n-- ----------------------------\n(.*?)(?=\n-- ----)', 'indexes'),
    (r'-- Primary Key structure for table (\S+)\n-- ----------------------------\n(.*?)(?=\n-- ----)', 'primary_keys'),
    (r'-- Uniques structure for table (\S+)\n-- ----------------------------\n(.*?)(?=\n-- ----)', 'uniques'),
    (r'-- Foreign Keys structure for table (\S+)\n-- ----------------------------\n(.*?)(?=\n-- ----)', 'foreign_keys'),
    (r'-- Triggers structure for table (\S+)\n-- ----------------------------\n(.*?)(?=\n-- ----)', 'triggers'),
]

table_constraints = {}

for pattern_str, constraint_type in constraint_patterns:
    pattern = re.compile(pattern_str, re.DOTALL)
    for match in pattern.finditer(content):
        table_name = match.group(1)
        constraint_def = match.group(2).strip()
        
        if table_name not in table_constraints:
            table_constraints[table_name] = {}
        
        if constraint_type not in table_constraints[table_name]:
            table_constraints[table_name][constraint_type] = []
        
        table_constraints[table_name][constraint_type].append(
            f"-- ----------------------------\n-- {constraint_type.replace('_', ' ').title()} structure for table {table_name}\n-- ----------------------------\n{constraint_def}"
        )

print(f"找到 {len(table_constraints)} 个表的约束定义")

# 获取当前时间戳
timestamp = datetime.now().strftime('%Y%m%d%H%M%S')

# 生成文件
for i, (table_name, basic_def) in enumerate(tables_basic.items()):
    print(f"\n[{i+1}/{len(tables_basic)}] 处理表: {table_name}")
    
    # 检查依赖的TYPE
    used_types = []
    for type_name in types.keys():
        if f'"{type_name}"' in basic_def or f"'{type_name}'" in basic_def:
            used_types.append(type_name)
    
    # 检查依赖的SEQUENCE
    used_seqs = []
    for seq in sequences.keys():
        if seq in basic_def or f"nextval('{seq}'::regclass)" in basic_def:
            used_seqs.append(seq)
    
    # 生成文件名
    filename = f"V{timestamp}_create_{table_name}.sql"
    filepath = os.path.join(output_dir, filename)
    
    # 构建文件内容
    file_content = []
    
    # 文件头
    file_content.append(f"/*")
    file_content.append(f" * Table: {table_name}")
    file_content.append(f" * Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    file_content.append(f" * Source: xdr22.sql")
    file_content.append(f" */")
    file_content.append("")
    
    # TYPE定义
    if used_types:
        file_content.append("-- ============================")
        file_content.append("-- TYPE DEFINITIONS")
        file_content.append("-- ============================")
        for type_name in used_types:
            file_content.append(types[type_name])
            file_content.append("")
    
    # SEQUENCE定义
    if used_seqs:
        file_content.append("-- ============================")
        file_content.append("-- SEQUENCE DEFINITIONS")
        file_content.append("-- ============================")
        for seq_name in used_seqs:
            file_content.append(sequences[seq_name])
            file_content.append("")
    
    # 表定义
    file_content.append("-- ============================")
    file_content.append("-- TABLE DEFINITION")
    file_content.append("-- ============================")
    file_content.append("-- ----------------------------")
    file_content.append(f"-- Table structure for {table_name}")
    file_content.append("-- ----------------------------")
    file_content.append(basic_def)
    file_content.append("")
    
    # ALTER SEQUENCE OWNED BY
    if table_name in table_alter_sequences:
        file_content.append("-- ============================")
        file_content.append("-- SEQUENCE OWNERSHIP")
        file_content.append("-- ============================")
        for alter_seq in table_alter_sequences[table_name]:
            file_content.append(alter_seq)
            file_content.append("")
    
    # 约束定义
    if table_name in table_constraints:
        constraints = table_constraints[table_name]
        
        # Indexes
        if 'indexes' in constraints:
            file_content.append("-- ============================")
            file_content.append("-- INDEXES")
            file_content.append("-- ============================")
            for index_def in constraints['indexes']:
                file_content.append(index_def)
                file_content.append("")
        
        # Primary Key
        if 'primary_keys' in constraints:
            file_content.append("-- ============================")
            file_content.append("-- PRIMARY KEY")
            file_content.append("-- ============================")
            for pk_def in constraints['primary_keys']:
                file_content.append(pk_def)
                file_content.append("")
        
        # Uniques
        if 'uniques' in constraints:
            file_content.append("-- ============================")
            file_content.append("-- UNIQUE CONSTRAINTS")
            file_content.append("-- ============================")
            for unique_def in constraints['uniques']:
                file_content.append(unique_def)
                file_content.append("")
        
        # Foreign Keys
        if 'foreign_keys' in constraints:
            file_content.append("-- ============================")
            file_content.append("-- FOREIGN KEYS")
            file_content.append("-- ============================")
            for fk_def in constraints['foreign_keys']:
                file_content.append(fk_def)
                file_content.append("")
        
        # Triggers
        if 'triggers' in constraints:
            file_content.append("-- ============================")
            file_content.append("-- TRIGGERS")
            file_content.append("-- ============================")
            for trigger_def in constraints['triggers']:
                file_content.append(trigger_def)
                file_content.append("")
    
    # 写入文件
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write('\n'.join(file_content))
    
    # 统计信息
    stats = []
    if used_seqs:
        stats.append(f"序列:{len(used_seqs)}")
    if used_types:
        stats.append(f"类型:{len(used_types)}")
    if table_name in table_alter_sequences:
        stats.append("序列所有权")
    if table_name in table_constraints:
        tc = table_constraints[table_name]
        if 'indexes' in tc:
            stats.append(f"索引:{len(tc['indexes'])}")
        if 'primary_keys' in tc:
            stats.append(f"主键:{len(tc['primary_keys'])}")
        if 'uniques' in tc:
            stats.append(f"唯一约束:{len(tc['uniques'])}")
        if 'foreign_keys' in tc:
            stats.append(f"外键:{len(tc['foreign_keys'])}")
        if 'triggers' in tc:
            stats.append(f"触发器:{len(tc['triggers'])}")
    
    if stats:
        print(f"    包含: {', '.join(stats)}")
    else:
        print(f"    仅基本定义")

print(f"\n完成！所有文件已保存到: {output_dir}")
print(f"共生成 {len(tables_basic)} 个完整的SQL文件")
print("\n每个文件都包含完整的建表语句，可直接在Navicat中执行！")
