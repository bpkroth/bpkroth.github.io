---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
date: 2024-10-28 20:36:00 +0000
---

# bpkroth blog

Welcome to my tiny Github Pages site.
I'm using this site to host little blog articles on technie related things and whatnot.

If you want to comment on them for some reason, umm, I guess open a PR or email or Twitter me or something?
<small>(I didn't think hard about that feature yet.)</small>

## Recent Posts

{% for post in site.posts limit:10 %}
- [{{ post.title }}]({{ post.url }})
  
  Date: {{ post.date | date: "%Y-%m-%d" }}

  Categories: {{ post.categories | join: ', ' }}

  Summary:

  > {{ post.content | strip_html | markdownify | truncatewords: 32 }}
{% endfor %}

- [More Posts ...](/categories.md)
