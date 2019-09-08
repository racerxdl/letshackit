---
id: 194
title: New way to measure filters and my new filter
date: 2016-07-22T19:30:36-03:00
author: Lucas Teske
layout: revision
guid: http://www.teske.net.br/lucas/2016/07/183-revision-v1/
permalink: /2016/07/183-revision-v1/
---
So I&#8217;m still mad about the FM Spectrum (88-108MHz) noise I get when using a LNA or something else. So I&#8217;m still looking for a nice and easy way to filter out these signals.

Last time I posted about a TV/FM Diplexer, that works great, but doesn&#8217;t attenuate enough the signals. So the solution would be cascading several of them, but I found that is very hard to find one Diplexer or FM Trap filter those days.

So I started looking out how to make my own filters. So I reopened Adam&#8217;s Website ([LNA4ALL](http://lna4all.blogspot.com.br/2015/10/diy-fm-trap-or-88-108-mhz-band-stop.html)) that have a small filter he did for FM Trap and tried (again) to make my own.

<!--more-->

This time I tryed to find capacitores that actually matches the values that it was calculated. I found here 2 56pF caps and 2 47pF caps. The two 47 is to make in parallel so I would have something arround 23,5pF that is close enough for the center tap 20pF cap.

Also I found a coil of 0,35mm diameter wire here, that&#8217;s exactly what he used. I also got a Cooper Pipe to do the coil wind. So this is how the filter went out:

[<img class="size-large wp-image-192 aligncenter" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/20160722_190915-1024x576.jpg" alt="My FM Trap Filter" width="625" height="352" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/20160722_190915-1024x576.jpg 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/20160722_190915-300x169.jpg 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/20160722_190915-768x432.jpg 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/20160722_190915-624x351.jpg 624w" sizes="(max-width: 625px) 100vw, 625px" />](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/20160722_190915.jpg)

So first I tested with SDR# with a real receiving FM Band and my HackRF to have a good wide spectrum (20MHz). Here is what it looks without the filter:

<div id="attachment_184" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-unfiltered.png"><img aria-describedby="caption-attachment-184" class="wp-image-184 size-large" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-unfiltered-1024x282.png" alt="FM Spectrum Unfiltered" width="625" height="172" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-unfiltered-1024x282.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-unfiltered-300x83.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-unfiltered-768x211.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-unfiltered-624x172.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-unfiltered.png 1184w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-184" class="wp-caption-text">
    PS: The frequency bar is inverted, who knows why.
  </p>
</div>

And here is what it looks like with my filter:

[<img class="size-large wp-image-185 aligncenter" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-filtered-1024x287.png" alt="FM Spectrum Filtered" width="625" height="175" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-filtered-1024x287.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-filtered-300x84.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-filtered-768x215.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-filtered-624x175.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-filtered.png 1183w" sizes="(max-width: 625px) 100vw, 625px" />](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-filtered.png)

I got impressed this time, because it really made a big difference. I also played with the coils stretching and compressing to change the center frequency. But as you can see, there are still some very high signals there. This generates a lot of background noise (in HackRF more than RTLSDR because of the IF Filters).

So I decided to find a better way to measure my filter response, since I don&#8217;t have a wideband noise generator. My idea was to go to GNU Radio and put my HackRF to generate a a wideband Noise signal. This could easily be done by putting a White Noise Source directly to Osmocom output. I also added a Slider to range the output frequency from 20MHz to 160MHz, so I can do a wide analysis of the filter.[<img class="size-full wp-image-186 aligncenter" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-15-17.png" alt="GNU Radio Noise Generator" width="468" height="246" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-15-17.png 468w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-15-17-300x158.png 300w" sizes="(max-width: 468px) 100vw, 468px" />](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-15-17.png)

So first I wanted to setup a baseline profile of the HackRF Output in the spectrum. For that I just got the output of HackRF through a 3dB attenuator and to my RTLSDR. I used QSpectrumAnalyzer as before with the range from 50MHz to 160MHz and 100kHz steps. This time for some weird reason I got some notching at the QSpectrumAnalyzer between the frequency steps.

<div id="attachment_187" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline.png"><img aria-describedby="caption-attachment-187" class="size-large wp-image-187" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline-1024x762.png" alt="The HackRF Output Centered at 100MHz" width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-187" class="wp-caption-text">
    The HackRF Output Centered at 100MHz
  </p>
</div>

<div id="attachment_188" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline2.png"><img aria-describedby="caption-attachment-188" class="size-large wp-image-188" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline2-1024x762.png" alt="Frequency Sweeped Peak Baseline" width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline2-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline2-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline2-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline2-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline2.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-188" class="wp-caption-text">
    Frequency Sweeped Peak Baseline
  </p>
</div>

So my Output are not very linear (maybe because of the Attenuator, or the impedance mismatch (the HackRF is 50 Ohms and the RTLSDR is 75 Ohms), but still this will give a very good idea of how is the shape of the Filter Curve. So here it is:

<div id="attachment_189" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-00-52.png"><img aria-describedby="caption-attachment-189" class="size-large wp-image-189" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-00-52-1024x762.png" alt="My FM Trap Filter response" width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-00-52-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-00-52-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-00-52-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-00-52-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-00-52.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-189" class="wp-caption-text">
    My FM Trap Filter response
  </p>
</div>

So as you can see, my notch is at 103MHz. But sadly I still get moderated high signal at 106MHz (that still have some radio stations). The good thing is that this time I got it right, the bandwidth is from 88-108MHz, and since it is a 3-pole filter, it was expected to not have a very wide attenuation band. So by this new way of testing, I decided to re-test my TV/FM Diplexer, with this technique, so I could have a more precise curve. And here is the result:

<div id="attachment_190" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-18-48-09.png"><img aria-describedby="caption-attachment-190" class="size-large wp-image-190" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-18-48-09-1024x762.png" alt="TV/FM Diplexer Response" width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-18-48-09-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-18-48-09-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-18-48-09-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-18-48-09-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-18-48-09.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-190" class="wp-caption-text">
    TV/FM Diplexer Response
  </p>
</div>

So as you can see, the TV/FM Diplexer have a very wide band stop filtering and completes (-30dB) attenuates the FM Spectrum. So probably this filter is still my best way around. I hope I can make better filters in the future (I ordered a lot of capacitores with a lot of values so I can keep making better filters).

I hope this information is useful for you, reader. I will keep posting news about my Crusade against the FM Band