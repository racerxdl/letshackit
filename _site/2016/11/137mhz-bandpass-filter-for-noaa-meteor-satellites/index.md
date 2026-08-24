---
title: "137MHz Bandpass filter for NOAA / Meteor Satellites | Lets Hack It"
description: "Build a 137MHz bandpass filter for NOAA and Meteor satellites. DIY electronics project using HackRF and RTLSDR for testing."
image: "https://lucasteske.dev/wp-content/uploads/2016/11/newfilter_predict-624x482.png"
---

# 137MHz Bandpass filter for NOAA / Meteor Satellites

 ![137MHz Bandpass filter for NOAA / Meteor Satellites](/wp-content/uploads/2016/11/newfilter_predict-624x482.png)Written by Lucas Teske   
on 13 November 2016

Yesterday I saw a new blog post by Adam (9a4qv) in LNA4ALL. The post ([here](http://lna4all.blogspot.com.br/2015/11/diy-137-mhz-wx-sat-bp-filter.html)) talks about a band pass filter he did for Weather Satellites and I decided to try as well.

Unfortunately I don’t have a exact match for that components at home, so I tried to do something with the components I have. So the lower value I had for capacitors was 10pF, and the needed values for Adam’s Filter is 1pF, 4.7pF and 15pF. I decided then to use 10 in series to do the 1pF, 2 in series for the 4.7pF (that will be 5pF) and then one in parallel with two in series to give me the 15pF. Its a very close match, and I’m unsure about the effects of serialization of capacitors in the filter (increase inductance maybe?). So here is the results.

So my circuit was a little different from Adam’s circuit. The coils are 3 turn very spaced wire (I tuned for better performance at 137MHz) and here is my final circuit (the inductor values are approximated):

[![137MHz Bandpass Filter Schematic](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter.png)

137MHz Bandpass Filter Schematic

And here is how it looks like:

[![My test setup, HackRF as Noise Generator and RTLSDR as spectrum analyzer.](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054220-1024x576.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054220.jpg)

My test setup, HackRF as Noise Generator and RTLSDR as spectrum analyzer.

[![Close up of the filter, doesn't look good but it works!](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054225-1024x576.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113_054225.jpg)

Close up of the filter, doesn’t look good but it works!

The first thing I did was to setup my “_Spectrum Analyzer_” (a.k.a. HackRF + RTLSDR) to test the filter response and tune the coils. My coils was wound very tight so I get the lowest possible response. Then I started stretching the coils until I reached the peak at 137MHz. Here is the response curve using QSpectrumAnalyzer and HackRF with sweep.

[![Filter Response, the red line is the peak response. Here is -31dB at 136.462MHz, check the baseline for comparison.](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterA-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterA.png)

Filter Response, the red line is the peak response. Here is -31dB at 136.462MHz, check the baseline for comparison.

[![Second measure of the filter, but now with 109MHz that is about the end of FM Band. You can see that the signal is -63dBm](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterB-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterB.png)

Second measure of the filter, but now with 109MHz that is about the end of FM Band. You can see that the signal is -63dBm

[![And here is the baseline centered at 134MHz. This is without any filter (just HackRF to the RTLSDR output)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterC-1024x762.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/filterC.png)

And here is the baseline centered at 134MHz. This is without any filter (just HackRF to the RTLSDR output)

I did the sweep for the baseline as well, and the response of HackRF =\> RTLSDR is very flat. The peak is always at about **-29.8dBm**. So my baseline is **-29.8dBm**.

Analyzing the values, at **136.242Mhz** I have a measure of &nbsp; **-31.542dBm** , so about **1.7dB** Insertion Loss. Then for 109MHz I have&nbsp; **-63dBm** of signal, that is about&nbsp; **−33,2 dB** of rejection. Just for reference, this is the simulated filter response:

[![Simulated Filter Response at RFSim99](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter_predict-1.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/newfilter_predict-1.png)

Simulated Filter Response at RFSim99

The simulation goes a little more far beyonde the edges, but if you see, the graph is pretty close to what we expected. So then I decided to give a try and receive NOAA signals. For a coecidence, NOAA18 was just passing by, with center frequency of&nbsp; **137.9125MHz**. I also wanted to give a try using an LNA4ALL at the output of the filter (that otherwise would saturate due FM Signals).

[![The Spectrum of NOAA 18 transmission. About 25dB SNR](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/noaa18_newfilter2-1024x867.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/noaa18_newfilter2.png)

The Spectrum of NOAA 18 transmission. About 25dB SNR

[![Processed NOAA 18 image](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304-759x1024.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304.jpg)

[![NOAA18 Raw Image](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304_raw-1024x691.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/20161113065304_raw.jpg)

They are much better than it was before, and I’m running the filter / LNA at SDR end. If it was on the Antenna End the performance would be probably better. I still need to check the performance for LRPT Signals, but even for 2m HAM Band (145MHz) the filtering is very good!

Have fun!

&nbsp;

EDIT (15/11/2016) – My Meteor M N2 capture! The longest capture I ever did!

[![2016_11_15_lrpt_10-15-44-s-rgb122-rectified](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/2016_11_15_LRPT_10-15-44.s-RGB122-rectified-991x1024.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/11/2016_11_15_LRPT_10-15-44.s-RGB122-rectified.jpg)

## Cite this article

### Suggested citation

Lucas Teske. “137MHz Bandpass filter for NOAA / Meteor Satellites.” _Lets Hack It_, 2016. [https://lucasteske.dev/2016/11/137mhz-bandpass-filter-for-noaa-meteor-satellites/](https://lucasteske.dev/2016/11/137mhz-bandpass-filter-for-noaa-meteor-satellites/).

### BibTeX

```
@misc{teske2016137mhzbandpassfilterfornoaameteorsat,
  author = {Lucas Teske},
  title = {137MHz Bandpass filter for NOAA / Meteor Satellites},
  year = {2016},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/2016/11/137mhz-bandpass-filter-for-noaa-meteor-satellites/}
}
```
