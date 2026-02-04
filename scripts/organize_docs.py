#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
整理项目文档和脚本
将文档移动到 docs 文件夹，脚本移动到 scripts 文件夹
"""

import os
import shutil
from pathlib import Path

# 项目根目录
ROOT_DIR = Path(r"C:\Users\wcss\Desktop\mysqlToPg")
XML_TESTS_DIR = ROOT_DIR / "xml_tests"

# 创建目标文件夹
def create_dirs():
    """创建必要的目录"""
    dirs = [
        ROOT_DIR / "scripts",
        ROOT_DIR / "docs" / "archive",
        XML_TESTS_DIR / "docs" / "reports",
        XML_TESTS_DIR / "docs" / "guides",
    ]
    for dir_path in dirs:
        dir_path.mkdir(parents=True, exist_ok=True)
        print(f"[OK] Created: {dir_path}")

# 移动根目录下的文档
def move_root_docs():
    """移动根目录下的文档到 docs/archive"""
    archive_dir = ROOT_DIR / "docs" / "archive"
    moved = 0
    
    # 要移动的文件模式
    patterns = ["*.md", "*.txt"]
    
    for pattern in patterns:
        for file in ROOT_DIR.glob(pattern):
            if file.name == "README.md":
                continue
            try:
                dest = archive_dir / file.name
                shutil.move(str(file), str(dest))
                print(f"[OK] Moved: {file.name} -> docs/archive/")
                moved += 1
            except Exception as e:
                print(f"[ERROR] Error moving {file.name}: {e}")
    
    # 移动 XML 文件
    for file in ROOT_DIR.glob("*.xml"):
        try:
            dest = archive_dir / file.name
            shutil.move(str(file), str(dest))
            print(f"[OK] Moved: {file.name} -> docs/archive/")
            moved += 1
        except Exception as e:
            print(f"[ERROR] Error moving {file.name}: {e}")
    
    print(f"\n[OK] Moved {moved} files from root to docs/archive/")

# 移动 xml_tests 根目录下的文档
def move_xml_tests_root_docs():
    """移动 xml_tests 根目录下的文档"""
    reports_dir = XML_TESTS_DIR / "docs" / "reports"
    guides_dir = XML_TESTS_DIR / "docs" / "guides"
    moved_reports = 0
    moved_guides = 0
    
    # 报告类文档关键词
    report_keywords = ["修复", "报告", "总结", "计划", "进度", "完成", "清单", "记录", "汇总", "更新"]
    # 指南类文档关键词
    guide_keywords = ["标准", "规范", "模板", "流程", "指南", "说明", "README"]
    
    for file in XML_TESTS_DIR.glob("*.md"):
        if file.name == "README.md":
            continue
        
        file_name = file.name
        is_report = any(keyword in file_name for keyword in report_keywords)
        is_guide = any(keyword in file_name for keyword in guide_keywords)
        
        try:
            if is_report:
                dest = reports_dir / file_name
                shutil.move(str(file), str(dest))
                print(f"[OK] Moved report: {file_name}")
                moved_reports += 1
            elif is_guide:
                dest = guides_dir / file_name
                shutil.move(str(file), str(dest))
                print(f"[OK] Moved guide: {file_name}")
                moved_guides += 1
        except Exception as e:
            print(f"[ERROR] Error moving {file_name}: {e}")
    
    # 移动 txt 文件
    for file in XML_TESTS_DIR.glob("*.txt"):
        try:
            dest = reports_dir / file.name
            shutil.move(str(file), str(dest))
            print(f"[OK] Moved: {file.name}")
            moved_reports += 1
        except Exception as e:
            print(f"[ERROR] Error moving {file.name}: {e}")
    
    print(f"\n[OK] Moved {moved_reports} reports and {moved_guides} guides")

# 移动子目录下的修复报告和快速开始
def move_subdir_docs():
    """移动子目录下的修复报告和快速开始文档"""
    reports_dir = XML_TESTS_DIR / "docs" / "reports"
    guides_dir = XML_TESTS_DIR / "docs" / "guides"
    moved = 0
    
    # 遍历所有子目录
    for subdir in XML_TESTS_DIR.iterdir():
        if not subdir.is_dir() or subdir.name in ["docs", ".git"]:
            continue
        
        # 移动修复报告.md
        report_file = subdir / "修复报告.md"
        if report_file.exists():
            try:
                dest = reports_dir / f"修复报告_{subdir.name}.md"
                shutil.move(str(report_file), str(dest))
                print(f"[OK] Moved: {subdir.name}/修复报告.md")
                moved += 1
            except Exception as e:
                print(f"[ERROR] Error moving {report_file}: {e}")
        
        # 移动深度修复报告.md
        deep_report_file = subdir / "深度修复报告.md"
        if deep_report_file.exists():
            try:
                dest = reports_dir / f"深度修复报告_{subdir.name}.md"
                shutil.move(str(deep_report_file), str(dest))
                print(f"[OK] Moved: {subdir.name}/深度修复报告.md")
                moved += 1
            except Exception as e:
                print(f"[ERROR] Error moving {deep_report_file}: {e}")
        
        # 移动快速开始.md
        guide_file = subdir / "快速开始.md"
        if guide_file.exists():
            try:
                dest = guides_dir / f"快速开始_{subdir.name}.md"
                shutil.move(str(guide_file), str(dest))
                print(f"[OK] Moved: {subdir.name}/快速开始.md")
                moved += 1
            except Exception as e:
                print(f"[ERROR] Error moving {guide_file}: {e}")
    
    print(f"\n[OK] Moved {moved} files from subdirectories")

# 删除一些明显过时的文档
def delete_obsolete_docs():
    """删除明显过时的文档"""
    obsolete_patterns = [
        "*临时*",
        "*备份*",
        "*old*",
        "*test*",
        "*temp*",
    ]
    
    deleted = 0
    for pattern in obsolete_patterns:
        for file in XML_TESTS_DIR.rglob(pattern):
            if file.suffix in [".md", ".txt"]:
                try:
                    file.unlink()
                    print(f"[OK] Deleted: {file.name}")
                    deleted += 1
                except Exception as e:
                    print(f"[ERROR] Error deleting {file.name}: {e}")
    
    print(f"\n[OK] Deleted {deleted} obsolete files")

def main():
    print("=" * 60)
    print("整理项目文档和脚本")
    print("=" * 60)
    
    print("\n1. 创建目录结构...")
    create_dirs()
    
    print("\n2. 移动根目录下的文档...")
    move_root_docs()
    
    print("\n3. 移动 xml_tests 根目录下的文档...")
    move_xml_tests_root_docs()
    
    print("\n4. 移动子目录下的文档...")
    move_subdir_docs()
    
    print("\n5. 删除过时文档...")
    delete_obsolete_docs()
    
    print("\n" + "=" * 60)
    print("整理完成！")
    print("=" * 60)

if __name__ == "__main__":
    main()
