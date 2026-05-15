# Notes: dk-v01-finalize-20260515

First real-run eval of the delegate-kit skill suite. Standard/Executor:
finalize v0.1 scaffolding by writing three docs and making the initial
git commit. Run produced commit `dcb052c`.

This archive was created retroactively (after the second eval,
`dk-v01-lessons`, establish the per-run example layout). See `brief.md`
"Reconstruction notes" for caveats.

## Outcome

- Status `done`. Six ADR entries persisted, workspace HANDOVER updated,
  examples/README.md replaced, initial commit landed.
- All six acceptance criteria met per main-agent verification at the time.
- Worker honored `file_ownership.forbidden` — no skill/install/README/LICENSE
  modifications. Git tree was clean post-commit (modulo `.agent-memory/`).

## What this run revealed

### 1. Validation commands must query semantics, not byte positions

The brief's `validation_commands` included
`head -5 /Users/lawson/Workspace/.agent-memory/HANDOVER.md  # expect 2026-05-15 mention`.
That file has a 5-line preamble before the stop-point section, so `head -5`
cannot reach the target text. The command would always exit 0 (showing
the preamble) regardless of whether the worker updated the file correctly.

Worker passed this check by semantic judgment, not by the literal command.
A stricter worker reading the command literally and concluding "exit 0 ==
pass" could have silently failed.

**Captured as workspace SUBAGENT_PLAYBOOK §13.**

### 2. Self-referential staleness — pre-completion state in completion artifacts

The brief's `workspace_handover_update_spec` told the worker to write
"v0.1 awaits first real-run eval (next non-trivial delegation task)" into
the workspace HANDOVER. The brief's own completion *was* the first eval,
so this line was obsolete the moment it was written. The user manually
corrected HANDOVER post-hoc.

The same anti-pattern still lives in `dcb052c`'s commit message body:
`"No real-run eval yet; v0.2 follows first delegation."` Not amending —
root commit, low marginal harm, useful as a permanent example of the
anti-pattern in the project's own git history.

**Captured as delegate-kit CONTRIBUTING.md "Brief-authoring gotchas".**

### 3. Local-auto-config git identity

Commit `dcb052c` was made under `lawson <lawson@lawsondeMacBook-Air.local>`,
git's auto-derived identity from system hostname. Hostname leak in OSS
commit history is undesirable.

**Remediation**: subsequent commits (9a9d9dc and onward) use
`Powerjackie <Powerjackie@users.noreply.github.com>` via
`git config --local`. Earlier commits remain under the old identity
unless explicitly rebased + amended before remote push.

## What this run did NOT test

- Description triggering of `delegate-execute` skill (worker received the
  brief as a direct prompt; skill auto-load was not exercised).
- Parallel dispatch.
- File ownership rejection (worker stayed in bounds without testing the
  wall).
- Research and Reviewer role skills.
- Cross-platform install scripts.

## Cross-reference

The second eval `dk-v01-lessons-20260515` (archived in
`../2026-05-15-dk-v01-lessons/`) was a smaller Light/Executor run that
captured the lessons from this eval into durable docs. See its
`notes.md` for v0.2 candidates.
