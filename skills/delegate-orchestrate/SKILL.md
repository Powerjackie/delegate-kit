---
name: delegate-orchestrate
description: Plan delegation when the user asks to delegate, parallelize, spawn subagents, or split independent work (派 subagent, 并行派工). Selects a minimal brief, checks dependencies and isolation, and verifies evidence. Do not load for ordinary implementation, research, or review unless delegation is requested or has a clear benefit.
---

# Delegate with the smallest useful contract

Use the host's native agent tools. This skill supplies coordination guidance,
not a scheduler, permission system, or substitute for the user's instructions.

## Decide whether delegation helps

Keep work inline when dispatch, context transfer, and integration cost exceed
the benefit. File count alone is not a trigger. Delegate independent work,
noisy exploration, or an independent check when it improves the outcome.
Do not spawn an agent just to follow this skill.

Before dispatch, inspect available tools: context inheritance, isolation,
permissions, communication, resume/cancel support, and model selection.
Do not assume a tool named Agent exists or invent unsupported parameters.
If delegation is unavailable, continue inline within authorization and report
that limitation. Never claim a delegation occurred when it did not.

## Default brief

For a bounded task, these four fields are enough; reuse a native tool's
equivalent fields rather than duplicate them:

```text
goal: [question to answer or outcome to deliver]
context: [repo/worktree, read-first files, relevant decisions or evidence]
boundaries: [allowed changes and side effects; exclusions]
done_when: [observable acceptance and required verification]
```

Include missing context, not a transcript dump. Check what the worker inherits;
explicitly state the goal and boundaries even when history is inherited.
Read only the relevant role guide when it adds value:
`../delegate-research/SKILL.md`, `../delegate-execute/SKILL.md`, or
`../delegate-review/SKILL.md`. Roles describe this assignment, not permanent
model identities. Routine investigation may be part of implementation.

Load `references/strict-contract.md` only for shared contracts, external side
effects, costly recovery, complex dependencies, or machine-consumed results.
Do not silently change a schema expected by an existing consumer.

## Coordinate execution

- In a shared checkout, assign non-overlapping write ownership. Also check
  shared interfaces, generated files, git index, databases, ports and services.
  Different files do not imply independent behavior.
- In separate worktrees, overlapping paths are possible. Name an integration
  owner and a merge/test order before dispatch. Worktrees do not isolate
  external services or make semantic conflicts disappear.
- Serialize dependent work until its prerequisite contract is settled. For
  uncertainty, delegate discovery first and update the plan from evidence.
- Choose concurrency from independent work, host limits, budget and ability
  to integrate results. There is no universal numeric fan-out limit.
- Choose a supported model for reasoning difficulty, error cost and budget.
  Simple inventory and architectural research need different capabilities.
  Respect user selection; leave host defaults when selection is unavailable.
- Use native progress messages and resume where supported. On a scope change,
  revise affected assignments and cancel obsolete work. Resolve permission
  or scope expansions through the parent within the user's authorization.

## Return and verify

Default return: completion status, result, evidence, and unresolved limits.
Concise prose is fine. Use structured output only when a consumer needs it;
prefer a host-enforced schema, otherwise validate JSON before consuming it.
A fenced block alone is not schema enforcement.

The parent checks acceptance against artifacts, diffs and meaningful tests.
After parallel implementation, verify the integrated state, not just individual
reports. Do not repeat expensive checks without a reason. Distinguish task
completion, protocol adherence and measured benefit; none proves the others.
Update project continuity when durable state changes, within declared scope.
