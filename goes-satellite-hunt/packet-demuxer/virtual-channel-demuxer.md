---
title: "Virtual Channel Demuxer - GOES Satellite Hunt | Lets Hack It"
description: "Written by Lucas Teske on 19 February 2017 Part of GOES Satellite Hunt Project overview → Virtual Channel Demuxer Now we will demux the Virtual Channels. I current save all virtual channel payload (the 892 bytes) to a file called channel_ID.bin then I post process with a python script to..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Written by Lucas Teske   
on 19 February 2017

# 

# Virtual Channel Demuxer

Now we will demux the Virtual Channels. I current save all virtual channel payload (the 892 bytes) to a file called **channel\_ID.bin** then I post process with a python script to separate the channel packets. Parsing the virtual channel header has also some advantages now that we can see if for some reason we skipped a frame of the channel, and also to discard the empty frames (I will talk about it later).

![6-octet VCDU header layout with Version, VCDU-ID, Counter, and Signaling Field bit allocations.](/assets/goes-satellite-hunt/vcdu-struct.png)

### Fields:

- **Version Number** – The Version of the Frame Data
- **S/C ID** – Satellite ID
- **VC ID** – Virtual Channel ID
- **Counter** – Packet Counter (relative to the channel)
- **Replay Flag** – Is 1 if the frame is being sent again.
- **Spare** – Not used.

Basically we will only use 2 values from the header: **VCID** and **Counter**.

```
uint32_t swapEndianess(uint32_t num) {
  return ((num>>24)&0xff) | ((num<<8)&0xff0000) | ((num>>8)&0xff00) | ((num<<24)&0xff000000);
}
 
(...)
      uint8_t vcid = (*(rsCorrectedData+1)) & 0x3F;
 
      // Packet Counter from Packet
      uint32_t counter = *((uint32_t *) (rsCorrectedData+2));
      counter = swapEndianess(counter);
      counter &= 0xFFFFFF00;
      counter = counter >> 8;
```

I usually save the last **counter** value and compare with the current one to see if I lost any frame. Just be carefull that the counter value is per channel ID (VCID). I actually never got any VCID higher than 63, so I store the counter in a 256 int32\_t array.

One last thing I do in the C code is to discard any frame that has 63 as VCID. The VCID 63 only contains&nbsp; **Fill Packets** , that is used for keeping the satellite signal continuous, even when not sending anything. The payload of the frame will always contain the same sequence (that can be sequence of 0, 1 or 01).

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
