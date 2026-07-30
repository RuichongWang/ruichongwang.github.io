# Anchoring a price you've never paid

The hard part of judging a quote isn't knowing scams — it's knowing what the
thing actually costs, in a city you've never been to, in a currency you don't
think in, at a price level that moved since anything on the web was written.

This file is a method, not a price list. Price lists go stale; the method
doesn't.

---

## The anchor ladder

Work down it. Stop at the first anchor you can get.

**1. Ride-hail in-app quote — best anchor for any transport.**
Open the app and price the same route without booking. This is a live,
locally-priced, non-negotiable number, and it's the strongest counter available:
"Bolt is 90." Apps by region — Uber (most), Bolt (Eastern Europe, Africa,
Turkey), Careem (Middle East, Pakistan), Grab (SE Asia), Gojek (Indonesia),
inDrive (Latin America, Central Asia, Africa), Didi (China, Mexico, LatAm),
Yandex Go (Russia, Central Asia), Ola (India), 99 (Brazil), Freenow (Western
Europe). Search `<city> Uber Bolt Grab available 2026` if unsure — availability
changes with local regulation.

**2. Published official tariff.**
Airport taxis usually have a posted fixed fare to the center, and it's usually
on the airport's own website. Metered cities publish flagfall + per-km. Search
`<city> airport taxi official fare` and `<city> taxi tariff per km`.

**3. Recent traveler reports — last 12 months only.**
`site:reddit.com <city> taxi how much`, r/<city>, r/travel, TripAdvisor forums.
Weight recent, specific, route-level reports ("I paid 250 EGP airport to Zamalek
last month") over blog posts, which are old and often copied from older posts.

**4. Cost-of-living data.**
Numbeo, Expatistan. Good for groceries, restaurant meals, and transport
baselines. Weak for anything tourist-facing — nobody submits the price they got
scammed on.

**5. Purchasing-power fallback.**
When search fails or they have no signal. See below. Always yields a verdict.

---

## The purchasing-power fallback

Five numbers describe a city's price level. Get them once on arrival — from a
shop, a bus, a menu — and every other price can be checked against them without
any network at all.

| Anchor | What it calibrates |
|--------|-------------------|
| One city bus or metro ticket | the floor of local transport |
| 1.5L bottled water, from a shop with no tourists in it | the base unit of "a cheap thing" |
| A local lunch where local workers eat | the base unit of "a meal" |
| A beer at a normal neighborhood bar | the tourist-markup detector |
| Median daily wage (search once, before the trip) | the ceiling test |

Rules of thumb that follow from them:

- **A short in-city taxi ride runs roughly 10–30× a bus ticket.** At 100× you're
  being fleeced. This ratio is remarkably stable across countries.
- **Airport → center is typically 2–4× a normal in-city ride** — never 10×.
- **Any single tourist-facing purchase above one day's median local wage**
  deserves a hard look, unless it's genuinely a major purchase (a rug, a tour).
- **A restaurant meal at more than 5× a local lunch** means you're in a tourist
  restaurant. Not a scam — but the bill shouldn't then surprise you.
- **A bottle of water at more than 3× shop price** is the standard venue markup.
  Above that it's a captive-audience play (inside a monument, on a boat).

---

## What counts as a rip-off

| Multiple over local price | Reading |
|--------------------------|---------|
| 1–1.5× | Normal. You're a foreigner, not a target. |
| 1.5–3× | **The tourist tax.** Standard in most of the world. Annoying, not a scam. |
| 3–4× | Aggressive opening. Expected to be negotiated down. In haggling cultures this *is* the opening bid, not the price. |
| 4–10× | **Scam.** Counter hard or walk. |
| 10×+ | Not a price — an extraction attempt. Treat as a live situation, not a negotiation. |

Two corrections to the table:

- **In a haggling market, the first number is theater.** Opening asks of 3–5× are
  normal in Egypt, Morocco, India, Vietnam street markets, and Turkish bazaars.
  Don't call a market opener a scam — it's the first move of a game the user is
  expected to play. See `scripts.md` for the counter-offer ratios.
- **Deception makes a fair price a scam.** A price obtained by switching the unit
  (billed per 100g after quoting "per portion"), by revealing a fee after the
  user is committed, or by quoting one number and writing another, is a scam at
  any multiple. Judge the method separately from the number, and say both.

---

## Currency traps

Most "I got overcharged" cases are actually a number the traveler misread.

- **Dropped zeros.** Vietnam (VND), Indonesia (IDR), Korea (KRW), Uzbekistan
  (UZS): "one fifty" can mean 150,000. Confirm the digit count, not the words.
- **Similar-looking notes.** EGP 50 vs 200, IDR 10k vs 100k, TRY 5 vs 50,
  COP 10k vs 100k. The classic short-change is handing back the lookalike.
- **Old or demonetized notes as change.** Turkey (pre-2005 lira), Zimbabwe,
  India's withdrawn notes. If a note looks unlike the others in the wallet, it's
  probably not spendable.
- **"Dollars or local?"** — quoting in USD/EUR at an invented rate is a markup
  hiding as a convenience. Always transact in local currency.
- **DCC (dynamic currency conversion).** The card terminal asks "charge in your
  home currency?" — say no, every time. It's a 3–7% invisible fee. If the
  receipt shows a home-currency amount you didn't choose, that's a chargeable
  dispute.
- **Airport exchange counters** are never the real rate. Check the mid-market
  rate before comparing; a 10–15% spread at arrivals is normal-bad, 30%+ is a
  scam. ATMs beat counters almost everywhere — decline the ATM's own conversion
  offer for the same DCC reason.

---

## Time decay — the part everyone gets wrong

Any price found online is a price from the past, and in exactly the countries
where scams are common, the currency has usually moved a lot.

- Under 12 months: use as-is.
- 12–24 months: inflate, and say you did.
- Over 24 months in a high-inflation currency: **don't trust the local-currency
  number at all.** Egypt, Turkey, Argentina, Nigeria, Venezuela, Iran, Ghana,
  Ethiopia, Lebanon, Sri Lanka, Pakistan, Laos have all seen a currency lose
  half its value or more inside two years.

The fix: convert the old price to USD/EUR **at the rate on the date it was
posted**, then convert back at today's rate. Tourist-facing prices track hard
currency far more closely than local wages do. Search
`<currency> to USD historical <year>` when it matters.

Worked example: a 2023 blog post says "Cairo airport taxi, 150 EGP." At 2023's
~31 EGP/USD that's about $5. If EGP now trades near 50, the equivalent is
roughly 250 EGP — so a 400 EGP quote is about 1.6× a fair current price, not the
2.7× the stale number suggests. Same evidence, different verdict.

---

## Search queries that work

```
<city> airport taxi official fare 2026
<city> taxi cost per km 2026
site:reddit.com <city> taxi how much <route>
site:reddit.com <city> scam
<city> Uber Bolt Careem Grab available
numbeo <city> cost of living
<currency> to USD exchange rate history
```

Two search hygiene rules: filter to the last year wherever the engine allows it,
and prefer forum threads over blog posts — blogs recycle each other's numbers
for years, forums are people reporting what they paid last week.
