# delegate-kit

> A cross-platform skill suite for delegating work to subagents in
> Claude Code and OpenCode. Classifier + Research / Executor / Reviewer
> brief templates with structured JSON outputs.

**Status:** v0.1 — scaffolding complete, two self-bootstrap evals run
(see [`examples/`](examples/)); not yet validated against unrelated
production workflows. Use at your own discretion; expect rough edges.
Feedback and example briefs welcome (see [`CONTRIBUTING.md`](CONTRIBUTING.md)).

**Runtime (Claude Code):** [delegate-flow](https://github.com/Powerjackie/delegate-flow)
runs these same briefs and schemas on the Workflow engine — file-ownership
disjointness becomes a hard gate, output shape is enforced at the tool layer, and
research findings are adversarially verified. delegate-kit defines *what to say to a
subagent*; delegate-flow defines *how to run a fleet of them, deterministically*.

## Why this exists

When you delegate a task to a subagent, three things go wrong by default:

1. **The subagent has no parent-chat context** — phrases like "as discussed
   above" silently fail.
2. **There's no enforced output shape** — the main agent has to re-read
   long transcripts to merge results.
3. **There's no agreed file-ownership contract** — parallel subagents
   conflict on shared files.

`delegate-kit` is a four-skill suite that gives a personal-development
agent loop (Claude Code, OpenCode, similar tools) a small, explicit
**delegation protocol** to address all three.

## What's inside

| Skill | Triggers on | Use it to write a brief for… |
|---|---|---|
| `delegate-orchestrate` | "delegate", "parallelize", "spawn agents", "audit", "派 subagent", "并行", "调研" | The main agent's classifier — decides whether to delegate, picks role, picks model tier, points at the role-specific skill |
| `delegate-research` | "investigate", "explore", "audit", "trace", "调研" | A **read-only** subagent that returns findings + evidence as JSON |
| `delegate-execute` | "implement", "fix in <module>", "refactor", "add tests for" | An **Executor** subagent with explicit `file_ownership` and validation commands |
| `delegate-review` | "review", "audit", "score", "validate", "审查", "评审" | A **Reviewer** subagent that scores artifacts against a rubric and gives a merge recommendation |

Each role skill ships a brief template and a required output JSON schema.
Brief templates are Markdown (human-writable, copy-pasteable); outputs are
fenced JSON (machine-mergeable by the main agent).

## Install

### Claude Code (user-level, default)

```bash
git clone https://github.com/<your-fork>/delegate-kit ~/delegate-kit
~/delegate-kit/install/claude-code.sh
```

Copies the four skills into `~/.claude/skills/`. Reload Claude Code
to pick them up.

### Claude Code (project-level)

```bash
~/delegate-kit/install/claude-code.sh --project /path/to/your/project
```

Installs into `<project>/.claude/skills/` — useful when the skills should
travel with a repo.

### OpenCode

OpenCode reads `~/.claude/skills/` by default, so the Claude Code install
usually covers it. If you've set `OPENCODE_DISABLE_CLAUDE_CODE_SKILLS=1`,
install explicitly:

```bash
~/delegate-kit/install/opencode.sh
```

### OpenAI Codex CLI

Codex uses the same SKILL.md format as Claude Code. Install into
`~/.codex/skills/`:

```bash
~/delegate-kit/install/codex.sh
```

Codex auto-discovery from `~/.codex/skills/` is unverified at v0.1 — if
the skills do not load after install, the alternative is to register
delegate-kit as a Codex plugin marketplace (`codex plugin marketplace`).
Tracked as a v0.2 candidate.

### Dev mode (hacking on this repo)

Use `--symlink` so edits to `skills/*/SKILL.md` go live without re-running
the installer:

```bash
~/delegate-kit/install/claude-code.sh --symlink
```

### Windows

The install scripts are Bash. On native Windows, use WSL / Git Bash, or
manually copy `skills/delegate-*/SKILL.md` into
`%USERPROFILE%\.claude\skills\`. A PowerShell installer is tracked for v0.2.

## How it triggers

When you ask the main agent to do something delegation-shaped — e.g.,
*"audit how token refresh works across these modules"* or *"并行检查这三个
分支的认证逻辑"* — Claude reads the matching skill's description and loads
its body. The skill then guides the main agent through:

1. **Classify** (orchestrate): delegate or not? Which role?
2. **Write brief** (role-specific skill): copy template, fill `task_id`,
   `parent_task`, `file_ownership`, `acceptance_criteria`, etc.
3. **Spawn subagent** via the agent platform's Agent / Task tool with the
   appropriate tool permissions.
4. **Merge** by parsing the subagent's required JSON output.

Skills are **soft policy** — they guide the agent's behavior when matched,
but they are not hard sandboxes. Real permission boundaries live in the
platform's tool / permission settings (Claude Code `allowed-tools`,
OpenCode `permission.task`, etc.).

## Design choices

- **Markdown briefs, JSON outputs.** Asymmetry is deliberate: humans
  write briefs (Markdown reads well), machines merge outputs (JSON parses
  cleanly).
- **File ownership is the parallel-safety primitive.** Two subagents may
  run in parallel iff their `exclusive_write` sets are disjoint. No
  separate "parallel constraint" bookkeeping.
- **Three roles, not ten.** Research / Executor / Reviewer cover most
  delegation needs. Add more only after observing repeat patterns.
- **Cross-platform from the start, lightly tested.** Skill bodies avoid
  OS-specific commands and require subagents to use repo-relative paths.
  Honest status: developed on macOS, designed portable, Linux/Windows
  untested. PRs documenting platform gotchas welcome.

## Limitations

- v0.1 has only been validated against two self-bootstrap evals (the
  kit was used to scaffold and document itself, see [`examples/`](examples/)).
  Brief-template fields are likely to shift after the first delegation
  on an unrelated production codebase.
- Native Windows install requires WSL or manual copy.
- No automated SKILL.md linter yet (planned for v0.2).

## License

Apache License 2.0 — see [`LICENSE`](LICENSE).
