---
title: GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
citation_work: goes-satellite-hunt
guid: https://www.teske.net.br/lucas/goes-satellite-hunt/
description: goes-satellite-hunt.meta-description
social_image: /assets/goes-satellite-hunt/g13fd.png
---

<section class="project-hero" aria-labelledby="goes-title">
  <div class="project-hero__content">
    <span class="project-hero__eyebrow">{% t goes-satellite-hunt.hero-eyebrow %}</span>
    <h1 class="project-hero__title" id="goes-title">GOES Satellite Hunt</h1>
    <p class="project-hero__description">{% t goes-satellite-hunt.hero-description %}</p>
    <div class="project-actions">
      <a class="project-button project-button--primary" href="{{ '/goes-satellite-hunt/motivation' | prepend: site.baseurl }}">{% t goes-satellite-hunt.motivation-button %}</a>
      <a class="project-button" href="https://github.com/opensatelliteproject">{% t goes-satellite-hunt.open-project-button %}</a>
    </div>
  </div>
  <div class="project-hero__visual">
    <img src="{{ '/assets/goes-satellite-hunt/g13fd.png' | prepend: site.baseurl_root }}" alt="{% t goes-satellite-hunt.hero-image-alt %}">
  </div>
</section>

<ol class="project-pipeline" aria-label="{% t goes-satellite-hunt.pipeline-label %}">
  <li><a href="{{ '/goes-satellite-hunt/the-hardware-setup/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.pipeline-receive %}</a></li>
  <li><a href="{{ '/goes-satellite-hunt/the-demodulator/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.pipeline-symbols %}</a></li>
  <li><a href="{{ '/goes-satellite-hunt/frame-decoder/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.pipeline-frames %}</a></li>
  <li><a href="{{ '/goes-satellite-hunt/packet-demuxer/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.pipeline-channels %}</a></li>
  <li><a href="{{ '/goes-satellite-hunt/file-assembler/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.pipeline-products %}</a></li>
</ol>

<div class="project-section-header">
  <h2>{% t goes-satellite-hunt.story-title %}</h2>
  <p>{% t goes-satellite-hunt.story-description %}</p>
</div>

<p>{% t goes-satellite-hunt.origin %}</p>

<p>{% t goes-satellite-hunt.impact-prefix %} <a href="https://github.com/opensatelliteproject">{% t goes-satellite-hunt.open-project-name %}</a>. {% t goes-satellite-hunt.impact-suffix %}</p>

<div class="project-section-header">
  <h2>{% t goes-satellite-hunt.chapters-title %}</h2>
  <p>{% t goes-satellite-hunt.chapters-description %}</p>
</div>

<section class="chapter-grid" aria-label="{% t goes-satellite-hunt.chapters-label %}">
  <article class="chapter-card">
    <span class="chapter-card__number">01</span>
    <span class="project-card__kicker">{% t goes-satellite-hunt.context-kicker %}</span>
    <h3>{% t goes-satellite-hunt.motivation-title %}</h3>
    <p>{% t goes-satellite-hunt.motivation-description %}</p>
    <a class="project-card__link" href="{{ '/goes-satellite-hunt/motivation' | prepend: site.baseurl }}">{% t goes-satellite-hunt.motivation-link %}</a>
  </article>
  <article class="chapter-card">
    <span class="chapter-card__number">02</span>
    <span class="project-card__kicker">{% t goes-satellite-hunt.hardware-kicker %}</span>
    <h3>{% t goes-satellite-hunt.hardware-title %}</h3>
    <p>{% t goes-satellite-hunt.hardware-description %}</p>
    <a class="project-card__link" href="{{ '/goes-satellite-hunt/the-hardware-setup/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.hardware-link %}</a>
  </article>
  <article class="chapter-card">
    <span class="chapter-card__number">03</span>
    <span class="project-card__kicker">{% t goes-satellite-hunt.demodulator-kicker %}</span>
    <h3>{% t goes-satellite-hunt.demodulator-title %}</h3>
    <p>{% t goes-satellite-hunt.demodulator-description %}</p>
    <a class="project-card__link" href="{{ '/goes-satellite-hunt/the-demodulator/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.demodulator-link %}</a>
  </article>
  <article class="chapter-card">
    <span class="chapter-card__number">04</span>
    <span class="project-card__kicker">{% t goes-satellite-hunt.frame-kicker %}</span>
    <h3>{% t goes-satellite-hunt.frame-title %}</h3>
    <p>{% t goes-satellite-hunt.frame-description %}</p>
    <a class="project-card__link" href="{{ '/goes-satellite-hunt/frame-decoder/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.frame-link %}</a>
  </article>
  <article class="chapter-card">
    <span class="chapter-card__number">05</span>
    <span class="project-card__kicker">{% t goes-satellite-hunt.packets-kicker %}</span>
    <h3>{% t goes-satellite-hunt.packets-title %}</h3>
    <p>{% t goes-satellite-hunt.packets-description %}</p>
    <a class="project-card__link" href="{{ '/goes-satellite-hunt/packet-demuxer/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.packets-link %}</a>
  </article>
  <article class="chapter-card">
    <span class="chapter-card__number">06</span>
    <span class="project-card__kicker">{% t goes-satellite-hunt.files-kicker %}</span>
    <h3>{% t goes-satellite-hunt.files-title %}</h3>
    <p>{% t goes-satellite-hunt.files-description %}</p>
    <a class="project-card__link" href="{{ '/goes-satellite-hunt/file-assembler/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.files-link %}</a>
  </article>
</section>

<div class="project-actions">
  <a class="project-button" href="{{ '/goes-satellite-hunt/file-types/' | prepend: site.baseurl }}">{% t goes-satellite-hunt.file-reference-button %}</a>
  <a class="project-button" href="{{ '/goes-satellite-hunt/ending' | prepend: site.baseurl }}">{% t goes-satellite-hunt.conclusion-button %}</a>
</div>

<aside class="project-note">
  <p>{% t goes-satellite-hunt.license-prefix %} <a href="https://creativecommons.org/licenses/by-sa/2.5/br/">{% t goes-satellite-hunt.license-name %}</a>; {% t goes-satellite-hunt.license-suffix %}</p>
  <p>{% t goes-satellite-hunt.thanks-prefix %} <strong>#hearsat</strong> {% t goes-satellite-hunt.thanks-community %} <a href="https://twitter.com/usa_satcom">@usa-satcom</a> {% t goes-satellite-hunt.thanks-and %} <a href="https://twitter.com/devnulling">@devnulling</a>, {% t goes-satellite-hunt.thanks-family %}</p>
</aside>
