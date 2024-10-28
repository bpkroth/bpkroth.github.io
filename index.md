---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

# bpkroth blog

Welcome to my tiny Github Pages site.
I'm using this site to host little blog articles on technie related things and whatnot.

## Recent Posts

{% for post in site.posts limit:10 %}
- [{{ post.title }}]({{ post.url }})
  
  Categories: {{ post.categories | join: ', ' }}

  {{ post.content | strip_html | markdownify | truncatewords: 50 }}
{% endfor %}

- [More Posts ...]({{ site.baseurl }}/categories/)
