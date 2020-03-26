---
id: 204
title: Satellite Projects
date: 2016-10-28T12:50:22-03:00
author: Lucas Teske
layout: page
guid: http://www.teske.net.br/lucas/?page_id=204
image: /wp-content/uploads/2016/10/Sem-título.png
---
These are my Satellite Project Page. Some of the stuff are WIP so please be gentle.


NOAA APT / Meteor LRPT

  * [QFH Antenna and my first reception of NOAA!]({{ '/2016/01/qfh-antenna-and-my-first-reception-of-noaa/' | prepend: site.baseurl }})
  * [Recording NOAA APT Signals With GQRX and RTLSDR in Linux]({{ '/2016/02/recording-noaa-apt-signals-with-gqrx-and-rtl-sdr-on-linux/' | prepend: site.baseurl }})
  * Creating an APT Signal Decoder (TODO)
  * LRPT Demodulator / Decoder (TODO)
  * [137MHz Bandpass Filter for NOAA / METEOR]({{ '/2016/11/137mhz-bandpass-filter-for-noaa-meteor-satellites/' | prepend: site.baseurl }})

GOES Satellite Hunt

* [First Page]({{ '/goes-satellite-hunt' | prepend: site.baseurl }})
* [Motivation]({{ '/goes-satellite-hunt/motivation' | prepend: site.baseurl }})
* [The Hardware Setup]({{ '/goes-satellite-hunt/the-hardware-setup' | prepend: site.baseurl }})
  * [Assemble Process]({{ '/goes-satellite-hunt/the-hardware-setup/assemble-process' | prepend: site.baseurl }})
  * [Dish Feed]({{ '/goes-satellite-hunt/the-hardware-setup/dish-feed' | prepend: site.baseurl }})
  * [LNA and Filter]({{ '/goes-satellite-hunt/the-hardware-setup/lna-and-filter' | prepend: site.baseurl }})
  * [Pointing the Antenna]({{ '/goes-satellite-hunt/the-hardware-setup/pointing-the-antenna' | prepend: site.baseurl }})
* [The Demodulator]({{ '/goes-satellite-hunt/the-demodulator' | prepend: site.baseurl }})
  * [Binary Phase Shift Keying Modulation]({{ '/goes-satellite-hunt/the-demodulator/demodulator-in-gnu-radio' | prepend: site.baseurl }})
  * [Demodulating BPSK Signal]({{ '/goes-satellite-hunt/the-demodulator/demodulating-bpsk-signal' | prepend: site.baseurl }})
  * [GNU Radio Flow]({{ '/goes-satellite-hunt/the-demodulator/gnu-radio-flow' | prepend: site.baseurl }})
  * [Decimating and filtering to desired sample rate]({{ '/goes-satellite-hunt/the-demodulator/decimating-and-filtering-to-desired-sample-rate' | prepend: site.baseurl }})
  * [Automatic Gain Control and Root Raised Cosine Filter]({{ '/goes-satellite-hunt/the-demodulator/automatic-gain-control-and-root-raised-cosine-filter' | prepend: site.baseurl }})
  * [Synchronization and Clock Recovery]({{ '/goes-satellite-hunt/the-demodulator/synchronization-and-clock-recovery' | prepend: site.baseurl }})
  * [Symbol Output from GNU Radio]({{ '/goes-satellite-hunt/the-demodulator/symbol-output-from-gnu-radio' | prepend: site.baseurl }})
* [Frame Decoder]({{ '/goes-satellite-hunt/frame-decoder' | prepend: site.baseurl }})
  * [Convolution Encoding, Frame Synchronization and Viterbi]({{ '/goes-satellite-hunt/frame-decoder/convolution-encoding-frame-synchronization-and-viterbi' | prepend: site.baseurl }})
  * [Encoding the sync word]({{ '/goes-satellite-hunt/frame-decoder/encoding-the-sync-word' | prepend: site.baseurl }})
  * [Frame Synchronization]({{ '/goes-satellite-hunt/frame-decoder/frame-synchronization' | prepend: site.baseurl }})
  * [Decoding Frame Data]({{ '/goes-satellite-hunt/frame-decoder/decoding-frame-data' | prepend: site.baseurl }})
* [Packet Demuxer]({{ '/goes-satellite-hunt/packet-demuxer' | prepend: site.baseurl }})
  * [De-randomization of the data]({{ '/goes-satellite-hunt/packet-demuxer/de-randomization-of-the-data' | prepend: site.baseurl }})
  * [Reed Solomon Error Correction]({{ '/goes-satellite-hunt/packet-demuxer/reed-solomon-error-correction' | prepend: site.baseurl }})
  * [Virtual Channel Demuxer]({{ '/goes-satellite-hunt/packet-demuxer/virtual-channel-demuxer' | prepend: site.baseurl }})
  * [Packet Demuxer]({{ '/goes-satellite-hunt/packet-demuxer/packet-demuxer' | prepend: site.baseurl }})
  * [Saving the Raw Packet]({{ '/goes-satellite-hunt/packet-demuxer/saving-the-raw-packet' | prepend: site.baseurl }})
* [File Assembler]({{ '/goes-satellite-hunt/file-assembler' | prepend: site.baseurl }})
  * [File Header Processing]({{ '/goes-satellite-hunt/file-assembler/file-header-processing' | prepend: site.baseurl }})
  * [LritRice Compression]({{ '/goes-satellite-hunt/file-assembler/lritrice-compression' | prepend: site.baseurl }})
  * [File Name from Header]({{ '/goes-satellite-hunt/file-assembler/file-name-from-header' | prepend: site.baseurl }})
  * [Viewing the files content]({{ '/goes-satellite-hunt/file-assembler/viewing-the-files-content' | prepend: site.baseurl }})
* [File Types]({{ '/goes-satellite-hunt/file-types' | prepend: site.baseurl }})
  * [LRIT Header Description]({{ '/goes-satellite-hunt/file-types/lrit-header-description' | prepend: site.baseurl }})
    * [0 - Primary Header]({{ '/goes-satellite-hunt/file-types/lrit-header-description/primary-header' | prepend: site.baseurl }})
    * [1 - Image Structure Header]({{ '/goes-satellite-hunt/file-types/lrit-header-description/1-image-structure-header' | prepend: site.baseurl }})
    * [2 - Image Navigation Record]({{ '/goes-satellite-hunt/file-types/lrit-header-description/2-image-navigation-record' | prepend: site.baseurl }})
    * [3 - Image Data Function Record]({{ '/goes-satellite-hunt/file-types/lrit-header-description/3-image-data-function-record' | prepend: site.baseurl }})
    * [4 - Annotation Record]({{ '/goes-satellite-hunt/file-types/lrit-header-description/4-annotation-record' | prepend: site.baseurl }})
    * [5 - Timestamp Record]({{ '/goes-satellite-hunt/file-types/lrit-header-description/5-timestamp-record' | prepend: site.baseurl }})
    * [6 - Ancillary Text]({{ '/goes-satellite-hunt/file-types/lrit-header-description/6-ancillary-text' | prepend: site.baseurl }})
    * [7 - Key Header]({{ '/goes-satellite-hunt/file-types/lrit-header-description/7-key-header' | prepend: site.baseurl }})
    * [128 - Segment Identification Header]({{ '/goes-satellite-hunt/file-types/lrit-header-description/128-segment-identification-header' | prepend: site.baseurl }})
    * [128 - Segment Identification Header]({{ '/goes-satellite-hunt/file-types/lrit-header-description/128-segment-identification-header' | prepend: site.baseurl }})
    * [129 - NOAA Specific Header]({{ '/goes-satellite-hunt/file-types/lrit-header-description/129-noaa-specific-header' | prepend: site.baseurl }})
    * [130 - Header Structured Record]({{ '/goes-satellite-hunt/file-types/lrit-header-description/130-header-structured-record' | prepend: site.baseurl }})
    * [131 - Rice Compression Record]({{ '/goes-satellite-hunt/file-types/lrit-header-description/131-rice-compression-record' | prepend: site.baseurl }})
    * [132 - DCS Filename Record]({{ '/goes-satellite-hunt/file-types/lrit-header-description/132-dcs-filename-record' | prepend: site.baseurl }})
* [Ending]({{ '/goes-satellite-hunt/ending' | prepend: site.baseurl }})
