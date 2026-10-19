#!/usr/bin/env python3
"""Omarchy keybinding drill. Questions are generated from docs/reference/keybindings.md.

  python3 scripts/practice-omarchy-cli.py              10 random questions
  python3 scripts/practice-omarchy-cli.py -n 20 --section tmux
  python3 scripts/practice-omarchy-cli.py --count      how many questions exist
  python3 scripts/practice-omarchy-cli.py --selftest   check the parser and generator
"""
import argparse
import random
import re
import sys
import time
from pathlib import Path

KEYS_FILE = Path(__file__).resolve().parent.parent / "docs/reference/keybindings.md"
BOLD, GREEN, RED, CYAN, RESET = "\033[1m", "\033[92m", "\033[91m", "\033[96m", "\033[0m"


def load_rows(path=KEYS_FILE):
    """-> list of (section, action, keys) from `| Action | `keys` |` table rows."""
    rows, section = [], ""
    for line in Path(path).read_text().splitlines():
        if line.startswith("## "):
            section = line[3:].strip()
        m = re.match(r"^\|\s*([^|`]+?)\s*\|\s*`([^`]+)`\s*\|$", line)
        if m and section:
            rows.append((section, m.group(1), m.group(2)))
    return rows


def base(action):
    return re.sub(r"\s*\(.*?\)", "", action).strip().lower()


def make_question(rows, row, rng):
    """Return (prompt, options, correct_index). Direction is random: action->keys or keys->action."""
    section, action, keys = row
    forward = rng.random() < 0.5
    pool = [r for r in rows if base(r[1]) != base(action) and r[2] != keys]
    same = [r for r in pool if r[0] == section]
    # ponytail: prefer same-section distractors; fall back to any section if too few
    picks = rng.sample(same if len(same) >= 3 else pool, 3)
    idx = 2 if forward else 1
    options = [row[idx]] + [p[idx] for p in picks]
    rng.shuffle(options)
    prompt = f"{action}?" if forward else f"What does {keys} do?"
    return prompt, options, options.index(row[idx]) + 1


def ask(n, prompt, options, correct):
    print(f"\n{BOLD}{n}. {prompt}{RESET}")
    for i, o in enumerate(options, 1):
        print(f"   {i}. {o}")
    t = time.time()
    try:
        ans = input("   > ").strip()
    except (KeyboardInterrupt, EOFError):
        print("\nbye")
        sys.exit(0)
    ok = ans == str(correct)
    print(f"   {GREEN}correct{RESET} ({time.time() - t:.1f}s)" if ok
          else f"   {RED}wrong{RESET}: {options[correct - 1]}")
    return ok


def selftest():
    rows = load_rows()
    assert len(rows) >= 40, f"only {len(rows)} rows parsed from {KEYS_FILE}"
    rng = random.Random(0)
    for row in rows:
        for _ in range(5):
            prompt, options, correct = make_question(rows, row, rng)
            assert len(set(options)) == 4, (prompt, options)
            assert 1 <= correct <= 4
            assert row[1] in prompt or row[2] in prompt
    print(f"selftest ok: {len(rows)} questions, {len({r[0] for r in rows})} sections")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawTextHelpFormatter)
    ap.add_argument("-n", type=int, default=10, help="number of questions")
    ap.add_argument("--section", help="only sections containing this text, e.g. tmux")
    ap.add_argument("--seed", type=int)
    ap.add_argument("--count", action="store_true", help="print how many questions exist and exit")
    ap.add_argument("--selftest", action="store_true")
    args = ap.parse_args()

    if args.selftest:
        return selftest()
    rows = load_rows()
    if args.count:
        print(len(rows))
        return
    chosen = [r for r in rows if not args.section or args.section.lower() in r[0].lower()]
    if not chosen:
        sys.exit(f"No section matches '{args.section}'. Sections: {sorted({r[0] for r in rows})}")
    rng = random.Random(args.seed)
    picks = rng.sample(chosen, min(args.n, len(chosen)))
    missed = []
    for n, row in enumerate(picks, 1):
        if not ask(n, *make_question(rows, row, rng)):
            missed.append(row)
    print(f"\n{BOLD}{CYAN}Score: {len(picks) - len(missed)}/{len(picks)}{RESET}")
    for s, a, k in missed:
        print(f"  review [{s}] {a}: {k}")


if __name__ == "__main__":
    main()
