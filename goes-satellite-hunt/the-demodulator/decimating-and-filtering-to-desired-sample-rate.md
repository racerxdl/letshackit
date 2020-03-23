---
title: Decimating and filtering to desired sample rate - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Decimating and filtering to desired sample rate

The next step is to decimate to reach the 2.5e6 of sample rate. For the airspy mini that is 15/18 of the 3e6 sample rate. So lets create a Rational Resampler block and put **15** as interpolation and **18** as decimation. The taps can be empty since it will auto-generate. This is not very optimal, but will work for now. I will release a better version for each SDR in the future.

![](/assets/goes-satellite-hunt/resampler.png)

Now we have 2.5 Msps and we need to decimate by two. But we will also lowpass the input to something close our rate. So let’s create a Low Pass filter with **Decimation as 2**, **Sample Rate as 2.5e6**, **Cut Off Frequency as symbol\_rate \* 2 \(that is 587766\)**, **Transition Width as 50e3**.

![](/assets/goes-satellite-hunt/decimation.png)

After that we will have the sample rate is **1.25e6 **


<div class="pagination">
    <a href="{{ 'gnu-radio-flow' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'automatic-gain-control-and-root-raised-cosine-filter' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
