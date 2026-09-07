# Contributing to delegate-kit

Thanks for your interest. This project is small but opinionated. Read this
file before opening a PR.

## What we want

Most valuable contributions, in order:

1. **Example briefs from real delegation runs** — drop them in `examples/`
   with a short README explaining the task, what triggered which skill,
   and what surprised you. This is how we'll evolve the templates with
   ground truth instead of speculation.
2. **Cross-platform gotchas you hit** — open an issue (or PR to
   `docs/cross-platform.md` when that file exists) documenting Windows /
   Linux / non-macOS behavior differences.
3. **Skill template refinements** — propose field additions or removals
   to `skills/delegate-*/SKILL.md` with rationale tied to a real run.
4. **New role skills** — only after observing ≥3 repeats of the same
   pattern that doesn't fit Research / Executor / Reviewer.

## What we don't want yet

- New role skills based on speculation (no real-run evidence).
- Frontmatter fields beyond what Claude Code / OpenCode officially recognize.
- Build systems, CI, package managers, version-bump tooling — until v1.0.
- README expansions beyond fixing inaccuracies.

## Before opening a change

1. Read `README.md` and at least one of the existing `skills/*/SKILL.md`.
2. Check installation in a temporary project directory, then load the skill
   in a fresh host session to test triggering when that host is available.
   Installation alone is not a triggering test. For local development:

   ```bash
   ./install/claude-code.sh --symlink
   ```

3. If you're modifying a skill body, **keep it under 500 lines**
   (Anthropic's recommended ceiling for SKILL.md). If a section needs more
   depth, split it into a sibling reference file (loaded only when needed).
4. If you're modifying frontmatter, sanity-check the description against
   Anthropic's [skill-authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices):
   - third person
   - includes both "what it does" and "when to use it"
   - includes "do not use for…" reverse triggers
   - under 1024 characters

## Style

- Brief templates: four fields by default (goal, context, boundaries,
  done_when). Add coordination detail only when the assignment needs it.
- Outputs: concise evidence reports by default. Machine consumers specify
  an exact schema and validate it; a fenced JSON block does not enforce one.
- Keep existing runtime contracts explicit. See the extended contract's
  v0.1 compatibility section before changing machine-consumed fields.
- Skill descriptions: concrete trigger phrases first, abstract description
  second, reverse triggers last.

## Brief-authoring gotchas (from real runs)

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

## Repo conventions

- Review the scenarios in `docs/evaluation.md` when changing behavior. Record
  static checks separately from live task acceptance, protocol adherence and
  paired comparisons. Never infer all three from a successful commit.
- Preserve historical examples verbatim except necessary secret redaction.
  Add corrections in notes rather than rewriting old outputs to pass a schema.
- Validate reference paths and copy/symlink installation, including nested
  reference files. Report unavailable host tests explicitly.

- `.agent-memory/` is gitignored. Don't commit local development memory.
- Project follows the workspace four-piece memory convention internally
  (`PROJECT.md` / `HANDOVER.md` / `DECISIONS.md` / `BOOTSTRAP_LOG.md`).
- Changes that alter user-facing behavior should add a DECISIONS.md entry
  locally even if not pushed.

## License

By contributing, you agree your contributions are licensed under the
Apache License 2.0 (matching the project license).
