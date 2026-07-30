---
name: your-skill-name
description: |
  One or two sentences on what this skill does, written so Claude can tell
  from the description alone whether to load it. Name the concrete triggers —
  the words a user would actually type, the file types involved, the tasks it
  covers — and say plainly when NOT to use it.

  Examples:
    /your-skill-name something
    "help me with <the thing this skill knows>"

# Optional: restrict what the skill is allowed to reach for.
# allowed-tools:
#   - Read
#   - WebSearch
#   - Bash(git status)
---

# Your Skill Name

One paragraph: what this skill knows or does, and the shape of the work it
covers. Keep SKILL.md itself lean — it loads into context whenever the skill
triggers. Push detail into `references/`.

---

## When to use this

- Concrete situation one
- Concrete situation two

Do NOT use this for: the adjacent thing that has its own skill.

---

## Steps

1. First thing to do, stated as an instruction.
2. Second thing. Be specific about commands, paths, and outputs.
3. What "done" looks like, and how to verify it.

---

## References

Load these on demand — don't read them upfront.

| File | Contents |
|------|----------|
| `references/detail.md` | The deep material that doesn't belong in context by default |
