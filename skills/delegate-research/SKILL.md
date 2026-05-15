---
name: delegate-research
description: Write a brief for a Research subagent — read-only codebase exploration, evidence gathering, dependency tracing, audit-style investigation, or candidate-approach comparison. Use after delegate-orchestrate has classified the task as Research role, or when the user directly asks to "investigate", "explore", "audit", "trace", or "调研" with no writes expected. The subagent returns findings + evidence as structured JSON; main agent merges. Do not use when implementation/writes are needed (use delegate-execute) or when validating an existing artifact (use delegate-review).
allowed-tools:
  - Read
  - Grep
  - Glob
---

## 0) When to use this skill

Read this skill when drafting a brief for a Research subagent. A Research
subagent **never writes files**; it returns evidence and findings as JSON.

## 1) Research brief template

```
task_id: <slug-YYYYMMDD-N>
parent_task: <one-sentence goal stated in MAIN agent's terms>
subagent_role: research

objective: |
  <what specific question the main agent needs answered, in 1-3 lines>

questions_to_answer:
  - <question 1>
  - <question 2>

acceptance_criteria:
  - [ ] Each listed question has an answer in `key_findings`.
  - [ ] Each finding cites at least one path or line range as evidence.
  - [ ] Output is fenced JSON; no narrative outside the JSON block.

file_ownership:
  exclusive_write: []        # always empty for research
  read_only_allowed:
    - <glob or path>
  forbidden:
    - <e.g., .env, secrets/**, anything off-scope>

scope:
  you_may_not:
    - edit any file
    - run destructive commands
    - spawn further subagents
  you_must:
    - cite paths or line ranges for every claim
    - return JSON only; no prose

evidence_quality:
  - prefer primary source (actual file contents) over inference
  - if you cannot find evidence, say so explicitly in `gaps`

stop_conditions:
  - all `questions_to_answer` have a finding
  - or two consecutive searches yield no new evidence
```

## 2) Required output schema (Research)

Research subagent MUST return exactly this JSON shape:

```json
{
  "task_id": "<short-id>",
  "status": "<one of: done | blocked | partially_done>",
  "summary": "<one paragraph in plain prose>",
  "key_findings": [
    {
      "claim": "<one-line finding>",
      "evidence": ["<path:line-range or path>", "..."],
      "confidence": "<one of: high | medium | low>"
    }
  ],
  "gaps": [
    "<question that couldn't be answered, and why>"
  ],
  "followups": [
    "<next investigation step the main agent should consider>"
  ],
  "risks": [],
  "blocked_on": ""
}
```

## 3) Anti-patterns to reject in your own brief

- Long-form prose questions ("understand the auth flow") → instead enumerate
  3-5 specific sub-questions.
- No `file_ownership.read_only_allowed` glob → subagent will wander.
- Missing `evidence_quality` clause → findings will be unverifiable inference.
- Asking the Research subagent to "also implement a small fix" → that's
  scope drift; spawn a separate `delegate-execute` brief instead.
