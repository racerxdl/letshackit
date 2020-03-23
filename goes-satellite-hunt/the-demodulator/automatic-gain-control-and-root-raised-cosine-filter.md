---
title: Automatic Gain Control and Root Raised Cosine Filter - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Automatic Gain Control and Root Raised Cosine Filter

For better performance we should keep our signal in a constant level regardless of the input signal. For that we will use a Automatic Gain Control, that will do a Software Gain \(basically just multiply the signal\) that does not change the resolution \(so it will not give a better signal\) but will sure keep our level constant. We can use the simple **AGC** block from GNU Radio.

![](/assets/goes-satellite-hunt/agc.png)

With **rate as 10e-3**, **Reference as 0.5**, **Gain as 0.5**, **Max Gain as 4000**.

Another step is the RRC Filter \(Root Raised Cosine Filter\). This is a filter optimized for nPSK modulations and uses as a parameter our symbol rate. The Filter is not very hard to generate \(its a FIR with some specific taps\), but luckily GNU Radio provide a block for us.

![](/assets/goes-satellite-hunt/rrc.png)

For the parameters we will use **1.25e6 as sample rate**, **293883 as Symbol Rate**, **0.5 as Alpha** and **361 as Num Taps**. From these parameters, Alpha and Symbol Rate is provided from the specification. The number of taps you can experiment with, but I found that a good balance between quality vs performance was at 361 taps. After that we should have basically a signal that contains only the BPSK Modulated signal \(or noise in the same band\). Then we can go to Synchronization and Clock Recovery.


<div class="pagination">
    <a href="{{ 'decimating-and-filtering-to-desired-sample-rate' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'synchronization-and-clock-recovery' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
