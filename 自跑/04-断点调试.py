"""断点调试演示 · 由「你」执行

在哪跑：项目根目录 /Users/xigua/dev/w1-py-template/
怎么跑：uv run python 自跑/04-断点调试.py
触发什么：程序执行到 breakpoint() 会停住，出现 (Pdb) 提示符
验证什么：能用命令单步查看变量 —— 取代 print 调试
"""

from w1_py_template import add, sum_all


def main() -> None:
    a, b = 3, 4
    breakpoint()  # ⬅️ 程序停在这里，你会看到 (Pdb) 提示符
    r = add(a, b)
    print("add =", r)
    s = sum_all([1, 2, 3])
    print("sum_all =", s)


if __name__ == "__main__":
    main()
