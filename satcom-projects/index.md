---
id: 311
title: global.satcom-projects
date: 2017-02-18T14:56:33-03:00
author: Lucas Teske
layout: page
guid: https://www.teske.net.br/lucas/satcom-projects/
description: Satellite communications projects covering antenna hardware, software-defined radio, weather satellites, signal decoding, and open source ground stations.
social_image: /assets/goes-satellite-hunt/g13fd.png
---

<p class="project-lede">Field notes, long-form guides, recordings, and open-source tools from more than a decade of receiving and decoding satellite signals.</p>

<section class="project-hero" aria-labelledby="featured-goes-title">
  <div class="project-hero__content">
    <span class="project-hero__eyebrow">Featured long-form guide · GOES-13 · LRIT</span>
    <h2 class="project-hero__title" id="featured-goes-title">GOES Satellite Hunt</h2>
    <p class="project-hero__description">Follow the complete path from building the L-band receiving hardware to recovering weather images: BPSK demodulation, CCSDS frame synchronization, Reed–Solomon correction, packet demultiplexing, and LRIT file assembly.</p>
    <div class="project-actions">
      <a class="project-button project-button--primary" href="{{ '/goes-satellite-hunt/' | prepend: site.baseurl }}">Explore the guide</a>
      <a class="project-button" href="{{ '/goes-satellite-hunt/motivation' | prepend: site.baseurl }}">Start reading</a>
    </div>
  </div>
  <div class="project-hero__visual">
    <img src="{{ '/assets/goes-satellite-hunt/g13fd.png' | prepend: site.baseurl_root }}" alt="GOES-13 full-disk infrared image of Earth decoded by the project">
  </div>
</section>

<ol class="project-pipeline" aria-label="GOES Satellite Hunt decoding pipeline">
  <li><a href="{{ '/goes-satellite-hunt/the-hardware-setup/' | prepend: site.baseurl }}">Receiving hardware</a></li>
  <li><a href="{{ '/goes-satellite-hunt/the-demodulator/' | prepend: site.baseurl }}">BPSK demodulation</a></li>
  <li><a href="{{ '/goes-satellite-hunt/frame-decoder/' | prepend: site.baseurl }}">Frame decoding</a></li>
  <li><a href="{{ '/goes-satellite-hunt/packet-demuxer/' | prepend: site.baseurl }}">Packet demultiplexing</a></li>
  <li><a href="{{ '/goes-satellite-hunt/file-assembler/' | prepend: site.baseurl }}">LRIT file assembly</a></li>
</ol>

<div class="project-section-header">
  <h2>Explore the archive</h2>
  <p>Projects range from first reception through complete, reusable decoding pipelines.</p>
</div>

<section class="project-grid" aria-label="Satellite project resources">
  <article class="project-card">
    <span class="project-card__kicker">Project archive</span>
    <h3>Satellite field notes</h3>
    <p>Browse the GOES experiments, NOAA and Meteor reception work, RF hardware, filters, and follow-up investigations.</p>
    <a class="project-card__link" href="{{ '/satcom-projects/satellite-projects' | prepend: site.baseurl }}">Browse all satellite projects</a>
  </article>
  <article class="project-card">
    <span class="project-card__kicker">Open data</span>
    <h3>Sample baseband recordings</h3>
    <p>Download real GOES-13 and GOES-16 IQ captures for developing and validating your own demodulators and decoders.</p>
    <a class="project-card__link" href="{{ '/satcom-projects/sample-baseband-files' | prepend: site.baseurl }}">Open the recording library</a>
  </article>
  <article class="project-card">
    <span class="project-card__kicker">First reception</span>
    <h3>NOAA and Meteor</h3>
    <p>Start with a home-built QFH antenna, RTL-SDR reception, GQRX recording, and a dedicated 137 MHz band-pass filter.</p>
    <a class="project-card__link" href="{{ '/2016/01/qfh-antenna-and-my-first-reception-of-noaa/' | prepend: site.baseurl }}">Read the NOAA reception story</a>
  </article>
  <article class="project-card">
    <span class="project-card__kicker">Open source</span>
    <h3>Open Satellite Project</h3>
    <p>The software and reusable tooling that grew out of GOES Satellite Hunt, including decoding and ground-station components.</p>
    <a class="project-card__link" href="https://github.com/opensatelliteproject">View the project on GitHub</a>
  </article>
</section>
