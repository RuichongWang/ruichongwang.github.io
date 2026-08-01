---
layout: post
title: "A Correct Answer, Ninety Seconds Late"
subtitle: "I built a travel-scam assistant that searched the web before it answered. Standing next to a driver who just changed the price, that is the same as not answering."
description: 'I built a travel-scam assistant that searched the web before it answered. Standing next to a driver who just changed the price, that is the same as not answering.'
tags:
  - artificial-intelligence
  - programming
  - software-engineering
  - design
  - llm
date: 2026-07-30
image:
  path: /assets/og/answer-twice.png
  width: 1200
  height: 630
  alt: 'Share card: A Correct Answer, Ninety Seconds Late'
---

Someone is standing next to a taxi. The driver has just announced that the
agreed price is no longer the price. Their bag is in the trunk. They have maybe
ten seconds of attention before they have to say something back.

A web search takes ninety.

That gap is the whole design problem, and it was invisible to me until the thing
was built and I watched it answer.

---

## The Race You Lose

The skill does three jobs. It checks whether a quoted price is a rip-off. It
tells you what to do while a scam is happening. It briefs you before a trip.

The first and third are fine. The second one had a bug that no test would catch,
because the output was correct.

It searched first. Every time. A quote in Cairo meant looking up the current
airport tariff, checking whether Uber operated there, converting the currency.
All of it useful, all of it arriving after the moment it was useful in. The
answer was right and the person had already paid.

You cannot fix that by searching faster. Web search is seconds at best. The
budget is not seconds. It is however long you can stand next to a stranger
looking at your phone, and that shrinks as the situation gets worse.

---

## Answering Twice

So it answers twice.

{% include figure.html src="answer-twice-timeline.svg" alt="Two designs on one clock. Searching first delivers a single answer at about ninety seconds. Answering twice delivers one at zero and a second at ninety. The attention window closes at about ten seconds." caption="Both designs deliver the same researched answer at the same time. Only one of them puts anything inside the window where it can be used." %}

The first answer ships immediately, with no tool calls. Whatever the model
already knows, shaped into something you can act on before you look up:

> *Do this first: don't settle it in the car. Say you'll sort it at the*
> *airport, and let him drive.*
> *Say this: mesh del-wa'-ti, fil-ma-taar — "not now, at the airport."*
> *Don't: pay before your bag is out of the trunk.*
> *After: if you booked in an app, report "driver demanded extra cash."*

One physical action, one line to say, one thing that makes it worse, one line on
getting the money back. Under a screen. Then it tells you to go, and that more
is coming.

The second answer searches while you act. The in-app report path and its
deadline. The wording that gets refunded. Whether tourist police cover this
spot. What the route should have cost. Things the first answer could not know,
arriving when you have thirty seconds instead of ten.

The trade is explicit: **the first answer is allowed to be wrong.** That is what
buys the speed. It only holds if the correction is impossible to miss.

---

## The Correction Goes First

A fast answer gets forgiven. A buried correction does not.

So the second answer opens with one of three lines and nothing else — it still
holds, one thing changed, or stop, this is a different situation. If something
changed, it goes first and in bold, before any new material. The second answer
is never allowed to be a longer version of the first one, quietly patching the
error somewhere in paragraph four.

The shape is not new. Anytime algorithms — the kind that return a usable answer
immediately and improve it given more time — have been a deadline-planning
technique since the late eighties, and emergency medicine has been doing the
same thing longer than that under the name triage: treat on presentation,
revise when the labs come back. What neither gives you is the protocol for the
revision, because an anytime algorithm can replace its own estimate silently
and a person cannot. The claim here is narrow. Not two-tier answers — two-tier
answers where the second tier has to say what the first one got wrong.

This is the part that took a rewrite to get right, and it is the part I would
port to anything else built this way. Two-tier answers are easy. A second tier honest
about the first is not. The natural shape of a follow-up is *here is more
detail*; the useful shape is *here is what I got wrong.*

---

## The Wrong Cairo Scam

Then a live run on Cairo broke the case the skill was built around.

I had the mid-route renegotiation as the canonical story. The car stops
somewhere unremarkable, the price changes, and the counter is to get your bag
out of the trunk before you say anything about money. It is a real scam, it is
well documented, and it is not the one that mostly runs there.

The dominant Cairo play is a cash demand *before* pickup. The driver accepts the
app booking, then calls or messages asking for more — before the meter, before
the trunk, before any of the advice I had written applies. Traveler reports have
people cycling through three drivers in a row, each one asking for more than the
app fare.

The escalation is worse than the opening. The driver offers to cancel the trip
in the app and drive you anyway, for cash.

That one gets a hard no, and the reason is the most useful thing the whole
exercise produced. Cancelling a trip in progress drops four protections at once
— the GPS trace, the fare record, the dispute route, and the insurance. A
documented ride becomes an unrecorded car with a stranger, and you are on your
way to an airport with your luggage in his trunk.

None of that was in the first answer. It came out of the search running while
the user acted on the first answer. The argument for the design arrived as a
side effect of testing it.

---

## What Goes Stale

The other thing the second answer buys is a clean split between what to bake in
and what to look up.

Scam playbooks do not go stale. The forced bracelet, the "temple is closed
today" redirect, the unit switched from a portion to a kilo — these have run for
decades and will run next year. They belong in the files, and they are what
makes the first answer possible at all.

Prices go stale badly, and worst where it matters most. In Egypt, Turkey,
Argentina, Nigeria, a currency can halve inside two years. A price from a 2023
blog post is not merely old. It is wrong in the direction that changes the
verdict. The fix is to convert the old price to hard currency
at the rate on the date it was posted, then back at today's rate:

> *A 2023 post says "Cairo airport taxi, 150 EGP." At that year's ~31 EGP/USD
> that is about $5. At today's ~50, the equivalent is roughly 250 EGP — so a 400
> EGP quote is about 1.6× a fair price, not the 2.7× the stale number suggests.*

Same evidence, opposite conclusion. That calculation is baked in. The two
exchange rates are looked up.

There is a third case, and it is the one that justifies the split: no signal.
Foreign SIM, dead battery, basement restaurant. So the first answer also carries
a fallback that needs no network at all — five local prices that describe a
city's whole price level, and a handful of ratios between them. A short taxi
ride runs about ten to thirty times a bus ticket almost everywhere. At a hundred
times, you are being fleeced, and you can work that out standing still.

---

## The Limits

Four, and the first is not about the design.

**The first answer is wrong sometimes, and sometimes nobody reads the second
one.** That is the accepted cost, not a bug I plan to fix. The alternative —
being right ninety seconds late — is worse in a way that is harder to see,
because a late answer still looks like a good answer in the transcript.

**None of this is measured.** I changed a design because the failure mode was
obvious once I watched it, and everything above is reasoning rather than
evidence. There is no timing data, no A/B, and no user but me. Two-tier answers
could be worse than one: two messages are more to read than one, and an answer
that arrives fast is more persuasive than it has earned to be.

**A correction is only as visible as the reader's attention.** The three fixed
openers are a mechanism, not a guarantee. Someone who acted on the first answer
and put the phone away never sees the second one, and the design does nothing
about that.

**The whole thing is only as good as what a search can reach.** The Cairo
correction came from traveler forums, which exist because people bothered to
write up what happened to them. For a city nobody posts about, the first answer
is all there is, and it will be confidently generic.

There is one rule that outranks all of this, and it exists precisely because the
speed makes the advice feel more authoritative than it is. If you are isolated,
outnumbered, in a moving vehicle, or someone is holding your passport, the skill
stops analyzing the price and tells you to pay and leave. Money is recoverable
through the app, the card, and the tourist police. The other thing is not. No
answer, at any speed, is worth coaching someone into winning an argument in a
place they cannot walk away from.

---

Neither answer is the good one on its own. The first is fast and shallow, the
second is late and right, and the version that works is the one that admits, out
loud, which of the two it is being.

The driver is still asking for two hundred pounds. But now you have something to
say while you figure out whether he should get it.
