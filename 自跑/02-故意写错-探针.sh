#!/usr/bin/env bash
# ==========================================================
# 02 故意写错 · 由「你」执行
# 在哪跑：项目根目录 /Users/xigua/dev/w1-py-template/
# 怎么跑：bash 自跑/02-故意写错-探针.sh
# 触发什么：造一个类型错误 → 分别交给 mypy 和 pytest 看谁抓得住
# 验证什么：证明「类型错误只有 mypy 能拦，pytest 完全看不见」
#           同时证明我配的 mypy 是真的在工作（不是假关卡）
# ==========================================================
cd "$(dirname "$0")/.." || exit 1

PROBE="src/w1_py_template/_type_probe.py"

echo "当前目录：$(pwd)"
echo "=================================================="

echo
echo "【准备】造一个类型错误的探针文件：$PROBE"
cat > "$PROBE" <<'EOF'
def f(x: int) -> str:
    return x
EOF
echo "--- 文件内容（声明返回 str，实际返回 int）---"
cat "$PROBE"
read -p ">>> 按回车继续（交给 mypy 检查）..."

echo
echo "【第 1 问】mypy 抓得住吗？"
echo "  预期：报错 Incompatible return value type (got \"int\", expected \"str\")"
uv run mypy
echo "  → 退出码 = $? （非 0 = 抓住了 ✅）"
read -p ">>> 按回车继续（交给 pytest 检查）..."

echo
echo "【第 2 问】pytest 抓得住吗？"
echo "  预期：5 passed —— 一个都不红 ❌"
uv run pytest -q
echo "  → 退出码 = $? （0 = 没抓住，说明它压根不管类型）"

echo
echo "⭐ 结论：pytest 全绿 ≠ 类型没问题。类型这道关只有 mypy 守。"
read -p ">>> 按回车清理探针文件..."

rm -f "$PROBE"
echo
echo "【清理】已删除 $PROBE，复跑 mypy 确认恢复干净："
uv run mypy
echo "  → 退出码 = $? （0 = 干净了）"
