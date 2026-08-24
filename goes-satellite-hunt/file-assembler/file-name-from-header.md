---
title: "File Name from Header - GOES Satellite Hunt | Lets Hack It"
description: "Written by Lucas Teske on 19 February 2017 Part of GOES Satellite Hunt Project overview → File Name from Header Some of the files has a filename in the header. So if they have, we can rename it. The header that contains the filename is header type 4 (Annotation Record)...."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Written by Lucas Teske   
on 19 February 2017

# 

# File Name from Header

Some of the files has a filename in the header. So if they have, we can rename it. The header that contains the filename is header type 4 (Annotation Record). so I created a funcion called&nbsp; **manageFile** inside&nbsp; **packetmanager.py** to do the work of the filename.

```
def manageFile(filename):
  f = open(filename, "r")
 
  try:
    k = readHeader(f)
    type, filetypecode, headerlength, datalength = k
  except:
    print " Header 0 is corrupted for file %s" %filename
    return
 
  newfilename = filename
  while f.tell() < headerlength:
    data = readHeader(f)
    if data[0] == 4:
      #print " Filename is %s" % data[1]
      newfilename = data[1]
      break
  f.close()
  if filename != newfilename:
    print " Renaming %s to %s/%s" %(filename, os.path.dirname(filename), newfilename)
    os.rename(filename, "%s/%s" %(os.path.dirname(filename), newfilename))
  else:
    print " Couldn't find name in %s" %filename
```

This code will search for a filename in header, if it finds, it will rename the input filename to whatever is in the header. If not, it will just keep the same name. So in the&nbsp; **channeldecoder.py** I can just do this to have everything processed:

```
if (packet["sequenceflag_int"] == 2 or packet["sequenceflag_int"] == 3):
  if isCompressed:
    if USEDECOMPRESSOR and startnum != -1:
      decompressed = Decompressor("channels/%s/%s_%s_" % (channelid, packet["apid"], packet["version"]), pixels, startnum, endnum)
      packetmanager.manageFile(decompressed)
  else:
    print "File is not compressed. Checking headers."
    packetmanager.manageFile(filename)
```

After that, you should have all files with the correct naming (if they have in the header) and decompressed! The filenames are usually like&nbsp;

_gos13chnIR04rgnNHseg001res04dat308034918927.lrit_

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
