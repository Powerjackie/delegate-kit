# Notes: dk-v01-lessons-20260515

Second real-run eval of the delegate-kit skill suite. First was
`dk-v01-finalize-20260515` (Standard/Executor, multi-file + git commit);
this one was deliberately scoped as Light/Executor (two markdown insertions,
no git) to stress-test the smaller end of the brief-size axis.

## Outcome

- Status `done`. All 5 validation commands returned exit 0.
- `SUBAGENT_PLAYBOOK.md` gained §13 with the validation-command lesson (+18 lines).
- `CONTRIBUTING.md` gained the "Brief-authoring gotchas" section between
  Style and Repo conventions (+23 lines).
- Worker honored `file_ownership.forbidden` — no leak.
- No git operations were performed (brief explicitly forbade them).

## Observations for v0.2

### 1. Description triggering was not actually tested in this run

The main agent invoked `Agent` tool directly with the brief as the prompt;
it did not let Claude Code's skill-loading mechanism match `delegate-execute`'s
description against the user request. So this eval validates **brief
structure** and **worker compliance**, not **description routing**. The
next real-run test should be initiated from a fresh Claude Code session
with a natural user prompt (e.g., "派一个 subagent 把…记到…"), to
observe whether `delegate-execute` auto-loads.

### 2. "Light" is about complexity, not byte count

The SUBAGENT_PLAYBOOK §8 Light template suggests 20-40 line briefs. This
brief came in around 80 lines — most of the bloat was verbatim content
the subagent had to paste literally. Decision complexity was still Light
(2 atomic insertions, 1 grep predicate per check).

Proposed v0.2 wording change: replace §3's "Brief size" column with
"Decision complexity" or "Logical branches". Byte count is a noisy proxy.

### 3. Verbatim insertion blocks should be visually distinct

Inside the brief, "this is content to paste" and "this is guidance to
the worker" are intermixed. The worker handled it correctly here, but a
clearer convention would reduce ambiguity. Candidate convention for v0.2:

```
INSERT VERBATIM (do not paraphrase, do not edit):
---
<content>
---
```

vs. plain prose elsewhere being instructions.

### 4. Pre-completion vs post-completion state — second sighting

The first eval's `git_commit_spec` baked "No real-run eval yet" into the
commit message body. That line is now permanently in `dcb052c`'s history,
ironic because the commit itself is part of the eval. Not amending (single
commit, low harm), but worth noting as a real cost of the staleness
anti-pattern just documented in CONTRIBUTING.md.

## What this run did NOT test

- Parallel dispatch (file_ownership disjoint-set rule).
- Forbidden-path enforcement under pressure (worker stayed in bounds without
  the wall ever being tested).
- Research and Reviewer role skills.
- Cross-platform install scripts on Linux/Windows.
- Skill description auto-loading by Claude Code (see Observation 1).

These remain open for v0.2 / v0.3 evals.
