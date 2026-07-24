---
title: global.big-gate-boy
date: 2021-01-16T18:25:00-03:00
author: Lucas Teske
layout: page
permalink: /biggateboy
description: big-gate-boy.meta-description
social_image: /assets/lyd6168/20201029_001922.jpg
---

<p class="project-lede">{% t big-gate-boy.lede %}</p>

<section class="project-hero project-hero--gameboy" aria-labelledby="big-gate-boy-title">
  <div class="project-hero__content">
    <span class="project-hero__eyebrow">{% t big-gate-boy.hero-eyebrow %}</span>
    <h2 class="project-hero__title" id="big-gate-boy-title">{% t big-gate-boy.hero-title %}</h2>
    <p class="project-hero__description">{% t big-gate-boy.hero-description %}</p>
    <div class="project-actions">
      <a class="project-button project-button--primary" href="https://github.com/racerxdl/biggateboy/">{% t big-gate-boy.source-button %}</a>
      <a class="project-button" href="https://www.youtube.com/playlist?list=PLEP_M2UAh9q7uSd0U_beeeF6FGvOSb_zy">{% t big-gate-boy.playlist-button %}</a>
    </div>
  </div>
  <div class="project-hero__visual">
    <img src="{{ '/assets/lyd6168/20201029_001922.jpg' | prepend: site.baseurl_root }}" alt="Game Boy graphics running across a large LED panel">
  </div>
</section>

<ol class="project-pipeline project-pipeline--four" aria-label="{% t big-gate-boy.path-label %}">
  <li><a href="{{ '/biggateboy/microcode' | prepend: site.baseurl }}">{% t big-gate-boy.pipeline-cpu %}</a></li>
  <li><a href="https://github.com/racerxdl/biggateboy/tree/main/testdata">{% t big-gate-boy.pipeline-tests %}</a></li>
  <li><a href="{{ '/lyd6168' | prepend: site.baseurl }}">{% t big-gate-boy.pipeline-panels %}</a></li>
  <li><span>{% t big-gate-boy.pipeline-display %}</span></li>
</ol>

<header class="project-section-header">
  <h2>{% t big-gate-boy.explore-title %}</h2>
  <p>{% t big-gate-boy.explore-description %}</p>
</header>

<div class="project-grid">
  <article class="project-card">
    <span class="project-card__kicker">{% t big-gate-boy.cpu-kicker %}</span>
    <h3>{% t big-gate-boy.cpu-title %}</h3>
    <p>{% t big-gate-boy.cpu-description %}</p>
    <a class="project-card__link" href="{{ '/biggateboy/microcode' | prepend: site.baseurl }}">{% t big-gate-boy.cpu-link %}</a>
  </article>
  <article class="project-card">
    <span class="project-card__kicker">{% t big-gate-boy.panels-kicker %}</span>
    <h3>{% t big-gate-boy.panels-title %}</h3>
    <p>{% t big-gate-boy.panels-description %}</p>
    <a class="project-card__link" href="{{ '/lyd6168' | prepend: site.baseurl }}">{% t big-gate-boy.panels-link %}</a>
  </article>
  <article class="project-card">
    <span class="project-card__kicker">{% t big-gate-boy.streams-kicker %}</span>
    <h3>{% t big-gate-boy.streams-title %}</h3>
    <p>{% t big-gate-boy.streams-description %}</p>
    <a class="project-card__link" href="https://www.youtube.com/playlist?list=PLEP_M2UAh9q7uSd0U_beeeF6FGvOSb_zy">{% t big-gate-boy.streams-link %}</a>
  </article>
  <article class="project-card">
    <span class="project-card__kicker">{% t big-gate-boy.source-kicker %}</span>
    <h3>{% t big-gate-boy.source-title %}</h3>
    <p>{% t big-gate-boy.source-description %}</p>
    <a class="project-card__link" href="https://github.com/racerxdl/biggateboy/">{% t big-gate-boy.source-link %}</a>
  </article>
</div>

<header class="project-section-header">
  <h2>{% t big-gate-boy.resources-title %}</h2>
  <p>{% t big-gate-boy.resources-description %}</p>
</header>

<ul class="project-resource-list">
  <li>
    <a href="{{ '/lyd6168/testing-ic' | prepend: site.baseurl }}">{% t big-gate-boy.testing-title %}</a>
    <span>{% t big-gate-boy.testing-description %}</span>
  </li>
  <li>
    <a href="{{ '/lyd6168/upgrade-fpga' | prepend: site.baseurl }}">{% t big-gate-boy.firmware-title %}</a>
    <span>{% t big-gate-boy.firmware-description %}</span>
  </li>
  <li>
    <a href="{{ '/assets/lyd6168/MBI-MBI5153GP_C183654.pdf' | prepend: site.baseurl_root }}">{% t big-gate-boy.datasheet-title %}</a>
    <span>{% t big-gate-boy.datasheet-description %}</span>
  </li>
</ul>

<aside class="bgb-status">
  <span class="bgb-status__label">{% t big-gate-boy.status-label %}</span>
  <p>{% t big-gate-boy.status-description %}</p>
</aside>

