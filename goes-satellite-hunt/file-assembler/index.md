---
title: LRIT Header Description - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# File Assembler

In the last chapter of my GOES Satellite Hunt, I explained how to obtain the packets. In this part I will explain how to aggregate and decompress the packets to generate the LRIT files.  This part will be somwhat quick, because most of the hard stuff was already done in the last part. Sadly the decompression algorithm is a modified RICE algorithm, and the Linux version of the library provided by NOAA cannot be used anymore because of incompatibilities between GCC ABIs \( The NOAA library has been compiled with GCC 2\). Until I reverse engineer and create a open version of the decompression algorithm, I will use the  workaround I will explain here.

In the packets before we have a flag called **continuation flag** that will specify if the packet is a **start**, **continuation** or **end packet**. It will also say if the packet itself is a single file. Usually the file header is entire contained on the first packet. One of the things we need to do is aggregate the start, continuation and end packets into a single file. This is easy since the when a start packet appears inside a channel with the same **APID**, the entire file will be transmitted at once, so the packets that will follow will be either continuation or end before a new start comes. So basically we just need to find a Packet Start with a certain APID and then grab and aggregate all of the following packets that has the same APID. But the packet content may also be compressed using **LritRice.lib** \(provided by NOAA\). To check if we need to decompress the packet or not, we need to check the header of the start packet \(the header will always be decompressed\).

<div class="pagination">
    <a href="{{ '/goes-satellite-hunt/packet-demuxer/saving-the-raw-packet' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'file-header-processing' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
