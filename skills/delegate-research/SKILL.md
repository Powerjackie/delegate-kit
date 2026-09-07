---
name: delegate-research
description: Prepare a read-only investigation assignment after delegation has been chosen, or when the user explicitly asks a subagent to investigate, trace dependencies, or compare approaches. Requires evidence and explicit uncertainty. Do not load for ordinary inline research or implementation.
---

# Delegate investigation

Ask a bounded question that supports a decision. Do not initiate delegation
solely because this skill loaded.

```text
goal: [question to answer and the decision it informs]
context: [checkout, sources, existing evidence and relevant constraints]
boundaries: [read scope; no file or external-state changes]
done_when: [questions answered with evidence or explicit unresolved gaps]
```

Let the worker choose useful searches rather than prescribe every query.
Inspect available read-only tools; shell commands and tests may write caches
or artifacts even when used for investigation. Do not assume a role label or
skill frontmatter enforces permissions.

Require primary evidence for factual claims: file and line, test observation,
or source URL as appropriate. Separate observation, inference and uncertainty.
If available sources are insufficient, say what is missing and which next
step would resolve it. Do not invent certainty to fill every field.

Stop when the question is sufficiently answered, an agreed budget is reached,
or progress needs missing access or a changed scope. Two unproductive searches
alone are not a reason to abandon an otherwise answerable question.

Default final report: completion status; findings and evidence; uncertainty;
next action if needed. Use concise prose or a comparison table. Follow an
explicit consumer schema when provided. Research complexity determines model
needs; repository inventory and architectural synthesis are different tasks.
