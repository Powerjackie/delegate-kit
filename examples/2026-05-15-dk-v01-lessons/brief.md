# Brief: dk-v01-lessons-20260515

- **Role:** Executor (Light)
- **Dispatched:** 2026-05-15
- **Dispatcher:** main Claude Code session (this repo's author)
- **Subagent type:** `general-purpose` (Claude Code built-in)
- **Outcome:** done — see `output.json` and `notes.md`

## What this brief is doing in the repo

This is the **second** real-run eval of the delegate-kit skill suite. Its
job was to capture two lessons surfaced by the first eval (the v0.1
finalization run, commit `62e6355`) into the two appropriate homes:

- A workspace-level lesson (`SUBAGENT_PLAYBOOK.md` §13) about validation
  command authoring.
- A project-level lesson (`CONTRIBUTING.md` "Brief-authoring gotchas")
  about self-referential staleness.

## Brief content (verbatim as sent to the subagent)

```
You are a subagent. You have no parent-chat context.

Task: Append two lessons captured from the delegate-kit v0.1 bootstrap eval —
one to a workspace-level playbook, one to delegate-kit's CONTRIBUTING.md.

Target files (exclusive_write):
- /Users/lawson/Workspace/.agent-memory/SUBAGENT_PLAYBOOK.md
- /Users/lawson/Workspace/repos/delegate-kit/CONTRIBUTING.md

Read-only allowed (context):
- /Users/lawson/Workspace/.agent-memory/PITFALLS.md  (tone reference)
- /Users/lawson/Workspace/repos/delegate-kit/.agent-memory/HANDOVER.md  (eval reference)

Forbidden (do not modify):
- any file under skills/, install/, examples/ in delegate-kit
- delegate-kit README, LICENSE, .gitignore
- any other workspace file outside the two exclusive_write targets
- any other project (stat-translate, dual_so101_thesis, portable-project-bootstrap)

Change (1) — append to /Users/lawson/Workspace/.agent-memory/SUBAGENT_PLAYBOOK.md
A new top-level section AFTER the existing "## 12. Memory update rule".
Section header EXACTLY:
    ## 13. Lessons from real-run evals
Sub-heading EXACTLY:
    ### Validation command authoring (2026-05-15, delegate-kit v0.1 bootstrap)
Body (insert verbatim; preserve the backticks and the example):

    When authoring `validation_commands` or similar verification steps:
    - Query semantic content (`grep`, `awk`, exit codes), not byte/line
      positions (`head -N`, `wc -l`).
    - Files with preambles/headers (e.g., HANDOVER.md, README.md) silently
      invalidate line-position commands.
    - Validation must fail loud when target state is absent, not produce a
      noisy false-positive log.

    **Example of the bug.** `head -5 HANDOVER.md  # expect 2026-05-15 mention`
    fails because the file begins with a 5-line preamble. The line range
    never reaches the target section. Correct form:
    `grep -q '^\*\*2026-05-15\*\*' HANDOVER.md`.

Change (2) — insert into /Users/lawson/Workspace/repos/delegate-kit/CONTRIBUTING.md
A new section BETWEEN the existing "## Style" and "## Repo conventions" sections.
Section header EXACTLY:
    ## Brief-authoring gotchas (from real runs)
Body (insert verbatim):

    These are lessons captured from actual delegation runs. Add to this
    section when a real eval surfaces a new gotcha.

    ### Don't bake pre-completion state into completion artifacts

    A brief that produces a status artifact (HANDOVER update, commit message,
    CHANGELOG line, README badge, etc.) must not hard-code "pending" or
    "awaits eval" text into that artifact — because the artifact's existence
    is the proof that the task is complete.

    **Wrong.** A brief instructs the worker to write
    `"v0.1 awaits first real-run eval"` into HANDOVER, while the brief's own
    completion *is* the first eval. The text is obsolete the moment it lands.

    **Right.** Either (a) hard-code post-completion truth
    (`"v0.1 eval complete — see commit X"`), or (b) have the worker compute
    the status string from its own success path so it can write "done" only
    if it actually finished.

    (Origin: delegate-kit v0.1 bootstrap eval, 2026-05-15. See workspace
    SUBAGENT_PLAYBOOK §13 for the related validation-command lesson.)

Do not touch:
- Any existing section of either file beyond the two specified insertions.
- Existing section numbering 1–12 of SUBAGENT_PLAYBOOK.md (your insertion is §13).
- Git in any way (no commit, no push, no stage).

Validation (run each, all must pass):
- grep -c '^## 13\.' /Users/lawson/Workspace/.agent-memory/SUBAGENT_PLAYBOOK.md          # expect 1
- grep -q 'Validation command authoring' /Users/lawson/Workspace/.agent-memory/SUBAGENT_PLAYBOOK.md
- grep -q 'Brief-authoring gotchas' /Users/lawson/Workspace/repos/delegate-kit/CONTRIBUTING.md
- grep -q "Don't bake pre-completion state" /Users/lawson/Workspace/repos/delegate-kit/CONTRIBUTING.md
- grep -c '^## [0-9]\+\.' /Users/lawson/Workspace/.agent-memory/SUBAGENT_PLAYBOOK.md      # expect 13

Report (fenced JSON, exact shape):
{
  "task_id": "dk-v01-lessons-20260515",
  "status": "<one of: done | blocked | partially_done>",
  "summary": "<one paragraph>",
  "changed_files": [
    {"path": "<absolute path>", "lines_added": <int>, "summary": "<one line>"}
  ],
  "validation_results": [
    {"command": "<exact command>", "exit_code": <int>, "result": "<pass|fail>"}
  ],
  "risks": [],
  "followups": [],
  "blocked_on": ""
}

Escalation:
- If "## 12. Memory update rule" is not present in SUBAGENT_PLAYBOOK, STOP and report — do not guess insertion location.
- If "## Style" or "## Repo conventions" not present in CONTRIBUTING.md, STOP and report — do not guess.
- If any validation command fails, STOP after first try and report status=partially_done with which command failed.
```
