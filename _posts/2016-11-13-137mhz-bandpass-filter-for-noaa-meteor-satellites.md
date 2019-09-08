---
id: 256
title: 137MHz Bandpass filter for NOAA / Meteor Satellites
date: 2016-11-13T14:44:12-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=256
permalink: /2016/11/137mhz-bandpass-filter-for-noaa-meteor-satellites/
image: /wp-content/uploads/2016/11/newfilter_predict-624x482.png
categories:
  - English
  - Satellite
  - SDR
tags:
  - 9A4QV
  - Adam
  - AGC
  - Antenna
  - APT
  - English
  - Filter
  - GQRX
  - HackRF
  - Linux
  - LNA4ALL
  - QFH
  - qspectrumanalyzer
  - RFSim99
  - RTL SDR
  - RTLSDR
  - Satellite
  - Satellites
  - SDR
  - Software Defined Radio
  - Ubuntu
  - Weather Satellites
  - WXSat
---
Yesterday I saw a new blog post by Adam (9a4qv) in LNA4ALL. The post ([here](http://lna4all.blogspot.com.br/2015/11/diy-137-mhz-wx-sat-bp-filter.html)) talks about a band pass filter he did for Weather Satellites and I decided to try as well.

Unfortunately I don&#8217;t have a exact match for that components at home, so I tried to do something with the components I have. So the lower value I had for capacitors was 10pF, and the needed values for Adam&#8217;s Filter is 1pF, 4.7pF and 15pF. I decided then to use 10 in series to do the 1pF, 2 in series for the 4.7pF (that will be 5pF) and then one in parallel with two in series to give me the 15pF. Its a very close match, and I&#8217;m unsure about the effects of serialization of capacitores in the filter (increase inductance maybe?). So here is the results.

<!--more-->

So my circuit was a little different from Adam&#8217;s circuit. The coils are 3 turn very spaced wire (I tuned for better performance at 137MHz) and here is my final circuit (the inductor values are approximated):

<div id="attachment_258" style="width: 648px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter.png"><img aria-describedby="caption-attachment-258" class="wp-image-258 size-full" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter.png" alt="137MHz Bandpass Filter Schematic" width="638" height="431" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter.png 638w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter-300x203.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter-624x422.png 624w" sizes="(max-width: 638px) 100vw, 638px" /></a>
  
  <p id="caption-attachment-258" class="wp-caption-text">
    137MHz Bandpass Filter Schematic
  </p>
</div>

And here is how it looks like:

<div id="attachment_259" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054220.jpg"><img aria-describedby="caption-attachment-259" class="size-large wp-image-259" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054220-1024x576.jpg" alt="My test setup, HackRF as Noise Generator and RTLSDR as spectrum analyzer." width="625" height="352" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054220-1024x576.jpg 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054220-300x169.jpg 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054220-768x432.jpg 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054220-624x351.jpg 624w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-259" class="wp-caption-text">
    My test setup, HackRF as Noise Generator and RTLSDR as spectrum analyzer.
  </p>
</div>

<div id="attachment_260" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054225.jpg"><img aria-describedby="caption-attachment-260" class="size-large wp-image-260" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054225-1024x576.jpg" alt="Close up of the filter, doesn't look good but it works!" width="625" height="352" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054225-1024x576.jpg 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054225-300x169.jpg 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054225-768x432.jpg 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054225-624x351.jpg 624w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-260" class="wp-caption-text">
    Close up of the filter, doesn&#8217;t look good but it works!
  </p>
</div>

The first thing I did was to setup my &#8220;_Spectrum Analyzer_&#8221; (a.k.a. HackRF + RTLSDR) to test the filter response and tune the coils. My coils was wound very tight so I get the lowest possible response. Then I started stretching the coils until I reached the peak at 137MHz. Here is the response curve using QSpectrumAnalyzer and HackRF with sweep.

<div id="attachment_261" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterA.png"><img aria-describedby="caption-attachment-261" class="size-large wp-image-261" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterA-1024x762.png" alt="Filter Response, the red line is the peak response. Here is -31dB at 136.462MHz, check the baseline for comparsion." width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterA-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterA-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterA-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterA-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterA.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-261" class="wp-caption-text">
    Filter Response, the red line is the peak response. Here is -31dB at 136.462MHz, check the baseline for comparsion.
  </p>
</div>

<div id="attachment_262" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterB.png"><img aria-describedby="caption-attachment-262" class="size-large wp-image-262" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterB-1024x762.png" alt="Second measure of the filter, but now with 109MHz that is about the end of FM Band. You can see that the signal is -63dBm" width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterB-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterB-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterB-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterB-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterB.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-262" class="wp-caption-text">
    Second measure of the filter, but now with 109MHz that is about the end of FM Band. You can see that the signal is -63dBm
  </p>
</div>

<div id="attachment_263" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterC.png"><img aria-describedby="caption-attachment-263" class="size-large wp-image-263" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterC-1024x762.png" alt="And here is the baseline centered at 134MHz. This is without any filter (just HackRF to the RTLSDR output)" width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterC-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterC-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterC-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterC-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterC.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-263" class="wp-caption-text">
    And here is the baseline centered at 134MHz. This is without any filter (just HackRF to the RTLSDR output)
  </p>
</div>

I did the sweep for the baseline as well, and the response of HackRF => RTLSDR is very flat. The peak is always at about **-29.8dBm**. So my baseline is **-29.8dBm**.

Analyzing the values, at **136.242Mhz** I have a measure of  **-31.542dBm**, so about **1.7dB** Insertion Loss. Then for 109MHz I have **-63dBm** of signal, that is about **−33,2 dB** of rejection. Just for reference, this is the simulated filter response:

<div id="attachment_264" style="width: 890px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter_predict-1.png"><img aria-describedby="caption-attachment-264" class="size-full wp-image-264" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter_predict-1.png" alt="Simulated Filter Response at RFSim99" width="880" height="680" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter_predict-1.png 880w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter_predict-1-300x232.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter_predict-1-768x593.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter_predict-1-624x482.png 624w" sizes="(max-width: 880px) 100vw, 880px" /></a>
  
  <p id="caption-attachment-264" class="wp-caption-text">
    Simulated Filter Response at RFSim99
  </p>
</div>

The simulation goes a little more far beyonde the edges, but if you see, the graph is pretty close to what we expected. So then I decided to give a try and receive NOAA signals. For a coecidence, NOAA18 was just passing by, with center frequency of **137.9125MHz**. I also wanted to give a try using an LNA4ALL at the output of the filter (that otherwise would saturate due FM Signals).

<div id="attachment_265" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/noaa18_newfilter2.png"><img aria-describedby="caption-attachment-265" class="size-large wp-image-265" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/noaa18_newfilter2-1024x867.png" alt="The Spectrum of NOAA 18 transmission. About 25dB SNR" width="625" height="529" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/noaa18_newfilter2-1024x867.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/noaa18_newfilter2-300x254.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/noaa18_newfilter2-768x650.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/noaa18_newfilter2-624x528.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/noaa18_newfilter2.png 1160w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-265" class="wp-caption-text">
    The Spectrum of NOAA 18 transmission. About 25dB SNR
  </p>
</div>

[<img class="size-large wp-image-266 aligncenter" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304-759x1024.jpg" alt="Processed NOAA 18 image" width="625" height="843" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304-759x1024.jpg 759w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304-222x300.jpg 222w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304-768x1037.jpg 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304-624x842.jpg 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304.jpg 1040w" sizes="(max-width: 625px) 100vw, 625px" />](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304.jpg)

[<img class="size-large wp-image-267 aligncenter" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304_raw-1024x691.jpg" alt="NOAA18 Raw Image" width="625" height="422" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304_raw-1024x691.jpg 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304_raw-300x203.jpg 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304_raw-768x518.jpg 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304_raw-624x421.jpg 624w" sizes="(max-width: 625px) 100vw, 625px" />](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304_raw.jpg)

They are much better than it was before, and I&#8217;m running the filter / LNA at SDR end. If it was on the Antenna End the performance would be probably better. I still need to check the performance for LRPT Signals, but even for 2m HAM Band (145MHz) the filtering is very good!

Have fun!

&nbsp;

EDIT (15/11/2016) &#8211; My Meteor M N2 capture! The longest capture I ever did!

[<img class="alignnone size-large wp-image-270" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/2016_11_15_LRPT_10-15-44.s-RGB122-rectified-991x1024.jpg" alt="2016_11_15_lrpt_10-15-44-s-rgb122-rectified" width="625" height="646" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/11/2016_11_15_LRPT_10-15-44.s-RGB122-rectified-991x1024.jpg 991w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/2016_11_15_LRPT_10-15-44.s-RGB122-rectified-290x300.jpg 290w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/2016_11_15_LRPT_10-15-44.s-RGB122-rectified-768x793.jpg 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/11/2016_11_15_LRPT_10-15-44.s-RGB122-rectified-624x645.jpg 624w" sizes="(max-width: 625px) 100vw, 625px" />](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/2016_11_15_LRPT_10-15-44.s-RGB122-rectified.jpg)