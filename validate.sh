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

# ---------------------------------------------------------------- the patrol
#
# A rule nobody checks decays into a rule nobody follows, so the ones that can
# be mechanically checked are checked here rather than only written down.
# Several of the repo's rules can't be — "reuse before building", "search
# before inventing" — and pretending otherwise would be worse than saying so.

echo
echo "patrol"

# --- single source of truth: no path list duplicated between docs and script
#
# 2026-07-30: the first version of this grepped for the literal string
# "Mirrored: `skills/", which was the exact wording of the violation it was
# written for. That wording was then fixed, so the check could never fire
# again — it passed forever and looked healthy doing it. Bind on the shape of
# the violation instead, and derive the path list from the script rather than
# restating it here, since restating it is the thing being checked for.

# Count per LINE, not per file. Re-enumerating the list puts several entries
# on one line; legitimately mentioning skills/ in one rule and docs/ in another
# puts one on each. A whole-file count cannot tell those apart and false-alarms
# on the second — and an alarm that fires on correct docs gets learned around,
# which is worse than not checking.

mirrored="$(sed -n '/^PUBLIC_PATHS=(/,/^)/p' "$REPO_ROOT/sync-public.sh" |
            sed -n 's/^[[:space:]]*\([A-Za-z.][A-Za-z0-9._-]*\)[[:space:]]*$/\1/p')"

worst=0
while IFS= read -r line; do
  case "$line" in *'`'*) ;; *) continue ;; esac
  n=0
  while read -r entry; do
    [ -z "$entry" ] && continue
    case "$line" in *"$entry"*) n=$((n + 1)) ;; esac
  done <<< "$mirrored"
  [ "$n" -gt "$worst" ] && worst=$n
done < "$REPO_ROOT/CLAUDE.md"

[ "$worst" -ge 3 ] &&
  note "CLAUDE.md lists $worst of PUBLIC_PATHS' entries on one line — point at sync-public.sh instead"

# --- the memory store must never be publishable

if sed -n '/^PUBLIC_PATHS=(/,/^)/p' "$REPO_ROOT/sync-public.sh" | grep -qE '^\s*memory\b'; then
  note "'memory' is in PUBLIC_PATHS — the private store would be published"
fi

# --- every privately-held skill actually exists

while read -r name; do
  [ -z "$name" ] && continue
  [ -d "$REPO_ROOT/skills/$name" ] ||
    note "PRIVATE_SKILLS names '$name', which is not a skill"
done < <(sed -n '/^PRIVATE_SKILLS=(/,/^)/p' "$REPO_ROOT/sync-public.sh" |
         sed -n 's/^[[:space:]]*\([a-z][a-z0-9-]*\)[[:space:]]*$/\1/p')

# --- pointers that point at nothing
#
# Docs lean on cross-references now that rules are stated once and linked to.
# A moved file turns those into dead ends silently, so backticked repo paths
# get resolved. Only things that look like paths: no spaces, no globs, and
# either a slash or a known extension.

# A reference is written relative to whatever file mentions it, so matching on
# path suffix is what actually reflects how they're read. Names that merely
# look like paths — repo slugs, branch names — are excluded by pattern rather
# than by listing them, so the exclusion doesn't rot as they change.

index="$(git -C "$REPO_ROOT" ls-files 2>/dev/null || find "$REPO_ROOT" -type f)"

while read -r ref; do
  bare="${ref%/}"
  case "$bare" in
    RuichongWang/*|claude/*) continue ;;   # repo slug, branch name
  esac
  if printf '%s\n' "$index" | grep -qE "(^|/)$(printf '%s' "$bare" |
       sed 's/[.[\*^$]/\\&/g')(/|$)"; then
    continue
  fi
  note "dead reference: $ref"
done < <(
  grep -rhoE '`[A-Za-z][A-Za-z0-9._/-]*`' \
    "$REPO_ROOT"/CLAUDE.md "$REPO_ROOT"/README.md \
    "$REPO_ROOT"/memory/*.md "$REPO_ROOT"/skills/*/SKILL.md 2>/dev/null |
  tr -d '`' |
  grep -E '/|\.(md|sh|yml|html|css)$' |
  grep -vE '^(https?|~)' |
  sort -u
)

# --- duplicated prose across the docs
#
# jscpd tokenises markdown per block and compares across files, which is the
# shape of the failure this repo actually had: one rule written into three
# files, two of them going stale without anyone noticing. Skipped when npx
# can't fetch it, so a offline run degrades instead of failing.

if [ "${SKIP_DUP_CHECK:-0}" = "1" ] || ! command -v npx >/dev/null 2>&1; then
  echo "  (duplication check skipped)"
elif ! npx --yes jscpd@latest --min-tokens 40 --threshold 0 \
        --reporters console --format markdown \
        --pattern "{CLAUDE.md,README.md,memory/*.md,skills/**/*.md}" \
        "$REPO_ROOT" >/tmp/jscpd.out 2>&1; then
  if grep -q 'Clone found' /tmp/jscpd.out; then
    note "duplicated prose across docs — state it once and link to it"
    grep -A3 'Clone found' /tmp/jscpd.out | head -24
  else
    echo "  (jscpd could not run — duplication check skipped)"
  fi
fi

echo
if [ "$fail" -eq 0 ]; then
  echo "all skills valid, patrol clean"
else
  echo "validation failed"
  exit 1
fi
