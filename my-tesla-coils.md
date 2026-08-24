---
title: "My Tesla Coils | Lets Hack It"
description: "A visual archive of Lucas Teske's SSTC, DRSSTC, and spark-gap Tesla coil projects, including musical arcs, FPGA control, technical notes, photos, and recordings."
image: "https://lucasteske.dev/wp-content/uploads/2016/11/5620739994_1080ae890f_o.jpg"
---

Written by Lucas Teske   
on 28 November 2016

# My Tesla Coils

High voltage · resonant power · 2011–2012
## Resonant power, FPGA-controlled sparks, and a little music.

A workshop archive of SSTCs, DRSSTCs, musical interrupters, experimental feedback circuits, and the long evolution of ZARC—from a 600 W prototype to a four-channel FPGA-controlled machine.

[Explore the major builds](#coil-milestones)[Browse bench experiments](#coil-experiments)

13documented builds

16recordings

2011–2012archive period

![Purple electrical arcs branching from the ZARC DRSSTC in a dark workshop](/wp-content/uploads/2016/11/5620739994_1080ae890f_o.jpg)
_ZARC DRSSTC in action_

Workshop log
## An archive of sparks, failures, and working hardware

These are the builds that survived well enough to document. Together they trace experiments with switching devices, feedback, tuning, audio modulation, mechanical construction, and FPGA control.

Dates refer to video uploads rather than exact build dates. Recording and upload were usually close together.

SSTCAugust 27, 2012

### ZINC SSTC

Audio-modulated portable coil

The last Tesla coil I built was a compact SSTC driven by two IRFP250N MOSFETs and a protoboard GDT driver. I designed it to travel, so I could demonstrate musical arcs away from the workshop using ZARC's audio interrupter.

- SSTC
- 2 × IRFP250N
- Audio

[![](https://i.ytimg.com/vi/vFWoArNIBew/hqdefault.jpg) ZINC demonstration ](https://www.youtube.com/watch?v=vFWoArNIBew)

SSTCNovember 23, 2011

### Driverless SSTC

Direct current-transformer feedback

An experimental half-wave, driverless SSTC of my own design. A current transformer on the secondary feeds the MOSFET gates directly. I never optimized the circuit, but the feedback scheme worked.

- Driverless
- Half-wave
- CT feedback

[![](https://i.ytimg.com/vi/poqmtvrZDk0/hqdefault.jpg) Driverless SSTC test ](https://www.youtube.com/watch?v=poqmtvrZDk0)

[![Driverless SSTC circuit diagram](https://i.imgur.com/Th0JOug.png) ](https://i.imgur.com/Th0JOug.png)

DRSSTCSeptember 16, 2011

### ZARC with FPGA MIDI Interrupter

Four channels on 220 VAC mains

ZARC's final configuration paired a four-channel polyphonic FPGA MIDI interrupter with the controller in the coil's base. The limiter was set to 400 A; after detuning the coil slightly, measured primary current stayed below 320 A.

- DRSSTC
- FPGA MIDI
- 320 A peak

[![](https://i.ytimg.com/vi/gAdmvSDJwfU/hqdefault.jpg) FPGA MIDI performance ](https://www.youtube.com/watch?v=gAdmvSDJwfU)[![](https://i.ytimg.com/vi/BHmwMWUPKDc/hqdefault.jpg) Variac failure ](https://www.youtube.com/watch?v=BHmwMWUPKDc)

DRSSTCApril 6, 2011

### ZARC — Tuned Base

The final 1 kW mechanical build

I rebuilt ZARC's base and refined the tuning into what became the final hardware setup—about 1 kW input, doubled 110 VAC for roughly 320 VDC on the bus, and 300 A peak through an IRG4PC50UD full bridge. It remains one of my favorite electrical engineering projects.

- DRSSTC
- 1 kW
- 300 A peak

[![](https://i.ytimg.com/vi/8PSwmFOdTWc/hqdefault.jpg) Tuned-base test 1 ](https://www.youtube.com/watch?v=8PSwmFOdTWc)[![](https://i.ytimg.com/vi/M4n_VW-3P9c/hqdefault.jpg) Tuned-base test 2 ](https://www.youtube.com/watch?v=M4n_VW-3P9c)

[![ZARC's rebuilt base viewed from the top-front](https://c2.staticflickr.com/6/5180/5583127713_041b5428d4_n.jpg) ](https://www.flickr.com/photos/energylabs/5583127713/in/album-72157626476042126/)[![Front view of ZARC's rebuilt base](https://c7.staticflickr.com/6/5142/5583715958_dd2a87e698_n.jpg) ](https://www.flickr.com/photos/energylabs/5583715958/in/album-72157626476042126/)[![LED illumination inside ZARC's base](https://c1.staticflickr.com/6/5096/5578809376_7a91391356_n.jpg) ](https://www.flickr.com/photos/energylabs/5578809376/in/album-72157626476042126/)[![ZARC DRSSTC producing arcs at half power](https://c2.staticflickr.com/6/5143/5620107121_cb3cc9f639_n.jpg) ](https://www.flickr.com/photos/energylabs/5620107121/in/album-72157626476042126/)

DRSSTCMarch 4, 2011

### ZARC — First Full-Body Test

Final enclosure, early tuning

ZARC reached its final physical form before its final tuning pass. The interrupter was still the rough early version, but the system produced nearly 70 cm arcs with much better stability.

- DRSSTC
- 70 cm arcs
- Prototype

[![](https://i.ytimg.com/vi/AjZxN-Oh8hQ/hqdefault.jpg) Full-body test 1 ](https://www.youtube.com/watch?v=AjZxN-Oh8hQ)[![](https://i.ytimg.com/vi/W45HzzltVCU/hqdefault.jpg) Full-body test 2 ](https://www.youtube.com/watch?v=W45HzzltVCU)

DRSSTCFebruary 26, 2011

### Musical DRSSTC

The first reliably working audio-modulated DRSSTC in the ZARC line. Earlier attempts mostly ended in explosions; this prototype finally turned the interrupter into music and stable arcs.

- DRSSTC
- Audio modulation

[![](https://i.ytimg.com/vi/3jsGwaVaCh8/hqdefault.jpg) Musical DRSSTC test ](https://www.youtube.com/watch?v=3jsGwaVaCh8)

DRSSTCFebruary 26, 2011

### Mini DRSSTC

A compact DRSSTC experiment from the same development period, built to explore the topology at a smaller scale.

- DRSSTC
- Compact

[![](https://i.ytimg.com/vi/9iRUjJxLCXo/hqdefault.jpg) Mini DRSSTC test ](https://www.youtube.com/watch?v=9iRUjJxLCXo)

SSTCFebruary 26, 2011

### 1.5 MHz Micro SSTC

A continuous-wave SSTC running at 1.5 MHz from a full bridge of IRF740 MOSFETs—an intentionally aggressive switching frequency for that device.

- SSTC
- 1.5 MHz
- IRF740

[![](https://i.ytimg.com/vi/q4ZZiwBTu18/hqdefault.jpg) 1.5 MHz test ](https://www.youtube.com/watch?v=q4ZZiwBTu18)

SSTCFebruary 26, 2011

### Medium SSTC 3

Audio-modulated interrupter

This build reused the secondary from my other medium SSTCs and first DRSSTC, then changed the top load and added audio modulation.

- SSTC
- Audio modulation
- Shared secondary

[![](https://i.ytimg.com/vi/FZI4-mv9B-w/hqdefault.jpg) Medium SSTC 3 test ](https://www.youtube.com/watch?v=FZI4-mv9B-w)

DRSSTC2011

### First Working DRSSTC

My first working DRSSTC used primary current-transformer feedback and a half bridge of STGW30NC60WD IGBTs. Doubled rectified 127 VAC supplied roughly 300 VDC to the main bus.

- DRSSTC
- 300 V bus
- STGW30NC60WD

[![](https://i.ytimg.com/vi/rj4tLlkp_sc/hqdefault.jpg) First working DRSSTC ](https://www.youtube.com/watch?v=rj4tLlkp_sc)

SSTCFebruary 26, 2011

### Medium Half-Wave CW SSTC

A medium 30 × 10 cm secondary driven in continuous-wave mode by two IRFP260N MOSFETs from an unfiltered half-wave rectified supply.

- SSTC
- CW
- 2 × IRFP260N

[![](https://i.ytimg.com/vi/z0nRNUIxOzo/hqdefault.jpg) Half-wave CW test ](https://www.youtube.com/watch?v=z0nRNUIxOzo)

SGTCFebruary 26, 2011

### ZVS Spark-Gap Tesla Coil

Flyback-powered experiment

A spark-gap coil powered by a flyback transformer on a Mazzilli ZVS driver with two IRFP250N MOSFETs at 30 VDC and a 1 nF, 40 kV capacitor bank.

- SGTC
- Flyback
- 1 nF / 40 kV

[![](https://i.ytimg.com/vi/7xrbQroWcrg/hqdefault.jpg) ZVS spark-gap test ](https://www.youtube.com/watch?v=7xrbQroWcrg)

DRSSTCFebruary 26, 2011

### ZARC — 600 W Prototype

The early ZARC prototype produced nearly 50 cm arcs at 600 W. It introduced IRG4PC50U IGBTs with reverse ultrafast diodes to damp reverse voltage peaks.

- DRSSTC
- 600 W
- 50 cm arcs

[![](https://i.ytimg.com/vi/VxdQy4QUH6Q/hqdefault.jpg) ZARC prototype test ](https://www.youtube.com/watch?v=VxdQy4QUH6Q)

High-voltage archive

These are historical project notes, not construction instructions. Tesla coils contain lethal voltages and stored energy; reproducing this work requires appropriate high-voltage engineering knowledge and safety controls.
