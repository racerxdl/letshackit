---
title: Frame Decoder - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Frame Decoder

![](/assets/goes-satellite-hunt/bitanalysis.png)

In the last chapter , I explained how I did the BPSK Demodulator for the LRIT Signal. Now I will explain how to decode the output of the data we got in the last chapter.

One thing that is worth mentioning is that most \(if not all\) weather satellites that transmit digital signals use the CCSDS standard packet format, or at least something based on it. For example this frame decoder can be used \(with some modifications due QPSK instead BPSK\) for LRPT Signals from Meteor Satellites \(I plan to do a LRPT decoder as well in the future, and I will post about it\). I will not describe my entire code here, just the pieces for decoding the data. I will also not write the entire code here, since it can be checked in github. So before start see the picture below \(again\). We will some info from it as well.![](/assets/goes-satellite-hunt/lrit-specs.png)

<div class="pagination">
    <a href="{{ '/goes-satellite-hunt/the-demodulator/symbol-output-from-gnu-radio' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'convolution-encoding-frame-synchronization-and-viterbi' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
