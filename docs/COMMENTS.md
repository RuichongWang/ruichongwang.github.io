# Turning on comments

Comments run on [giscus](https://giscus.app), which stores every thread as a
GitHub Discussion. No server, no database, no cost, no tracking. Readers sign in
with GitHub to post.

Every step below happens on the **public** repo, `RuichongWang/ruichongwang.github.io`
— the one Pages builds from. giscus refuses a private repository, and the private
workspace this site is written in is not the one to enable Discussions on.

The markup is already wired into the post layout. It renders nothing until
`comments.enabled` is true **and** both ids are filled in, so a half-finished
setup can't ship a broken widget.

## Four steps

**1. Enable Discussions.** Public repo → Settings → General → Features → tick
**Discussions**.

**2. Create a category for it.** Public repo → Discussions → the pencil icon
beside "Categories" → New category. Name it `Comments` and set the format to
**Announcement**, so only you can open a thread — otherwise anyone can create
discussions that appear as comments on posts that don't exist.

**3. Install the app.** Visit <https://github.com/apps/giscus> and grant it
access to that repository only.

**4. Get the two ids.** Go to <https://giscus.app>, enter
`RuichongWang/ruichongwang.github.io` under "Repository", and pick `Comments` under
"Discussion Category". Scroll to the generated `<script>` block and copy the
values of `data-repo-id` and `data-category-id`.

Then edit `docs/_config.yml`:

```yaml
comments:
  enabled: true
  repo: "RuichongWang/ruichongwang.github.io"
  repo_id: "R_kgD..."          # data-repo-id
  category: "Comments"
  category_id: "DIC_kwD..."    # data-category-id
```

Commit, push, and comments appear under every post. The ids are public
identifiers, not secrets — they belong in the config file.

## Worth knowing before you turn it on

**Requiring a GitHub login filters out most readers.** For a blog about
building agents that is mostly fine, since the audience already has an account.
It does mean the box stays empty for a long time, and an empty comment box
under every post reads worse than no comment box at all. Consider leaving it
off until a post actually draws traffic.

**Threads are tied to the URL** (`data-mapping="pathname"`). Renaming a post's
slug orphans its comments. `data-strict="1"` prevents near-miss URLs from
matching the wrong thread.

**Moderation happens in the Discussions tab.** Deleting a discussion deletes
the comments on that post.
