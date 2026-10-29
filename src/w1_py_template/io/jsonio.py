"""JSON 序列化示例（后面做 AI 项目时，prompt / 评测结果都靠它落地）。"""

from __future__ import annotations

import json

__all__ = ["dump_json", "load_json"]


def dump_json(data: object) -> str:
    """把对象序列化成 JSON 字符串（中文不转义）。"""
    return json.dumps(data, ensure_ascii=False)


def load_json(text: str) -> object:
    """把 JSON 字符串反序列化成对象。"""
    return json.loads(text)
