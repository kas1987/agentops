---
name: judgment
description: 'Strategic direction prompt to determine what is worth building before generating models/decks/analysis. Triggers: "judgment prompt", "what should we build", "is this worth doing", "strategic direction".'
metadata:
  tier: solo
  dependencies: []
---

# /judgment - Strategic Direction Prompt

> **Purpose:** Clarify what should be built before execution so output serves an actual decision, not just production velocity.

**YOU MUST EXECUTE THIS WORKFLOW. Do not just describe it.**

## When to Use

- Before `/operating-model` or `/board-deck`
- When request quality is vague but urgency is high
- When alternatives are unclear and scope could sprawl

## Required Intake Questions

1. What do you think you need right now?
2. Who is it for, and what decision are they making?
3. What alternatives have you considered?

## Execution Steps

### Step 1: Clarify objective and decision

- Separate desired artifact from desired outcome.
- Restate the target decision in one sentence.

### Step 2: Surface alternatives

Evaluate at least 3 options:

- do nothing / defer
- lightweight option
- full build option

Assess each option for:

- decision impact
- time-to-value
- reversibility
- data readiness

### Step 3: Recommend output type

Recommend the smallest useful output:

- operating model
- board deck
- short memo
- one-page decision brief

Include why that format is best for this decision.

### Step 4: Define execution brief

Return:

- objective
- audience and decision
- chosen artifact
- acceptance criteria
- risks/unknowns
- next command to run

## Output Format

```text
DECISION TARGET:
[What decision this work is driving]

OPTIONS CONSIDERED:
1. [Option] - [Pros/cons]
2. [Option] - [Pros/cons]
3. [Option] - [Pros/cons]

RECOMMENDED PATH:
[Best path and why]

MINIMUM USEFUL OUTPUT:
[Artifact to build now]

EXECUTION BRIEF:
- Objective:
- Audience:
- Acceptance criteria:
- Key risks:
- Next command:
```

## Critical Rules

- Do not jump into production without decision clarity.
- Prefer minimum useful output over maximal output.
- Flag unknowns that can invalidate recommendations.
- Tie recommendation to decision quality, not aesthetics.

## Notes

This skill is based on the "Judgment Prompt" intent you provided (strategic direction before build). If you want, we can add your full canonical XML block later and keep this skill as the execution wrapper.
