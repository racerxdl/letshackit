---
title: "Satcom Projects | Lets Hack It"
description: "Satellite communications projects covering antenna hardware, software-defined radio, weather satellites, signal decoding, and open source ground stations."
image: "https://lucasteske.dev/assets/goes-satellite-hunt/g13fd.png"
---

Written by Lucas Teske   
on 18 February 2017

# Satcom Projects

Field notes, long-form guides, recordings, and open-source tools from more than a decade of receiving and decoding satellite signals.

Featured long-form guide · GOES-13 · LRIT
## GOES Satellite Hunt

Follow the complete path from building the L-band receiving hardware to recovering weather images: BPSK demodulation, CCSDS frame synchronization, Reed–Solomon correction, packet demultiplexing, and LRIT file assembly.

[Explore the guide](/goes-satellite-hunt/)[Start reading](/goes-satellite-hunt/motivation)

 ![GOES-13 full-disk infrared image of Earth decoded by the project](/assets/goes-satellite-hunt/g13fd.png)

1. [Receiving hardware](/goes-satellite-hunt/the-hardware-setup/)
2. [BPSK demodulation](/goes-satellite-hunt/the-demodulator/)
3. [Frame decoding](/goes-satellite-hunt/frame-decoder/)
4. [Packet demultiplexing](/goes-satellite-hunt/packet-demuxer/)
5. [LRIT file assembly](/goes-satellite-hunt/file-assembler/)

## Explore the archive

Projects range from first reception through complete, reusable decoding pipelines.

Project archive
### Satellite field notes

Browse the GOES experiments, NOAA and Meteor reception work, RF hardware, filters, and follow-up investigations.

[Browse all satellite projects](/satcom-projects/satellite-projects)

Open data
### Sample baseband recordings

Download real GOES-13 and GOES-16 IQ captures for developing and validating your own demodulators and decoders.

[Open the recording library](/satcom-projects/sample-baseband-files)

First reception
### NOAA and Meteor

Start with a home-built QFH antenna, RTL-SDR reception, GQRX recording, and a dedicated 137 MHz band-pass filter.

[Read the NOAA reception story](/2016/01/qfh-antenna-and-my-first-reception-of-noaa/)

Open source
### Open Satellite Project

The software and reusable tooling that grew out of GOES Satellite Hunt, including decoding and ground-station components.

[View the project on GitHub](https://github.com/opensatelliteproject)
