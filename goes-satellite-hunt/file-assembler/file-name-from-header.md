---
title: File Name from Header - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# File Name from Header

Some of the files has a filename in the header. So if they have, we can rename it. The header that contains the filename is header type 4 \(Annotation Record\). so I created a funcion called **manageFile** inside **packetmanager.py** to do the work of the filename.

```py
def manageFile(filename):
  f = open(filename, "r")
 
  try:
    k = readHeader(f)
    type, filetypecode, headerlength, datalength = k
  except:
    print "   Header 0 is corrupted for file %s" %filename
    return
 
  newfilename = filename
  while f.tell() < headerlength:
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
```

This code will search for a filename in header, if it finds, it will rename the input filename to whatever is in the header. If not, it will just keep the same name. So in the **channeldecoder.py** I can just do this to have everything processed:

```py
if (packet["sequenceflag_int"] == 2 or packet["sequenceflag_int"] == 3):
  if isCompressed:
    if USEDECOMPRESSOR and startnum != -1:
      decompressed = Decompressor("channels/%s/%s_%s_" % (channelid, packet["apid"], packet["version"]), pixels, startnum, endnum)
      packetmanager.manageFile(decompressed)
  else:
    print "File is not compressed. Checking headers."
    packetmanager.manageFile(filename)
```

After that, you should have all files with the correct naming \(if they have in the header\) and decompressed! The filenames are usually like 

_gos13chnIR04rgnNHseg001res04dat308034918927.lrit_

<div class="pagination">
    <a href="{{ 'lritrice-compression' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'viewing-the-files-content' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
