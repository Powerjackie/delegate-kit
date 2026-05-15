---
name: delegate-execute
description: Write a brief for an Executor subagent — bounded-scope implementation with explicit write permissions (bug fix in a defined directory, add a test, refactor inside a module, generate config from a template). Use after delegate-orchestrate has classified the task as Executor role, or when the user asks to "implement", "fix", "refactor in <module>", "write tests for", "add" with explicit scope. The subagent edits within declared file_ownership and returns changed_files + test results as structured JSON. Do not use for exploration (use delegate-research), validation of existing artifacts (use delegate-review), or open-scope refactors without bounded ownership.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Edit
  - Write
  - Bash
---

## 0) When to use this skill

Read this skill when drafting a brief for an Executor subagent — i.e., a
subagent allowed to **write to specific files only**, with a clear acceptance
test it must pass before reporting completion.

## 1) Executor brief template

```
task_id: <slug-YYYYMMDD-N>
parent_task: <one-sentence goal stated in MAIN agent's terms>
subagent_role: executor

objective: |
  <what specific change to make, in 1-3 lines>

problem_statement: |
  <the bug or gap, with concrete repro or symptom>

acceptance_criteria:
  - [ ] <criterion 1 — must be testable>
  - [ ] <criterion 2>
  - [ ] All listed validation commands pass.

file_ownership:
  exclusive_write:
    - <path-or-glob>      # files you may edit
  read_only_allowed:
    - <path-or-glob>      # files you may read but not edit
  forbidden:
    - <path-or-category>  # everything else: tests of unrelated modules,
                          # public schema/contract files, VERSION, RELEASES.md,
                          # migrations, .env, secrets/**, etc.

scope:
  you_may_not:
    - modify public API names, exported types, or schemas
    - introduce new dependencies
    - reformat unrelated code
    - bump versions, tag, push, merge
  you_must:
    - keep diff minimal
    - preserve existing behavior except where acceptance_criteria require change
    - update or add tests for new behavior
    - never delete tests to make work pass

validation_commands:
  - <repo-relative command, e.g., `pytest tests/<module> -q`>
  - <e.g., `npm test -- <scope>`>
  - <e.g., `ruff check src/<module>`>

escalation_rules:
  - If you must edit a `forbidden` path, stop and report — do not edit.
  - If validation fails twice with no progress, stop and report — do not
    expand scope.
  - If you discover a related bug outside `exclusive_write`, list it in
    `followups`; do not fix it inline.
```

## 2) Required output schema (Executor)

Executor subagent MUST return exactly this JSON shape:

```json
{
  "task_id": "<short-id>",
  "status": "<one of: done | blocked | partially_done>",
  "summary": "<one paragraph in plain prose>",
  "changed_files": [
    {"path": "<path>", "change": "<one-line description of what changed>"}
  ],
  "tests_run": [
    {
      "command": "<exact command>",
      "result": "<one of: pass | fail | not_run>",
      "log_excerpt": "<last ~10 lines if fail, empty if pass>"
    }
  ],
  "acceptance_check": [
    {
      "criterion": "<verbatim from brief>",
      "met": "<one of: yes | no | partial>",
      "evidence": "<file:line or test name>"
    }
  ],
  "risks": [
    "<known issue you did not address, with reason>"
  ],
  "followups": [
    "<related fix the main agent might want to dispatch separately>"
  ],
  "blocked_on": ""
}
```

## 3) Anti-patterns to reject in your own brief

- `file_ownership.exclusive_write` left as a single broad glob like `src/**`
  → too permissive; narrow to the actual module.
- No `validation_commands` → "done" becomes unverifiable.
- Acceptance criterion written as "fix the bug" without a test → not testable.
- Asking Executor to "also document this in README" → scope drift; either
  add README to `exclusive_write` explicitly, or dispatch a follow-up.
- Omitting `escalation_rules` → subagent will silently expand scope on
  the first roadblock.
