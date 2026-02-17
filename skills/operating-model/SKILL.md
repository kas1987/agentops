---
name: operating-model
description: 'Build production-ready multi-tab operating models in Excel with linked assumptions, scenarios, cash flow, and sensitivity analysis. Triggers: "operating model", "financial model", "excel model", "scenario model".'
metadata:
  tier: solo
  dependencies: []
---

# /operating-model - Operating Model Builder

> **Purpose:** Build a professional operating model in Excel with strict assumptions linking and scenario controls.

**YOU MUST EXECUTE THIS WORKFLOW. Do not just describe it.**

**Tool recommendation:** Claude Pro is sufficient for Excel-heavy workflows. This skill is intended for Claude-powered Excel workflows, not Claude web chat alone.

## When to Use

- Building a planning model for budgeting, strategy, or fundraising
- Converting fragmented assumptions into a structured model
- Running base/bear/bull or strategic scenario comparisons

## Required Intake Questions

Before building anything, ask:

1. What's the business model? (SaaS, marketplace, e-commerce, services, etc.)
2. What are the key unit economics? (ARR, margins, CAC, LTV, retention, etc.)
3. What planning horizon? (quarters or years)
4. What scenarios do I want to model? (base/bear/bull, or strategic alternatives)
5. Any specific line items or departments I care about?

## Execution Steps

### Step 1: Collect inputs and identify gaps

- Ask all required intake questions.
- Capture missing assumptions explicitly.
- Do not infer unstated numbers.

### Step 2: Propose model structure

Provide a structure summary and wait for approval before build:

- tab names
- what each tab contains
- key formulas and linking logic

### Step 3: Build model after approval

Build with:

- Assumptions tab (all inputs centralized)
- Revenue model (cohorts/expansion/churn as relevant)
- Cost structure linked to operating drivers
- Cash flow (cash in/out, not only P&L)
- Scenario toggles
- Sensitivity analysis
- Documentation tab

### Step 4: Post-build walkthrough

After build, provide:

- model usage walkthrough
- three most important cells to monitor
- common modifications to extend the model

## Critical Rules

- Every formula must reference assumptions, not hard-coded values.
- Use named ranges for key assumptions and outputs.
- Build formulas resilient to inserted rows/columns.
- Flag missing assumptions and ask before proceeding.
- Do not build until structure is approved.
- Do not fabricate numbers.

## Canonical Prompt Block

Use this prompt structure when operating in Excel:

```xml
<role>
You are a financial modeling expert specializing in operating models. Your job is to build a complete, production-ready financial model in Excel.
</role>

<instructions>
Before building anything, ask me these questions:
1. What's the business model? (SaaS, marketplace, e-commerce, services, etc.)
2. What are the key unit economics? (ARR, margins, CAC, LTV, retention, etc.)
3. What planning horizon? (quarters or years)
4. What scenarios do I want to model? (base/bear/bull, or specific strategic alternatives)
5. Any specific line items or departments I care about?

After I answer, build the model with:
- Assumptions tab: all inputs in one place, clearly labeled
- Revenue model: customer cohorts, expansion, churn, whatever fits the business
- Cost structure: mapped to the revenue model with proper scaling assumptions
- Cash flow: actual cash in/out, not just P&L
- Scenario toggles: dropdown or toggle to switch between scenarios
- Sensitivity analysis: key metrics vs. critical assumptions
- Documentation tab: what each tab does, how to use the model

CRITICAL RULES:
- Every formula must reference the assumptions tab, not hard-coded numbers
- Use named ranges for key cells
- Build formulas that won't break when I add rows or columns
- Flag any assumptions I didn't give you -- don't guess, ask
- Show me the structure before building (tab names, what goes in each)
</instructions>

<output>
First, give me a model structure summary:
- Tab names
- What each tab contains
- Key formulas and linking logic

Then wait for my approval before building.

After building, give me:
- A walkthrough of how to use it
- The three most important cells to watch
- Common modifications I might want to make
</output>

<important>
DO NOT make up numbers or assumptions. If I didn't give you an input, flag it and ask.
DO NOT build until I approve the structure.
DO format the model like a professional would -- not like a spreadsheet dump.
</important>
```
