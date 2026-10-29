"""jsonio 的测试。

覆盖 dump_json / load_json 两个函数，把 jsonio.py 的覆盖率从 71% 补到 100%。
"""

import json

import pytest

from w1_py_template import dump_json, load_json


def test_dump_json_基本() -> None:
    assert dump_json({"a": 1}) == '{"a": 1}'


def test_dump_json_中文不转义() -> None:
    # ensure_ascii=False 的效果：中文原样保留，不会被转成 \uXXXX
    assert dump_json({"name": "西瓜"}) == '{"name": "西瓜"}'


def test_load_json() -> None:
    assert load_json('{"a": 1}') == {"a": 1}


def test_往返一致() -> None:
    data = {"a": 1, "b": [1, 2, 3], "c": {"d": "西瓜"}}
    assert load_json(dump_json(data)) == data


def test_load_json_坏JSON抛异常() -> None:
    with pytest.raises(json.JSONDecodeError):
        load_json("{bad json")
