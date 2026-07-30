---
name: tourist-trap
description: |
  Tourist overcharging and scam defense. Answers three things: is this quoted
  price a rip-off and what should I counter with; a scam is happening to me
  right now, what do I do; and what should I watch for before I go.

  Use when someone traveling quotes a price and asks if it's fair, is stuck or
  being pressured (taxi stopped mid-route demanding more, "the temple is closed
  today", padded restaurant bill, fake police, forced "gift"), thinks they were
  cheated and wants the money back, or asks what the local scams are.

  Triggers:
    /tourist-trap 开罗机场到市区要 400 埃镑，贵吗
    /tourist-trap 出租车半路停下来要加钱
    /tourist-trap 下周去伊斯坦布尔，有什么坑
    "is 400 EGP fair for an airport taxi from Cairo airport"
    "the driver stopped and is demanding more money"
    "am I being ripped off" / "宰客" / "被坑了"

  NOT for: whether an attraction is worth visiting, general trip planning, or
  ordinary haggling where the user already knows the market price.

allowed-tools:
  - WebSearch
  - WebFetch
  - Read
---

# Tourist Trap

Tells a traveler whether they're being overcharged, what to say, and how to get
out — fast enough to be useful while it's happening.

Answer in the language the user wrote in. Give confrontation lines in the local
language with a transliteration they can read aloud.

---

## Rule 0 — safety outranks money

Check this **before** anything else. If any of these are true, stop the price
analysis and tell them to pay and leave:

- They're isolated — night, empty road, back room, off the main street
- The other party controls their movement or their things — they're in a moving
  vehicle, luggage is in the trunk, passport was handed over, door is blocked
- More people arrived after the dispute started
- Anyone is drunk, high, or escalating physically
- It's a "police" interaction they can't verify

**Say it plainly: pay, get out, recover the money afterwards.** ¥200 is not
worth a bad outcome, and `references/recourse.md` often gets it back anyway.
Never coach someone into winning an argument in a place they can't walk away
from. Only run the negotiation path when they can leave freely.

---

## Rule 1 — this is a catalog of exceptions

Almost everyone selling something to a traveler, in every city named in this
skill, is running an ordinary business at an ordinary price. `playbooks.md`
describes the minority. The user opens it at the one moment they are most
primed to read a stranger as a threat, and a tool that only ever describes
fraud will confirm whatever they already fear.

That is a calibration instruction, not a disclaimer. It changes the wording:

- **Judge the transaction, never the place or the people.** "This is 3× the app
  fare" is checkable and is what they need to say in the next ten seconds.
  "Drivers here do this" is neither.
- **Match a playbook to a situation, not to a nationality.** The universal tells
  at the top of `playbooks.md` are behaviors — approached you, manufactured
  urgency, can't leave freely — and they work in Rome as well as anywhere else.
  Lead with those; reach for a country-specific entry second.
- **"Most reported" is not "most common."** The frequency behind these playbooks
  comes from traveler forums, a complaint-selected sample — nobody posts about
  the fair fare they paid. Say "a known scam here," not "the usual practice
  here," and never extrapolate a rate from it.
- **A pre-trip brief is not a threat assessment.** Mode C leaves someone
  equipped, not suspicious of everyone they meet. A brief that would make a
  reader dread the trip is a wrong answer.

Rule 0 still outranks this. When someone's safety is in question, act on the
suspicion and sort out the fairness later.

---

## The two-tier rule — modes A and B

Never make someone standing in the street wait on a web search. Answer twice.

**Tier 1 — immediate, zero tool calls.** Whatever you already know, shaped into
something they can act on in ten seconds. Under a screen. It ends by telling them
to go do it and that more is coming: *"先按上面做,我继续查。"* Tier 1 must never
block on a search — a rough verdict now beats an exact one ninety seconds late,
and ninety seconds is a long time to stand next to an angry driver.

**Tier 2 — after, while they're acting.** Now search. Verify the assumption tier 1
rested on, get the exact procedure, and check anything local that could change the
plan. Deliver it as a follow-up in the same turn.

Rules for tier 2:

- **Lead with whether tier 1 still holds.** Three openers, nothing else:
  「不变,补充细节」·「有一处要改」·「停,情况不一样」.
- **A correction goes first, in bold, before any new material.** The fast answer is
  allowed to be wrong. A correction that arrives buried is not.
- **It is not a longer tier 1.** Don't restate what they already read. New and
  actionable only.
- **Skip it** only when tier 1 genuinely resolved the thing.

What tier 2 goes and gets:

| Mode | Tier 1 rests on | Tier 2 fetches |
|------|----------------|----------------|
| **A** | purchasing-power anchors, from memory | the real local price; restate the multiple if it moved |
| **B** | the playbook and the standard counter | the exact procedure — in-app report path and deadline, the wording that gets refunded, whether tourist police actually operate here, current platform policy — plus the branch for "it already went badly" |

Mode C has no time pressure. Search first, answer once.

---

## Step 1 — pick the mode

| Signal | Mode |
|--------|------|
| A number and a question about it | **A — price check** |
| Present tense, something is happening now | **B — live situation** |
| Future tense, a destination named | **C — pre-trip brief** |

Ambiguous? Assume **B**. Being wrong about B is cheap; being slow about it isn't.

---

## Mode A — price check

**1. Extract** (ask only for what you can't infer, one message, max 2 questions):
service/item, quoted price + currency, city, and **how the quote arrived** —
street hail, hotel arrangement, app, shop, or someone who approached them.
The last one matters most: an unsolicited quote from someone who approached you
is a different animal from a posted price.

**2. Tier 1 — verdict from what you already know.** Use the purchasing-power
anchors in `references/anchors.md` and say the confidence is rough. Don't search
yet.

**3. Answer in this shape.** Verdict first — they may be reading this with the
driver watching.

```
宰客 · 约 4–5 倍
→ 还价到 80–100 EGP，说"Uber 是 90"，不行就走
理由：机场→市中心网约车约 90，官方牌价约 120。他报 400。
```

Verdict vocabulary: **合理** (within normal tourist markup, 1–3×) ·
**偏贵但正常** (3–4×, the tourist tax, not a scam) · **宰客** (4×+, or any
markup obtained by deception) · **判断不了** (say so, give the anchor you'd use).

A price extracted by deception is a scam even if the number turns out fair —
bait price, unit switched from 100g to kg, fee revealed after they're committed.
Call that out separately from the multiple.

**4. Tier 2 — now go get the real anchor.** Follow the ladder in
`references/anchors.md`. If the multiple moved, say so at the top and restate the
counter-offer.

---

## Mode B — live situation

**1. Run Rule 0.** If it trips, that's the whole answer.

**2. Name the playbook.** Read `references/playbooks.md` and identify which one
this is. Telling them "this is the mid-route renegotiation, it ends when you're
out of the car" is worth more than sympathy — it tells them how it finishes.

**3. Tier 1 — four lines and nothing else.** No searching first.

```
先做这个：<one physical action — get out, get the bag, stand in the doorway>
说这句：<local-language line> (transliteration)
别做：<the move that makes it worse>
之后：<recourse, one line>
```

Then one line telling them to go, and that you're still working. Keep the whole
thing under a screen. No analysis, no alternatives, no "you could also".

Ask at most one follow-up question, and only for something that changes the money
— what was agreed, or app versus street. Put it **after** the four lines: the
actions don't depend on the answer, so nothing should wait on it.

**4. Tier 2 — search, then follow up.** Get the specifics tier 1 couldn't have:
the in-app report path and its deadline, the phrasing that actually gets refunded,
whether tourist police cover this spot, current platform policy in this country,
and what the route should have cost. Then give them the branch for "it already
went badly."

Scripts and the escalation ladder are in `references/scripts.md`. Recovery is in
`references/recourse.md`.

---

## Mode C — pre-trip brief

Search current conditions — scams rotate and prices move:

- `<city> tourist scams 2026`
- `site:reddit.com <city> scam` and `site:reddit.com <city> taxi how much`
- `<city> airport taxi official fare`
- `<city> Uber Bolt Grab Careem available`

Then produce a card they can screenshot and use offline:

1. **The 5 scams that actually run there** — from search, not from memory.
   One line each: the setup, the tell.
2. **Six anchor prices** — metro/bus ticket, 1.5L water, street meal, local beer,
   3km taxi, airport→center. Local currency + their home currency.
3. **Three phrases** — "no thanks", "too expensive", "how much" — with
   transliteration.
4. **Numbers** — tourist police, emergency, and which ride-hail app works there.
   Search these; don't recall them.
5. **The one local rule** — the single habit that prevents most of it here
   (e.g. Cairo: never enter a taxi without an agreed price or an app booking).

---

## References

Read on demand, not upfront.

| File | Contents |
|------|----------|
| `references/anchors.md` | How to price something you've never bought, including with no signal |
| `references/playbooks.md` | The scam catalog — setup, tell, counter — plus universal warning signs |
| `references/scripts.md` | What to say, in which language, and the escalation ladder |
| `references/recourse.md` | Getting the money back afterwards |
