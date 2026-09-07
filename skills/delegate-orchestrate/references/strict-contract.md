# Extended delegation contract

Load only relevant sections. This is an opt-in extension to the four-field
brief, not a mandatory form for every worker.

## Coordination and effects

```text
task_id: [stable identifier]
goal: [outcome]
context: [checkout and evidence; inherited and missing context]
boundaries: [authorized changes and external side effects]
done_when: [acceptance and verification]
file_ownership:
  exclusive_write: [paths in the named checkout]
  read_only_allowed: [relevant sources]
  forbidden: [explicit exclusions]
execution:
  isolation: [shared checkout / separate worktree / other supported mode]
  depends_on: [tasks or contracts that must complete first]
  shared_resources: [git index, database, ports, services, generated outputs]
  integration_owner: [who combines and verifies changes]
  integration_order: [prerequisites and merge/test order]
recovery:
  budget: [time/cost bounds if provided or agreed]
  checkpoint: [when to report progress or changed assumptions]
  escalate_when: [needs new authority or cannot progress within boundaries]
  rollback: [if the assignment has effects that require recovery]
return_contract: [human report or exact schema/version and its consumer]
```

For a read-only assignment, prohibit writes to generated artifacts as well as
source. Configure real permissions at the host layer where supported; these
fields are coordination policy, not a sandbox. Permission to edit source
does not imply permission to publish, commit, or mutate a service.

Retry based on new evidence. Stop repeating an unchanged failing approach;
report the blocker and the smallest useful next action. There is no universal
two-search or two-test cutoff. A worker may request a boundary change but
must not make that change unilaterally.

## Optional machine return

Agree the exact schema with the consumer before dispatch. Prefer native
structured output. When only text is available, parse and validate the result,
and request repair on invalid output before treating the task as complete.
Do not mix status updates into the final JSON payload.

Example v0.2 envelope:

```json
{
  "schema_version": "delegate-kit/2",
  "task_id": "example-task",
  "status": "done",
  "result": "The requested result",
  "evidence": [],
  "limitations": [],
  "blocked_on": ""
}
```

Consumer requirements: all fields required; version literal as above; task_id
must match the assignment; status is done, partially_done, or blocked; result
and blocked_on are strings; evidence and limitations are arrays of strings.
A blocked result needs nonempty blocked_on; otherwise use an empty string and
put incomplete work in limitations. Require evidence appropriate to acceptance
before accepting done. Add role-specific fields only by agreement with the
consumer, including their types and validation rules. This document does not
provide a schema validator or runtime enforcement.

## v0.1 compatibility

v0.2 prose reports and the example envelope are NOT drop-in replacements for
v0.1 role schemas. For an existing v0.1 runtime (including delegate-flow unless
it explicitly supports v0.2), use its exact expected schema and brief, or pin
delegate-kit to revision `b989426`. Do not assume it accepts new fields.
Historical examples retain their original output format.
