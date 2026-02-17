---
name: tabby
description: 'Tabby terminal workspace orchestration for AgentOps workflows. Helps design split layouts, map panes to tasks, and run RPI phases with predictable terminal context. Triggers: "tabby", "workspace layout", "split panes", "terminal workspace".'
metadata:
  tier: solo
  dependencies: []
---

# /tabby - Tabby Workspace Operations

> **Purpose:** Use Tabby workspaces as an execution surface for AgentOps so Research-Plan-Implement-Validate work runs in stable, role-based panes.

**YOU MUST EXECUTE THIS WORKFLOW. Do not just describe it.**

**Primary target:** TabbySpaces plugin workflows and Tabby terminal layout conventions.

## When to Use

- Setting up a repeatable terminal layout for an AgentOps cycle
- Coordinating multiple streams (coding, tests, logs, docs) without context drift
- Running hybrid Windows + WSL operations while keeping command intent explicit
- Preparing a workspace handoff so the next session can resume quickly

## Core Model

Treat each pane as a role with one responsibility:

- `codePane` - edit/run implementation commands
- `validatePane` - tests, lint, checks
- `contextPane` - docs, plans, references
- `opsPane` - git status, releases, operational scripts

One pane, one job. Do not mix commands across panes unless explicitly asked.

## Execution Steps

Given `/tabby <goal>`:

### Step 1: Detect environment and shell mode

Check whether WSL is available and whether the repo uses hybrid execution.

```bash
if command -v wsl >/dev/null 2>&1; then
  echo "WSL_AVAILABLE=true"
else
  echo "WSL_AVAILABLE=false"
fi

pwd
git rev-parse --show-toplevel 2>/dev/null || true
```

If hybrid mode is active, prefer WSL for build/test/git-heavy tasks and allow Windows-native for docs/navigation tasks.

### Step 2: Pick a workspace layout

Choose one layout based on task complexity:

- **Quick change (2 panes):** `codePane + validatePane`
- **Feature cycle (3 panes):** `codePane + validatePane + contextPane`
- **Full RPI cycle (4 panes):** `codePane + validatePane + contextPane + opsPane`

### Step 3: Bind pane responsibilities

Assign exact responsibilities before executing commands:

1. `codePane` runs implementation commands only
2. `validatePane` runs tests/lint only
3. `contextPane` is read-only context (plans/specs/docs)
4. `opsPane` handles git/release/status commands

If user asks for parallel work, ensure each parallel stream is attached to a separate pane.

### Step 4: Execute with AgentOps mapping

Map pane work to AgentOps skills:

- Research starts in `contextPane` with `/research` and source reading
- Plan runs in `contextPane` with `/plan` and issue decomposition
- Implement runs in `codePane` with `/implement` or `/crank`
- Validate runs in `validatePane` with `/vibe`
- Wrap-up runs in `opsPane` with `/post-mortem` and optional `/release`

### Step 5: Capture session state for handoff

At wrap-up, produce a concise handoff note that includes:

- active workspace name
- pane purpose map
- commands still running
- next command to execute

Store handoff in `.agents/handoff/` when appropriate.

## WSL Hybrid Guidance

When both Windows and WSL are available:

- Prefer WSL for: `git`, build tools, package managers, tests
- Allow Windows-native for: editor navigation and non-build docs work
- Keep path intent explicit:
  - Windows path: `c:\\.07_Job\\...`
  - WSL path: `/mnt/c/.07_Job/...`

Do not silently switch shells mid-step without noting it.

## Guardrails

- Do not overload one pane with unrelated command streams.
- Do not run destructive git commands unless user explicitly asks.
- Do not assume plugin install state; verify before relying on TabbySpaces features.
- If TabbySpaces is unavailable, fall back to manual pane conventions and continue.

## Examples

```bash
/tabby "set up full RPI workspace for auth refactor"
```

Expected behavior:

1. choose 4-pane layout
2. bind pane responsibilities
3. run RPI phases with clear pane ownership
4. create handoff note with next command

```bash
/tabby "quick bugfix workflow"
```

Expected behavior:

1. choose 2-pane layout
2. implement in `codePane`
3. run checks in `validatePane`
4. report PASS/WARN/FAIL

## Troubleshooting

| Problem | Cause | Solution |
| ------- | ----- | -------- |
| TabbySpaces commands unavailable | Plugin not installed in Tabby | Continue with manual pane-role mapping and share install steps |
| WSL commands fail | WSL distro not installed or not initialized | Fallback to Windows-native commands and mark limitation |
| Confused pane ownership | No role map defined at start | Re-run Step 3 and restate one-pane-one-job map |
| Validation blocks implementation | Validate pane overloaded with non-test tasks | Move non-validation tasks to context or ops pane |

## See Also

- `docs/workflows/tabbyspaces-integration.md` - End-to-end integration workflow
- `skills/using-agentops/SKILL.md` - Meta workflow and skill routing
- `docs/SKILLS.md` - Full skill catalog
