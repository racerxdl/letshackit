---
title: "GOES Satellite Hunt | Lets Hack It"
description: "A complete practical guide to receiving GOES-13 LRIT, from L-band antenna hardware and BPSK demodulation through CCSDS decoding and weather-image assembly."
image: "https://lucasteske.dev/assets/goes-satellite-hunt/g13fd.png"
---

Written by Lucas Teske   
on 19 February 2017

# 

Long-form field guide · GOES-13 · Published 2017
# GOES Satellite Hunt

Build an L-band ground station and follow every transformation from radio-frequency samples to complete LRIT weather products. The guide connects practical RF hardware, GNU Radio, channel coding, CCSDS frames, packet transport, and image files as one system.

[Start with the motivation](/goes-satellite-hunt/motivation)[Open Satellite Project](https://github.com/opensatelliteproject)

 ![GOES-13 full-disk infrared image of Earth recovered from the LRIT broadcast](/assets/goes-satellite-hunt/g13fd.png)

1. [Receive the L-band signal](/goes-satellite-hunt/the-hardware-setup/)
2. [Recover BPSK symbols](/goes-satellite-hunt/the-demodulator/)
3. [Decode CCSDS frames](/goes-satellite-hunt/frame-decoder/)
4. [Extract virtual channels](/goes-satellite-hunt/packet-demuxer/)
5. [Assemble LRIT products](/goes-satellite-hunt/file-assembler/)

## From a signal to an image

A practical record of the investigation, organized as a reusable technical guide.

This work began as a five-part blog series written while I was reverse engineering the GOES-13 downlink at the end of 2016. I reorganized it here to explain the complete receive chain coherently and to keep the material useful alongside the GOES-16 research that followed.

The investigation led directly to [Open Satellite Project](https://github.com/opensatelliteproject). Many of the same ideas also apply to weather satellites with related downlink protocols, including the Meteosat family.

## Chapters

Read in order for the complete pipeline, or jump directly to the layer you are implementing.

01Context
### Motivation

Why receive GOES directly, what the project set out to prove, and how the complete system fits together.

[Begin the guide](/goes-satellite-hunt/motivation)

02RF hardware
### The hardware setup

Assemble the dish, build a cylindrical waveguide feed, add filtering and amplification, and point the antenna.

[Build the receiver](/goes-satellite-hunt/the-hardware-setup/)

03Signal processing
### The demodulator

Move the recorded spectrum to baseband, filter and resample it, recover carrier and clock, and output BPSK symbols.

[Recover the symbols](/goes-satellite-hunt/the-demodulator/)

04Channel coding
### Frame decoder

Find the attached sync marker, resolve phase ambiguity, apply Viterbi decoding, and recover fixed-size CCSDS frames.

[Decode the frames](/goes-satellite-hunt/frame-decoder/)

05Transport
### Packet demultiplexer

De-randomize the stream, correct Reed–Solomon errors, separate virtual channels, and reconstruct space packets.

[Extract the packets](/goes-satellite-hunt/packet-demuxer/)

06Products
### Files and LRIT formats

Process LRIT headers, decompress Rice-coded imagery, name the products, and interpret the complete file catalogue.

[Assemble the files](/goes-satellite-hunt/file-assembler/)

[Browse the LRIT file reference](/goes-satellite-hunt/file-types/)[Read the conclusion](/goes-satellite-hunt/ending)

This guide is published under the [Creative Commons Attribution-ShareAlike license](https://creativecommons.org/licenses/by-sa/2.5/br/); corrections are welcome.

Thanks to the **#hearsat** community on StarChat for helping me learn satellite SDR, especially [@usa-satcom](https://twitter.com/usa_satcom) and [@devnulling](https://twitter.com/devnulling), and to my family for supporting a roof full of dishes and antennas.

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
