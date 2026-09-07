---
name: delegate-review
description: Prepare an independent review assignment for a subagent after delegation has been chosen, or when the user explicitly requests a delegated artifact review. Defines the artifact, acceptance criteria, and evidence needed for findings. Do not load for ordinary inline review or implementation of fixes.
---

# Delegate an independent check

Name the artifact and the decision the review supports. Do not initiate
delegation solely because this skill loaded.

```text
goal: [what judgment is needed]
context: [artifact path or revision, base revision, acceptance and constraints]
boundaries: [read-only scope and whether side-effecting validation is allowed]
done_when: [concrete findings with evidence, or no findings plus coverage limits]
```

Review against acceptance and actual behavior. Prioritize correctness,
regressions and missing validation. Explain a finding's trigger, impact and
supporting file:line or reproducible evidence. Distinguish confirmed defects
from questions and hypotheses. Do not manufacture findings to fill a rubric.

Default final report: completion status; findings ordered by severity;
checks performed and coverage limits; recommendation if requested. A clean
review means no issues found within that coverage, not proof of correctness.
Summarizing enough context to explain a finding is part of review.

Use a scorecard only when comparing candidates or when the caller requests
one. Define dimensions and checks first; introduce numeric weights only when
an actual aggregation rule and decision threshold need them.

Keep implementation separate from an independent review assignment. Return
actionable findings to the parent, which can authorize fixes and determine
whether another verification pass is needed. Follow an explicit machine
schema when a consumer requires it; otherwise concise prose is sufficient.
