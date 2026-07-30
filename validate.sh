#!/usr/bin/env bash
#
# Check every skill in skills/ before committing:
#   - SKILL.md exists
#   - frontmatter is delimited by --- ... ---
#   - name: and description: are present
#   - name: matches the directory name
#
#   ./validate.sh
#
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fail=0

note() { printf '  %s\n' "$1"; fail=1; }

for dir in "$REPO_ROOT"/skills/*/; do
  name="$(basename "$dir")"
  file="$dir/SKILL.md"
  echo "$name"

  if [ ! -f "$file" ]; then
    note "missing SKILL.md"
    continue
  fi

  [ "$(head -1 "$file")" = "---" ] || note "SKILL.md must start with '---'"

  # Frontmatter is everything up to the second '---'.
  front="$(awk 'NR==1 && $0=="---" { next } /^---[[:space:]]*$/ { exit } { print }' "$file")"

  declared="$(printf '%s\n' "$front" | sed -n 's/^name:[[:space:]]*//p' | head -1)"
  if [ -z "$declared" ]; then
    note "no 'name:' in frontmatter"
  elif [ "$declared" != "$name" ]; then
    note "name: '$declared' does not match directory '$name'"
  fi

  printf '%s\n' "$front" | grep -q '^description:' || note "no 'description:' in frontmatter"

  # Angle brackets in frontmatter break the skill spec — use PLACEHOLDER instead.
  printf '%s\n' "$front" | grep -q '[<>]' && note "frontmatter contains angle brackets (< or >)"
done

echo
if [ "$fail" -eq 0 ]; then
  echo "all skills valid"
else
  echo "validation failed"
  exit 1
fi
