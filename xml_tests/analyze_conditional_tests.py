#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
分析 Intelligence 之后的 Mapper XML，找出包含条件语句的方法
为每个条件分支生成测试用例
"""

import os
import re
from pathlib import Path
from xml.etree import ElementTree as ET

# Intelligence 之后的模块（按字母顺序）
MODULES_AFTER_INTELLIGENCE = [
    'IsolationHistory',
    'KillProcessHistory',
    'LinkedStrategy',
    'LinkedStrategyValidtime',
    'LoginBaseline',
    'NoticeHistory',
    'OutGoingConfig',
    'ProhibitHistory',
    'QueryTemplate',
    'RiskIncident',
    'RiskIncidentHistory',
    'RiskIncidentOutGoing',
    'RiskIncidentOutGoingHistory',
    'ScanHistory',
    'ScanHistoryDetail',
    'ScenarioData',
    'ScenarioTemplate',
    'SecurityAlarmHandle',
    'SecurityEvent',
    'SecurityType',
    'SecurityZoneSync',
    'SharedData',
    'StrategyDeviceRel',
    'TagSearch',
    'ThirdAuth',
    'VirusKillHistory',
    'VulAnalysisSub'
]

def analyze_xml_file(xml_path):
    """
    分析XML文件，找出包含条件语句的方法
    """
    try:
        with open(xml_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 查找所有的 select/insert/update/delete 标签及其ID
        methods_with_conditions = []
        
        # 使用正则查找所有方法ID
        method_pattern = r'<(select|insert|update|delete)\s+id="([^"]+)"[^>]*>'
        methods = re.findall(method_pattern, content)
        
        for method_type, method_id in methods:
            # 提取该方法的完整内容
            method_start = content.find(f'<{method_type} id="{method_id}"')
            if method_start == -1:
                continue
            
            # 找到对应的结束标签
            method_end = content.find(f'</{method_type}>', method_start)
            if method_end == -1:
                continue
            
            method_content = content[method_start:method_end + len(f'</{method_type}>')]
            
            # 检查是否包含条件语句
            has_choose = '<choose>' in method_content
            has_when = '<when test=' in method_content
            has_if = '<if test=' in method_content
            
            if has_choose or has_if:
                # 提取条件
                conditions = []
                
                # 提取 choose/when 条件
                if has_choose:
                    when_pattern = r'<when test="([^"]+)">'
                    when_conditions = re.findall(when_pattern, method_content)
                    for cond in when_conditions:
                        conditions.append(('when', cond))
                    
                    if '<otherwise>' in method_content:
                        conditions.append(('otherwise', 'default'))
                
                # 提取 if 条件
                if_pattern = r'<if test="([^"]+)">'
                if_conditions = re.findall(if_pattern, method_content)
                for cond in if_conditions:
                    # 简化条件，提取关键变量
                    var_match = re.search(r'(\w+\.?\w*)\s*[!=<>]', cond)
                    if var_match:
                        conditions.append(('if', var_match.group(1), cond))
                
                if conditions:
                    methods_with_conditions.append({
                        'id': method_id,
                        'type': method_type,
                        'conditions': conditions
                    })
        
        return methods_with_conditions
        
    except Exception as e:
        print(f"Error analyzing {xml_path}: {e}")
        return []

def main():
    """
    主函数
    """
    base_dir = Path(__file__).parent.parent
    xml_dir = base_dir / 'postgresql_xml_manual'
    
    print("=" * 80)
    print("分析 Intelligence 之后的 Mapper XML 条件语句")
    print("=" * 80)
    print()
    
    all_results = {}
    
    for module_name in MODULES_AFTER_INTELLIGENCE:
        xml_file = xml_dir / f"{module_name}Mapper.xml"
        
        if not xml_file.exists():
            continue
        
        print(f"分析: {module_name}Mapper.xml")
        methods = analyze_xml_file(xml_file)
        
        if methods:
            all_results[module_name] = methods
            print(f"  找到 {len(methods)} 个包含条件语句的方法:")
            for method in methods:
                print(f"    - {method['id']} ({method['type']})")
                print(f"      条件数量: {len(method['conditions'])}")
                for cond_type, *cond_details in method['conditions'][:3]:  # 只显示前3个
                    if cond_type == 'when':
                        print(f"        <when> {cond_details[0][:60]}...")
                    elif cond_type == 'otherwise':
                        print(f"        <otherwise>")
                    elif cond_type == 'if':
                        print(f"        <if> {cond_details[0]} ...")
                if len(method['conditions']) > 3:
                    print(f"        ... 还有 {len(method['conditions']) - 3} 个条件")
        else:
            print(f"  未找到包含条件语句的方法")
        print()
    
    print("=" * 80)
    print(f"汇总:")
    print(f"  共分析 {len(MODULES_AFTER_INTELLIGENCE)} 个模块")
    print(f"  {len(all_results)} 个模块包含条件语句")
    
    total_methods = sum(len(methods) for methods in all_results.values())
    print(f"  共 {total_methods} 个方法需要条件分支测试")
    print("=" * 80)
    
    # 生成需要添加条件测试的清单
    print()
    print("需要添加条件分支测试的模块:")
    print()
    for module_name, methods in all_results.items():
        print(f"## {module_name}")
        for method in methods:
            print(f"  - {method['id']}: {len(method['conditions'])} 个条件分支")
        print()

if __name__ == '__main__':
    main()
