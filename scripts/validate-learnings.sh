#!/usr/bin/env bash
# Validate learnings docs for required structure and index wiring
# Usage: ./scripts/validate-learnings.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

LEARNINGS_DIR="$REPO_ROOT/docs/learnings"
LEARNINGS_INDEX="$LEARNINGS_DIR/README.md"
DOCS_INDEX="$REPO_ROOT/docs/INDEX.md"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

pass() { echo -e "${GREEN}✓${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; errors=$((errors + 1)); }
warn() { echo -e "${YELLOW}!${NC} $1"; }

errors=0

if [[ ! -d "$LEARNINGS_DIR" ]]; then
  fail "Missing docs/learnings directory"
  exit 1
fi

if [[ ! -f "$LEARNINGS_INDEX" ]]; then
  fail "Missing docs/learnings/README.md"
  exit 1
fi

if [[ ! -f "$DOCS_INDEX" ]]; then
  fail "Missing docs/INDEX.md"
  exit 1
fi

echo ""
echo "🔎 Validating learnings documentation..."
echo ""

required_headers=(
  "## Metadata"
  "## Core Thesis"
  "## Evidence and Signals"
  "## Open Questions"
)

found_notes=0

while IFS= read -r -d '' file; do
  base="$(basename "$file")"

  # Skip index/checklist/meta docs
  if [[ "$base" == "README.md" || "$base" == "CHECKLIST.md" ]]; then
    continue
  fi

  found_notes=$((found_notes + 1))
  rel_path="docs/learnings/$base"

  echo "── $base"

  for header in "${required_headers[@]}"; do
    if grep -qF "$header" "$file"; then
      pass "$base: has '$header'"
    else
      fail "$base: missing '$header'"
    fi
  done

  if grep -Eq "^-( Source URL:|\*\*Source\*\*: )|^Source URL:" "$file"; then
    pass "$base: source link metadata present"
  else
    fail "$base: missing source URL metadata"
  fi

  if grep -qE "^## (Decision Rules|Decision Framework)" "$file"; then
    pass "$base: decision section present"
  else
    fail "$base: missing decision rules/framework section"
  fi

  if grep -qE "^## (Action Plan|Next Steps)" "$file"; then
    pass "$base: action section present"
  else
    fail "$base: missing action plan/next steps section"
  fi

  if grep -qE "^## (Risks and Counterpoints|Risks to Watch)" "$file"; then
    pass "$base: risks section present"
  else
    fail "$base: missing risks section"
  fi

  if grep -qF "($base)" "$LEARNINGS_INDEX"; then
    pass "$base: linked in docs/learnings/README.md"
  else
    fail "$base: not linked in docs/learnings/README.md"
  fi

  if grep -qF "(learnings/$base)" "$DOCS_INDEX"; then
    pass "$base: linked in docs/INDEX.md"
  else
    fail "$base: not linked in docs/INDEX.md"
  fi

  echo ""
done < <(find "$LEARNINGS_DIR" -maxdepth 1 -type f -name "*.md" -print0 | sort -z)

if [[ $found_notes -eq 0 ]]; then
  warn "No learnings notes found (expected at least one file besides README/CHECKLIST)"
fi

echo "═══════════════════════════════════════════════════════"
if [[ $errors -gt 0 ]]; then
  echo -e "${RED}LEARNINGS VALIDATION FAILED: $errors issue(s)${NC}"
  echo "═══════════════════════════════════════════════════════"
  exit 1
fi

echo -e "${GREEN}LEARNINGS VALIDATION PASSED${NC}"
echo "═══════════════════════════════════════════════════════"
