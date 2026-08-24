---
title: "GNU Radio Flow - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → GNU Radio Flow Let’s get our hands to GNU Radio and build our demodulator. So in GNU Radio we will have some additional blocks along the Costas Loop and M&M Recovery. I..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# GNU Radio Flow

Let’s get our hands to GNU Radio and build our demodulator. So in GNU Radio we will have some additional blocks along the Costas Loop and M&M Recovery. I will be using Airspy R2 / Mini so the values are for them, but I will soon provide also a version for RTLSDR (that will just have different values for the first steps). As suggested by Trango in #hearsat, is best to run the sample rate a bit low in airspy to avoid USB Packet Losses (to be honest I never had any USB packet drop with airspy or hackrf, but this will heavily depend on the CPU and USB Controller that you have on your machine. So its better to be safe than sorry.). For Airspy R2 we will use 2.5 Msps, and for Airspy mini we can use 3 Msps. Our target sample rate for the whole process is 1.25Msps (actually we can use anything near that value). Let’s start with the osmocom block:

![Osmocom source configuration panel showing device arguments and channel settings for airspy radio.](/assets/goes-satellite-hunt/osmocom-source.png)

Let’s set the Sample rate to&nbsp; **3e6** , the Center Frequency to&nbsp; **1691e6** and all gains to&nbsp; **15**. For the gains setting you can experiment your own values, but I found that I get the best SNR with everything maxed out (thats not very common). Also Osmocom Source has a “bug” for airspy, that is it doesn’t get the Mixer Gain Available (just because its not BB gain. That’s stupid.). I made a patch (that was actively rejected because of the Gain name) to map the Mixer gain to BB gain (as it is for RTLSDR). In the future I will probably do a new GRC Block to use with airspy with the correct names and stuff, but for now you can compile gr-osmosdr from source code using my fork:&nbsp;[https://github.com/racerxdl/gr-osmosdr](https://github.com/racerxdl/gr-osmosdr).

## Cite este trabalho

### Citação sugerida

Lucas Teske. “GOES Satellite Hunt.” _Lets Hack It_, 2017. [https://lucasteske.dev/goes-satellite-hunt/](https://lucasteske.dev/goes-satellite-hunt/).

### BibTeX

```
@misc{teske2017goessatellitehunt,
  author = {Teske, Lucas},
  title = {GOES Satellite Hunt},
  year = {2017},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/goes-satellite-hunt/}
}
```
