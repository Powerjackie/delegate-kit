#!/usr/bin/env bash
# Install delegate-kit skills into an OpenCode skills directory.
#
# Default: copy skills into ~/.config/opencode/skills/.
# Pass --symlink to symlink instead (recommended for development).
# Pass --project <path> to install into <path>/.opencode/skills/ instead.
#
# OpenCode also reads `.claude/skills/` by default (unless
# OPENCODE_DISABLE_CLAUDE_CODE_SKILLS=1 is set), so installing via
# claude-code.sh may already cover OpenCode. Use this script when you
# want a dedicated OpenCode install path or when the Claude-compat
# path is disabled.
#
# Idempotent. Bash on macOS / Linux / WSL.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_SRC="$REPO_ROOT/skills"

MODE="copy"
TARGET_BASE="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --symlink)
      MODE="symlink"
      shift
      ;;
    --project)
      TARGET_BASE="$2/.opencode"
      shift 2
      ;;
    -h|--help)
      sed -n '2,16p' "$0" | sed 's/^# \?//'
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

echo "Installing delegate-kit skills (OpenCode)"
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
echo "Done. Reload OpenCode (or restart the session) to pick up the new skills."
echo "Verify with: ls $TARGET"
