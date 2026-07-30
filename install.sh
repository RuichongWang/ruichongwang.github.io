#!/usr/bin/env bash
#
# Install skills from this repo into ~/.claude/skills.
#
#   ./install.sh                    # install every skill
#   ./install.sh matrix             # install just one
#   ./install.sh --list             # show what's available
#   ./install.sh --copy matrix      # copy instead of symlink
#   ./install.sh --uninstall matrix # remove it again
#
# Works from a clone, or straight from the internet:
#
#   curl -fsSL https://raw.githubusercontent.com/RuichongWang/ruichongwang.github.io/main/install.sh | bash
#
set -euo pipefail

REPO_SLUG="${SKILLS_REPO:-RuichongWang/ruichongwang.github.io}"
REPO_BRANCH="${SKILLS_BRANCH:-main}"
TARGET_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
# Named for what the clone holds, not for the repo — the repo is a user site
# that happens to carry the skills alongside the blog it publishes.
CACHE_DIR="${SKILLS_CACHE_DIR:-$HOME/.claude/.skills-src/claude-skills}"

MODE="install"
LINK=1
FORCE=0
NAMES=()

# ---------------------------------------------------------------- args

while [ $# -gt 0 ]; do
  case "$1" in
    --all)       ;;                       # default; accepted for clarity
    --list)      MODE="list" ;;
    --uninstall) MODE="uninstall" ;;
    --copy)      LINK=0 ;;
    --force|-f)  FORCE=1 ;;
    --dir)       TARGET_DIR="${2:?--dir needs a path}"; shift ;;
    -h|--help)   sed -n '3,14p' "${BASH_SOURCE[0]}" | sed 's/^#\{1\} \{0,1\}//'; exit 0 ;;
    -*)          echo "unknown option: $1" >&2; exit 2 ;;
    *)           NAMES+=("$1") ;;
  esac
  shift
done

# ---------------------------------------------------------------- source

# Prefer the clone this script lives in; otherwise fetch the repo.
resolve_source() {
  local here
  if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [ -d "$here/skills" ]; then
      echo "$here"
      return
    fi
  fi

  command -v git >/dev/null || { echo "git is required to fetch $REPO_SLUG" >&2; exit 1; }
  if [ -d "$CACHE_DIR/.git" ]; then
    git -C "$CACHE_DIR" fetch --quiet origin "$REPO_BRANCH"
    git -C "$CACHE_DIR" reset --quiet --hard "origin/$REPO_BRANCH"
  else
    mkdir -p "$(dirname "$CACHE_DIR")"
    git clone --quiet --depth 1 --branch "$REPO_BRANCH" \
      "https://github.com/$REPO_SLUG.git" "$CACHE_DIR"
  fi
  echo "$CACHE_DIR"
}

SRC="$(resolve_source)"
SKILLS_SRC="$SRC/skills"
[ -d "$SKILLS_SRC" ] || { echo "no skills/ directory in $SRC" >&2; exit 1; }

available() {
  local d
  for d in "$SKILLS_SRC"/*/; do
    [ -f "$d/SKILL.md" ] && basename "$d"
  done
}

describe() {  # first line of the SKILL.md description: field
  awk '
    /^description:/ {
      sub(/^description:[[:space:]]*\|?[[:space:]]*/, "")
      if (NF) { print; exit }
      inside = 1
      next
    }
    inside && /^[a-zA-Z-]+:/ { exit }
    inside && NF { sub(/^[[:space:]]+/, ""); print; exit }
  ' "$1/SKILL.md"
}

# ---------------------------------------------------------------- modes

if [ "$MODE" = "list" ]; then
  echo "Skills in $REPO_SLUG:"
  while read -r name; do
    printf '  %-14s %s\n' "$name" "$(describe "$SKILLS_SRC/$name")"
  done < <(available)
  exit 0
fi

if [ ${#NAMES[@]} -eq 0 ]; then
  while read -r name; do NAMES+=("$name"); done < <(available)
fi
[ ${#NAMES[@]} -gt 0 ] || { echo "no skills found in $SKILLS_SRC" >&2; exit 1; }

if [ "$MODE" = "uninstall" ]; then
  for name in "${NAMES[@]}"; do
    dest="$TARGET_DIR/$name"
    if [ -L "$dest" ] || [ -d "$dest" ]; then
      rm -rf "$dest"
      echo "removed  $name"
    else
      echo "skipped  $name (not installed)"
    fi
  done
  exit 0
fi

mkdir -p "$TARGET_DIR"

for name in "${NAMES[@]}"; do
  src="$SKILLS_SRC/$name"
  dest="$TARGET_DIR/$name"

  if [ ! -f "$src/SKILL.md" ]; then
    echo "no such skill: $name (try --list)" >&2
    exit 1
  fi

  if [ "$LINK" -eq 1 ] && [ "$FORCE" -eq 0 ] &&
     [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "linked   $name (already up to date)"
    continue
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ "$FORCE" -eq 1 ]; then
      rm -rf "$dest"
    else
      echo "exists   $name — left alone (use --force to replace)"
      continue
    fi
  fi

  if [ "$LINK" -eq 1 ]; then
    ln -s "$src" "$dest"
    echo "linked   $name -> $src"
  else
    cp -R "$src" "$dest"
    echo "copied   $name"
  fi
done

echo
echo "Installed into $TARGET_DIR. Restart Claude Code to pick up new skills."
if [ "$LINK" -eq 1 ]; then
  echo "Symlinked, so 'git -C $SRC pull' updates every skill at once."
fi
