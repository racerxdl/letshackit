---
id: 173
title: FM/TV Diplexer Test
date: 2016-03-23T22:29:24-03:00
author: racerxdl
layout: post
guid: http://www.teske.net.br/lucas/?p=173
permalink: /2016/03/fmtv-diplexer-test/
categories:
  - SDR
tags:
  - Band Pass
  - Band Stop
  - Diplexer
  - Filter
  - FM
  - FM TV Diplexer
  - High Pass
  - Linux
  - Low Pass
  - qspectrumanalyzer
  - RTL SDR
  - RTLSDR
  - SDR
  - TV
---
So it has been a time since my last post (again). Today I&#8217;m writting about a TV/FM Diplexer that I bought to address a issue that I&#8217;m having here with my NOAA stuff.

So the biggest problem is that in São Paulo the FM Radio (88-110MHz) are **VERY** strong. I can receive a -40dBm signal with a RTL-SDR with no gains in almost all channels. This is a big issue since the <del>RTL-SDR does not have a input filter</del> (actually it has, see my patches at <https://github.com/librtlsdr/librtlsdr> ) the LNA gets very easily saturated when getting gains over 25dB (usually needed by APT Signals). So I start to search for a FM Band Stop Filter. But it turned that it was not so simple to do a good FM Band Stop Filter.

So I started searching for a commercial filter, and I noticed that most of the FM Filters were discontinued a few years ago and the only thing I could find was a FM/TV Diplexer.

<a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fmtvdiplexer.jpg" rel="attachment wp-att-175"><img class="alignnone size-large wp-image-175" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fmtvdiplexer-1024x902.jpg" alt="FM/TV Diplexer" width="625" height="551" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fmtvdiplexer-1024x902.jpg 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fmtvdiplexer-300x264.jpg 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fmtvdiplexer-768x677.jpg 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fmtvdiplexer-624x550.jpg 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fmtvdiplexer.jpg 1076w" sizes="(max-width: 625px) 100vw, 625px" /></a>

<!--more-->

So the idea behing is a diplexer is that it have a common input (or output depending on the direction that is used) that have FM + TV Signals. To separate (or combine) there is a low pass for the FM Band (Usually the lowpass cuts at something arround 115MHz, and there is a High Pass to the TV Band that cuts on the same freq. So I wanted to use the TV Band and strip the FM Band. So I hooked up the input as my [QFH antenna](https://www.teske.net.br/lucas/2016/01/qfh-antenna-and-my-first-reception-of-noaa/) , the RTL-SDR on one of the outputs and started [qspectrumanalyzer](https://github.com/xmikos/qspectrumanalyzer) to analyze the filter response and put a 75 Ohm terminator on the other output.

<a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fm_tv_diplexer.jpg" rel="attachment wp-att-174"><img class="alignnone size-full wp-image-174" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fm_tv_diplexer.jpg" alt="FM/TV Diplexer" width="560" height="995" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fm_tv_diplexer.jpg 560w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fm_tv_diplexer-169x300.jpg 169w" sizes="(max-width: 560px) 100vw, 560px" /></a>

So here is the result:

<div id="attachment_176" style="width: 635px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithoutDiplexer.png" rel="attachment wp-att-176"><img aria-describedby="caption-attachment-176" class="size-large wp-image-176" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithoutDiplexer-1024x762.png" alt="Without the Diplexer (Diret to antenna) - Spectrum from 50 to 300MHz" width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithoutDiplexer-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithoutDiplexer-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithoutDiplexer-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithoutDiplexer-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithoutDiplexer.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-176" class="wp-caption-text">
    Without the Diplexer (Diret to antenna) &#8211; Spectrum from 50 to 300MHz
  </p>
</div>

<div id="attachment_177" style="width: 635px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexer.png" rel="attachment wp-att-177"><img aria-describedby="caption-attachment-177" class="size-large wp-image-177" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexer-1024x762.png" alt="With the Diplexer, with terminator on the FM Side (RTL on the TV Side)" width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexer-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexer-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexer-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexer-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexer.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-177" class="wp-caption-text">
    With the Diplexer, with terminator on the FM Side (RTL on the TV Side)
  </p>
</div>

<div id="attachment_178" style="width: 635px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexerTVSide.png" rel="attachment wp-att-178"><img aria-describedby="caption-attachment-178" class="size-large wp-image-178" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexerTVSide-1024x762.png" alt="With the Diplexer. Terminator on the TV Side (RTL-SDR on the FM Side)" width="625" height="465" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexerTVSide-1024x762.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexerTVSide-300x223.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexerTVSide-768x572.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexerTVSide-624x465.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexerTVSide.png 1080w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-178" class="wp-caption-text">
    With the Diplexer. Terminator on the TV Side (RTL-SDR on the FM Side)
  </p>
</div>

So the filter looks amazing. It have a base atenuation arround 20dB. This should give me enough room for a LNA. Also check that the other band remains basically inaltered.

So soon as possible I will post new results of APT Signals capture. Keep noticed!