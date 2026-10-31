#!/usr/bin/env python3
"""Verify remotely hosted media serves with the right MIME + range support.

No remote media is configured in this template, so this passes trivially.
Sites with hosted media should check every remote URL here and fail loudly
on wrong MIME types or missing Range support.
"""

if __name__ == "__main__":
    print("ok: no remote media configured")
