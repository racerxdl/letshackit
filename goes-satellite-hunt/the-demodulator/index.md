---
title: The Demodulator - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# The Demodulator

In last chapter I explained how I manage to build a reception system to get the GOES LRIT Signal. Now I will explain how to get the packets out of the LRIT signal. I choose the LRIT signal basically because of two reasons:

1. It contains basically all EMWIN data + Full Disks from GOES 13 and 15.
2. Less complexity on the demodulator side \(Simple BPSK Demodulator\)

This is the LRIT Specification \(theoretically\):

![](/assets/goes-satellite-hunt/lrit-specs.png)


<div class="pagination">
    <a href="{{ '/goes-satellite-hunt/the-hardware-setup/pointing-the-antenna' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'demodulator-in-gnu-radio' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
