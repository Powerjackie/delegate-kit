---
name: delegate-execute
description: Prepare a bounded implementation assignment for an Executor subagent after delegation has been chosen, or when the user explicitly requests an implementation handoff. Defines authorized changes and acceptance evidence. Do not load for ordinary inline coding, open-ended planning, or a read-only review.
---

# Delegate implementation

Use the host's native worker mechanism. Do not initiate delegation solely
because this skill loaded. Default to a short brief:

```text
goal: [specific behavior to change, with symptom or reproduction]
context: [checkout, read-first files and relevant existing patterns]
boundaries: [owned files/module, exclusions and authorized side effects]
done_when: [observable behavior and risk-appropriate validation]
```

Choose a coherent module boundary; do not enumerate every file before enough
investigation has occurred. Reading and diagnosis within scope are part of
implementation. Avoid unrelated refactors and preserve other people's edits.
Tests, documentation and memory updates must be included in ownership if the
task requires them. Do not silently broaden scope to finish housekeeping.

For concurrent writers or shared contracts, read
`../delegate-orchestrate/references/strict-contract.md`. Identify checkout
isolation and shared resources as well as files. Only an assigned integration
owner should commit combined work in a shared checkout, when authorized.

The worker should:

- Read before editing and use existing project patterns.
- Make the smallest coherent change that satisfies acceptance.
- Validate behavior proportionately to risk. Report tests not run and why;
  do not add ceremonial tests for prose or remove tests to conceal failure.
- Investigate failures while a plausible next step remains within scope.
  Escalate when authority, dependencies or missing information block progress.
- Report adjacent issues without silently taking ownership of them.

Default final report: done / partially_done / blocked; changes; verification
evidence; remaining limitations. Include paths, exact test commands and
outcomes where useful. Completion is a claim the parent must verify against
the resulting artifacts. If the caller specifies a machine schema, follow
that exact contract instead of this prose format.
