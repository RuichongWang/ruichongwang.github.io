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
# before inventing", "state the falsifier", "new evidence to reopen" — and
# pretending otherwise would be worse than saying so.

echo
echo "patrol"

# This script is itself mirrored to the public repo, where it runs against a
# different set of files: no CLAUDE.md, no memory/, no sync-public.sh, no
# dashboard.py. Most of the patrol reads exactly those, and CI over there had
# been red for two syncs — `sed: can't read .../sync-public.sh` under `set -e`,
# which stops the run before the skill checks that are the reason validate.sh
# is published at all.
#
# So the workspace checks are gated on the workspace being present, and the
# skip is announced rather than silent. A patrol that quietly examines less
# than it appears to is the failure this whole section exists to prevent.
workspace=0
[ -f "$REPO_ROOT/sync-public.sh" ] && [ -f "$REPO_ROOT/memory/pending.md" ] &&
  workspace=1

if [ "$workspace" -eq 0 ]; then
  echo "  workspace checks skipped — no memory/ or sync-public.sh here."
  echo "  This is the published mirror; only the skill and blog checks apply."
fi

# Not indented, deliberately: the block below is ~270 lines and reindenting it
# would bury a one-line change in a whole-file diff.
if [ "$workspace" -eq 1 ]; then

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

# --- moot conditions on open queue items
#
# Every open item names the condition that would make it pointless (queue
# item 11, borrowed from self-evolve's retire_if). The patrol reports items
# whose condition now holds — it never closes them, because eco lost a card
# to auto-evaluation. Predicates are three-valued: exit 0 the condition
# holds, 1 it doesn't, anything else is "could not check", which is evidence
# of nothing either way and is deliberately silent.

declare -A item_status=() live=() blockers=() group_of=()

# Fields are separated by US (\037), not by tab. Tab is an IFS *whitespace*
# character, so bash collapses a run of them into one delimiter and drops
# trailing ones — with 'Moot check:' last and optional that was invisible, but
# an item carrying 'Group:' and no 'Blocked by:' has an empty field in the
# middle, and under tabs its group silently shifted left into 'blocked'.
while IFS=$'\037' read -r status title sec moot line blocked group cmd; do
  # The id is the heading's leading token — '22' or 'A'. Recorded for every
  # item, live or closed, because a live item is allowed to name a closed one
  # as its blocker and check 3 below has to be able to tell that apart from a
  # blocker that does not exist at all.
  id="${title%%.*}"
  item_status["$id"]="$status"

  # A '## ' heading is a second copy of the status field, and the second copy
  # is the one that goes stale: closing an item edits its status and leaves it
  # sitting under whatever heading it was filed under. Twelve finished items
  # accumulated under '## Open' that way, and the approval page's own subtitle
  # believed them — "17 on me" against five live items. The page is keyed on
  # status now, so this can no longer mislead a reader; it can still mislead
  # anyone reading pending.md directly, which is every session.
  case "$status" in
    open*|approved*|'in flight'*|spec*) ;;
    *)
      [ "$sec" = "Open" ] &&
        note "queue item '$title' is '$status' but still filed under '## Open'"
      continue ;;
  esac
  [ "$sec" = "Closed" ] &&
    note "queue item '$title' is live ('$status') but filed under '## Closed'"
  live["$id"]=1
  blockers["$id"]="$blocked"
  [ -n "$group" ] && group_of["$id"]="$group"
  # The approval page shows one line per item. Without a written one it
  # clips the first paragraph, which lands mid-sentence and reads as a broken
  # tool — so the summary is the item's job, not the renderer's.
  [ "$line" = "0" ] &&
    note "queue item '$title' has no 'Line:' summary for the approval page"
  if [ "$moot" = "0" ]; then
    note "queue item '$title' has no 'Moot when:' line"
    continue
  fi
  [ -z "$cmd" ] && continue
  set +e
  ( cd "$REPO_ROOT" && timeout 15 bash -c "$cmd" ) >/dev/null 2>&1
  rc=$?
  set -e
  [ "$rc" -eq 0 ] && echo "  moot? '$title' — its moot condition holds; close it or say why not"
done < <(awk '
  function emit() { if (title != "") printf "%s%s%s%s%s%s%d%s%d%s%s%s%s%s%s\n", \
    status, US, title, US, sec, US, moot, US, line, US, blocked, US, group, US, cmd }
  BEGIN { US = sprintf("%c", 31) }
  # Emit before switching sections, or the last item of each one is attributed
  # to the next — which would report every closed item as filed under Open.
  /^## / { emit(); title = ""; sec = substr($0, 4); sub(/[ \t]+$/, "", sec) }
  /^### / { emit(); title = substr($0, 5); status = ""; moot = 0; line = 0
            cmd = ""; blocked = ""; group = "" }
  /^`/ && status == "" && title != "" {
    s = $0; sub(/^`/, "", s); sub(/`.*/, "", s); status = s }
  /^Line:/       && title != "" { line = 1 }
  /^Moot when:/  && title != "" { moot = 1 }
  # Both fields are single-line and free of internal spaces once trimmed:
  # "Blocked by: 20, 21" is a comma-joined id list, "Group:" a slug.
  /^Blocked by:/ && title != "" {
    b = $0; sub(/^Blocked by:/, "", b); gsub(/[ \t]/, "", b); blocked = b }
  /^Group:/      && title != "" {
    g = $0; sub(/^Group:/, "", g); gsub(/[ \t]/, "", g); group = g }
  /^Moot check:/ && title != "" {
    c = $0
    if (match(c, /`[^`]+`/)) { c = substr(c, RSTART + 1, RLENGTH - 2); cmd = c } }
  END { emit() }
' "$REPO_ROOT/memory/pending.md")

# --- dependencies between queue items
#
# 'Blocked by:' and 'Group:' arrived with item 23 and had no patrol. Both are
# read by the dashboard, and both fail silently rather than loudly: a wrong id
# does not error, it just stops blocking, and the page then shows the item as
# ready to start. The checks below all read the arrays the loop above filled,
# so the file is still parsed exactly once.
#
# Ids are sorted before every report so two runs on the same file print the
# same lines — associative-array order is not stable, and a patrol whose output
# reshuffles is one nobody can diff.

sorted_ids() { printf '%s\n' "$@" | sort; }

# --- a 'Blocked by:' id must name an item that exists
#
# The failure is silent and points the wrong way: a typo'd or deleted blocker
# does not hold the item back, it releases it, and the approval page then
# offers it as ready to start.

# --- a blocker that is already closed is stale
#
# Same page, opposite error: the item is actually ready and is being shown as
# blocked, so it sits there while its blocker has been done for a week.
# Advisory — the line is wrong, but nothing downstream breaks.

if [ "${#live[@]}" -gt 0 ]; then
  while read -r id; do
    [ -z "${blockers[$id]:-}" ] && continue
    IFS=, read -ra deps <<< "${blockers[$id]}"
    for b in "${deps[@]}"; do
      [ -z "$b" ] && continue
      if [ -z "${item_status[$b]+set}" ]; then
        note "queue item $id is 'Blocked by: $b', which is not an item in the queue"
        continue
      fi
      case "${item_status[$b]}" in
        done*|declined*|expired*)
          echo "  stale block: item $id is blocked by $b, which is already ${item_status[$b]} — drop it from the 'Blocked by:' line" ;;
      esac
    done
  done < <(sorted_ids "${!live[@]}")
fi

# --- nothing blocks itself, directly or round a cycle
#
# Every item in a cycle waits on another item in the cycle, so none of them can
# ever start — and reading the items one at a time will never show it, because
# each one's 'Blocked by:' line looks perfectly reasonable on its own. Only
# live items participate: a closed blocker cannot be waiting on anything.

declare -A dep_color=()
dep_path=()

visit_dep() {
  local n="$1" b i start members
  local -a deps
  dep_color["$n"]=gray
  dep_path+=("$n")
  IFS=, read -ra deps <<< "${blockers[$n]:-}"
  for b in "${deps[@]}"; do
    [ -z "$b" ] && continue
    [ -z "${live[$b]+set}" ] && continue
    case "${dep_color[$b]:-white}" in
      gray)
        start=0
        for i in "${!dep_path[@]}"; do
          if [ "${dep_path[$i]}" = "$b" ]; then start=$i; break; fi
        done
        members=""
        for i in "${dep_path[@]:$start}"; do members="${members}${i} -> "; done
        note "queue items block each other in a cycle: ${members}${b} — none of them can start"
        ;;
      white) visit_dep "$b" ;;
    esac
  done
  dep_path=("${dep_path[@]:0:$((${#dep_path[@]} - 1))}")
  dep_color["$n"]=black
}

if [ "${#live[@]}" -gt 0 ]; then
  while read -r id; do
    if [ "${dep_color[$id]:-white}" = "white" ]; then visit_dep "$id"; fi
  done < <(sorted_ids "${!live[@]}")
fi

# --- a 'Group:' slug with only one live item in it
#
# A group is a claim that these items get run together. One member means the
# claim is false — either the slug is a typo that will never join its partners,
# or the partners have closed and the line is a leftover. Advisory: it costs
# nothing to leave, it just says something untrue on the page.

if [ "${#group_of[@]}" -gt 0 ]; then
  declare -A group_count=() group_members=()
  for id in "${!group_of[@]}"; do
    g="${group_of[$id]}"
    group_count[$g]=$(( ${group_count[$g]:-0} + 1 ))
    group_members[$g]="${group_members[$g]:+${group_members[$g]}, }$id"
  done
  while read -r g; do
    [ "${group_count[$g]}" -eq 1 ] &&
      echo "  group of one: '$g' has only item ${group_members[$g]} in it — a typo, or its partners have closed"
  done < <(sorted_ids "${!group_count[@]}")
fi

# --- the queue still parses
#
# dashboard.py reads memory/pending.md by format. Nothing warns when an item is
# written in a shape it can't read — the page just quietly renders one fewer
# item, which is the one failure a queue must never have. --check exits nonzero
# on any item whose status it cannot find.

if command -v python3 >/dev/null 2>&1; then
  python3 "$REPO_ROOT/dashboard.py" --check >/dev/null 2>&1 ||
    note "dashboard.py cannot read some queue items — run ./dashboard.py --check"
fi

fi   # end of the workspace-only checks

# --- the blog's text still clears WCAG AA
#
# Every text colour on the site against every surface it could land on. The
# rule this enforces was written twice and broken twice: the redesign survey
# proposed a --faint of #6f7779 that measures 4.46:1, and the value that
# replaced it was derived against --raised alone and left --faint on --code-bg
# at 4.43:1. Neither is caught by measuring the built pages, because no page
# currently puts faint text in a code block — the defect is latent until some
# future rule moves it there, and then nothing is looking.
#
# The whole matrix, not the pairs in use: a token pair that passes only
# because nothing happens to use it is a trap for whoever uses it next.
# 4.5:1 throughout — --faint sets type below the 18.66px large-text
# threshold, so the 3:1 allowance never applies to it.

if command -v python3 >/dev/null 2>&1; then
  # Captured, not piped. `note` sets fail=1, and bash runs the last stage of a
  # pipeline in a subshell — piping into `while read ... note` printed all four
  # failures and still exited 0, which is worse than no check at all: CI stays
  # green while the terminal says something is wrong.
  contrast_out="$(python3 - "$REPO_ROOT/docs/assets/css/style.css" <<'PY'
import re, sys
css = open(sys.argv[1]).read()

def toks(pat):
    m = re.search(pat, css, re.S)
    return dict(re.findall(r'--([\w-]+):\s*(#[0-9a-fA-F]{6})', m.group(1))) if m else {}

light = toks(r':root\s*\{(.*?)\}')
dark = {**light, **toks(r'prefers-color-scheme:\s*dark\s*\)\s*\{\s*:root\s*\{(.*?)\}')}

def lum(h):
    c = [int(h[i:i+2], 16) / 255 for i in (1, 3, 5)]
    c = [v / 12.92 if v <= .03928 else ((v + .055) / 1.055) ** 2.4 for v in c]
    return .2126 * c[0] + .7152 * c[1] + .0722 * c[2]

def ratio(a, b):
    a, b = sorted((lum(a), lum(b)), reverse=True)
    return (a + .05) / (b + .05)

FG, BG = ("text", "muted", "faint", "accent"), ("bg", "raised", "quote-bg", "code-bg")
for name, t in (("light", light), ("dark", dark)):
    missing = [k for k in FG + BG if k not in t]
    if missing:
        print(f"{name} palette is missing {', '.join(missing)} — check the token block")
        continue
    for f in FG:
        for b in BG:
            r = ratio(t[f], t[b])
            if r < 4.5:
                print(f"--{f} on --{b} is {r:.2f}:1 in {name} — WCAG AA wants 4.5:1")
PY
)"
  if [ -n "$contrast_out" ]; then
    while IFS= read -r l; do
      note "blog contrast: $l"
    done <<<"$contrast_out"
  fi
fi

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
