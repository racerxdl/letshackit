---
title: GNU Radio Flow - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# GNU Radio Flow

Let’s get our hands to GNU Radio and build our demodulator. So in GNU Radio we will have some additional blocks along the Costas Loop and M&M Recovery. I will be using Airspy R2 / Mini so the values are for them, but I will soon provide also a version for RTLSDR \(that will just have different values for the first steps\). As suggested by Trango in \#hearsat, is best to run the sample rate a bit low in airspy to avoid USB Packet Losses \(to be honest I never had any USB packet drop with airspy or hackrf, but this will heavily depend on the CPU and USB Controller that you have on your machine. So its better to be safe than sorry.\). For Airspy R2 we will use 2.5 Msps, and for Airspy mini we can use 3 Msps. Our target sample rate for the whole process is 1.25Msps \(actually we can use anything near that value\). Let’s start with the osmocom block:

![](/assets/goes-satellite-hunt/osmocom-source.png)

Let’s set the Sample rate to **3e6**, the Center Frequency to **1691e6** and all gains to **15**. For the gains setting you can experiment your own values, but I found that I get the best SNR with everything maxed out \(thats not very common\). Also Osmocom Source has a “bug” for airspy, that is it doesn’t get the Mixer Gain Available \(just because its not BB gain. That’s stupid.\). I made a patch \(that was actively rejected because of the Gain name\) to map the Mixer gain to BB gain \(as it is for RTLSDR\). In the future I will probably do a new GRC Block to use with airspy with the correct names and stuff, but for now you can compile gr-osmosdr from source code using my fork: [https://github.com/racerxdl/gr-osmosdr](https://github.com/racerxdl/gr-osmosdr).

<div class="pagination">
    <a href="{{ 'demodulating-bpsk-signal' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'decimating-and-filtering-to-desired-sample-rate' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
