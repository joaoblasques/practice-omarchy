#!/usr/bin/env bash
# Baseline check. Safe: read-only, never runs the installer or touches dotfiles.
set -euo pipefail
cd "$(dirname "$0")"

pwd
for f in scripts/*.sh init.sh; do bash -n "$f"; done
# compile() in-process: py_compile would write __pycache__
python3 -c "f='scripts/check-drift.py'; compile(open(f).read(), f, 'exec')"
zsh -n scripts/ai-shell.zsh scripts/ccgo.sh
bash -c 'source scripts/ccgo.sh && type ccgo ccgo-check >/dev/null'
python3 -W error::SyntaxWarning -c "f='scripts/practice-omarchy-cli.py'; compile(open(f).read(), f, 'exec')"
# ponytail: -S warning hides SC2016 infos; --shell covers sourced files (ccgo.sh) that have no shebang
shellcheck --shell=bash -S warning scripts/*.sh init.sh
bash scripts/practice-omarchy-setup.sh --dry-run --shell zsh >/dev/null
python3 scripts/check-drift.py
python3 scripts/practice-omarchy-cli.py --selftest
echo "init.sh: baseline OK"
