#!/usr/bin/env bash
# ==========================================================
# 05 打包验证（周末实战）· 由「你」执行
# 在哪跑：项目根目录 /Users/xigua/dev/w1-py-template/
# 怎么跑：bash 自跑/05-打包验证.sh
# 触发什么：把项目打成 wheel → 在另一个干净项目里当第三方包装上
# 验证什么：⭐ 你真的懂「打包与导入」—— 自己的包能被别人安装使用
# ==========================================================
set -e
cd "$(dirname "$0")/.." || exit 1

echo "当前目录：$(pwd)"
echo "=================================================="

echo
echo "【第 1 步】uv build —— 把项目打成 wheel（≈ mvn package 出 jar）"
echo "  预期：dist/ 下出现 w1_py_template-0.1.0-py3-none-any.whl"
uv build
ls -lh dist/
read -p ">>> 按回车继续（建一个干净项目来装它）..."

echo
echo "【第 2 步】在 /tmp 造一个全新项目（模拟'别人'的环境）"
rm -rf /tmp/whl-test && mkdir -p /tmp/whl-test && cd /tmp/whl-test
uv init --library . >/dev/null
echo "  干净项目建在：$(pwd)"
read -p ">>> 按回车继续（把你打的 wheel 装进去）..."

echo
echo "【第 3 步】uv add 你的 wheel —— 像装 httpx 一样装自己的包"
uv add ~/dev/w1-py-template/dist/*.whl
read -p ">>> 按回车继续（导入试试）..."

echo
echo "【第 4 步】在干净项目里 import 你的包"
uv run python -c "from w1_py_template import add, sum_all; print('wheel OK:', add(2, 3), sum_all([1, 2, 3]))"
echo "  → 预期输出：wheel OK: 5 6"

echo
echo "=================================================="
echo "⭐ 这一趟证明了：你的项目不只是'本机能跑'，"
echo "   而是一个可以分发、可以被别人安装的正规 Python 包。"
echo "   （≈ 你写的 jar 被别的项目依赖成功了）"
