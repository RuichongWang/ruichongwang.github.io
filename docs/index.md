---
layout: default
masthead: true
---

{%- comment -%}
  The masthead lives in the rail in _layouts/default.html, so it can become the
  sidebar on wide screens. This page is the post list only.
{%- endcomment -%}
{%- assign lead = site.posts.first %}
{%- if lead %}
<article class="lead">
  <span class="meta">{{ lead.date | date: "%B %-d, %Y" }}</span>
  <h2 class="lead-title"><a href="{{ lead.url | relative_url }}">{{ lead.title }}</a></h2>
  {%- if lead.subtitle %}
  <p class="dek">{{ lead.subtitle }}</p>
  {%- endif %}
  <a class="cta" href="{{ lead.url | relative_url }}">Read the post</a>
</article>
{%- else %}
<p class="empty">Nothing published yet.</p>
{%- endif %}

{%- if site.posts.size > 1 %}
<h2 class="section-label">Earlier</h2>
<ul class="post-list">
{%- for post in site.posts offset: 1 %}
  <li>
    <span class="meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
    {%- if post.subtitle %}
    <p class="dek">{{ post.subtitle }}</p>
    {%- endif %}
  </li>
{%- endfor %}
</ul>
{%- endif %}
