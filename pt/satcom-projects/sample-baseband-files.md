---
title: "Arquivos de amostra em banda-base | Lets Hack It"
description: "Escrito por Lucas Teske em 20 Dezembro 2016 Arquivos de amostra em banda-base So I decided (now that I have a fairly good SNR) to make some samples and share with anyone who might do their own decoders. The GQRX files are a complex packed data (two floats with IQ)..."
image: "https://lucasteske.dev/wp-content/uploads/2016/12/0xAmxzb-624x463.png"
---

![Arquivos de amostra em banda-base](/wp-content/uploads/2016/12/0xAmxzb-624x463.png)Escrito por Lucas Teske   
em 20 Dezembro 2016

# Arquivos de amostra em banda-base

So I decided (now that I have a fairly good SNR) to make some samples and share with anyone who might do their own decoders. The GQRX files are a complex packed data (two floats with IQ) and the filename gives the specs. For example

gqrx\_20161202\_145551\_1691000000\_1250000\_fc.raw

Means that the file was recorder at 2016/12/02 14:55:51 UTC with center frequency in 1691 MHz and Sample rate of 1.25MHz.

# GOES 13

## LRIT

That’s basically the main signal for the end user. It provides more data than EMWIN (almost everything that the satellite can give is broadcasted here) and with higher resolution. It also provides full disk images of the earth in Infrared, Visible and Water Vapour. It is decodable using a 1.5m prime focus dish (or 1.2m offset dish) with a good feed. I have some samples with my 1.9m dish and 2.2m dish. Both are good enough to decode and no RS Errors at most of the time. The signal is modulated using BPSK with 293883 symbols / sec with CCSDS Standard Framing.

- GQRX ( 2016/12/02 14:55 UTC – 1691MHz – 1.25Msps – 1.9m dish – 5dB SNR – 10GB ) &nbsp;[gqrx\_20161202\_145551\_1691000000\_1250000\_fc.raw](https://www.teske.net.br/lucas/basebands/goes13/lrit/gqrx_20161202_145551_1691000000_1250000_fc.raw)
- GQRX ( same as previous but only first 1GB ) –&nbsp;[gqrx\_20161202\_145551\_1691000000\_1250000\_fc\_segment0.raw](https://www.teske.net.br/lucas/basebands/goes13/lrit/gqrx_20161202_145551_1691000000_1250000_fc_segment0.raw)
- GQRX ( 2016/12/15 16:38 UTC – 1691MHz – 1.25Msps – 2.2m dish – 10dB SNR – 6GB )&nbsp;[gqrx\_20161215\_163848\_1691000000\_1250000\_fc.raw](https://www.teske.net.br/lucas/basebands/goes13/lrit/gqrx_20161215_163848_1691000000_1250000_fc.raw)
- WAV ( same as the previous but in 16 bit wave file )&nbsp;[gqrx\_20161215\_163848\_1691000000\_1250000\_fc.wav](https://www.teske.net.br/lucas/basebands/goes13/lrit/gqrx_20161215_163848_1691000000_1250000_fc.wav)

## EMWIN

That’s the easiest signal to catch on GOES satellites. Its a low bandwidth signal that is easily picked up even with a 90cm dish (maybe even less). It doesn’t transmit much data and doesn’t transmit full disk images. It is modulated using OQPSK.

- SDRSharp (2016/12/20 14h27 GMT-3 – 1692.7MHz – 156.250 kHz)-&nbsp;[SDRSharp\_20161220\_142714Z\_1692700000Hz\_IQ.wav](https://www.teske.net.br/lucas/basebands/goes13/emwin/SDRSharp_20161220_142714Z_1692700000Hz_IQ.wav)

## DCPR

This is a rebroadcast from the Data Collection System (DCS). In the L Band (the recordings) its actually a translation repeater that gets a portion of the UHF Band and repeats in the L Band. The DCS Stations are in ground and sends all sets of data to the satellite using very directional yagis. I have basically no much info about it but feel free to test it.

- SDRSharp (2016/12/20 14h32 GMT-3 – 1694.4MHz )&nbsp;[SDRSharp\_20161220\_143246Z\_1694400000Hz\_IQ.wav](https://www.teske.net.br/lucas/basebands/goes13/dcpr/SDRSharp_20161220_143246Z_1694400000Hz_IQ.wav)

# GOES 16 ( GOES-R )

GOES-16 is the next generation of GOES Satellites. At the time I’m writing this the satellite is still under test. For now all these samples should be treated as Test Data and may not reflect on the signals that will be on air when it gets out of the test phase.

## Telemetry

That’s the telemetry of GOES-16 Satellite. The Telemetry content is unknown so far, but the modulation is BPSK at 40ksps.

- GQRX ( 2016/12/22 20:19:55 UTC-3 – 1693 MHz – 312500 Hz) [gqrx\_20161222\_201955\_1693000000\_312500\_fc.raw](https://www.teske.net.br/lucas/basebands/goes16/TLM/gqrx_20161222_201955_1693000000_312500_fc.raw)

## DCPR

- GQRX ( 2016/12/22 20:23:08 UTC-3 – 1680.2 MHz – 1250000 Hz&nbsp;) –&nbsp;[gqrx\_20161222\_202308\_1680200000\_1250000\_fc.raw](https://www.teske.net.br/lucas/basebands/goes16/DCPR/gqrx_20161222_202308_1680200000_1250000_fc.raw)

## HRIT

UPDATED ( 2017/01/24 ): So I sent an email to NOAA and they kindly sent me the updated specs for HRIT. So HRIT is modulated using BPSK but using NRZ-M encoding (that’s differential as we noticed before). So the flow to decode would be BPSK -\> Viterbi -\> Diff Decode. The other params keep the same (Vit k=7 r=1/2 and RS(255, 223))

- SDRSharp ( 2017/01/17 16:25:08 UTC – 1694.1MHz – 5000000 Hz ) – [SDRSharp\_20170117\_162508Z\_1694100000Hz\_IQ.wav](https://www.teske.net.br/lucas/basebands/goes16/HRIT/SDRSharp_20170117_162508Z_1694100000Hz_IQ.wav)
