#!/usr/bin/env bash
# Install delegate-kit skills into an OpenAI Codex CLI skills directory.
#
# Codex uses the same SKILL.md frontmatter format as Claude Code (YAML
# `name` + `description`, markdown body) and organizes skills under
# `~/.codex/skills/` (for user-level skills) or inside plugins registered
# via `codex plugin marketplace`.
#
# Default: copy skills into `~/.codex/skills/`.
# Pass --symlink to symlink instead (recommended for development of this repo).
# Pass --project <path> to install into <path>/.codex/skills/ instead.
#
# Caveat: at the time of writing (delegate-kit v0.1), Codex's auto-discovery
# of `~/.codex/skills/` is unverified by this project. Codex's bundled
# skills ship inside plugin marketplaces. If skills do not auto-load after
# this install:
#   1. Run `codex plugin marketplace` to inspect registered sources.
#   2. Consider packaging delegate-kit as a Codex plugin and registering
#      its directory via `codex plugin marketplace add <path-or-url>`.
# Tracked as a v0.2 candidate in the repo's HANDOVER.
#
# Idempotent. Bash on macOS / Linux / WSL.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_SRC="$REPO_ROOT/skills"

MODE="copy"
TARGET_BASE="$HOME/.codex"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --symlink)
      MODE="symlink"
      shift
      ;;
    --project)
      TARGET_BASE="$2/.codex"
      shift 2
      ;;
    -h|--help)
      sed -n '2,22p' "$0" | sed 's/^# \?//'
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

TARGET="$TARGET_BASE/skills"
mkdir -p "$TARGET"

echo "Installing delegate-kit skills (Codex)"
echo "  from: $SKILLS_SRC"
echo "  to:   $TARGET"
echo "  mode: $MODE"
echo

shopt -s nullglob
for skill_dir in "$SKILLS_SRC"/delegate-*/; do
  name=$(basename "$skill_dir")
  dest="$TARGET/$name"

  if [[ -e "$dest" || -L "$dest" ]]; then
    rm -rf "$dest"
  fi

  if [[ "$MODE" == "symlink" ]]; then
    ln -s "$skill_dir" "$dest"
    echo "  [link] $name -> $skill_dir"
  else
    cp -R "$skill_dir" "$dest"
    echo "  [copy] $name"
  fi
done

echo
echo "Done. Reload Codex (or restart the session) to pick up the new skills."
echo "Verify with: ls $TARGET"
echo
echo "If Codex does not auto-discover skills from this path, consider"
echo "registering delegate-kit as a Codex plugin marketplace instead:"
echo "  codex plugin marketplace --help"
