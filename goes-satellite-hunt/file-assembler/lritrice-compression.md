---
title: LritRice Compression - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# LritRice Compression

Usually for images, the data is compressed using **LritRice.lib**. Although RICE compression is a open standard \(NASA’s fitsio library has compression and decompression of RICE\), the LritRice use a modified version. With time I will reverse engineer and create a open version that will be able to decompress LRIT data, but for now I had to do a workaround. Since the LritRice from linux is “broken”, I made a very nasty workaround:

Make a windows application to decompress and run through wine.

The project of decompressor is available here: [https://github.com/racerxdl/open-satellite-project/tree/master/GOES/decompressor](https://github.com/racerxdl/open-satellite-project/tree/master/GOES/decompressor), I will soon release some binaries for those who don’t want to compile the application themselves. But for those who want, just open the visual studio solution and hit compile, it should generate a **decompressor.exe** that we will be using together with wine and python \(or if you’re at windows, just with python\).

The decompressor is made to receive some arguments and has two ways of operation:

* **Single File Decompression:** _decompressor.exe Pixels Filename_
* **Multi File Decompression:** _decompressor.exe Prefix StartNumber EndNumber \[DebugMode\]_

We’re gonna use the Multi File decompression. It does basically the same as single file, but iterates over several files and decompress all of them into a single file. So the output file will be a single file with all of the original files together \(so our final LRIT file\). The **StartNumber** should be the number of the first **continuation** packet \(so not the header packet\). The Multi File Decompression will look into StartNumber-1 to EndNumber files, being the StartNumber-1 just rewrited to the output file that will have a **\_decomp** suffix. So in our **channeldecoder.py** we need to do few steps.

First let’s check if either the packet stream will need to be decompressed or just appended. If they just need to be appended, we only do that. Text files and DCS files are usually not compressed.

In our **savePacket** function, if the packet is a **start packet**, we should run the **getHeaderData** from **packetmanager** and check the compression flags.

```py
if packet["sequenceflag_int"] == 1:
  print "Starting packet %s_%s_%s.lrit"  % (packet["apid"], packet["version"], packet["packetnumber"])
  startnum = packet["packetnumber"]
  p = packetmanager.getHeaderData(data[10:])
  for i in p:
    if i["type"] == 1 or i["type"] == 129:
      isCompressed = not i["compression"] == 0
    if i["type"] == 1:
      pixels = i["columns"]
```

In headers of type 1 \(Image Structure Header\) or type 129 \(NOAA Specific Header\) both describe if its compressed or not. If its an image, we will have the compression flag set on Image Structure Header. If its another file, it will be in NOAA Specifc header. If the data is compressed, we need to grab the **columns**parameter that will be used as the **Pixels** parameter in **decompressor**. If the decompression is enabled, all further packets including the end packet will need to be decompressed. So for running decompressor we also need what is the packetnumber of the first packet \(that will be the start packet + 1\) and the number of the latest packet. So if the continuation flag says that the current packet is the latest, we need to save the number:

```py
elif packet["sequenceflag_int"] == 2:
   print "Ending packet %s_%s_%s.lrit"  % (packet["apid"], packet["version"], packet["packetnumber"])
   endnum = packet["packetnumber"]
   if startnum == -1:
     print "Orphan Packet. Dropping"
     return
elif packet["sequenceflag_int"] != 3 and startnum == -1:
   print "Orphan Packet. Dropping."
   return
```

I also set the **startnum** as -1 when there is no received start packet, so I can know if I have any orphan continuation / end packets. If that’s the case, we just drop \(if we don’t have the headers we cannot know whats the content\). Now we need to handle the output filename. If its compressed we won’t be appending each packet to a final file, instead we will create a file that contains the packet number on it \(so the decompressor can run over it\). But if the data isn’t compressed, we can just append to the final file, so our final file shouldn’t have the packet number.

```py
if isCompressed:
  filename = "channels/%s/%s_%s_%s.lrit" % (channelid, packet["apid"], packet["version"], packet["packetnumber"])
else:
  filename = "channels/%s/%s_%s.lrit" % (channelid, packet["apid"], packet["version"])
```

Now, in aspect of saving the file. If its not compressed we need to open for appending, if it is we just save by skipping the 10 first bytes.

```py
firstorsinglepacket = packet["sequenceflag_int"] == 1 or packet["sequenceflag_int"] == 3
if not isCompressed:
  f = open(filename, "wb" if firstorsinglepacket else "ab")
else:
  f = open(filename, "wb")
```

For running the decompressor I created a function called **Decompressor** that will receive the parameters and run wine to process the file. It will also delete the original compressed packets, since everything should be at a \_decomp file.

```py
from subprocess import call
 
def Decompressor(prefix, pixels, startnum, endnum):
  startnum += 1
  call(["wine", "Decompress.exe", prefix, str(pixels), str(startnum), str(endnum), "a"], env={"WINEDEBUG":"-all"})
  for i in range(startnum-1, endnum+1):
    k = "%s%s.lrit" % (prefix, i)
    if os.path.exists(k):
      os.unlink(k)
  return "%s_decomp%s.lrit" % (prefix, startnum-1)
```

Now we can do the following to have the things decompressed:

```py
if (packet["sequenceflag_int"] == 2 or packet["sequenceflag_int"] == 3):
  if isCompressed:
    if startnum != -1:
      decompressed = Decompressor("channels/%s/%s_%s_" % (channelid, packet["apid"], packet["version"]), pixels, startnum, endnum)
```

The **decompressed** var will have the final filename of the decompressed file.

<div class="pagination">
    <a href="{{ 'file-header-processing' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'file-name-from-header' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
