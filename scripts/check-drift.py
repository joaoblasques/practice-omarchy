#!/usr/bin/env python3
"""Fail if a config block differs between the installer and docs/reference/configs.md.

Installer side:  add_block <file> <name> <<'EOF' ... EOF
Docs side:       <!-- block:<name> --> followed by a fenced code block
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SETUP = ROOT / "scripts/practice-omarchy-setup.sh"
CONFIGS = ROOT / "docs/reference/configs.md"


def installer_blocks(text):
    return {m.group(1): m.group(2) for m in re.finditer(
        r"^\s*add_block [^\n]*? (\w+) <<'EOF'\n(.*?)\nEOF$", text, re.S | re.M)}


def doc_blocks(text):
    return {m.group(1): m.group(2) for m in re.finditer(
        r"<!-- block:(\w+) -->\n```\w*\n(.*?)\n```", text, re.S)}


def main():
    a, b = installer_blocks(SETUP.read_text()), doc_blocks(CONFIGS.read_text())
    errors = []
    if not a:
        errors.append("no add_block heredocs found in setup.sh (parser out of date?)")
    for name in sorted(set(a) | set(b)):
        if name not in a:
            errors.append(f"block '{name}' is in configs.md but not in the installer")
        elif name not in b:
            errors.append(f"block '{name}' is in the installer but not in configs.md")
        elif a[name] != b[name]:
            errors.append(f"block '{name}' differs between installer and configs.md")
    for e in errors:
        print(f"DRIFT: {e}\n  WHY: AGENTS.md says these live in two places and must match.\n"
              f"  FIX: make the heredoc in scripts/practice-omarchy-setup.sh and the fenced block\n"
              f"       under <!-- block:NAME --> in docs/reference/configs.md identical.")
    if errors:
        sys.exit(1)
    print(f"OK: {len(a)} config blocks match ({', '.join(sorted(a))})")


if __name__ == "__main__":
    main()
