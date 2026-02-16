# Learnings

[![Validate Learnings](https://github.com/kas1987/agentops/actions/workflows/validate-learnings.yml/badge.svg)](https://github.com/kas1987/agentops/actions/workflows/validate-learnings.yml)

Curated learnings captured from external research, videos, and long-form analysis.

## Standards

- Filename format: `kebab-case-topic.md`
- Required sections: thesis, claims, implications, decision rules, action plan, risks
- Quality gate: run the checklist before commit
- Preferred structure: start from the learning template

## Entries

- [Job Market Split: From Production to Specification Bottleneck](job-market-split-specification-bottleneck.md) — Why specification skill becomes the scarce resource as production cost collapses.
- [Codex 5.3 vs Opus 4.6: Two Agent Philosophies](codex-53-vs-opus-46-two-agent-philosophies.md) — Delegation vs coordination architectures, plus a workflow routing framework.
- [Escape the Application Pile: Own Your Interface Layer](escape-the-application-pile-own-interface-layer.md) — Why interface ownership beats ATS optimization in attention-constrained hiring markets.

## Authoring Aids

- [Learning Template](../templates/learning.template.md)
- [Learnings Quality Checklist](CHECKLIST.md)

## How to Use

- Start with the two entries above to understand the core shift in knowledge work.
- Use the workflow routing ideas to classify tasks as delegation, coordination, or hybrid.
- Revisit these notes when updating team operating models and tool choices.

## Capture Workflow

1. Create a new note from the [Learning Template](../templates/learning.template.md).
2. Fill source metadata and extract key claims with evidence.
3. Add decision rules and an action plan.
4. Run the [Learnings Quality Checklist](CHECKLIST.md).
5. Run `./scripts/validate-learnings.sh` from repo root.
6. Add the new entry to this index and commit.

## Automation

- Local gate: `bash ./scripts/validate-learnings.sh`
- CI gate: `.github/workflows/validate-learnings.yml`
- Trigger scope: learnings docs, learning template, docs index, and validator script changes
