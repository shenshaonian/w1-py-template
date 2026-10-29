"""核心逻辑示例。

引用了什么：logging（自带日志库）、__future__.annotations（自带）；无第三方依赖。
代码做了什么：add(a, b) 两数相加；sum_all(values) 求和（空列表返回 0）；各打一条 debug 日志。
对外暴露：__all__ = ["add", "sum_all"]（logger 不在其中，不算对外）。

两条纪律：库代码只 getLogger 不 basicConfig；日志用 %s 占位符不用 f-string。
"""

from __future__ import annotations

import logging

logger = logging.getLogger(__name__)

# 对外暴露：add、sum_all（按字母排序，否则 ruff RUF022 报错）
__all__ = ["add", "sum_all"]


def add(a: int, b: int) -> int:
    """两数相加。"""
    logger.debug("add %s + %s", a, b)
    return a + b


def sum_all(values: list[int]) -> int:
    """对一组整数求和（空列表返回 0）。"""
    logger.debug("sum_all len=%s", len(values))
    return sum(values)
