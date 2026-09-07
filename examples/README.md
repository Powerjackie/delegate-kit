# delegate-kit Examples

This directory records real delegation runs performed with the
`delegate-kit` skill suite.

Each example should show contributors what a healthy brief and subagent
output look like. These records are also the main evidence for evolving the
brief templates over time.

## Directory convention

Use one directory per real run:

```text
examples/YYYY-MM-DD-<task-slug>/
  brief.md
  output.md             # or output.json for a machine contract
  notes.md
```

## Adding an example

After a real delegation run:

1. Copy the brief sent to the subagent into `brief.md` and sanitize any secrets.
2. Save the subagent's actual full output as `output.md`, or `output.json`
   when a JSON contract was used. Do not convert prose into fabricated JSON.
3. Write `notes.md` covering which role skill triggered, whether the description matched on the first try, which fields you wished existed, and which fields felt vestigial.

The existing v0.1 examples are historical self-bootstrap runs, not evidence
that v0.2 improves performance. Preserve their original artifacts. Record
task success, protocol adherence and comparative benefit separately; see
[the evaluation plan](../docs/evaluation.md).

PRs welcome.
