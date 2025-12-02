---
description: Initialize session with standardized get-bearings protocol
allowed-tools: Read, Bash(git*), Bash(npx*), Bash(vibe-check*), Glob
---

# /session-start - Initialize Session

Start a new session with automatic context detection, minimal context loading, and baseline metrics capture.

## Usage

```bash
/session-start
```

## Protocol

### Step 1: Check for Existing Project

```bash
# Check for progress file
[ -f "claude-progress.json" ] && echo "Ongoing project detected"

# Check for feature list
[ -f "feature-list.json" ] && echo "Feature tracking active"
```

### Step 2: If Project Exists

Display:
```
📋 Ongoing project detected
   Project: [project name]
   Last session: [sessions[-1].summary]
   Working on: [current_state.working_on]
   Vibe Level: [current_state.vibe_level]
   Next: [current_state.next_steps[0]]
```

Load ONLY:
- `resume_summary` from progress file (~100-200 tokens)
- Current working files if specified
- Do NOT load full history

### Step 3: If No Project

Ask:
```
No existing project detected.
What are you working on today?
```

Options:
- Start fresh work
- Search for existing bundles: `/bundle-search`
- Load specific bundle: `/bundle-load [name]`

### Step 4: Establish Vibe Level

Ask user to declare vibe level:
```
🎯 What Vibe Level is this session's work? (0-5)

| Level | Trust | Verify | Use For |
|-------|-------|--------|---------|
| 5 | 95% | Final only | Format, lint |
| 4 | 80% | Spot check | Boilerplate |
| 3 | 60% | Key outputs | Features |
| 2 | 40% | Every change | Integrations |
| 1 | 20% | Every line | Architecture |
| 0 | 0% | N/A | Research |

For Level 1-2: Recommend tracer tests before coding.
```

### Step 5: Capture Baseline Metrics (vibe-check)

After vibe level is established, capture baseline:

```bash
# Capture baseline metrics for session comparison
npx @boshu2/vibe-check session start --level $VIBE_LEVEL --format json
```

This stores:
- Baseline metrics from last 7 days
- Session ID for tracking
- Vibe level declared

If vibe-check is not installed:
```bash
npm install -g @boshu2/vibe-check
```

### Step 6: Report Context Status

Report current context estimate:
```
Context Status: 🟢 <5% loaded
Budget: 195k tokens remaining
```

## Output

Provide:
1. Project status (new or resuming)
2. Current state summary
3. Vibe level confirmed
4. Baseline metrics captured
5. Suggested next action
6. Context budget status

Example output:
```
## Session Started

📋 Ongoing project: auth-refactor
   Working on: Add refresh token rotation
   Last session: Research complete. JWT + Redis pattern identified.

🎯 Vibe Level: 3 (Features)
   Trust: 60% | Verify: Key outputs

📊 Baseline captured:
   Trust Pass Rate: 92% (avg last 7 days)
   Rework Ratio: 15%
   Velocity: 4.2/hr

📈 Context: 🟢 <5% loaded (195k remaining)

Ready to work. Run `/session-end` when done.
```

## Integration

This command sets up the session. End with `/session-end` for proper closure and metrics capture.
