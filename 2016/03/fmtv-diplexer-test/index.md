---
title: "FM/TV Diplexer Test | Lets Hack It"
description: "Solve RTL-SDR signal saturation with a commercial FM/TV diplexer. This test shows how to filter strong FM signals for better NOAA reception."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# FM/TV Diplexer Test

Written by Lucas Teske   
on 24 March 2016

So it has been a time since my last post (again). Today I’m writing about a TV/FM Diplexer that I bought to address an issue that I’m having here with my NOAA stuff.

So the biggest problem is that in São Paulo the FM Radio (88-110MHz) are&nbsp; **VERY** strong. I can receive a -40dBm signal with a RTL-SDR with no gains in almost all channels. This is a big issue since the ~~RTL-SDR does not have a input filter~~ (actually it has, see my patches at&nbsp;[https://github.com/librtlsdr/librtlsdr](https://github.com/librtlsdr/librtlsdr)&nbsp;) the LNA gets very easily saturated when getting gains over 25dB (usually needed by APT Signals). So I started to search for a FM Band Stop Filter. But it turned that it was not so simple to do a good FM Band Stop Filter.

So I started searching for a commercial filter, and I noticed that most of the FM Filters were discontinued a few years ago and the only thing I could find was a FM/TV Diplexer.

[![FM/TV Diplexer](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fmtvdiplexer-1024x902.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fmtvdiplexer.jpg)

So the idea behind a diplexer is that it has a common input (or output depending on the direction that is used) that have FM + TV Signals. To separate (or combine) there is a low pass for the FM Band (Usually the lowpass cuts at something around 115MHz, and there is a High Pass to the TV Band that cuts on the same freq. So I wanted to use the TV Band and strip the FM Band. So I hooked up the input as my [QFH antenna](https://www.teske.net.br/lucas/2016/01/qfh-antenna-and-my-first-reception-of-noaa/)&nbsp;, the RTL-SDR on one of the outputs and started [qspectrumanalyzer](https://github.com/xmikos/qspectrumanalyzer)&nbsp;to analyze the filter response and put a 75 Ohm terminator on the other output.

[![FM/TV Diplexer](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fm_tv_diplexer.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/fm_tv_diplexer.jpg)

So here is the result:

[![Without the Diplexer (Diret to antenna) - Spectrum from 50 to 300MHz](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithoutDiplexer-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithoutDiplexer.png)

Without the Diplexer (Diret to antenna) – Spectrum from 50 to 300MHz

[![With the Diplexer, with terminator on the FM Side (RTL on the TV Side)](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexer-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexer.png)

With the Diplexer, with terminator on the FM Side (RTL on the TV Side)

[![With the Diplexer. Terminator on the TV Side (RTL-SDR on the FM Side)](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexerTVSide-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/03/T_WithDiplexerTVSide.png)

With the Diplexer. Terminator on the TV Side (RTL-SDR on the FM Side)

So the filter looks amazing. It has a base attenuation of around 20dB. This should give me enough room for a LNA. Also check that the other band remains basically unaltered.

So soon as possible I will post new results of APT Signals capture. Stay tuned!

## Cite this article

### Suggested citation

Lucas Teske. “FM/TV Diplexer Test.” _Lets Hack It_, 2016. [https://lucasteske.dev/2016/03/fmtv-diplexer-test/](https://lucasteske.dev/2016/03/fmtv-diplexer-test/).

### BibTeX

```
@misc{teske2016fmtvdiplexertest,
  author = {Lucas Teske},
  title = {FM/TV Diplexer Test},
  year = {2016},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/2016/03/fmtv-diplexer-test/}
}
```
