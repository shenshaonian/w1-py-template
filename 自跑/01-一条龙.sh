#!/usr/bin/env bash
# ==========================================================
# 01 一条龙 · 由「你」执行
# 在哪跑：项目根目录 /Users/xigua/dev/w1-py-template/
# 怎么跑：bash 自跑/01-一条龙.sh
# 触发什么：依次调用 ruff / mypy / pytest 三个检查工具
# 验证什么：写完代码后，一条命令确认"写法 / 类型 / 行为"三层都没问题
# ==========================================================
cd "$(dirname "$0")/.." || exit 1

echo "当前目录：$(pwd)"
echo "（如果不是 /Users/xigua/dev/w1-py-template，说明你 cd 错了）"
echo "=================================================="

echo
echo "【第 1 步】ruff check —— 查「写法」"
echo "  验证：语法、没用到的变量、import 顺序、过时写法、明显 bug 模式"
echo "  预期：All checks passed!"
uv run ruff check .
echo "  → 上面这条的退出码 = $? （0 = 通过，1 = 有问题）"

echo
echo "【第 2 步】ruff format --check —— 查「格式」"
echo "  验证：格式是否统一（只检查，不改文件）"
echo "  预期：All files already formatted"
uv run ruff format --check .
echo "  → 退出码 = $? （0 = 格式没问题）"
echo "  ⚠️ 想真的改文件，用：uv run ruff format ."

echo
echo "【第 3 步】mypy —— 查「类型」"
echo "  验证：类型标注是否自洽（运行时不查，只有它查）"
echo "  预期：Success: no issues found in 4 source files"
uv run mypy
echo "  → 退出码 = $? （0 = 类型没问题）"

echo
echo "【第 4 步】pytest -v —— 查「行为」"
echo "  验证：功能到底对不对（唯一能验证正确性的）"
echo "  预期：5 个用例全 PASSED"
uv run pytest -v
echo "  → 退出码 = $? （0 = 功能没问题）"

echo
echo "【第 5 步】pytest --cov —— 查「覆盖率」"
echo "  验证：测试覆盖了多少代码"
echo "  预期：TOTAL 94%（jsonio.py 71% 是已知缺口）"
uv run pytest --cov

echo
echo "=================================================="
echo "看完了吗？四步退出码都是 0 就说明三道关全绿。"
echo "哪一步不是 0，就说明那一层有问题——把报错发给我，别自己硬猜。"
