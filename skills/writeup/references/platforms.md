# Platforms

One draft does not go to two platforms. The claim and the evidence carry over;
the opening, the length, the link strategy, and the structure do not.

**Rewrite the opening for every platform, always.** It is the only part that is
never portable, and reusing it is the clearest tell that a post was
cross-published.

**On sourcing.** Hard mechanics below — character limits, tag counts, what the
submit form accepts — are checkable and stated flatly. Ranking and reach claims
are marked with their evidence, because most 2026 "algorithm" writing is vendor
SEO content with no primary data that contradicts itself freely. Two claims here
rest on something checkable and are stated as fact; the rest are hedged.

---

## Long form — Medium, dev.to, personal blog

- **600–1,800 words.** The often-repeated "1,600 words is optimal" traces to a
  Medium study from 2013 and shouldn't be treated as current; practitioner
  consensus now sits lower, around 600–1,200. Write to the argument's length.
- Medium: **5 tags** (hard limit). dev.to: **4**. Don't assume they match.
- **dev.to supports `canonical_url`** — set it to the original when
  cross-posting and the original keeps the SEO. It is the platform's own
  primitive for exactly this case.
- The Medium subtitle is a distinct field (~140 chars), separate from the SEO
  description. Treat it as a second headline that makes its own argument.
- Declarative titles over questions.
- A section heading every 200–300 words; the reader scans first, reads second.
- Links, code blocks, and images all work. Use them.

## X / Twitter

**Links suppress reach. This is no longer folklore.** Buffer's analysis of 18.8M
posts across 71K accounts found link posts are the worst-performing format on
the platform — non-Premium link posts fell to a **0% median engagement rate**
after March 2025, against ~0.40% for text posts (~0.28% for Premium link posts).
The mechanism is visible in the algorithm X open-sourced in January 2026: there
is no explicit URL penalty in the code, because the ranker predicts 19
engagement actions and **none of them is an external link click**. Links take
users off-platform and generate none of the signals the model optimizes. The
suppression is learned, not written.

**The workaround is the part that's folklore.** Putting the link in a reply or
the last post is widely advised and, as far as I can find, has never been
measured. Follow it, don't trust it.

Two formats, not one:

- **Thread.** 5–9 posts. Post 1 must stand completely alone — assume zero
  context and zero scroll-back, it's the only one most people see. One idea per
  post; if a post needs a "cont.", it's two posts. Screenshots of real output
  outperform paraphrases of it.
- **Long post (Premium): up to 25,000 characters**, with the timeline showing
  the first 280 and a "Show more". A structurally different artifact from a
  thread — closer to a blog post that lives on-platform, which also sidesteps
  the link problem entirely.

## 小红书

- **封面图决定一切.** 正文是图片已经生效之后才被读到的东西.
- 标题 ≤ 20 字, 钩子放在前 8 字 —— feed 里大约就露这么多.
- 正文 ≤ 1,000 字, 口语, 短段落, emoji 分段是常规而非装饰. (长文 beta 可到
  6,000 字, 邀请制, 标题仍然 20 字.)
- 标签上限 10 个, 实际 3–8 个更常见.
- **站外引流是违规, 不只是无效.** 《导流治理规则》禁止通过任何路径引导用户离站
  —— 笔记、评论区、私信里的联系方式、他站账号名、URL 都算, 处罚从限流到限制发布
  到永久封号. "私信我"这类评论会被隐藏. 评论区挂链只能挂站内商品, 不是外链通道.
  **所以笔记必须能作为一个自洽的东西成立**, 没有合规的导流出口.
- 技术内容要翻译成"我遇到了什么问题、怎么解决的", 不是"我做了个什么工具".

## 即刻

*未经核实 —— 找不到官方文档或第三方资料, 以下是经验判断, 别当规则.*

- 300–800 字, 不需要小标题.
- 观点先行, 一段一个意思, 可以直接放链接.
- 读者是同行, 不用解释基础概念 —— 解释了反而掉价.
- 适合放"我今天发现了什么"这种半成品思考, 不需要完整结论.

## 公众号

- **完读率决定分发, 不是打开率.** 2025 年推荐算法全面铺开后, 流量结构变了:
  社交推荐加算法推荐已经超过订阅推送, 订阅号平均打开率 2025 Q1 只有 0.89%
  且还在跌. 2026 年的排序指标里完读率排第一, 粉丝数几乎垫底.
- 所以分成三件事优化: 标题决定推荐流里的点击, **完读率决定推荐量**, 转发决定
  社交扩散. 为订阅推送的打开率优化, 是在优化一个正在萎缩的渠道.
- 排版是内容的一部分: 短段、加粗关键句、图文交替.
- 外链: 订阅号正文不能放, 只能是站内链接或小程序;"阅读原文"是唯一的站外出口,
  每篇一个. (认证服务号开通微信支付后可以在正文插外链, 是例外.)
- **原文链接发布后不能改也不能删.** 只有一次机会, 发之前确认 URL.

## Hacker News

- **标题上限 80 字符.** 硬限制。
- The title is the entire submission. No marketing voice, no adjectives, no
  "revolutionary" — descriptive and flat wins. Use the original title.
- **You cannot submit a URL and body text together** — the form takes one or the
  other. Submitting your post's URL means your framing goes in a self-comment.
  This is a mechanic, not a style preference.
- **Show HN has its own rules and writeups don't qualify** — it must be
  something people can actually run or try. Blog posts and newsletters are
  explicitly excluded.
- Expect the top comment to be the strongest objection to your claim. If you
  know what it is, address it in the piece, not in a reply.

## LinkedIn

- The first two lines are all that show before "see more" — roughly 140 chars on
  mobile, 200+ on desktop. They carry the whole post. 3,000 char cap.
- **Put the link in the body, not the first comment.** The first-comment
  workaround has been patched: comments containing external links are suppressed
  by up to ~80%, and posts obviously engineered to funnel to one get hit too. A
  body link costs about 18.8% median reach by the largest 2026 dataset — much
  less than the folklore's 40–60%, and much less than the comment penalty.
  (Vendor sources disagree here and none of the dissenting ones publish data.)
- Short paragraphs, most with a blank line between them.
- Lower technical depth than the same content elsewhere.

## Reddit

- **Enforcement is automated, not editorial.** 96.4% of content-manipulation
  removals are automated. The thing that kills a post is AutoModerator acting
  before any human sees it, on mechanical triggers: minimum comment karma
  (commonly 50–100), minimum account age, domain blocklists, or a post history
  weighted too heavily to one domain.
- So "read the rules" is not enough — the rules that bite often live in the
  AutoModerator config rather than the sidebar. Account age, karma, and domain
  diversity have to exist *before* you post.
- The sitewide 9:1 self-promotion ratio was retired; some subs still enforce a
  local version.
- Post as a participant: what you learned, with the artifact linked as
  supporting evidence rather than as the point. The title states the finding,
  not the project.

---

## What survives compression, and what dies

Going from long form to short:

| Survives | Dies |
|----------|------|
| The one claim | Architecture and implementation sections |
| The single sharpest piece of evidence | The other four pieces of evidence |
| The wrong first answer / the surprise | Nuance and qualification |
| One concrete number | Background and category framing |
| The limits, in one clause | The limits section |

Cutting the limits entirely changes what the piece asserts. If they won't fit,
keep one clause of honest qualification — "works for X, not Y" — rather than
dropping them silently.
