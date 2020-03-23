---
title: Motivation - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Motivation

So few people know that I started a crusade against GOES 13 Satellite. My idea was to capture the GOES 13 signal \(that’s reachable in São Paulo\) with a good SNR \(enough to decode\) and them make all the toolkit to demodulate, decode and output the images and other data they send. I wanted a high-res image, and the L-Band transmissions usually provide that \(GOES for example is 1km/px with whole earth sphere in frame. A 10000 x 10000 pixels image\).

So I choose GOES over other Weather Satellites mainly because GOES is a **Geostationary** Satellite. That means its position never change. That was needed for me, because L Band usually needs a relatively big dish to capture the signal, and if the satellite is moving, the antenna needs to track it. That means: Alt-Az tracker \(or something else\) that will be most likely more expensive than the whole capture system \(at least in Brazil\). Since GOES does not move, I could just point my dish and forget about it. It would always capture the signal.

<div class="pagination">
    <a href="{{ '/goes-satellite-hunt' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'the-hardware-setup' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
