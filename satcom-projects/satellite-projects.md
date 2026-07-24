---
id: 204
title: global.satellite-projects
date: 2016-10-28T12:50:22-03:00
author: Lucas Teske
layout: page
guid: http://www.teske.net.br/lucas/?page_id=204
description: A curated archive of satellite reception, RF hardware, software-defined radio, GOES decoding, and weather satellite projects.
social_image: /wp-content/uploads/2016/10/Sem-título.png
---
<p class="project-lede">A curated path through the satellite work: start with reception hardware, follow the signal-processing experiments, and continue into complete weather-satellite decoding systems.</p>

<section class="project-hero" aria-labelledby="goes-archive-title">
  <div class="project-hero__content">
    <span class="project-hero__eyebrow">Complete project · Hardware to imagery</span>
    <h2 class="project-hero__title" id="goes-archive-title">GOES Satellite Hunt</h2>
    <p class="project-hero__description">The strongest place to start. This book-length guide documents the full GOES-13 LRIT receive chain and the engineering lessons that later became Open Satellite Project.</p>
    <div class="project-actions">
      <a class="project-button project-button--primary" href="{{ '/goes-satellite-hunt/' | prepend: site.baseurl }}">Open the complete guide</a>
      <a class="project-button" href="{{ '/satcom-projects/sample-baseband-files' | prepend: site.baseurl }}">Get sample signals</a>
    </div>
  </div>
  <div class="project-hero__visual">
    <img src="{{ '/wp-content/uploads/2016/10/Sem-título.png' | prepend: site.baseurl_root }}" alt="Home-built L-band feed and low-noise amplifier mounted on a satellite dish">
  </div>
</section>

<ol class="project-pipeline" aria-label="GOES Satellite Hunt chapter groups">
  <li><a href="{{ '/goes-satellite-hunt/the-hardware-setup/' | prepend: site.baseurl }}">Dish, feed, and LNA</a></li>
  <li><a href="{{ '/goes-satellite-hunt/the-demodulator/' | prepend: site.baseurl }}">GNU Radio receiver</a></li>
  <li><a href="{{ '/goes-satellite-hunt/frame-decoder/' | prepend: site.baseurl }}">CCSDS frames</a></li>
  <li><a href="{{ '/goes-satellite-hunt/packet-demuxer/' | prepend: site.baseurl }}">Virtual channels</a></li>
  <li><a href="{{ '/goes-satellite-hunt/file-types/' | prepend: site.baseurl }}">LRIT products</a></li>
</ol>

<div class="project-section-header">
  <h2>NOAA APT and Meteor LRPT</h2>
  <p>Accessible VHF projects for building the receiving station and learning the signal path.</p>
</div>

<ul class="project-resource-list">
  <li>
    <a href="{{ '/2016/01/qfh-antenna-and-my-first-reception-of-noaa/' | prepend: site.baseurl }}">QFH antenna and first NOAA reception</a>
    <span>Build the antenna, track a pass, and receive the first weather image.</span>
  </li>
  <li>
    <a href="{{ '/2016/02/recording-noaa-apt-signals-with-gqrx-and-rtl-sdr-on-linux/' | prepend: site.baseurl }}">Recording NOAA APT with GQRX and RTL-SDR</a>
    <span>Configure the Linux software stack and preserve a pass for offline decoding.</span>
  </li>
  <li>
    <a href="{{ '/2016/11/137mhz-bandpass-filter-for-noaa-meteor-satellites/' | prepend: site.baseurl }}">137 MHz band-pass filter</a>
    <span>Design, build, and measure a dedicated filter for NOAA and Meteor reception.</span>
  </li>
</ul>

<div class="project-section-header">
  <h2>GOES field notes</h2>
  <p>Experiments and milestones that continued after the original GOES-13 receive chain.</p>
</div>

<ul class="project-resource-list">
  <li>
    <a href="{{ '/2016/12/new-2-2m-dish-from-embrasat/' | prepend: site.baseurl }}">A new 2.2 m dish</a>
    <span>Hardware expansion for stronger L-band reception and future signals.</span>
  </li>
  <li>
    <a href="{{ '/2017/01/goes-16-in-the-house/' | prepend: site.baseurl }}">GOES-16 in the house</a>
    <span>Early reception and reverse engineering of the next GOES generation.</span>
  </li>
  <li>
    <a href="{{ '/2017/03/goes-16-test-week/' | prepend: site.baseurl }}">GOES-16 test week</a>
    <span>Preparing the station and decoder for the experimental HRIT broadcast.</span>
  </li>
  <li>
    <a href="{{ '/2017/04/goes-16-test-week-results/' | prepend: site.baseurl }}">GOES-16 test week results</a>
    <span>Decoded ABI products, false-color imagery, and lessons from the live test.</span>
  </li>
  <li>
    <a href="{{ '/2017/04/some-lna-tests-for-hritlrit/' | prepend: site.baseurl }}">LNA tests for HRIT and LRIT</a>
    <span>Practical gain and noise comparisons for the satellite receive chain.</span>
  </li>
  <li>
    <a href="{{ '/2017/10/goes-grb-first-light/' | prepend: site.baseurl }}">GOES GRB first light</a>
    <span>The jump to the high-rate GOES Rebroadcast service and its first decoded products.</span>
  </li>
</ul>

<div class="project-section-header">
  <h2>Related resources</h2>
  <p>Original articles, reusable recordings, and the software created from the research.</p>
</div>

<section class="project-grid" aria-label="Related satellite resources">
  <article class="project-card">
    <span class="project-card__kicker">Original publication</span>
    <h3>The five-part GOES blog series</h3>
    <p>Read the original chronological posts that were reorganized and expanded into GOES Satellite Hunt.</p>
    <a class="project-card__link" href="{{ '/2016/10/goes-satellite-hunt-part-1-antenna-system/' | prepend: site.baseurl }}">Open part one</a>
  </article>
  <article class="project-card">
    <span class="project-card__kicker">Development data</span>
    <h3>GOES baseband recordings</h3>
    <p>Use real LRIT, HRIT, telemetry, EMWIN, and DCPR captures to test your own signal-processing code.</p>
    <a class="project-card__link" href="{{ '/satcom-projects/sample-baseband-files' | prepend: site.baseurl }}">Browse the recordings</a>
  </article>
</section>
