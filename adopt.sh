#!/usr/bin/env bash
#
# Move a skill that already lives in ~/.claude/skills into this repo, then
# symlink it back — so it's version-controlled without changing how it loads.
#
#   ./adopt.sh crispr           # ~/.claude/skills/crispr -> skills/crispr (+ symlink back)
#   ./adopt.sh crispr --force   # replace an existing skills/crispr in the repo
#
# Useful right after /matrix writes a new skill: adopt it, then commit.
#
set -euo pipefail

TARGET_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORCE=0
NAMES=()

while [ $# -gt 0 ]; do
  case "$1" in
    --force|-f) FORCE=1 ;;
    --dir)      TARGET_DIR="${2:?--dir needs a path}"; shift ;;
    -h|--help)  sed -n '3,10p' "${BASH_SOURCE[0]}" | sed 's/^#\{1\} \{0,1\}//'; exit 0 ;;
    -*)         echo "unknown option: $1" >&2; exit 2 ;;
    *)          NAMES+=("$1") ;;
  esac
  shift
done

[ ${#NAMES[@]} -gt 0 ] || { echo "usage: ./adopt.sh <skill-name>..." >&2; exit 2; }

for name in "${NAMES[@]}"; do
  live="$TARGET_DIR/$name"
  repo="$REPO_ROOT/skills/$name"

  if [ -L "$live" ]; then
    echo "skipped  $name — already a symlink to $(readlink "$live")"
    continue
  fi
  if [ ! -f "$live/SKILL.md" ]; then
    echo "no SKILL.md at $live" >&2
    exit 1
  fi
  if [ -e "$repo" ]; then
    if [ "$FORCE" -eq 1 ]; then
      rm -rf "$repo"
    else
      echo "exists   skills/$name in the repo — use --force to replace" >&2
      exit 1
    fi
  fi

  mkdir -p "$REPO_ROOT/skills"
  mv "$live" "$repo"
  ln -s "$repo" "$live"
  echo "adopted  $name -> skills/$name (symlinked back into $TARGET_DIR)"
done

echo
echo "Next: review the SKILL.md, then commit it."
