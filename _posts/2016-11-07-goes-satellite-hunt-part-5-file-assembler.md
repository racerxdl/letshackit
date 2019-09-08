---
id: 245
title: GOES Satellite Hunt (Part 5 – File Assembler)
date: 2016-11-07T20:58:57-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=245
permalink: /2016/11/goes-satellite-hunt-part-5-file-assembler/
image: /wp-content/uploads/2016/11/3Zz7gvgh-624x568.jpg
categories:
  - English
  - Reverse Engineering
  - Satellite
  - SDR
tags:
  - AGC
  - Airspy
  - Automatic Gain Control
  - Bug
  - Compile
  - Convolutional Code
  - Convolutional Encoding
  - EMWIN
  - English
  - Full Disk
  - GNU Radio
  - Gnuradio
  - GOES
  - GRC
  - Hearsat
  - LRIT
  - Osmocom
  - RE
  - Reed Solomon
  - Reverse Engineering
  - Root Raised Cosine Filter
  - RRC Filter
  - RS
  - Sat
  - Satellite
  - SDR
  - Statistics
  - Viterbi
---
In the last chapter of my GOES Satellite Hunt, I explained how to obtain the packets. In this part I will explain how to aggregate and decompress the packets to generate the LRIT files.  This part will be somwhat quick, because most of the hard stuff was already done in the last part. Sadly the decompression algorithm is a modified RICE algorithm, and the Linux version of the library provided by NOAA cannot be used anymore because of incompatibilities between GCC ABIs ( The NOAA library has been compiled with GCC 2). Until I reverse engineer and create a open version of the decompression algorithm, I will use the  workaround I will explain here.

<!--more-->

In the packets before we have a flag called **continuation flag** that will specify if the packet is a **start**,  **continuation** or **end packet.** It will also say if the packet itself is a single file. Usually the file header is entire contained on the first packet. One of the things we need to do is aggregate the start, continuation and end packets into a single file. This is easy since the when a start packet appears inside a channel with the same **APID**, the entire file will be transmitted at once, so the packets that will follow will be either continuation or end before a new start comes. So basically we just need to find a Packet Start with a certain APID and then grab and aggregate all of the following packets that has the same APID. But the packet content may also be compressed using **LritRice.lib** (provided by NOAA). To check if we need to decompress the packet or not, we need to check the header of the start packet (the header will always be decompressed).

# File Header Processing

The LRIT File has several headers. The first one is from the transport layer that says what is the file number and what is the total decompressed size. i usually ignore this data because its only used for validation of the finished file. This header has 10 bytes.

<div style="width: 636px" class="wp-caption aligncenter">
  <img class="size-large" src="https://i.imgur.com/OPMwMQz.png" alt="LRIT File" width="626" />
  
  <p class="wp-caption-text">
    LRIT File
  </p>
</div>

Discarding the first 10 bytes (2 bytes for file counter and 8 bytes for the length), you will have the Primary Header. The primary header has basically just the size of the LRIT File header. We will need to parse all the headers (including the secondary) in order to find if the continuation packets will be compressed and if they are, what are the parameters to decompress (yes, they can change). I created a **packetmanager.py** script to export few helper functions to parse the header inside **channeldecode.py**. There are several header types with different lengths, but they do have two parameters in common:

  * **Type** &#8211; 1 byte (uint8_t)
  * **Size** &#8211; 2 byte (uint16_t)

So what I usually do, is to grab the first 3 bytes of a header, check the size (the size includes these 3 bytes) and then fetch more size &#8211; 3 bytes to the buffer. With this buffer I pass to another function that will parse the header data and return a object with their parameters. This is my **parseHeader** function:

<pre class="brush: python; title: ; notranslate" title="">def parseHeader(type, data):
  if type == 0:
    filetypecode, headerlength, datalength = struct.unpack("&gt;BIQ", data)
    return {"type":type, "filetypecode":filetypecode, "headerlength":headerlength, "datalength":datalength}
  elif type == 1:
    bitsperpixel, columns, lines, compression = struct.unpack("&gt;BHHB", data)
    return {"type":type, "bitsperpixel":bitsperpixel, "columns":columns, "lines":lines, "compression":compression}

  elif type == 2:
    projname, cfac, lfac, coff, loff = struct.unpack("&gt;32sIIII", data)
    return {"type":type, "projname":projname, "cfac":cfac, "lfac":lfac, "coff":coff, "loff":loff}

  elif type == 3:
    return {"type":type, "data":data}

  elif type == 4:
    return {"type":type, "filename":data}

  elif type == 5:
    days, ms = struct.unpack("&gt;HI", data[1:])
    return {"type":type, "days":days, "ms":ms}

  elif type == 6:
    return {"type":type, "data":data}

  elif type == 7:
    return {"type":type, "data":data}

  elif type == 128:
    imageid, sequence, startcol, startline, maxseg, maxcol, maxrow = struct.unpack("&gt;7H", data)
    return {"type":type, "imageid":imageid, "sequence":sequence, "startcol":startcol, "startline":startline, "maxseg":maxseg, "maxcol":maxcol, "maxrow":maxrow}

  elif type == 129:
    signature, productId, productSubId, parameter, compression = struct.unpack("&gt;4sHHHB", data)
    return {"type":type, "signature":signature, "productId":productId, "productSubId":productSubId, "parameter":parameter, "compression":compression}

  elif type == 130:
    return {"type":type, "data":data}

  elif type == 131:
    flags, pixel, line = struct.unpack("&gt;HBB", data)
    return {"type":type, "flags":flags, "pixel":pixel, "line":line}

  elif type == 132:
    return {"type":type, "data": data}
  else:
    return {"type":type}
</pre>

And since we should read all headers, here is the **getHeaderData** function:

<pre class="brush: python; title: ; notranslate" title="">def getHeaderData(data):
  headers = []
  while len(data) &gt; 0:
    type = ord(data[0])
    size = struct.unpack("&gt;H", data[1:3])[0]
    o = data[3:size]
    data = data[size:]
    td = parseHeader(type, o)
    headers.append(td)
    if td["type"] == 0:
      data = data[:td["headerlength"]-size]
  return headers
</pre>

With that, we have enough stuff for using in our **channeldecoder.py** and know if the file is compressed. Basically we can do a simple **import packetmanager** and use the packetmanager.py functions.

# LritRice Compression

Usually for images, the data is compressed using **LritRice.lib**. Although RICE compression is a open standard (NASA&#8217;s fitsio library has compression and decompression of RICE), the LritRice use a modified version. With time I will reverse engineer and create a open version that will be able to decompress LRIT data, but for now I had to do a workarround. Since the LritRice from linux is &#8220;broken&#8221;, I made a very nasty workarround:

Make a windows application to decompress and run through wine.

The project of decompressor is available here: <https://github.com/racerxdl/open-satellite-project/tree/master/GOES/decompressor>, I will soon release some binaries for those who don&#8217;t want to compile the application themselves. But for those who want, just open the visual studio solution and hit compile, it should generate a **decompressor.exe** that we will be using together with wine and python (or if you&#8217;re at windows, just with python).

The decompressor is made to receive some arguments and has two ways of operation:

  * **Single File Decompression:** _decompressor.exe Pixels Filename_
  * **Multi File Decompression:** _decompressor.exe Prefix StartNumber EndNumber [DebugMode]_

We&#8217;re gonna use the Multi File decompression. It does basically the same as single file, but iterates over several files and decompress all of them into a single file. So the output file will be a single file with all of the original files together (so our final LRIT file). The **StartNumber** should be the number of the first **continuation** packet (so not the header packet). The Multi File Decompression will look into StartNumber-1 to EndNumber files, being the StartNumber-1 just rewrited to the output file that will have a **_decomp** suffix. So in our **channeldecoder.py** we need to do few steps.

First let&#8217;s check if either the packet stream will need to be decompressed or just appended. If they just need to be appended, we only do that. Text files and DCS files are usually not compressed.

In our **savePacket** function, if the packet is a **start packet**, we should run the **getHeaderData** from **packetmanager** and check the compression flags.

<pre class="brush: python; title: ; notranslate" title="">if packet["sequenceflag_int"] == 1:
    print "Starting packet %s_%s_%s.lrit"  % (packet["apid"], packet["version"], packet["packetnumber"])
    startnum = packet["packetnumber"]
    p = packetmanager.getHeaderData(data[10:])
    for i in p:
      if i["type"] == 1 or i["type"] == 129:
        isCompressed = not i["compression"] == 0
      if i["type"] == 1:
        pixels = i["columns"]
</pre>

In headers of type 1 (Image Structure Header) or type 129 (NOAA Specific Header) both describe if its compressed or not. If its an image, we will have the compression flag set on Image Structure Header. If its another file, it will be in NOAA Specifc header. If the data is compressed, we need to grab the **columns** parameter that will be used as the **Pixels** parameter in **decompressor**. If the decompression is enabled, all further packets including the end packet will need to be decompressed. So for running decompressor we also need what is the packetnumber of the first packet (that will be the start packet + 1) and the number of the latest packet. So if the continuation flag says that the current packet is the latest, we need to save the number:

<pre class="brush: python; title: ; notranslate" title="">elif packet["sequenceflag_int"] == 2:
    print "Ending packet %s_%s_%s.lrit"  % (packet["apid"], packet["version"], packet["packetnumber"])
    endnum = packet["packetnumber"]
    if startnum == -1:
      print "Orphan Packet. Dropping"
      return
 elif packet["sequenceflag_int"] != 3 and startnum == -1:
    print "Orphan Packet. Dropping."
    return
</pre>

I also set the **startnum** as -1 when there is no received start packet, so I can know if I have any orphan continuation / end packets. If that&#8217;s the case, we just drop (if we don&#8217;t have the headers we cannot know whats the content). Now we need to handle the output filename. If its compressed we won&#8217;t be appending each packet to a final file, instead we will create a file that contains the packet number on it (so the decompressor can run over it). But if the data isn&#8217;t compressed, we can just append to the final file, so our final file shouldn&#8217;t have the packet number.

<pre class="brush: python; title: ; notranslate" title="">if isCompressed:
    filename = "channels/%s/%s_%s_%s.lrit" % (channelid, packet["apid"], packet["version"], packet["packetnumber"])
  else:
    filename = "channels/%s/%s_%s.lrit" % (channelid, packet["apid"], packet["version"])
</pre>

Now, in aspect of saving the file. If its not compressed we need to open for appending, if it is we just save by skipping the 10 first bytes.

<pre class="brush: python; title: ; notranslate" title="">firstorsinglepacket = packet["sequenceflag_int"] == 1 or packet["sequenceflag_int"] == 3
    if not isCompressed:
      f = open(filename, "wb" if firstorsinglepacket else "ab")
    else:
      f = open(filename, "wb")
</pre>

For running the decompressor I created a function called **Decompressor** that will receive the parameters and run wine to process the file. It will also delete the original compressed packets, since everything should be at a _decomp file.

<pre class="brush: python; title: ; notranslate" title="">from subprocess import call

def Decompressor(prefix, pixels, startnum, endnum):
  startnum += 1
  call(["wine", "Decompress.exe", prefix, str(pixels), str(startnum), str(endnum), "a"], env={"WINEDEBUG":"-all"})
  for i in range(startnum-1, endnum+1):
    k = "%s%s.lrit" % (prefix, i)
    if os.path.exists(k):
      os.unlink(k)
  return "%s_decomp%s.lrit" % (prefix, startnum-1)
</pre>

Now we can do the following to have the things decompressed:

<pre class="brush: python; title: ; notranslate" title="">if (packet["sequenceflag_int"] == 2 or packet["sequenceflag_int"] == 3):
      if isCompressed:
        if startnum != -1:
          decompressed = Decompressor("channels/%s/%s_%s_" % (channelid, packet["apid"], packet["version"]), pixels, startnum, endnum)
</pre>

The **decompressed** var will have the final filename of the decompressed file.

# File Name from Header

Some of the files has a filename in the header. So if they have, we can rename it. The header that contains the filename is header type 4 (Annotation Record). so I created a funcion called **manageFile** inside **packetmanager.py** to do the work of the filename.

<pre class="brush: python; title: ; notranslate" title="">def manageFile(filename):
  f = open(filename, "r")

  try:
    k = readHeader(f)
    type, filetypecode, headerlength, datalength = k
  except:
    print "   Header 0 is corrupted for file %s" %filename
    return

  newfilename = filename
  while f.tell() &lt; headerlength:
    data = readHeader(f)
    if data[0] == 4:
      #print "   Filename is %s" % data[1]
      newfilename = data[1]
      break
  f.close()
  if filename != newfilename:
    print "   Renaming %s to %s/%s" %(filename, os.path.dirname(filename), newfilename)
    os.rename(filename, "%s/%s" %(os.path.dirname(filename), newfilename))
  else:
    print "   Couldn't find name in %s" %filename
</pre>

This code will search for a filename in header, if it finds, it will rename the input filename to whatever is in the header. If not, it will just keep the same name. So in the **channeldecoder.py** I can just do this to have everything processed:

<pre class="brush: python; title: ; notranslate" title="">if (packet["sequenceflag_int"] == 2 or packet["sequenceflag_int"] == 3):
      if isCompressed:
        if USEDECOMPRESSOR and startnum != -1:
          decompressed = Decompressor("channels/%s/%s_%s_" % (channelid, packet["apid"], packet["version"]), pixels, startnum, endnum)
          packetmanager.manageFile(decompressed)
      else:
        print "File is not compressed. Checking headers."
        packetmanager.manageFile(filename)
</pre>

After that, you should have all files with the correct naming (if they have in the header) and decompressed! The filenames are usually like _gos13chnIR04rgnNHseg001res04dat308034918927.lrit_.

# Viewing the files content

I still need to do some program to parse, but at least for now there is the **[xrit2pic](http://www.alblas.demon.nl/wsat/software/soft_msg.html)** that can parse some of the GOES LRIT (and other satellites LRIT) files. If you want to make your own parser, most of the files are easy to process. The Text files are just raw text data (so just skip the headers), the images are in raw format (check the headers to see how they&#8217;re composed). Some aditional details about the headers that I mapped are here: <https://github.com/racerxdl/open-satellite-project/blob/master/GOES/standalone/packetmanager.py#L172-L260>

In a future article I will make a User Guide to my LRIT Decoder. For now I want to make it better and with a more user friendly interface, so this articles are intended to someone who wants to understand how the protocol works. These are some data I got from GOES 13:

<div style="width: 650px" class="wp-caption alignnone">
  <a href="http://imgur.com/3Zz7gvg"><img class="size-large" src="https://i.imgur.com/3Zz7gvgl.jpg" alt="GOES 13 Full Disk Image" width="640" /></a>
  
  <p class="wp-caption-text">
    GOES 13 Full Disk Image
  </p>
</div>

<div style="width: 730px" class="wp-caption aligncenter">
  <img class="size-large" src="https://i.imgur.com/ZPt2udw.jpg" alt="Meteosat Small Fulldisk image" width="720" />
  
  <p class="wp-caption-text">
    Meteosat Small Fulldisk image
  </p>
</div>

<div style="width: 650px" class="wp-caption aligncenter">
  <a href="http://imgur.com/TYA4b1X"><img class="size-large" src="https://i.imgur.com/TYA4b1Xl.jpg" alt="WEFAX messages" width="640" /></a>
  
  <p class="wp-caption-text">
    WEFAX messages
  </p>
</div>

Text Messages:

> &#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8211;  
> LRIT Admin Message #011  
> Start:14-April-2010  
> End:20-December-2018  
> Distribution: East and West  
> Subject: LRIT contact information  
> &#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8211;  
> The LRIT Systems team, in an effort to be more responsive  
> to the user community, would like for users to have  
> contact information. In the event that a user notices any  
> long term trends or anomalies in the LRIT data stream, or  
> has suggestions or comments. We ask that contact be made  
> via email to LRIT@noaa.gov.
> 
> If more immediate matters arise, that the user deems as  
> urgent, we advise the use of the following operational  
> facility phone number: 301-817-3880.  
> &#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8211;

# Ending

This is the last chapter of my GOES Satellite Hunt. For sure there will be more things that I will right about it but at least with this Article you should be able to create your own Demodulator / Decoder for LRIT signals. I still have some stuff todo, but I will post my progress here in this blog.

I would like to thank Trango (@usa_satcom) for all the help with the problems I had with Viterbi and ReedSolomon parts, and all other guys on #hearsat that helped me to build this project. I hope you all liked this article, and stay tuned for more!

The entire working source code is at [OpenSatellite Project in github](https://github.com/racerxdl/open-satellite-project).