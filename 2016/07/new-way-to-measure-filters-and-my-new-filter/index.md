---
title: "New way to measure filters and my new filter | Lets Hack It"
description: "Construa um filtro FM Trap e teste-o com HackRF e GNU Radio. Veja como eliminar ruídos na banda FM e medir a resposta do filtro com precisão."
image: "https://lucasteske.dev/wp-content/uploads/2016/07/20160722_190915-624x351.jpg"
---

# New way to measure filters and my new filter

 ![New way to measure filters and my new filter](/wp-content/uploads/2016/07/20160722_190915-624x351.jpg)Written by Lucas Teske   
on 22 July 2016

So I’m still mad about the FM Spectrum (88-108MHz) noise I get when using a LNA or something else. So I’m still looking for a nice and easy way to filter out these signals.

Last time I posted about a TV/FM Diplexer, that works great, but doesn’t attenuate enough the signals. So the solution would be cascading several of them, but I found that is very hard to find one Diplexer or FM Trap filter those days.

So I started looking out how to make my own filters. So I reopened Adam’s Website ([LNA4ALL](http://lna4all.blogspot.com.br/2015/10/diy-fm-trap-or-88-108-mhz-band-stop.html)) that have a small filter he did for FM Trap and tried (again) to make my own.

This time I tried to find capacitors that actually matches the values that it was calculated. I found here 2 56pF caps and 2 47pF caps. The two 47 is to make in parallel so I would have something around 23.5pF that is close enough for the center tap 20pF cap.

Also I found a coil of 0,35mm diameter wire here, that’s exactly what he used. I also got a copper pipe to do the coil wind. So this is how the filter went out:

[![My FM Trap Filter](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/20160722_190915-1024x576.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/20160722_190915.jpg)

So first I tested with SDR# with a real receiving FM Band and my HackRF to have a good wide spectrum (20MHz). Here is what it looks without the filter:

[![FM Spectrum Unfiltered](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-unfiltered-1024x282.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-unfiltered.png)

PS: The frequency bar is inverted, who knows why.

And here is what it looks like with my filter:

[![FM Spectrum Filtered](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-filtered-1024x287.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/hackrf-filtered.png)

I got impressed this time, because it really made a big difference. I also played with the coils stretching and compressing to change the center frequency. But as you can see, there are still some very high signals there. This generates a lot of background noise (in HackRF more than RTLSDR because of the IF Filters).

So I decided to find a better way to measure my filter response, since I don’t have a wideband noise generator. My idea was to go to GNU Radio and put my HackRF to generate a wideband Noise signal. This could easily be done by putting a White Noise Source directly to Osmocom output. I also added a Slider to range the output frequency from 20MHz to 160MHz, so I can do a wide analysis of the filter.[![GNU Radio Noise Generator](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-15-17.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-15-17.png)

So first I wanted to setup a baseline profile of the HackRF Output in the spectrum. For that I just got the output of HackRF through a 3dB attenuator and to my RTLSDR. I used QSpectrumAnalyzer as before with the range from 50MHz to 160MHz and 100kHz steps. This time for some weird reason I got some notching at the QSpectrumAnalyzer between the frequency steps.

[![The HackRF Output Centered at 100MHz](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline.png)

The HackRF Output Centered at 100MHz

[![Frequency Sweeped Peak Baseline](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline2-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/baseline2.png)

Frequency Sweeped Peak Baseline

So my Output are not very linear (maybe because of the Attenuator, or the impedance mismatch (the HackRF is 50 Ohms and the RTLSDR is 75 Ohms), but still this will give a very good idea of how is the shape of the Filter Curve. So here it is:

[![My FM Trap Filter response](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-00-52-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-19-00-52.png)

My FM Trap Filter response

So as you can see, my notch is at 103MHz. But sadly I still get moderated high signal at 106MHz (that still have some radio stations). The good thing is that this time I got it right, the bandwidth is from 88-108MHz, and since it is a 3-pole filter, it was expected to not have a very wide attenuation band. So by this new way of testing, I decided to re-test my TV/FM Diplexer, with this technique, so I could have a more precise curve. And here is the result:

[![TV/FM Diplexer Response](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-18-48-09-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/07/Captura-de-tela-de-2016-07-22-18-48-09.png)

TV/FM Diplexer Response

So as you can see, the TV/FM Diplexer has a very wide band stop filtering and completely (-30dB) attenuates the FM Spectrum. So probably this filter is still my best way around. I hope I can make better filters in the future (I ordered a lot of capacitors with a lot of values so I can keep making better filters).

I hope this information is useful for you, reader. I will keep posting news about my Crusade against the FM Band

## Cite this article

### Suggested citation

Lucas Teske. “New way to measure filters and my new filter.” _Lets Hack It_, 2016. [https://lucasteske.dev/2016/07/new-way-to-measure-filters-and-my-new-filter/](https://lucasteske.dev/2016/07/new-way-to-measure-filters-and-my-new-filter/).

### BibTeX

```
@misc{teske2016newwaytomeasurefiltersandmynewfilter,
  author = {Lucas Teske},
  title = {New way to measure filters and my new filter},
  year = {2016},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/2016/07/new-way-to-measure-filters-and-my-new-filter/}
}
```
