# --test-first Experiment Metrics

> Track these metrics for each epic run with `--test-first` to evaluate Phase 1.

## Per-Epic Template

Copy this table for each epic run:

| Metric | Value | Notes |
|--------|-------|-------|
| **Epic ID** | | |
| **Date** | | |
| **Issues (spec-eligible / total)** | | |
| **assertion_gap_rate** | | % of tests that validate a subset of contract invariants (lower = better) |
| **copy_not_delete_rate** | | % of workers that copy instead of extract/move (lower = better) |
| **cycle_time_delta** | | % time overhead vs comparable non-TDD epic (lower = better) |
| **red_gate_pass_rate** | | % of TEST WAVE outputs that pass RED gate on first try (higher = better) |
| **spec_blocked_rate** | | % of SPEC WAVE workers that wrote BLOCKED (lower = better) |
| **green_gate_pass_rate** | | % of IMPL WAVE outputs that pass GREEN gate on first try (higher = better) |
| **worker_count** | | Total workers spawned across all waves |
| **wave_count** | | Total waves (SPEC + TEST + IMPL) |

## Collection Instructions

- **assertion_gap_rate:** Compare each contract's invariant count to test assertion count. If contract has 5 invariants but tests check 3, gap = 40%.
- **copy_not_delete_rate:** After IMPL WAVE, `git diff` should show deletions from source. If only additions, worker copied instead of extracted.
- **cycle_time_delta:** Compare wall-clock time to a similar-sized epic without --test-first. Express as percentage overhead.
- **red_gate_pass_rate:** Count issues where TEST WAVE tests all failed on first run / total spec-eligible issues.
- **spec_blocked_rate:** Count SPEC WAVE BLOCKED outputs / total spec-eligible issues.
- **green_gate_pass_rate:** Count issues where IMPL WAVE tests all passed on first run / total spec-eligible issues.

## Phase 1 Graduation Criteria

Run on **3-5 epics**, then evaluate:

| Criterion | Threshold | Action |
|-----------|-----------|--------|
| assertion_gap_rate < 10% | Target | Graduate --test-first to default |
| cycle_time_delta < 30% overhead | Target | Overhead acceptable for quality gain |
| spec_blocked_rate > 40% | Red flag | Issue descriptions need more detail, not TDD |
| red_gate_pass_rate < 50% | Red flag | Contract → test generation needs improvement |
| green_gate_pass_rate < 70% | Red flag | Contracts are too vague for implementation |

## Experiment Log

<!-- Paste per-epic tables below as you run experiments -->
