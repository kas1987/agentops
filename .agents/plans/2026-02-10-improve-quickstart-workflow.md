# Plan: Improve /quickstart Workflow (Monorepo + Dirty Tree)

**Date:** 2026-02-10
**Source:** `.agents/research/2026-02-10-quickstart-workflow-improvements.md`

## Overview

Improve `/quickstart` so it produces a useful mini RPI cycle when run from a repo root in a monorepo, and so it prioritizes the user’s *current* work (dirty tree) over historical diffs. Also fix small doc drift around the `ao quick-start` CLI command.

## Issues

### Issue 1: Make /quickstart detection monorepo-aware

**Dependencies:** None

**Acceptance:**
- `skills/quickstart/SKILL.md` detects languages by scanning a small depth (or git file list) and prints *which path* triggered detection (example: `Go detected (cli/go.mod)`).
- Detection still stays fast and excludes obvious noise dirs (`.git`, `.agents`, `.beads`, `node_modules`).

**Description:**
Update Step 1 detection commands so running from repo root works for subdir modules.

### Issue 2: Make Mini Research + Mini Vibe prefer dirty working tree

**Dependencies:** None

**Acceptance:**
- If repo is dirty, Mini Research and Mini Vibe base file selection on `git status --porcelain` (staged + unstaged + untracked), not `git diff HEAD~N`.
- If repo is clean, fall back to last commit file list (`git show --name-only --pretty="" HEAD`).
- Add an optional filter to drop known-noise paths (example: `cli/.agents/`, `.agents/`, `.beads/`) but only if it doesn’t empty the list.

**Description:**
Add a small snippet that produces `RECENT_FILES` once and reuses it for both steps.

### Issue 3: Align onboarding docs with new behavior

**Dependencies:** Issue 1, Issue 2

**Acceptance:**
- `skills/quickstart/references/troubleshooting.md` no longer claims detection is “current directory only” if we ship repo-aware detection.
- `skills/quickstart/references/getting-started.md` reflects the updated “recent files” heuristic (dirty tree first).
- `docs/reference.md` uses `ao quick-start --minimal` (not `ao quickstart --minimal`).

**Description:**
Update onboarding docs to match what `/quickstart` now does.

## Execution Order

**Wave 1** (parallel): Issue 1, Issue 2
**Wave 2** (after Wave 1): Issue 3

## Next Steps

- Run `/pre-mortem` (quick) on this plan.
- Implement via `/crank` using the beads epic created from these issues.

