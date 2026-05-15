---
name: delegate-orchestrate
description: Decide whether and how to delegate a task to subagents. Use when the user asks to delegate, parallelize, spawn agents/subagents, run audits, compare candidate approaches, do codebase exploration that would pollute main context, hand off implementation work, or split work across Research/Executor/Reviewer roles. Also triggers on Chinese phrases like "派 subagent", "并行", "调研", "候选方案对比", "codebase 探索", "审查". Classifies task complexity, picks role, writes self-contained briefs with explicit file ownership, enforces structured JSON output for mergeable returns. Do not use for one-line fixes faster inline, tasks requiring continuous back-and-forth, or scope still fluid with frequent requirement changes.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Agent
---

## 0) Entrypoint (MAIN agent quick guide)

You are the MAIN agent. When a non-trivial task arrives:

1. Decide delegate vs keep inline (§1, §2).
2. If delegate: decide serial vs parallel (§3) and pick role (§4).
3. Choose the smallest sufficient model per subagent (§4).
4. Write a brief per subagent using the role-specific skill (`delegate-research`,
   `delegate-execute`, `delegate-review`), spawn subagents, and merge structured
   JSON outputs into a single final answer.

Cross-platform gotchas to enforce in every brief:

- Do NOT assume `cd` persists across subagent commands; use repo-relative or
  absolute paths in every command.
- Prefer cross-platform commands; avoid `sed -i`, `xargs`, `osascript`, and
  PowerShell-only one-liners when the skill must run on macOS/Linux/Windows.
- Keep briefs self-contained: no "as discussed", "use the previous plan", or
  any reference to parent-chat context.

---

## 1) Delegate triggers (when to say YES)

Delegate when ANY of:

- High cognitive load: multi-file/multi-component work or non-linear deps.
- ≥2 branches with minimal coupling (parallelizable).
- You mainly need execution artifacts (diffs/logs/tests) rather than narrative.
- You want to isolate long exploration from main context.
- The result has a fixed return interface (return a schema, not a story).

## 2) Non-delegate triggers (when to say NO)

Do NOT delegate when ANY of:

- Single-file/tiny-scope task; faster inline.
- Outcome depends on continuous conversation context that delegation dilutes.
- Requirements likely to change mid-flight; subagent will return outdated work.
- Merge/review cost likely > execution benefit.
- Only 1–3 tool actions are needed; spawn overhead dominates.

---

## 3) Serial vs parallel

- **Parallel only if** exclusive_write sets are disjoint (see role skills' `file_ownership` block).
- **Parallel only if** you can state dependencies in one sentence and they're minimal.
- If you cannot clearly express the dependency quickly, assume there IS one → serial.
- Cap parallel fan-out at **2–4** for personal-dev scenarios; beyond that, main-agent merge cost exceeds gain.

---

## 4) Roles & model tiers

Pick one role per subagent. Each role has its own brief skill — read it before
drafting the brief.

| Role | Use for | Skill | Default tier |
|---|---|---|---|
| **research** | Read-only exploration, evidence gathering, audits | `delegate-research` | Small |
| **executor** | Bounded-scope implementation + tests | `delegate-execute` | Balanced |
| **reviewer** | Validate against acceptance criteria, audit diffs | `delegate-review` | Balanced |

Model rule: step up one tier ONLY when the specific subagent's task requires
ambiguity resolution or synthesis. Default is the smallest sufficient tier.

Tier mapping (Claude Code today):

- **Small**: Haiku — research, grep-style scans, log summarization
- **Balanced**: Sonnet — implementation, review, most worker tasks
- **Premium**: Opus — only for cross-cutting architecture or final merge of conflicting outputs

---

## 5) Universal output schema (every role complies)

Every subagent MUST return exactly one fenced JSON block. Role-specific
skills may add fields, but these are required everywhere:

```json
{
  "task_id": "<short-id>",
  "status": "<one of: done | blocked | partially_done>",
  "summary": "<one-paragraph plain-text summary>",
  "risks": [],
  "followups": [],
  "blocked_on": "<populated only when status=blocked, else empty string>"
}
```

The main agent should read JSON first and only consult the subagent's prose
when JSON is ambiguous or insufficient.

---

## 6) Reminder — MAIN agent responsibilities (always)

The main agent always:

- Locks task definition and acceptance criteria up front.
- Chooses decomposition, tool permissions, and role assignments.
- Writes briefs that are self-contained (no hidden assumptions).
- Reads structured JSON before prose when merging.
- Runs final sanity checks (compile/test/grep) before reporting to user.
- Updates HANDOVER memory if the workflow changed durable project state.
