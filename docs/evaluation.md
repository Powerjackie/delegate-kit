# Evaluating delegation quality

The v0.2 revision is a design change, not a demonstrated performance gain.
Keep three separate questions: did the task finish, was the specified
protocol followed, and did the skill improve results versus native behavior?

## Static scenario review

These are acceptance scenarios for reviewing instructions, not executed
agent benchmarks. For each, trace the rule that produces the expected choice.

| Scenario | Expected behavior |
|---|---|
| One typo with one edit | Keep inline; no forced brief or delegation |
| Independent bounded investigation | Four-field brief and concise evidence report |
| Architecture investigation | Select capability by reasoning difficulty, not a cheap research default |
| Two writers, different files, shared API | Resolve dependency before parallel implementation |
| Two worktrees editing the same file | Allow with integration owner and merge/test order |
| Two worktrees sharing a database | Account for database effects; isolation is incomplete |
| Worker needs an excluded memory file | Parent resolves scope; worker does not silently edit it |
| Consumer requires v0.1 JSON | Preserve exact contract or pin; no automatic v0.2 conversion |
| No callable worker tool | Work inline and disclose; do not fabricate a dispatch |
| Native context inheritance | State goal/boundaries and supply missing context without a transcript dump |
| Several failed searches with a useful next lead | Continue within budget; no arbitrary two-search cutoff |
| Independent review finds no defects | Report coverage limits; do not invent scores or findings |

## Paired runs

Choose unrelated real tasks: a bounded bug fix, dependency investigation,
parallel implementation with integration, and a review with known defects.
Include a small task where delegation should be rejected.

For each task, use the same repository revision, acceptance criteria, model,
permissions, budget and environment in separate fresh sessions. Run once with
native delegation and once with delegate-kit. Avoid prior-run context leakage;
alternate order across tasks and repeat where model variability matters.
Record host/model versions and any unavoidable differences. Never run paired
side-effecting trials against a shared production resource.

Record:

- Task acceptance based on independent artifact checks.
- Protocol adherence: actual skill loading, brief, output and ownership.
- User interventions, retries, integration failures and scope violations.
- Wall-clock duration and token/cost data when available (otherwise unavailable).
- Whether delegation was warranted and whether reports supported verification.

Keep exact sanitized prompts and outputs alongside notes; preserve prose as
prose. Do not rewrite a nonconforming historical report as compliant JSON.
Assess outcomes before looking at which configuration produced them where
practical. Report per-task results and uncertainty, not just an average score.

Retain a rule when it improves acceptance or reduces avoidable cost without
introducing material failures. Revise or remove rules that only add ceremony.
No live paired runs or automatic-trigger validation are claimed by this document.

## 2026-09-08 revision checks

Executed locally on macOS using Node assertions and the existing installers:

- Four frontmatter names/descriptions, four brief fields, balanced fences,
  relative skill references and local Markdown links passed structural checks.
- The optional JSON example parsed. This does not test a host-enforced schema.
- All three Bash installers passed syntax checks and copy -> symlink -> copy
  installation in a temporary project, including the nested reference file.
- All eight existing Claude Code/Codex development symlinks resolved to the
  updated repository source.
- Git whitespace validation passed. Four entry files total 190 lines versus
  437 in v0.1; line reduction is not a token or performance benchmark.

The twelve scenarios above were reviewed against the instruction text, not
executed by separate agents. No live worker, fresh-session triggering, paired
benchmark, delegate-flow integration, Linux or Windows run was performed.
