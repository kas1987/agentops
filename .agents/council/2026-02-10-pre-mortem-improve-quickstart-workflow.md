# Pre-Mortem: Improve /quickstart Workflow (Monorepo + Dirty Tree)

**Date:** 2026-02-10
**Plan:** `.agents/plans/2026-02-10-improve-quickstart-workflow.md`

## Council Verdict: PASS (with WARNs)

| Judge | Verdict | Key Finding |
|-------|---------|-------------|
| Missing-Requirements | WARN | Handle “git repo but no commits / no HEAD” cleanly; don’t assume `git show HEAD` works. |
| Feasibility | PASS | Changes are doc-only and low-risk; keep repo scans shallow and pruned. |
| Scope | PASS | Scope is tight: quickstart heuristics + doc drift fix. Avoid turning quickstart into a full validator. |

## Shared Findings

- Prefer building “dirty tree file list” from `git diff --name-only` (staged + unstaged) plus `git ls-files --others --exclude-standard` rather than parsing `git status --porcelain` (renames and formatting edge cases).
- If falling back to “last commit file list”, guard with `git rev-parse --verify HEAD` so fresh repos don’t error.
- Keep monorepo detection cheap: shallow `find` with prunes, or use `git ls-files` when available.

## Concerns Raised

- **Performance:** naive `find .` on large repos can be slow. Use `-maxdepth` and prune `.git`, `.agents`, `.beads`, `node_modules`, etc.
- **Noise filtering:** excluding `.agents/` / `.beads/` is good, but only if it’s best-effort and never empties the candidate set.

## Recommendation

Proceed. Implement the new snippets with guard rails (no-HEAD handling, best-effort filtering) and update the reference docs so troubleshooting no longer contradicts shipped behavior.

## Decision Gate

[x] PROCEED
[ ] ADDRESS
[ ] RETHINK

