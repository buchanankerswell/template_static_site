#!/usr/bin/env python3
"""Validate the published site directory (stdlib only).

Usage:
    python3 pipeline/check.py docs
"""

import json
import sys
from pathlib import Path


def main() -> None:
    site = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("docs")
    index = site / "index.html"
    if not index.exists():
        raise SystemExit(f"missing {index}")
    data = site / "data"
    count = 0
    if data.exists():
        for path in sorted(data.glob("*.json")):
            json.loads(path.read_text())
            count += 1
    print(f"ok: {index} exists, {count} data files")


if __name__ == "__main__":
    main()
