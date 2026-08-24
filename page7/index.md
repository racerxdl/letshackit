---
title: "Home | Lets Hack It"
description: "November 02, 2016 GOES Satellite Hunt (Part 3 – Frame Decoder) In the last chapter of GOES Satellite Hunt, I explained how I did the BPSK Demodulator for the LRIT Signal. Now I will explain how to decode the output of the data we got in the last chapter. One..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

November 02, 2016
# [GOES Satellite Hunt (Part 3 – Frame Decoder)](/2016/11/goes-satellite-hunt-part-3-frame-decoder/)

 ![](/wp-content/uploads/2016/11/qqk3UwA-624x135.png)

In the last chapter of GOES Satellite Hunt, I explained how I did the BPSK Demodulator for the LRIT Signal. Now I will explain how to decode the output of the data we got in the last chapter. One thing that is worth mentioning is that most (if not all) weather satellites that transmit digital signals use the CCSDS standard packet format, or at least something based on it. For example this frame decoder can be used (with some modifications due QPSK instead BPSK) for LRPT Signals from Meteor Satellites (I plan to do a LRPT decoder as well in...

October 31, 2016
# [GOES Satellite Hunt (Part 2 – Demodulator)](/2016/10/goes-satellite-hunt-part-2-demodulator/)

 ![](/wp-content/uploads/2016/10/Captura-de-tela-de-2016-10-29-23-25-17-624x378.png)

In the last episode of my GOES Satellite Hunt I explained how I manage to build a reception system to get the GOES LRIT Signal. Now I will explain how to get the packets out of the LRIT signal. I choose the LRIT signal basically because of two reasons: It contains basically all EMWIN data + Full Disks from GOES 13 and 15. Less complexity on the demodulator side (Simple BPSK Demodulator) This is the LRIT Specification (theoretically): Demodulator in GNU Radio So first things first. We successfully acquired a LRIT signal from GOES. Our first step is to demodulate...

October 18, 2016
# [GOES Satellite Hunt (Part 1 – Antenna System)](/2016/10/goes-satellite-hunt-part-1-antenna-system/)

 ![](/wp-content/uploads/2016/10/Sem-t%C3%ADtulo.png)

So few people know that I started a crusade against GOES 13 Satellite. My idea was to capture the GOES 13 signal (that’s reachable in São Paulo) with a good SNR (enough to decode) and then make all the tools to demodulate, decode and output the images and other data they send. I wanted a high-res image, and the L-Band transmissions usually provide that (GOES for example is 1km/px with whole earth sphere in frame. A 10000 x 10000 pixels image) So I choose GOES over other Weather Satellites mainly because GOES is a Geostationary Satellite. That means its position...

July 22, 2016
# [New way to measure filters and my new filter](/2016/07/new-way-to-measure-filters-and-my-new-filter/)

 ![](/wp-content/uploads/2016/07/20160722_190915-624x351.jpg)

So I’m still mad about the FM Spectrum (88-108MHz) noise I get when using a LNA or something else. So I’m still looking for a nice and easy way to filter out these signals. Last time I posted about a TV/FM Diplexer, that works great, but doesn’t attenuate enough the signals. So the solution would be cascading several of them, but I found that is very hard to find one Diplexer or FM Trap filter those days. So I started looking out how to make my own filters. So I reopened Adam’s Website (LNA4ALL) that have a small filter he...

March 24, 2016
# [FM/TV Diplexer Test](/2016/03/fmtv-diplexer-test/)

So it has been a time since my last post (again). Today I’m writing about a TV/FM Diplexer that I bought to address an issue that I’m having here with my NOAA stuff. So the biggest problem is that in São Paulo the FM Radio (88-110MHz) are&nbsp;VERY strong. I can receive a -40dBm signal with a RTL-SDR with no gains in almost all channels. This is a big issue since the RTL-SDR does not have a input filter (actually it has, see my patches at&nbsp;https://github.com/librtlsdr/librtlsdr&nbsp;) the LNA gets very easily saturated when getting gains over 25dB (usually needed by APT...
