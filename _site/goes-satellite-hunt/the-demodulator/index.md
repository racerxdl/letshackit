---
title: "The Demodulator - GOES Satellite Hunt | Lets Hack It"
description: "Written by Lucas Teske on 19 February 2017 Part of GOES Satellite Hunt Project overview → The Demodulator In last chapter I explained how I manage to build a reception system to get the GOES LRIT Signal. Now I will explain how to get the packets out of the LRIT..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Written by Lucas Teske   
on 19 February 2017

# 

# The Demodulator

In last chapter I explained how I manage to build a reception system to get the GOES LRIT Signal. Now I will explain how to get the packets out of the LRIT signal. I choose the LRIT signal basically because of two reasons:

1. It contains basically all EMWIN data + Full Disks from GOES 13 and 15.
2. Less complexity on the demodulator side (Simple BPSK Demodulator)

This is the LRIT Specification (theoretically):

![Table listing key LRIT transmission parameters for GOES satellites, including modulation, frequency, and error correction details.](/assets/goes-satellite-hunt/lrit-specs.png)

## Cite this work

### Suggested citation

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
