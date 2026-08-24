---
title: "Frame Decoder - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → Frame Decoder In the last chapter , I explained how I did the BPSK Demodulator for the LRIT Signal. Now I will explain how to decode the output of the data we..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# Frame Decoder

![Abstract digital pattern with vertical stripes in multicolored pixels, resembling corrupted data or glitch art.](/assets/goes-satellite-hunt/bitanalysis.png)

In the last chapter , I explained how I did the BPSK Demodulator for the LRIT Signal. Now I will explain how to decode the output of the data we got in the last chapter.

One thing that is worth mentioning is that most (if not all) weather satellites that transmit digital signals use the CCSDS standard packet format, or at least something based on it. For example this frame decoder can be used (with some modifications due QPSK instead BPSK) for LRPT Signals from Meteor Satellites (I plan to do a LRPT decoder as well in the future, and I will post about it). I will not describe my entire code here, just the pieces for decoding the data. I will also not write the entire code here, since it can be checked in github. So before start see the picture below (again). We will some info from it as well. ![Table listing key LRIT transmission parameters for GOES satellites, including modulation, frequency, and error correction details.](/assets/goes-satellite-hunt/lrit-specs.png)

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
