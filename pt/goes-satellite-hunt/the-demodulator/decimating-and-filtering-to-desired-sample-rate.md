---
title: "Decimating and filtering to desired sample rate - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → Decimating and filtering to desired sample rate The next step is to decimate to reach the 2.5e6 of sample rate. For the airspy mini that is 15/18 of the 3e6 sample rate...."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# Decimating and filtering to desired sample rate

The next step is to decimate to reach the 2.5e6 of sample rate. For the airspy mini that is 15/18 of the 3e6 sample rate. So lets create a Rational Resampler block and put&nbsp; **15** as interpolation and&nbsp; **18** as decimation. The taps can be empty since it will auto-generate. This is not very optimal, but will work for now. I will release a better version for each SDR in the future.

![Osmocom source block with sample rate, frequency, and gain settings, connected to a rational resampler.](/assets/goes-satellite-hunt/resampler.png)

Now we have 2.5 Msps and we need to decimate by two. But we will also lowpass the input to something close our rate. So let’s create a Low Pass filter with&nbsp; **Decimation as 2** ,&nbsp; **Sample Rate as 2.5e6** ,&nbsp;**Cut Off Frequency as symbol\_rate \* 2 (that is 587766)**,&nbsp; **Transition Width as 50e3**.

![Low Pass Filter block with decimation 2, cutoff 587.766k, Kaiser window, beta 6.76](/assets/goes-satellite-hunt/decimation.png)

After that we will have the sample rate is&nbsp; **1.25e6&nbsp;**

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
