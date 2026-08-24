---
title: "Projetos de Satélite | Lets Hack It"
description: "A curated archive of satellite reception, RF hardware, software-defined radio, GOES decoding, and weather satellite projects."
image: "https://lucasteske.dev/wp-content/uploads/2016/10/Sem-título.png"
---

Escrito por Lucas Teske   
em 28 Outubro 2016

# Projetos de Satélite

A curated path through the satellite work: start with reception hardware, follow the signal-processing experiments, and continue into complete weather-satellite decoding systems.

Complete project · Hardware to imagery
## GOES Satellite Hunt

The strongest place to start. This book-length guide documents the full GOES-13 LRIT receive chain and the engineering lessons that later became Open Satellite Project.

[Open the complete guide](/pt/goes-satellite-hunt/)[Get sample signals](/pt/satcom-projects/sample-baseband-files)

 ![Home-built L-band feed and low-noise amplifier mounted on a satellite dish](/wp-content/uploads/2016/10/Sem-t%C3%ADtulo.png)

1. [Dish, feed, and LNA](/pt/goes-satellite-hunt/the-hardware-setup/)
2. [GNU Radio receiver](/pt/goes-satellite-hunt/the-demodulator/)
3. [CCSDS frames](/pt/goes-satellite-hunt/frame-decoder/)
4. [Virtual channels](/pt/goes-satellite-hunt/packet-demuxer/)
5. [LRIT products](/pt/goes-satellite-hunt/file-types/)

## NOAA APT and Meteor LRPT

Accessible VHF projects for building the receiving station and learning the signal path.

- [QFH antenna and first NOAA reception](/pt/2016/01/qfh-antenna-and-my-first-reception-of-noaa/)Build the antenna, track a pass, and receive the first weather image.
- [Recording NOAA APT with GQRX and RTL-SDR](/pt/2016/02/recording-noaa-apt-signals-with-gqrx-and-rtl-sdr-on-linux/)Configure the Linux software stack and preserve a pass for offline decoding.
- [137 MHz band-pass filter](/pt/2016/11/137mhz-bandpass-filter-for-noaa-meteor-satellites/)Design, build, and measure a dedicated filter for NOAA and Meteor reception.

## GOES field notes

Experiments and milestones that continued after the original GOES-13 receive chain.

- [A new 2.2 m dish](/pt/2016/12/new-2-2m-dish-from-embrasat/)Hardware expansion for stronger L-band reception and future signals.
- [GOES-16 in the house](/pt/2017/01/goes-16-in-the-house/)Early reception and reverse engineering of the next GOES generation.
- [GOES-16 test week](/pt/2017/03/goes-16-test-week/)Preparing the station and decoder for the experimental HRIT broadcast.
- [GOES-16 test week results](/pt/2017/04/goes-16-test-week-results/)Decoded ABI products, false-color imagery, and lessons from the live test.
- [LNA tests for HRIT and LRIT](/pt/2017/04/some-lna-tests-for-hritlrit/)Practical gain and noise comparisons for the satellite receive chain.
- [GOES GRB first light](/pt/2017/10/goes-grb-first-light/)The jump to the high-rate GOES Rebroadcast service and its first decoded products.

## Related resources

Original articles, reusable recordings, and the software created from the research.

Original publication
### The five-part GOES blog series

Read the original chronological posts that were reorganized and expanded into GOES Satellite Hunt.

[Open part one](/pt/2016/10/goes-satellite-hunt-part-1-antenna-system/)

Development data
### GOES baseband recordings

Use real LRIT, HRIT, telemetry, EMWIN, and DCPR captures to test your own signal-processing code.

[Browse the recordings](/pt/satcom-projects/sample-baseband-files)
