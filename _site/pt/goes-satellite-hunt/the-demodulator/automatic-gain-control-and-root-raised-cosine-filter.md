---
title: "Automatic Gain Control and Root Raised Cosine Filter - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → Automatic Gain Control and Root Raised Cosine Filter For better performance we should keep our signal in a constant level regardless of the input signal. For that we will use a Automatic..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# Automatic Gain Control and Root Raised Cosine Filter

For better performance we should keep our signal in a constant level regardless of the input signal. For that we will use a Automatic Gain Control, that will do a Software Gain (basically just multiply the signal) that does not change the resolution (so it will not give a better signal) but will sure keep our level constant. We can use the simple&nbsp; **AGC** block from GNU Radio.

![AGC block with parameters: Rate 10m, Reference 500m, Gain 500m, Max Gain 4k.](/assets/goes-satellite-hunt/agc.png)

With&nbsp; **rate as 10e-3** ,&nbsp; **Reference as 0.5** ,&nbsp; **Gain as 0.5** ,&nbsp; **Max Gain as 4000**.

Another step is the RRC Filter (Root Raised Cosine Filter). This is a filter optimized for nPSK modulations and uses as a parameter our symbol rate. The Filter is not very hard to generate (its a FIR with some specific taps), but luckily GNU Radio provide a block for us.

![Root Raised Cosine Filter block with parameters: decimation 1, sample rate 1.25M, symbol rate 293.883k, alpha 500m, 361 taps.](/assets/goes-satellite-hunt/rrc.png)

For the parameters we will use&nbsp; **1.25e6 as sample rate** ,&nbsp; **293883 as Symbol Rate** ,&nbsp; **0.5 as Alpha** and **361 as Num Taps**. From these parameters, Alpha and Symbol Rate is provided from the specification. The number of taps you can experiment with, but I found that a good balance between quality vs performance was at 361 taps. After that we should have basically a signal that contains only the BPSK Modulated signal (or noise in the same band). Then we can go to Synchronization and Clock Recovery.

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
