#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
MySQL到PostgreSQL转换工具
基于迁移规范约束文档进行转换
"""

import re
import os
from pathlib import Path
from datetime import datetime

class MySQLToPostgreSQLConverter:
    """MySQL到PostgreSQL转换器"""
    
    def __init__(self):
        self.stats = {
            'tables': 0,
            'indexes': 0,
            'foreign_keys': 0,
            'triggers': 0,
            'type_conversions': {},
            'warnings': []
        }
    
    def convert_data_type(self, data_type):
        """转换数据类型"""
        # 去除括号中的数字（显示宽度）
        type_match = re.match(r'(\w+)(?:\(([^)]+)\))?(.*)$', data_type.strip(), re.IGNORECASE)
        if not type_match:
            return data_type
        
        base_type = type_match.group(1).upper()
        size = type_match.group(2)
        modifiers = type_match.group(3) or ''
        
        # 类型映射
        type_map = {
            'TINYINT': 'SMALLINT',
            'MEDIUMINT': 'INTEGER',
            'INT': 'INTEGER',
            'BIGINT': 'BIGINT',
            'FLOAT': 'REAL',
            'DOUBLE': 'DOUBLE PRECISION',
            'DATETIME': 'TIMESTAMP',
            'MEDIUMTEXT': 'TEXT',
            'LONGTEXT': 'TEXT',
            'TINYTEXT': 'TEXT',
            'BLOB': 'BYTEA',
            'MEDIUMBLOB': 'BYTEA',
            'LONGBLOB': 'BYTEA',
        }
        
        # 特殊处理
        if base_type == 'TINYINT' and size == '1':
            # TINYINT(1) -> BOOLEAN
            return 'BOOLEAN'
        elif base_type in type_map:
            pg_type = type_map[base_type]
            if base_type in ['INT', 'BIGINT', 'SMALLINT', 'MEDIUMINT', 'TINYINT']:
                # 整数类型不带长度
                return pg_type
            return pg_type
        elif base_type in ['VARCHAR', 'CHAR']:
            if size:
                return f"{base_type}({size})"
            return base_type
        elif base_type == 'DECIMAL' or base_type == 'NUMERIC':
            if size:
                return f"NUMERIC({size})"
            return 'NUMERIC'
        
        return data_type
    
    def convert_table_definition(self, create_sql):
        """转换CREATE TABLE语句"""
        lines = create_sql.split('\n')
        result_lines = []
        table_name = None
        primary_keys = []
        indexes = []
        foreign_keys = []
        unique_indexes = []
        column_comments = []
        table_comment = None
        has_auto_increment = False
        auto_increment_column = None
        update_timestamp_columns = []
        
        # 解析表名
        create_line_match = re.search(r'CREATE TABLE [`\"]?(\w+)[`\"]?\s*\(', create_sql, re.IGNORECASE)
        if create_line_match:
            table_name = create_line_match.group(1)
        
        i = 0
        while i < len(lines):
            line = lines[i].strip()
            
            # DROP TABLE
            if line.upper().startswith('DROP TABLE'):
                result_lines.append(re.sub(r'`', '"', line))
                i += 1
                continue
            
            # CREATE TABLE
            if line.upper().startswith('CREATE TABLE'):
                # 转换表名的引号
                converted_line = re.sub(r'`([^`]+)`', r'"\1"', line)
                # 移除MySQL特定选项
                converted_line = re.sub(r'\)\s*ENGINE\s*=\s*\w+.*$', '', converted_line, flags=re.IGNORECASE)
                result_lines.append(converted_line)
                i += 1
                continue
            
            # 表结束
            if re.match(r'\)\s*ENGINE', line, re.IGNORECASE):
                # 先输出主键和约束
                if primary_keys:
                    pk_columns = ', '.join([f'"{col}"' for col in primary_keys])
                    result_lines.append(f"  PRIMARY KEY ({pk_columns})")
                
                # 输出唯一约束
                for idx in unique_indexes:
                    result_lines.append(f"  {idx}")
                
                # 输出外键
                for fk in foreign_keys:
                    result_lines.append(f"  {fk}")
                
                result_lines.append(');')
                i += 1
                continue
            
            # PRIMARY KEY
            if re.match(r'PRIMARY KEY', line, re.IGNORECASE):
                # 提取主键列
                pk_match = re.search(r'PRIMARY KEY\s*\(([^)]+)\)', line, re.IGNORECASE)
                if pk_match:
                    pk_cols = pk_match.group(1)
                    primary_keys = [col.strip().strip('`').strip('"') for col in pk_cols.split(',')]
                i += 1
                continue
            
            # UNIQUE INDEX
            if re.match(r'UNIQUE (INDEX|KEY)', line, re.IGNORECASE):
                # 提取为单独的CREATE INDEX语句
                idx_match = re.search(r'UNIQUE (?:INDEX|KEY)\s+[`"]?(\w+)[`"]?\s*\(([^)]+)\)', line, re.IGNORECASE)
                if idx_match:
                    idx_name = idx_match.group(1)
                    idx_cols = idx_match.group(2)
                    cols = [f'"{col.strip().strip("`").strip(chr(34))}"' for col in idx_cols.split(',')]
                    idx_sql = f'CREATE UNIQUE INDEX "{idx_name}" ON "{table_name}" ({", ".join(cols)});'
                    indexes.append(idx_sql)
                i += 1
                continue
            
            # INDEX/KEY
            if re.match(r'(INDEX|KEY)\s+[`"]?\w+[`"]?', line, re.IGNORECASE) and not re.match(r'PRIMARY KEY|UNIQUE', line, re.IGNORECASE):
                # 提取为单独的CREATE INDEX语句
                idx_match = re.search(r'(?:INDEX|KEY)\s+[`"]?(\w+)[`"]?\s*\(([^)]+)\)', line, re.IGNORECASE)
                if idx_match:
                    idx_name = idx_match.group(1)
                    idx_cols = idx_match.group(2)
                    cols = [f'"{col.strip().strip("`").strip(chr(34))}"' for col in idx_cols.split(',')]
                    idx_sql = f'CREATE INDEX "{idx_name}" ON "{table_name}" ({", ".join(cols)});'
                    indexes.append(idx_sql)
                i += 1
                continue
            
            # CONSTRAINT FOREIGN KEY
            if re.search(r'CONSTRAINT.*FOREIGN KEY', line, re.IGNORECASE):
                # 转换外键
                fk_line = re.sub(r'`', '"', line)
                fk_line = re.sub(r'USING BTREE', '', fk_line, flags=re.IGNORECASE)
                foreign_keys.append(fk_line.rstrip(','))
                i += 1
                continue
            
            # 普通列定义
            if line and not line.startswith(')') and not line.startswith('--'):
                # 解析列定义
                col_match = re.match(r'[`"]?(\w+)[`"]?\s+(.+?)(?:,\s*)?$', line)
                if col_match:
                    col_name = col_match.group(1)
                    col_def = col_match.group(2).strip().rstrip(',')
                    
                    # 提取注释
                    comment_match = re.search(r"COMMENT\s+'([^']+)'", col_def, re.IGNORECASE)
                    if comment_match:
                        column_comments.append((col_name, comment_match.group(1)))
                        col_def = re.sub(r"\s*COMMENT\s+'[^']+'", '', col_def, flags=re.IGNORECASE)
                    
                    # 检查AUTO_INCREMENT
                    if 'AUTO_INCREMENT' in col_def.upper():
                        has_auto_increment = True
                        auto_increment_column = col_name
                        # 提取数据类型
                        type_match = re.match(r'(\w+(?:\([^)]+\))?)', col_def, re.IGNORECASE)
                        if type_match:
                            orig_type = type_match.group(1).upper()
                            if 'BIGINT' in orig_type:
                                col_def = 'BIGSERIAL'
                            elif 'INT' in orig_type:
                                col_def = 'SERIAL'
                            else:
                                col_def = 'SERIAL'
                            col_def += re.sub(r'^\w+(?:\([^)]+\))?\s*(?:NOT\s+NULL\s*)?(?:AUTO_INCREMENT\s*)?', '', col_def, flags=re.IGNORECASE)
                    else:
                        # 转换数据类型
                        type_match = re.match(r'(\w+(?:\([^)]+\))?)', col_def, re.IGNORECASE)
                        if type_match:
                            orig_type = type_match.group(1)
                            pg_type = self.convert_data_type(orig_type)
                            col_def = col_def.replace(orig_type, pg_type, 1)
                    
                    # 移除MySQL特定选项
                    col_def = re.sub(r'CHARACTER SET \w+', '', col_def, flags=re.IGNORECASE)
                    col_def = re.sub(r'COLLATE \w+', '', col_def, flags=re.IGNORECASE)
                    col_def = re.sub(r'USING BTREE', '', col_def, flags=re.IGNORECASE)
                    col_def = re.sub(r'AUTO_INCREMENT', '', col_def, flags=re.IGNORECASE)
                    
                    # 检查ON UPDATE CURRENT_TIMESTAMP
                    if 'ON UPDATE CURRENT_TIMESTAMP' in col_def.upper():
                        update_timestamp_columns.append(col_name)
                        col_def = re.sub(r'ON UPDATE CURRENT_TIMESTAMP', '', col_def, flags=re.IGNORECASE)
                    
                    # 转换引号
                    result_line = f'  "{col_name}" {col_def}'
                    result_lines.append(result_line.rstrip() + ',')
            
            i += 1
        
        # 移除最后一个逗号
        if result_lines and result_lines[-1].endswith(','):
            result_lines[-1] = result_lines[-1][:-1]
        
        result_sql = '\n'.join(result_lines)
        
        # 添加索引
        if indexes:
            result_sql += '\n\n-- Indexes\n'
            result_sql += '\n'.join(indexes)
        
        # 添加列注释
        if column_comments:
            result_sql += '\n\n-- Column comments\n'
            for col_name, comment in column_comments:
                comment_safe = comment.replace("'", "''")
                result_sql += f'COMMENT ON COLUMN "{table_name}"."{col_name}" IS \'{comment_safe}\';\n'
        
        # 添加更新时间触发器
        if update_timestamp_columns:
            result_sql += '\n\n-- Update timestamp trigger\n'
            result_sql += self.create_update_trigger(table_name, update_timestamp_columns)
        
        self.stats['tables'] += 1
        self.stats['indexes'] += len(indexes)
        self.stats['foreign_keys'] += len(foreign_keys)
        if update_timestamp_columns:
            self.stats['triggers'] += 1
        
        return result_sql
    
    def create_update_trigger(self, table_name, columns):
        """创建更新时间触发器"""
        trigger_sql = f'''-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_{table_name}_timestamp()
RETURNS TRIGGER AS $$
BEGIN
'''
        for col in columns:
            trigger_sql += f'  NEW."{col}" = CURRENT_TIMESTAMP;\n'
        
        trigger_sql += f'''  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_{table_name}_update_timestamp
BEFORE UPDATE ON "{table_name}"
FOR EACH ROW
EXECUTE FUNCTION update_{table_name}_timestamp();
'''
        return trigger_sql
    
    def convert_file(self, input_file, output_file):
        """转换单个文件"""
        print(f"[*] Converting: {input_file}")
        
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 替换文件头
        pg_content = '''-- ====================================================================================================
-- PostgreSQL Migration Script
-- Converted from MySQL using automated migration tool
-- Source: bigdata-web-data.sql
-- Target Database: PostgreSQL 16.x
-- Generated: {timestamp}
-- ====================================================================================================

-- Set client encoding
SET client_encoding = 'UTF8';

-- Disable foreign key checks during migration
SET session_replication_role = 'replica';

'''.format(timestamp=datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
        
        # 分割表
        tables = re.split(r'(-- -+\n-- Table structure for .+?\n-- -+\n)', content)
        
        for i in range(1, len(tables), 2):
            if i+1 < len(tables):
                table_header = tables[i]
                table_content = tables[i+1]
                
                # 转换表定义
                full_table = table_header + table_content
                converted_table = self.convert_table_definition(full_table)
                pg_content += '\n' + converted_table + '\n'
        
        # 转换INSERT语句中的反引号
        pg_content = re.sub(r'INSERT INTO `([^`]+)`', r'INSERT INTO "\1"', pg_content)
        pg_content = re.sub(r'`([^`]+)`', r'"\1"', pg_content)
        
        # 移除INSERT语句前面错误的引号
        pg_content = re.sub(r'^\s*"INSERT"', '  INSERT', pg_content, flags=re.MULTILINE)
        
        # 添加文件尾
        pg_content += '''
-- Enable foreign key checks
SET session_replication_role = 'origin';

-- Update sequences
-- Run after data import:
-- SELECT setval(pg_get_serial_sequence('table_name', 'id_column'), (SELECT MAX(id_column) FROM table_name));
'''
        
        # 写入输出文件
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(pg_content)
        
        print(f"[OK] Converted: {output_file}")
    
    def convert_batch(self, input_dir, output_dir):
        """批量转换"""
        input_path = Path(input_dir)
        output_path = Path(output_dir)
        output_path.mkdir(parents=True, exist_ok=True)
        
        # 查找所有mysql批次文件
        mysql_files = sorted(input_path.glob('batch_*_mysql.sql'))
        
        print(f"\n[*] Found {len(mysql_files)} batch files to convert\n")
        
        for mysql_file in mysql_files:
            # 生成输出文件名
            pg_filename = mysql_file.name.replace('_mysql.sql', '_postgresql.sql')
            pg_file = output_path / pg_filename
            
            # 转换
            self.convert_file(str(mysql_file), str(pg_file))
        
        print(f"\n[OK] All {len(mysql_files)} files converted!")
        print(f"\n=== Conversion Statistics ===")
        print(f"Tables converted: {self.stats['tables']}")
        print(f"Indexes created: {self.stats['indexes']}")
        print(f"Foreign keys: {self.stats['foreign_keys']}")
        print(f"Triggers created: {self.stats['triggers']}")

def main():
    print("=" * 80)
    print("MySQL to PostgreSQL Converter".center(80))
    print("=" * 80)
    print()
    
    converter = MySQLToPostgreSQLConverter()
    
    input_dir = r"C:\Users\wcss\Desktop\mysqlToPg\mysql_split"
    output_dir = r"C:\Users\wcss\Desktop\mysqlToPg\output"
    
    converter.convert_batch(input_dir, output_dir)
    
    print("\n[DONE] Conversion complete!")
    print(f"[INFO] PostgreSQL files saved to: {output_dir}")

if __name__ == '__main__':
    main()
