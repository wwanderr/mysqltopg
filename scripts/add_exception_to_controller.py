#!/usr/bin/env python3
"""
批量为Controller添加异常处理
"""
import re
import sys

def add_exception_handling(java_file):
    with open(java_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 正则匹配所有@GetMapping方法
    pattern = r'(@GetMapping\([^)]*\)\s+public\s+String\s+\w+\([^)]*\)\s*\{)'
    
    def add_try_catch(match):
        method_start = match.group(1)
        return method_start + '\n        try {'
    
    # 第一步：在方法开始添加try
    content = re.sub(pattern, add_try_catch, content)
    
    # 第二步：在return之前添加catch（简化版：在方法结束}前添加）
    # 查找所有方法的return语句
    lines = content.split('\n')
    new_lines = []
    in_method = False
    method_indent = 0
    
    for i, line in enumerate(lines):
        new_lines.append(line)
        
        # 检测方法开始
        if 'public String ' in line and '@GetMapping' in '\n'.join(lines[max(0,i-5):i+1]):
            in_method = True
            method_indent = len(line) - len(line.lstrip())
        
        # 检测return语句，在其后添加catch
        if in_method and 'return ' in line and 'SUCCESS:' in line:
            # 在return后添加catch块
            indent = ' ' * (method_indent + 8)
            catch_block = [
                indent + '} catch (Exception e) {',
                indent + '    String errorMsg = "测试方法执行失败";',
                indent + '    System.err.println(errorMsg + ": " + e.getMessage());',
                indent + '    e.printStackTrace();',
                indent + '    return "{\\"error\\": \\"" + errorMsg + "\\", \\"message\\": \\"" + e.getMessage().replace("\\"", "\'") + "\\"}";',
                indent + '}'
            ]
            new_lines.extend(catch_block)
            in_method = False
    
    return '\n'.join(new_lines)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python add_exception_to_controller.py <controller.java>")
        sys.exit(1)
    
    java_file = sys.argv[1]
    result = add_exception_handling(java_file)
    
    with open(java_file, 'w', encoding='utf-8') as f:
        f.write(result)
    
    print(f"✅ 已为 {java_file} 添加异常处理")
