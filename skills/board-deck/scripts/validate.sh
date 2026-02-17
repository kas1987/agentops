#!/usr/bin/env bash
set -euo pipefail
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0; FAIL=0
check() { if bash -c "$2"; then echo "PASS: $1"; PASS=$((PASS + 1)); else echo "FAIL: $1"; FAIL=$((FAIL + 1)); fi; }

check "SKILL.md exists" "[ -f '$SKILL_DIR/SKILL.md' ]"
check "name is board-deck" "grep -q '^name: board-deck' '$SKILL_DIR/SKILL.md'"
check "mentions PowerPoint" "grep -qi 'PowerPoint' '$SKILL_DIR/SKILL.md'"
check "mentions audience" "grep -qi 'audience' '$SKILL_DIR/SKILL.md'"
check "mentions data gaps" "grep -qi 'data gap' '$SKILL_DIR/SKILL.md'"

echo ""; echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1
