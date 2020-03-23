---
title: Saving the Raw Packet - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Saving the Raw Packet

Now that we have the handler for the demuxing, we will implement the function **SavePacket**. It will receive two arguments, the channel id and  a packetdict. The channel id will be used for saving the packets in the correct folder \(separating them from other channel packets\). We may have also a **Fill Packet** here, that has an APID of 2047. We should drop the data if the apid is 2047. Usually the fill packets are only used to increase the likely hood of the header of packet starts on the start of channel data. So it “fills” the channel data to get the header in the next packet. It does not happen very often though.

In the last step we assembled a packet dict with this structure:

```py
{
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
```

The **data** field have the data we need to save, the **type** says the type of packet \(and also if its compressed\), the **sequenceflag** says if the packet is:

* **0** => Continued Segment, if this packet belongs to a file that has been already started.
* **1** => First Segment, if this packet contains the start of the file
* **2** => Last Segment, if this packet contains the end of the file
* **3** => Single Data, if this packet contains the whole file

It also contains a **packetnumber** that we can use to check if we skip any packet \(or lose\).

The **size** parameter is the length of **data** field – 2 bytes. The two last bytes is the CRC of the packet. The CCSDS only specify the polynomial for the CRC, [CRC-CCITT](https://en.wikipedia.org/wiki/Cyclic_redundancy_check) standard. I made a very small function based on a few C functions I found over the internet:

```py
def CalcCRC(data):
  lsb = 0xFF
  msb = 0xFF
  for c in data:
      x = ord(c) ^ msb
      x ^= (x >> 4)
      msb = (lsb ^ (x >> 3) ^ (x << 4)) & 255
      lsb = (x ^ (x << 5)) & 255
  return (msb << 8) + lsb

def CheckCRC(data, crc):
  c = CalcCRC(data)
  if not c == crc:
    print "   Expected: %s Found %s" %(hex(crc), hex(c))
  return c == crc
```

On **SavePacket** function we should check the CRC to see if any data was corrupted or if we did any mistake. So we just check the CRC and then save the packet to a file \(at least for now\):

```py
EXPORTCORRUPT = False
def SavePacket(channelid, packet):
  global totalCRCErrors
  global totalSavedPackets
  global tsize
  global isCompressed
  global pixels
  global startnum
  global endnum

  try:
    os.mkdir("channels/%s" %channelid)
  except:
    pass

  if packet["apid"] == 2047:
    print "  Fill Packet. Skipping"
    return

  datasize = len(packet["data"])

  if not datasize - 2 == packet["size"]: # CRC is the latest 2 bytes of the payload
    print "   WARNING: Packet Size does not match! Expected %s Found: %s" %(packet["size"], len(packet["data"]))
    if datasize - 2 > packet["size"]:
      datasize = packet["size"] + 2
      print "   WARNING: Trimming data to %s" % datasize

  data = packet["data"][:datasize-2]

  if packet["sequenceflag_int"] == 1:
    print "Starting packet %s_%s_%s.lrit"  % (packet["apid"], packet["version"], packet["packetnumber"])
    startnum = packet["packetnumber"]
  elif packet["sequenceflag_int"] == 2:
    print "Ending packet %s_%s_%s.lrit"  % (packet["apid"], packet["version"], packet["packetnumber"])
    endnum = packet["packetnumber"]
    if startnum == -1:
      print "Orphan Packet. Dropping"
      return
  elif packet["sequenceflag_int"] != 3 and startnum == -1:
    print "Orphan Packet. Dropping."
    return

  if packet["framesdropped"]:
    print "   WARNING: Some frames has been droped for this packet."
  filename = "channels/%s/%s_%s_%s.lrit" % (channelid, packet["apid"], packet["version"], packet["packetnumber"])
  print "- Saving packet to %s" %filename


  crc = packet["data"][datasize-2:datasize]
  if len(crc) == 2:
    crc = struct.unpack(">H", crc)[0]
    crc = CheckCRC(data, crc)
  else:
    crc = False
  if not crc:
    print "   WARNING: CRC does not match!"
    totalCRCErrors += 1

  if crc or (EXPORTCORRUPT and not crc):
    f = open(filename, "wb")
    f.write(data)
    f.close()

    totalSavedPackets += 1
  else:
    print "   Corrupted frame, skipping..."
```

With that you should be able to see a lot of files being out of your channel, each one being a packet. If you get the first packet \(with the sequenceflag = 1\), you will also have the Transport Layer header that contains the decompressed file size, and file number. We will handle the decompression and lrit file composition in next chapter. You can check the final code here:

[https://github.com/racerxdl/open-satellite-project/blob/master/GOES/standalone/channeldecoder.py](https://github.com/racerxdl/open-satellite-project/blob/master/GOES/standalone/channeldecoder.py)

<div class="pagination">
    <a href="{{ 'packet-demuxer' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '/goes-satellite-hunt/file-assembler' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
