"""core 的测试。

pytest 的三条规矩（对照 JUnit）：
- 函数即用例，名字以 test_ 开头
- 直接写 assert，不需要 assertEquals
- 用 raises 断言异常，不用 try/catch
"""

import pytest

from w1_py_template import add, sum_all


def test_add_正数() -> None:
    assert add(1, 2) == 3


def test_add_负数() -> None:
    assert add(-1, 1) == 0


def test_sum_all_空列表() -> None:
    assert sum_all([]) == 0


def test_sum_all_非空() -> None:
    assert sum_all([1, 2, 3]) == 6


def test_sum_all_拒绝非列表() -> None:
    with pytest.raises(TypeError):
        sum_all(None)  # type: ignore[arg-type]
