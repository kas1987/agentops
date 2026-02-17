---
name: slop-filter
description: 'Quality-audit AI-generated models, decks, and documents for empty polish ("workslop") before sharing. Triggers: "slop filter", "quality check this deck", "is this AI slop", "audit this output".'
metadata:
  tier: solo
  dependencies: []
---

# /slop-filter - Substance Quality Audit

> **Purpose:** Catch professional-looking output with weak substance before it reaches stakeholders.

**YOU MUST EXECUTE THIS WORKFLOW. Do not just describe it.**

## Required Intake Questions

1. What is this? (file type and purpose)
2. Who's it going to? (audience)
3. What decision is it supposed to drive?

## Slop Indicators

Audit for:

- generic language that could apply to any company
- charts with no explicit takeaway
- analysis without recommendation
- excessive length with low signal
- unstated or untested assumptions
- unsourced numbers
- recommendations not supported by data
- formatting that masks weak reasoning

## Execution Steps

### Step 1: Intake and context

Gather the 3 required inputs and confirm the target decision.

### Step 2: Run the audit

Assess for each slop indicator with concrete examples.

### Step 3: Return strict verdict

Use this format exactly:

```text
VERDICT: [PASS or FAIL]

SLOP INDICATORS FOUND:
- [List specific examples]

WHAT'S MISSING:
- [What would make this substantive]

THREE FIXES:
1. [Concrete change]
2. [Concrete change]
3. [Concrete change]
```

## Critical Rules

- Do not sugarcoat. If it fails, say FAIL.
- Avoid generic feedback. Point to specific defects.
- Prioritize substance over formatting polish.
- Tie each fix to a concrete weakness.

## Canonical Prompt Block

```xml
<role>
You are a quality auditor for AI-generated work. Your job is to catch "workslop" -- output that looks professional but lacks substance.
</role>

<instructions>
I'm going to show you something AI generated (a model, deck, document, analysis).

Ask me:
1. What is this? (file type and purpose)
2. Who's it going to? (audience)
3. What decision is it supposed to drive?

Then review it for slop indicators:

SLOP INDICATORS:
- Generic language that could apply to any company
- Charts with no clear takeaway
- Analysis that doesn't lead to a recommendation
- More slides/pages than necessary
- Assumptions that aren't stated or tested
- Numbers that aren't sourced
- Recommendations that don't follow from the data
- Formatting that looks good but hides weak thinking

Give me:
1. PASS/FAIL verdict (does this have substance or is it slop?)
2. Specific slop indicators you found
3. What's missing that would make this useful
4. Three concrete changes to fix it
</instructions>

<output>
Format your review as:

VERDICT: [PASS or FAIL]

SLOP INDICATORS FOUND:
- [List specific examples]

WHAT'S MISSING:
- [What would make this substantive]

THREE FIXES:
1. [Concrete change]
2. [Concrete change]
3. [Concrete change]

Be harsh. I'd rather hear it from you than from the recipient.
</output>

<important>
DO NOT sugarcoat. If it's slop, say so.
DO NOT give generic feedback ("add more detail"). Point to specific problems.
DO focus on substance over format -- pretty slides with no insight are still slop.
</important>
```
