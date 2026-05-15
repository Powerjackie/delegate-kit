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
2. Run the install script in `--symlink` mode and load the skill into
   Claude Code or OpenCode to verify the description triggers as expected:

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

- Brief templates: Markdown, snake_case field names, square-bracket
  placeholders.
- Output schemas: fenced JSON with placeholder strings like
  `"<one of: done | blocked | partially_done>"` for enum-typed fields.
- Skill descriptions: concrete trigger phrases first, abstract description
  second, reverse triggers last.

## Repo conventions

- `.agent-memory/` is gitignored. Don't commit local development memory.
- Project follows the workspace four-piece memory convention internally
  (`PROJECT.md` / `HANDOVER.md` / `DECISIONS.md` / `BOOTSTRAP_LOG.md`).
- Changes that alter user-facing behavior should add a DECISIONS.md entry
  locally even if not pushed.

## License

By contributing, you agree your contributions are licensed under the
Apache License 2.0 (matching the project license).
