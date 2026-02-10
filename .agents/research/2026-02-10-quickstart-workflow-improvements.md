# Research: Improve /quickstart Workflow (Post-Run Review)

**Date:** 2026-02-10
**Scope:** Review the current `/quickstart` workflow docs, compare against how it behaves when run from this repo root, and identify concrete improvements that keep the experience <10 minutes.

## Summary

The current `/quickstart` walkthrough is solid, but it assumes "project files live in the current directory" and that `git diff HEAD~N` is the best proxy for "recently changed area". In a monorepo (like this repo, where Go lives under `cli/`), those assumptions cause the workflow to miss obvious signals and pick noisy file lists. The improvements are mostly small bash snippets: repo-wide language detection, a dirtiness check (`git status --porcelain`), and better heuristics for picking files to read/review.

## Key Files

| File | Purpose |
|------|---------|
| `skills/quickstart/SKILL.md` | The `/quickstart` workflow definition and prompts. |
| `skills/quickstart/references/troubleshooting.md` | Documents known failure modes and fixes for quickstart. |
| `skills/quickstart/references/getting-started.md` | Explains what quickstart does and expected outputs. |
| `cli/go.mod` | Evidence this repo is a Go project (but not at repo root). |
| `AGENTS.md` | Repo-specific onboarding: "Run `bd onboard`". |

## Findings

### 1) Language detection is "current directory only" and fails for monorepos

Quickstart's language detection checks only the current working directory via `ls *.go go.mod ...` etc. (`skills/quickstart/SKILL.md:63-70`). This repo's Go module is under `cli/go.mod` (`cli/go.mod:1-4`), so running quickstart from repo root can report "no language detected" even though Go is clearly present.

Related: troubleshooting explicitly calls out that detection looks at the current directory and suggests `cd` into the source subdir (`skills/quickstart/references/troubleshooting.md:108-115`).

### 2) "Recent changes" uses `git diff HEAD~5`, which is a noisy proxy

Mini Research lists "what changed recently" using `git diff --name-only HEAD~5` (`skills/quickstart/SKILL.md:102-105`). That mixes multiple commits and can surface files that are not a good onboarding target (generated docs, tracking artifacts, etc.). It's also disconnected from the most useful thing to review during onboarding: what the user is *currently editing* (dirty working tree).

### 3) Mini Vibe has the same issue: it ignores local changes

Mini Vibe uses `git diff --name-only HEAD~3` (`skills/quickstart/SKILL.md:131-134`), which again focuses on committed history. If the repo is dirty, the most actionable validation target is the current `git diff` (staged/unstaged/untracked), not a historical diff.

### 4) Repo-specific onboarding guidance exists but isn't surfaced in quickstart

This repo's `AGENTS.md` says to run `bd onboard` to get started (`AGENTS.md:3`). `/quickstart` already detects `.beads/` (`skills/quickstart/SKILL.md:79-82`) and checks `bd` availability later (`skills/quickstart/SKILL.md:175-184`), but it doesn't explicitly route the user to `bd onboard` when both are present.

## Recommendations

1. Update Step 1 language detection to scan a few levels deep (and/or use `git ls-files` when in a git repo), and report *which path* triggered detection (example: "Go detected (cli/go.mod)").
2. Add a lightweight "repo hygiene" check (`git status --porcelain | head`) and use it to drive Steps 3 and 5:
   - If dirty: base Mini Research/Vibe on local changed files.
   - If clean: base on the last commit (`git show --name-only HEAD`) rather than `HEAD~N` diffs.
3. Optionally filter out known-noise paths when selecting files to read (example: `.agents/`, `cli/.agents/`, `.beads/`), but fall back to the unfiltered list if filtering yields nothing.
4. In Step 7 (Next Steps), when `bd` is available and `.beads/` exists, suggest running `bd onboard` before anything else (repo-specific fast path).
5. Update `skills/quickstart/references/troubleshooting.md` to match the new detection behavior (it should no longer claim "current directory only" if we implement repo-wide detection).

