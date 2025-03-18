---
layout: post
title:  "Generative (Distributed) Systems Gym"
date:   2025-03-18 19:36:33 +0000
categories: [LLMs, Databases, Systems]
---

# Generative (Distributed) Systems Gym

Some musings I was having on LLM opportunities for systems design after trying to use MS Copilot to generate slides for a discussion I was leading.

## Preface

I hate making slides.

I think it's something about the point, click, drag, etc. style of work.

(
There's a reason I write these musings in more or less plain text markdown.
In fact I used write my slide decks in $\LaTeX$ [Beamer](https://ctan.org/pkg/beamer), but the interactive editing wasn't quite there at the time and my advisor preferred PowerPoint or Google Slides.)
> Note to self, revisit this in the context of the "new" $\LaTeX$ editor [Overleaf](https://www.overleaf.com/)

There's something far more pleasing about writing in a text editor and then having the computer do the formatting for me.
It's like programming the document rather than just writing it.

Anyways ... I was also recently encouraged at work to make more use of MS Copilot for our day to day work.
In part I think this is just good self preservation in order to stay on top of the latest and greatest.
But I think it's also helpful to get us a sense of how these things might change our work in the future.

> FWIW, I'm actually writing this in VSCode with Github Copilot on atm, and it's fascinating to watch it try and guess what I want to say and my own reaction and adjustment to that.

So, I started trying to get Copilot to help me with my slides...

## Generating Slides

I'd already had a document written, so I thought "MS tools should be able to convert from one format to another, right?"

Generating the text for the slides is currently way too verbose.
(We seldom use full sentences in slides for instance.)

> As an aside the UX currently stinks.  I try several different ways to get PowerPoint to generate slides from a document, and it just doesn't work well in most of them.

However, they also currently lack awareness on the visual context of the slides.

For instance, we often use bulleted lists, color, bold, italics, etc. to convey meaning and highlight important words even amongst short phrases in the slides in order to draw the audience's attention.

It occurs to me that we might be able to apply a two pass approach to this problem.

1. Generate the text for the slides (e.g., in Markdown even).
2. Generate the visual context (style) for the slides (e.g., in PowerPoint or Google Slides)

    After all, a PowerPoint document is still just XML under the hood.

## Generating Images

However, text only slides are not enough.
We also need images.

I think this is where the generative models *could* improve the most.

When I asked Copilot to generate architecture diagram for me, I either got a very simple overlapping set of boxes or a very very complex 3D diagram with gibberish text in it.

Neither is conducive to editing for improvement.

So, I started thinking if I could use the copilot to generate *text* (code) for the diagram instead (e.g., [Mermaid](https://mermaid.js.org) or [Tikz](https://tikz.dev/)).

## Generating Code

But then I thought, why stop there?
Why not generate the code for the entire system?

## Generative Systems Gym

I think this is where we could really start to see some interesting opportunities.
Rather than just generating one system, why not generate a whole set of systems?

Could we also pit them against one another in a sort of generative systems gym, perhaps using genetic algorithms to search for the best system according to the original design goals?

> Enter [MLOS](https://aka.ms/mlos) for evaluation and optimization of the systems (thesis bias at work here).

This could be a really interesting way to explore the design space of systems and see how different design choices impact the performance, reliability, and other characteristics of the system.

## Conclusion

Anyways, interesting times ...

In the meantime, I still need to make my slides ;)
