# delegate-kit

A lightweight delegation guide for coding agents. Start with four fields:
goal, context, boundaries, and completion evidence. Use the host's native
agent tools; expand the contract only when the task needs it.

**Status: v0.2 protocol revision.** Static consistency and installation checks
do not prove better task performance. The two archived v0.1 self-bootstrap
runs demonstrate artifact delivery, not full protocol adherence or a measured
advantage over native delegation. See [the evaluation plan](docs/evaluation.md).

## Quick start

Ask your agent to delegate a bounded task. A typical brief is:

```text
goal: Identify why expired sessions sometimes remain authenticated.
context: Read the auth module, its tests, and the project handover.
boundaries: Read-only investigation; no source, cache, or service changes.
done_when: Return the failing path with evidence, or explain the missing evidence.
```

The parent chooses whether delegation helps, supplies the relevant context,
and checks the result. A short evidence-backed report is the default.
Loading a skill alone is not a reason to spawn another agent.

## Skills

| Skill | Assignment |
|---|---|
| `delegate-orchestrate` | Decide whether delegation helps and coordinate dependencies, isolation and integration |
| `delegate-research` | Investigate a bounded question with evidence and uncertainty |
| `delegate-execute` | Implement within an authorized boundary and verify the result |
| `delegate-review` | Independently check a concrete artifact and report actionable findings |

Descriptions target delegation requests rather than every mention of research,
implementation or review. The four names remain stable. The role guides are
optional detail; ordinary assignments do not need a multi-stage ceremony.

## When to expand the brief

For shared interfaces, concurrent writers, external side effects, costly
recovery or machine-consumed results, load the
[extended contract](skills/delegate-orchestrate/references/strict-contract.md).
It covers file ownership, dependencies, shared resources, integration and
recovery. Only fill relevant sections.

File ownership helps coordinate a shared checkout. Different files can still
depend on the same interface or service. Separate worktrees can accommodate
overlapping edits but still need integration and tests. Neither arrangement
automatically isolates databases, ports or external state.

Model choice follows reasoning difficulty, risk and budget, not role names.
Concurrency follows independent work and host limits, not a fixed fan-out.
Check available tools and inherited context before dispatch; use native
communication and resume support where available.

## Install

Clone the repository, then choose your host:

```bash
git clone https://github.com/Powerjackie/delegate-kit.git
cd delegate-kit
./install/claude-code.sh
# Or:
./install/opencode.sh
# Or:
./install/codex.sh
```

Scripts default to copying the complete skill directories, including reference
files. Add `--symlink` for development. Add `--project /absolute/project/path`
for project-local installation. Inspect a script's `--help` for its target.
Existing matching destination directories are replaced by these installers.

The existing Claude Code and Codex installers target `~/.claude/skills/` and
`~/.codex/skills/` respectively. Host discovery can vary by version and setup;
verify the four skills appear in your host after reloading. Installation checks
alone do not test natural-language triggering. OpenCode users should choose
its explicit installer when compatibility discovery is unavailable.

Installers require Bash (macOS, Linux, WSL or Git Bash). Native Windows users
can manually copy all four skill directories into their host's skill location.
Cross-host execution and Windows behavior remain incompletely tested.

## Migrating from v0.1

- Briefs default to four fields. Detailed ownership remains available on demand.
- Reports default to prose with evidence. JSON is opt-in when a consumer needs it.
- Fixed model tiers, concurrency limits and two-failure cutoffs are removed.
- Skill frontmatter no longer lists platform-specific tool names. Configure
  actual permissions on the worker through the host; these skills are soft policy.

**Machine consumers must keep their existing contract until migrated.** The
v0.2 optional envelope is not compatible with v0.1 role schemas. Pin to
`b989426` or supply the consumer's exact brief and return schema explicitly.

[delegate-flow](https://github.com/Powerjackie/delegate-flow) is a separate
runtime project. Its v0.2 compatibility has not been verified in this change;
do not feed it default v0.2 prose reports as if they were v0.1 JSON.

## Validation and contributions

See [CONTRIBUTING.md](CONTRIBUTING.md) for checks and
[docs/evaluation.md](docs/evaluation.md) for paired native-vs-skill evaluation.
Historical examples remain in [examples/](examples/). Improvements should be
supported by task outcomes, not longer prompts or more completed forms.

## License

Apache License 2.0. See [LICENSE](LICENSE).
