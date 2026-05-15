#!/usr/bin/env bash
# Install delegate-kit skills into a Claude Code skills directory.
#
# Default: copy skills into the user-level skills dir (~/.claude/skills/).
# Pass --symlink to symlink instead (recommended for development of this repo).
# Pass --project <path> to install into <path>/.claude/skills/ instead.
#
# Idempotent: safe to re-run; existing entries are overwritten.
#
# Compatible with: bash on macOS / Linux / WSL. Native Windows users:
# either run under WSL/Git Bash, or copy `../skills/delegate-*/SKILL.md`
# manually into your %USERPROFILE%\.claude\skills\ tree.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_SRC="$REPO_ROOT/skills"

MODE="copy"
TARGET_BASE="$HOME/.claude"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --symlink)
      MODE="symlink"
      shift
      ;;
    --project)
      TARGET_BASE="$2/.claude"
      shift 2
      ;;
    -h|--help)
      sed -n '2,12p' "$0" | sed 's/^# \?//'
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

echo "Installing delegate-kit skills"
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
echo "Done. Reload Claude Code (or restart the session) to pick up the new skills."
echo "Verify with: ls $TARGET"
