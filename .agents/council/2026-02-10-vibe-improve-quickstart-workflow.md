# Vibe: Improve /quickstart Workflow (Monorepo + Dirty Tree)

**Date:** 2026-02-10
**Target:** recent changes (quickstart skill + onboarding docs)

## Verdict: PASS (with minor WARNs)

### Mechanical Checks

- `./tests/smoke-test.sh --verbose`: PASS with warnings (warnings are optional agent dir + existing TODO/FIXME count)
- `./tests/docs/validate-links.sh`: PASS
- `./tests/docs/validate-skill-count.sh`: PASS

### Review Notes

- `/quickstart` detection is now monorepo-friendly and prints relative triggering paths (helps when run from repo root).
- Mini Research now prefers the dirty working tree (staged/unstaged/untracked) with safe fallbacks for clean repos and repos with no commits.
- Mini Vibe reuses `RECENT_FILES`; this assumes Step 3 ran in the same shell. The skill explicitly calls this out.
- Doc drift fixed: `docs/reference.md` now matches the actual `ao quick-start` command.

### Risks / Follow-Ups (non-blocking)

- The shallow scan uses `-maxdepth 4`; very deep monorepos may still require `cd` into a module directory. Troubleshooting now documents this.

