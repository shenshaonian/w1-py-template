"""w1-py-template：以后所有 Python 项目都从这份模板复制。

门面（facade）：只在这里暴露对外 API，等于 Java 里的"公开接口"意识。
"""

from w1_py_template.core import add, sum_all
from w1_py_template.io.jsonio import dump_json, load_json

__all__ = ["add", "dump_json", "load_json", "sum_all"]
