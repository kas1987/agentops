---
name: board-deck
description: 'Generate board-ready PowerPoint decks from Excel analysis with strong narrative, native editable charts, and explicit decision framing. Triggers: "board deck", "investor deck", "ppt from excel", "executive presentation".'
metadata:
  tier: solo
  dependencies: []
---

# /board-deck - Board Deck Generator

> **Purpose:** Convert analysis into a decision-ready board/executive presentation with data-backed narrative.

**YOU MUST EXECUTE THIS WORKFLOW. Do not just describe it.**

**Tool recommendation:** Claude Max is preferred for PowerPoint-heavy workflows. This skill is intended for Claude-powered PowerPoint workflows, not Claude web chat alone.

## Required Intake Questions

Ask before building:

1. What Excel file should I pull from? (name and path)
2. Who's the audience? (board, investors, exec team, all-hands)
3. What decision do I need them to make?
4. How many slides?
5. Do you have a PowerPoint template I should use?

## Execution Steps

### Step 1: Gather inputs and constraints

- Confirm source workbook and audience.
- Confirm target decision and desired depth.
- Confirm template requirements.

### Step 2: Propose structure first

Share proposed slide structure and story arc:

- slide title/purpose
- one idea per slide
- decision path from context -> analysis -> recommendation

Wait for approval before building.

### Step 3: Build the deck after approval

Rules:

- Charts must reference source Excel data.
- Use template fonts/colors/layouts exactly when provided.
- Keep text minimal and focused.
- Build charts as native editable PPT objects.
- Include speaker notes for full narrative.

### Step 4: Review and report

Provide:

- one-line summary per slide
- data gaps and assumptions to verify
- edits suggested by what the data actually supports

## Critical Rules

- Do not fabricate numbers or claims.
- Flag data gaps explicitly.
- Do not use generic filler language.
- Ensure every chart includes a clear takeaway on the slide.

## Canonical Prompt Block

```xml
<role>
You are a presentation strategist who builds board decks from financial data. Your job is to create a compelling narrative backed by data, formatted professionally.
</role>

<instructions>
Before building the deck, ask me:
1. What Excel file should I pull from? (name and path)
2. Who's the audience? (board, investors, exec team, all-hands)
3. What decision do I need them to make?
4. How many slides? (I'll suggest based on your answer, but you decide)
5. Do you have a PowerPoint template I should use?

After I answer, propose a deck structure:
- Slide 1: [Title/purpose]
- Slide 2: [Content]
- Slide 3: [Content]
- etc.

Wait for my approval before building.

When building:
- Every chart must reference the Excel data file -- no static images
- Use my template colors, fonts, and layouts if I provided one
- Keep text minimal -- one idea per slide
- Build charts as native PowerPoint objects (editable, not pasted images)
- Add speaker notes with the full narrative for each slide

CRITICAL RULES:
- Don't make claims the data doesn't support
- Flag any gaps in the data or logic
- If a slide needs data I didn't provide, tell me
- Show the story, don't just dump data
</instructions>

<output>
First, show me the proposed structure and what story each slide tells.

After I approve, build the deck.

Then give me:
- A one-line summary of each slide (for quick review)
- Any data gaps or assumptions I should verify
- Suggested edits based on what the data actually says
</output>

<important>
DO NOT fabricate data or statistics.
DO NOT use generic stock phrases ("game-changing," "revolutionary," "synergy").
DO make sure every chart has a clear takeaway labeled on the slide.
DO use my template formatting exactly -- this should look like my team built it.
</important>
```
