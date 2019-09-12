---
id: 33
title: GOES 16 in the house!
date: 2017-01-25T15:29:20-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=299
permalink: /2017/01/goes-16-in-the-house/
image: /wp-content/uploads/2017/01/201701251701745-10-624x624.gif
categories:
  - English
  - Reverse Engineering
  - Satellite
  - SDR
tags:
  - Airspy
  - Convolutional Code
  - Convolutional Encoding
  - EMWIN
  - English
  - GNU Radio
  - Gnuradio
  - GOES
  - GOES 16
  - GOES-R
  - GRC
  - HackRF
  - HRIT
  - LRIT
  - NOAA
  - Osmocom
  - RE
  - Reed Solomon
  - Root Raised Cosine Filter
  - Satellite
  - SDR
---
Few \*times\* ago I started to check on GOES 16 transmissions to see if I can get any data from it and make [OpenSatelliteProject](https://github.com/opensatelliteproject) work with it. Me and @usa_satcom noticed that the HRIT signal was transmitting using differential encoding that was not predicted on NOAA&#8217;s HRIT Specification (You can check it here <http://www.goes-r.gov/users/hrit-links.html> ). So I decided to send an email to NOAA asking what was the current HRIT specs for GOES-16. Of course I expected no answer from them (they would probably be really busy with GOES-16 Testing), but surprisingly they answered sending the specs and saying that any feedbacks would be helpful and appreciated. So the HRIT indeed uses Differential Encoding (NRZ-M to be more specific). Knowing that I could start changing OpenSatelliteProject to be compatible with HRIT.

<!--more-->

# NRZ-M Differential Encoding

The thing about Differential Encoding is that it removes the phase ambiguity problem. The NRZ-M specifically does that by setting that any bit 0 in the stream means the signal level keeps the same, and any bit 1 says that the bit was toggled from the latest state. Basically we have something like that:

Suppose we have this byte as stream: 0011 0100. Lets assume we start with  bit 0 (it works as well with 1):

  1. first bit is 0, then no change in level. Now we have ****
  2. second bit is 0, then no change in level. Now we have **00**
  3. 3rd bit is 1, then there is a toggle from last value. Now we have **001**
  4. 4th bit is 1, then there is a toggle from last value. Now we have **0010**
  5. 5th bit is 0 then no change in level. Now we have **00100**
  6. 6th bit is 1 then there is a change in level. Now we have **001001**
  7. 7th bit is 0 then no change in level. Now we have **0010011**
  8. 8th bit is 0 then no change in level. Now we have **00100111**

Got it? So a python script that does this operation bitwise would be like that:

<pre class="brush: python; title: ; notranslate" title="">bword = "00110100"
lastbit = "0"

for i in bword:
  if lastbit != i:
    encodedbword += "1"
    lastbit = "1"
  else:
    encodedbword += "0"
    lastbit = "0"
</pre>

In OpenSatelliteProject [libSatHelper](https://github.com/opensatelliteproject/libsathelper) I implemented a more efficient way by using byte-wise XORs to do the calc. Basically I shift the byte so all bits get xor&#8217;ed with the previous one. For example:

<pre class="brush: cpp; title: ; notranslate" title="">uint8_t lastBit = 0;
       uint8_t mask;
       for (int i=0; i&amp;lt;length; i++) { 
           mask = ((data[i] &amp;gt;&amp;gt; 1) &amp;amp; 0x7F) | (lastBit &amp;lt;&amp;lt; 7);
           lastBit = data[i] &amp;amp; 1;
           data[i] ^= mask;
       }
</pre>

That should work for decoding the NRZ-M. But there is another problem: Syncing and Viterbi (FEC).

# Syncing Data and Viterbi

Since we&#8217;re using soft symbols, we cannot just differential decode all data, or we would be hard decoding the symbols. So we need to run viterbi before the differential decoding. But then, the sync word wouldn&#8217;t match with those on LRIT decoding. For finding the new syncwords what I did was:

  1. Get the syncword **1ACFFC1D**
  2. Encode using NRZ-M for lastbit **** and **1**
  3. Encode using Convolutional Encoding **k=7** **r=1/2**

That way I got two new syncwords:

0xfc4ef4fd0cc2df89 and 0x25010b02f33d2076

With that, I could sync it perfectly considering the two phase ambiguities (they still happen, I just don&#8217;t need to care about it on decoder).

After syncing, I can just run viterbi as always to decode it. But before the data entering on my decoding chain for parsing the channel data, it needs to run over NRZ-M decoder. Then the rest keeps the same thing as LRIT.

# New Data

The Satellite is currently under test load. So it&#8217;s expected to have lot&#8217;s of fill frames. Indeed most of the time is sending Fill Frames (VCID 63), and some DCS Data (VCID 31). But I also got some images and there was one thing interesting on them: The NOAA Specific Header Compression was set to 5 instead of one. Further looking into file contents, I figured out that Compression = 5 means GIF file (It&#8217;s very easy to spot a GIF file since the data starts with GIF), and that was crashing my decompressor because it was intended to LRIT RICE. I did a few modifications at GOES Dump to handle GIF files and here are some of them:

[<img class="alignnone size-full wp-image-300" src="https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251701745-10.gif" alt="" width="720" height="720" />](https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251701745-10.gif)

<div id="attachment_301" style="width: 635px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251801945-USA_latest.gif"><img aria-describedby="caption-attachment-301" class="size-large wp-image-301" src="https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251801945-USA_latest-1024x663.gif" alt="" width="625" height="405" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251801945-USA_latest-1024x663.gif 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251801945-USA_latest-300x194.gif 300w, https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251801945-USA_latest-768x497.gif 768w, https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251801945-USA_latest-624x404.gif 624w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-301" class="wp-caption-text">
    Color charts!
  </p>
</div>

[<img class="alignnone size-full wp-image-302" src="https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251801258-gehov1latest.gif" alt="" width="640" height="960" />](https://www.teske.net.br/lucas/wp-content/uploads/2017/01/201701251801258-gehov1latest.gif)

&nbsp;

I will keep checking for any GOES-16 specific images and I will post here when I have news.