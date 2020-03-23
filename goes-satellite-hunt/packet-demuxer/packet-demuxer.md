---
title: Packet Demuxer - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Packet Demuxer

Having our virtual channels demuxed for files channel\_ID.bin, we can do the packet demuxer. I did the packet demuxer in python because of the easy of use. I plan to rewrite in C as well, but I will explain using python code.

![](/assets/goes-satellite-hunt/packet.png)

Each channel Data can contain one or more packets. If the Channel contains and packet end and another start, the **First Header Pointer** \(the 11 bits from the header\) will contain the address for the first header inside the packet zone.

First thing we need to do is read one frame from a **channel\_ID.bin** file, that is, 892 bytes \(6 bytes header + 886 bytes data\). We can safely ignore the 6 bytes header from VCDU now since we won’t have any usefulness for this part of the program. The **spare** 5 bits in the start we can ignore, and we should get the **FHP** value to know if we have a packet start in the current frame. If we don’t, and there is no pending packet to append data, we just ignore this frame and go to the next one. The **FHP** value will be 2047 \(all 1’s\) when the current frame only contains data related to a previous packet \(no header\). If the value is different than 2047 then we have a header. So let’s handle this:

```py
data = data[6:] # Strip channel header
fhp = struct.unpack(">H", data[:2])[0] & 0x7FF
data = data[2:] # Strip M_PDU Header

#data is now TP_PDU
if not fhp == 2047: # Frame Contains a new Packet
   # handle new header
```

So let’s talk first about handling a new packet. Here is the structure of a packet:

We have a 6 byte header containing some useful info, and a user data that can vary from 1 byte to 8192 bytes. So this packet can span across several frames and we need to handle it. Also there is another tricky thing here: Even the packet header can be split across two frames \(the 6 first bytes can be at two frames\) so we need to handle that we might not have enough data to even check the packet header. I created a function called **CreatePacket** that receives a buffer parameter that can or not have enough data for creating a packet. It will return a tuple that contains the APID for the packet \(or -1 if buffer doesn’t have at least 6  bytes\) and a buffer that contains any unused data for the packet \(for example if there was more than one packet in the buffer\). We also have a function called **ParseMSDU** that will receive a buffer that contains at least 6 bytes and return a tuple with the MSDU \(packet\) header decomposed. There is also a **SavePacket** function that will receive the channelId \(VCID\) and a object to save the data to a packet file. I will talk about the SavePacket later.

```py
import struct

SEQUENCE_FLAG_MAP = {
  0: "Continued Segment",
  1: "First Segment",
  2: "Last Segment",
  3: "Single Data"
}

pendingpackets = {}

def ParseMSDU(data):
  o = struct.unpack(">H", data[:2])[0]
  version = (o & 0xE000) >> 13
  type = (o & 0x1000) >> 12
  shf = (o & 0x800) >> 11
  apid = (o & 0x7FF)

  o = struct.unpack(">H", data[2:4])[0]
  sequenceflag = (o & 0xC000) >> 14
  packetnumber = (o & 0x3FFF)
  packetlength = struct.unpack(">H", data[4:6])[0] -1
  data = data[6:]
  return version, type, shf, apid, sequenceflag, packetnumber, packetlength, data

def CreatePacket(data):
  while True:
    if len(data) < 6:
      return -1, data
    version, type, shf, apid, sequenceflag, packetnumber, packetlength, data = ParseMSDU(data)
    pdata = data[:packetlength+2]
    if apid != 2047:
      pendingpackets[apid] = {
        "data": pdata,
        "version": version,
        "type": type,
        "apid": apid,
        "sequenceflag": SEQUENCE_FLAG_MAP[sequenceflag],
        "sequenceflag_int": sequenceflag,
        "packetnumber": packetnumber,
        "framesdropped": False,
        "size": packetlength
      }

      print "- Creating packet %s Size: %s - %s" % (apid, packetlength, SEQUENCE_FLAG_MAP[sequenceflag])
    else:
      apid = -1

    if not packetlength+2 == len(data) and packetlength+2 < len(data): # Multiple packets in buffer
      SavePacket(sys.argv[1], pendingpackets[apid])
      del pendingpackets[apid]
      data = data[packetlength+2:]
      apid = -1
      print "   Multiple packets in same buffer. Repeating."
    else:
      break
```

With that we create a dictionary called **pendingpackets** that will store APID as the key, and another dictionary with the packet data, including a field called **data** that we will append data from other frames until we fill the whole packet. Back to our read function, we will have something like this:

```py
...
  if not fhp == 2047: # Frame Contains a new Packet
    # Data was incomplete on last FHP and another packet starts here.
    # basically we have a buffer with data, but without an active packet
    # this can happen if the header was split between two frames
    if lastAPID == -1 and len(buff) > 0:
      print "   Data was incomplete from last FHP. Parsing packet now"
      if fhp > 0:
        # If our First Header Pointer is bigger than 0, we still have
        # some data to add.
        buff += data[:fhp]
      lastAPID, data = CreatePacket(buff)
      if lastAPID == -1:
        buff = data
      else:
        buff = ""

    if not lastAPID == -1: # We are finishing another packet
      if fhp > 0: # Append the data to the last packet
        pendingpackets[lastAPID]["data"] += data[:fhp]
      # Since we have a FHP here, the packet has ended.
      SavePacket(sys.argv[1], pendingpackets[lastAPID])
      del pendingpackets[lastAPID] # Erase the last packet data
      lastAPID = -1

    # Try to create a new packet
    buff += data[fhp:]
    lastAPID, data = CreatePacket(buff)
    if lastAPID == -1:
      buff = data
    else:
      buff = ""
```

This should handle all frames that has a new header. But maybe the packet is so big that we got frames without any header \(continuation packets\). In this case the FHP will be **2047**, and basically we have three things that can lead to that:

1. The header was split between last frame end, and the current frame. FHP will be 2047 and after we append to our buffer we will have a full header to start a packet
2. We just need to append the data to last packet.
3. We lost some frame \(or we just started\) and we got a continuation packet. So we drop it.

```py
...
else:
  if len(buff) > 0 and lastAPID == -1: # Split Header
    print "   Data was incomplete from last FHP. Parsing packet now"
    buff += data
    lastAPID, data = CreatePacket(buff)
    if lastAPID == -1:
      buff = data
    else:
      buff = ""
  elif len(buff)> 0:
    # This shouldn't happen, but I put a warn here if it does
    print "   PROBLEM!"
  elif lastAPID == -1:
    # We don't have any pending packets, and we received
    # a continuation packet, so we drop.
    pass
  else:
    # We have a last packet, so we append the data.
    print "   Appending %s bytes to %s" % (lastAPID, len(data))
    pendingpackets[lastAPID]["data"] += data
```

Now let’s talk about the  **SavePacket** function. I will describe some of the stuff here, but there will be also something described on the next chapter. Since the packet data can be compressed, we will need to check if the data is compressed, and if it is, we need to decompress. In this part we will not handle the decompression or the file assembler \(that will need decompression\).

<div class="pagination">
    <a href="{{ 'virtual-channel-demuxer' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'saving-the-raw-packet' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
