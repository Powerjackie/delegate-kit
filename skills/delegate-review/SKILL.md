---
name: delegate-review
description: Write a brief for a Reviewer subagent — validate an existing artifact against a rubric (PR diff review, pre-merge audit, design-doc critique, security scan of a specific module, scorecard for candidate approaches). Use after delegate-orchestrate has classified the task as Reviewer role, or when the user asks to "review", "audit", "score", "validate", "审查", or "评审" with no implementation expected. The subagent reads artifacts and rubric, returns a scorecard + conflicts + merge recommendation as structured JSON. Do not use for exploration (use delegate-research) or to fix issues found (dispatch a separate delegate-execute brief).
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

## 0) When to use this skill

Read this skill when drafting a brief for a Reviewer subagent — a subagent
that **never edits**; it consumes artifacts (diff, file, PR, design doc,
multiple subagents' outputs) and returns a structured judgment.

## 1) Reviewer brief template

```
task_id: <slug-YYYYMMDD-N>
parent_task: <one-sentence goal stated in MAIN agent's terms>
subagent_role: reviewer

objective: |
  <what specifically to review and what decision the main agent needs, 1-3 lines>

artifacts:
  - kind: <one of: diff | file | pr | merge-candidates | design-doc>
    ref: <path, commit SHA, PR URL, or list of task_ids>
  # multiple artifacts allowed; reviewer compares them when kind=merge-candidates

rubric:
  - dimension: correctness
    weight: <0..1>
    check: <how to assess>
  - dimension: completeness
    weight: <0..1>
    check: <...>
  - dimension: safety
    weight: <0..1>
    check: <e.g., secrets, injection, destructive ops>
  - dimension: <add project-specific dimension, e.g., performance, style>
    weight: <0..1>
    check: <...>

acceptance_criteria:
  - [ ] Each artifact scored on every rubric dimension.
  - [ ] Every "fail" or "concern" cites specific path / line / hunk.
  - [ ] Output includes one of: approve | request_changes | block, with reason.
  - [ ] If artifacts conflict, list conflicts with a recommended resolution.

scope:
  you_may_not:
    - edit any file
    - run destructive commands
    - re-spawn subagents to "verify" findings
  you_must:
    - cite a path:line for every "fail" or "concern"
    - score conservatively when evidence is missing (don't pad scores)

stop_conditions:
  - all rubric dimensions scored on every artifact
  - or required artifacts are unreadable (then status=blocked)
```

## 2) Required output schema (Reviewer)

Reviewer subagent MUST return exactly this JSON shape:

```json
{
  "task_id": "<short-id>",
  "status": "<one of: done | blocked | partially_done>",
  "summary": "<one paragraph in plain prose>",
  "recommendation": "<one of: approve | request_changes | block>",
  "recommendation_reason": "<one or two sentences>",
  "scorecard": [
    {
      "artifact": "<ref from brief>",
      "dimension": "<from rubric>",
      "score": "<one of: pass | concern | fail>",
      "evidence": "<path:line or hunk reference>",
      "note": "<short explanation>"
    }
  ],
  "conflicts": [
    {
      "field_or_decision": "<what conflicts between artifacts>",
      "options": ["<artifact-A says>", "<artifact-B says>"],
      "recommendation": "<which option, and why>"
    }
  ],
  "risks": [],
  "followups": [
    "<fix to dispatch separately, with suggested role>"
  ],
  "blocked_on": ""
}
```

## 3) Anti-patterns to reject in your own brief

- Rubric dimensions with no `check` → reviewer will fabricate criteria.
- All rubric weights = 1.0 → no signal in aggregation.
- Asking Reviewer to "fix what you find" → scope drift; the contract is
  judgment, not implementation.
- Missing `artifacts.ref` (just kind, no concrete path/SHA/URL) → reviewer
  has nothing to read.
- Combining "review the PR AND summarize what it does" → these are
  different tasks; the second is Research role.
