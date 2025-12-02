---
description: End session gracefully with progress update, metrics capture, and optional retrospective
allowed-tools: Read, Write, Bash(git*), Bash(npx*), Bash(vibe-check*)
---

# /session-end - End Session Gracefully

Properly close a session with automatic metrics capture, progress saving, and optional retrospective.

## Usage

```bash
/session-end
```

## Protocol

### Step 1: Check Git Status

```bash
git status --short
```

If uncommitted changes exist:
```
⚠️ Uncommitted changes detected:
   M src/auth/middleware.ts
   M tests/auth.test.ts

Would you like to:
1. Commit these changes
2. Stash for later
3. Leave uncommitted (not recommended)
```

### Step 2: Session Summary

Ask:
```
One-sentence summary of this session:
> ___
```

### Step 3: Capture Session Metrics (vibe-check)

Run vibe-check to capture session metrics:

```bash
# Get session metrics with failure pattern detection
VIBE_METRICS=$(npx @boshu2/vibe-check session end --format json 2>/dev/null)
```

If successful, this returns:
```json
{
  "session_id": "2025-12-02-001",
  "metrics": {
    "trust_pass_rate": 92,
    "rework_ratio": 11,
    "iteration_velocity": 4.2,
    "debug_spiral_duration_min": 0,
    "flow_efficiency": 85,
    "vibe_score": 76
  },
  "retro": {
    "failure_patterns_hit": [],
    "failure_patterns_avoided": ["Debug Spiral", "Context Amnesia"],
    "spirals_detected": 0,
    "learnings": ["Test-first approach prevented spirals"]
  },
  "baseline_comparison": {
    "trust_delta": 0,
    "rework_delta": -6,
    "verdict": "normal",
    "message": "Typical session for you"
  }
}
```

Display comparison:
```
📊 Session Metrics:
   Trust Pass Rate: 92% (+0% vs baseline)
   Rework Ratio: 11% (-6% vs baseline)
   Flow Efficiency: 85%
   VibeScore: 76%

✅ Patterns Avoided: Debug Spiral, Context Amnesia
💡 Learnings: Test-first approach prevented spirals
```

### Step 4: Update Progress File

Update `claude-progress.json` with session entry including metrics:

```json
{
  "current_state": {
    "working_on": "[updated based on work]",
    "next_steps": ["[updated next steps]"],
    "blockers": ["[any blockers encountered]"]
  },
  "sessions": [
    // ... existing sessions
    {
      "date": "YYYY-MM-DD",
      "summary": "[user's summary]",
      "commits": N,
      "duration_minutes": M,
      "vibe_level": L,
      "metrics": {
        "trust_pass_rate": 92,
        "rework_ratio": 11,
        "iteration_velocity": 4.2,
        "flow_efficiency": 85,
        "vibe_score": 76
      },
      "retro": {
        "failure_patterns_hit": [],
        "failure_patterns_avoided": ["Debug Spiral", "Context Amnesia"],
        "learnings": ["Test-first approach prevented spirals"]
      }
    }
  ],
  "resume_summary": "[Concise summary for next session startup]"
}
```

### Step 5: Check Feature Progress

If `feature-list.json` exists:
- Check if any features were completed
- Update `passes: true` and `completed_date` for finished features
- Never modify feature definitions, only mark completion

### Step 6: Offer Bundle Save

```
Would you like to save a context bundle for this work?
- Bundle name: [suggested-name]
- Size: ~Xk tokens compressed

(yes/no)
```

### Step 7: Suggest Retrospective

If failure patterns were hit:
```
⚠️ Failure patterns detected this session:
   - [pattern names]

Running a retrospective is recommended.
/retro - Extract patterns and learnings

(yes/skip)
```

If all patterns avoided:
```
✅ Great session! All failure patterns avoided.

Optional: /retro for learning extraction
```

## Output

```
✅ Session ended gracefully

📊 Session Stats:
   Duration: X minutes
   Commits: N
   Vibe Level: L
   VibeScore: XX%

📈 Vs Baseline:
   Trust: +X% | Rework: -Y%

✅ Patterns Avoided: Debug Spiral, Context Amnesia
💡 Learnings captured: N

📝 Progress saved to claude-progress.json
📦 Bundle saved: [name] (if created)

🔄 To resume: /session-resume
```

## Commit Progress

If progress files were updated:
```bash
git add claude-progress.json feature-list.json
git commit -m "progress: [brief summary]"
```

## Failure Patterns Tracked

vibe-check detects these failure patterns automatically:

| Pattern | Triggered When |
|---------|---------------|
| Debug Spiral | 2+ spirals detected |
| Context Amnesia | Rework ratio >50% |
| Velocity Crash | Iteration velocity <1/hr |
| Trust Erosion | Trust pass rate <60% |
| Flow Disruption | Flow efficiency <50% |

Avoiding these patterns earns positive learnings in the retro.

## Installation Note

If vibe-check is not installed:
```bash
npm install -g @boshu2/vibe-check
```

Or use npx (will download on first use):
```bash
npx @boshu2/vibe-check session end --format json
```
