#!/usr/bin/env bash
# ==========================================================
# 03 复现 Day4 那 46 个报错 · 由「你」执行
# 在哪跑：项目根目录 /Users/xigua/dev/w1-py-template/
# 怎么跑：bash 自跑/03-复现那46个报错.sh
# 触发什么：临时强制打开 RUF002/RUF003/N802 三条规则（不改任何配置文件）
# 验证什么：亲眼看到「中文全角标点」和「中文测试函数名」到底触发了什么
#           —— 以及为什么我在 pyproject.toml 里把它们 ignore 掉
# ==========================================================
cd "$(dirname "$0")/.." || exit 1

echo "当前目录：$(pwd)"
echo "=================================================="
echo
echo "说明：这个脚本用 --select 临时打开三条规则，"
echo "      跑完就恢复，不会动你的 pyproject.toml。"
echo

echo "【第 1 组】RUF002 / RUF003 —— 中文全角标点（：（）、，）"
echo "  预期：一堆 Docstring / Comment contains ambiguous ..."
uv run ruff check --select RUF002,RUF003 . 2>&1 | tail -5
read -p ">>> 按回车看下一组..."

echo
echo "【第 2 组】N802 —— 中文测试函数名"
echo "  预期：Function name \`test_add_正数\` should be lowercase（共 5 条）"
uv run ruff check --select N802 . 2>&1 | tail -8
read -p ">>> 按回车看恢复后的正常状态..."

echo
echo "【恢复】用项目真实配置再跑一次："
uv run ruff check .
echo "  → 退出码 = $? （0 = 干净，因为配置里已经 ignore 了那三条）"

echo
echo "=================================================="
echo "想想看：这三条该「改代码」还是「改配置」？"
echo "  - 中文文档必然用全角标点 → 规则不适用 → 改配置（ignore）"
echo "  - 中文测试名可读性好     → 只对 tests/ 放宽"
echo "  - 对比：E501 行太长是真问题 → 该改代码，不靠 ignore 掩盖"
