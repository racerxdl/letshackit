---
title: "GOES GRB First Light! | Lets Hack It"
description: "Learn to receive GOES-16 GRB downlink signals using DVB-S2 and SDR. This guide covers dish sizes, circular polarization, and Open Satellite Project ingestion tools."
image: "https://lucasteske.dev/wp-content/uploads/2017/10/36965004104_888abc985b_z-624x374.jpg"
---

# GOES GRB First Light!

 ![GOES GRB First Light!](/wp-content/uploads/2017/10/36965004104_888abc985b_z-624x374.jpg)Written by Lucas Teske   
on 15 October 2017

When the GOES-16 was first announced I got interested in their GRB Downlink (although the first try was at HRIT downlink). Basically GRB is a replacement for the old PDR downlink in GOES 13/14/15 generation, which gives few advantages over the old link:

- Uses market standard DVB-S2 Generic Stream
- Have FEC (as defined by DVB-S2)
- Higher bandwidth
- Easier to receive due DVB-S2 FEC

For those who don’t know, the GRB is a direct rebroadcast of GOES data, with minimum processing as possible (usually just packaged into NetCDF files with calibration parameters) and is intended for anyone that want’s to get full data from the satellite.

The down-link itself is split into two channels transmitted at same frequency (1684.5 MHz) with different circular polarities. That makes extremely necessary to use Circular Polarized feeds, since a Linear Feed will suffer with cross polarization (sum of each channel at the same signal).

For HRIT downlink usually a 1 meter dish is enough for receiving with a good signal (needs a very good hardware setup though). But for GRB, the minimum dish size listed by NOAA is 3.8m for the best regions.

[![GRB Recommended Dish Size by NOAA](https://www.teske.net.br/lucas/wp-content/uploads/2017/10/Sele%C3%A7%C3%A3o_005-1024x649.png)](https://www.teske.net.br/lucas/wp-content/uploads/2017/10/Sele%C3%A7%C3%A3o_005.png)

We all know that NOAA has big margins over their recommended sizes (especially for GRB which technically should work in any weather condition). So we were testing with few dish sizes (and still testing) and checking which is the minimum size to receive a GRB signal.

I have a 2.2m prime focus dish, but sadly my station is offline for house changes (which I hope to finish by start of next year), [@usa\_satcom](https://twitter.com/usa_satcom) did some tests with his 1.8m dish with a RHCP feed&nbsp; and a TBS device and haven’t got a lock (although [@drmpeg](https://twitter.com/drmpeg) did some tests with his IQ and got a lock and almost a decodable signal with about 6dB SNR). One of OpenSatelliteProject users at [OSP RocketChat](https://osp.teske.net.br) , Ray Weber ( @weather01089 ) nave a 3m dish in Boston with a nice Septum Feed from [RF Ham Design](http://www.rfhamdesign.com/products/dish-feeds/septum-dish-feed/index.php) which gets about 12dB SNR signal and a perfect lock. Sadly for some reason the CCSDS inner data looks corrupt for unknown reasons right now. I tested with Ray with a TBS Card and a Ayecka Device with alpha testing firmware for raw BB Frame output and so far no luck (for unknown reasons).

We will continue trying and checking, and any people that has a DVB-S2 Generic Stream capable receiver and a dish bigger than 2 meters and visibility to GOES 16 is welcome to help us with testing for GRB. Notice that GOES-16 will change position next month to its final location replacing GOES 13.

## GRB Ingestion

Besides that, I decided to make a GRB Ingestion module for [Open Satellite Project](https://opensatelliteproject.github.io/OpenSatelliteProject/) (which I plan to receive 24/7 in the future). I asked NOAA if they had some test data I could use, and they forwarded me to [CSPP-GEO](http://cimss.ssec.wisc.edu/csppgeo/) project which has some test data. CSPP-GEO is a nice ingestion software for GRB and it’s probably the standard receiver nowadays. It outputs NetCDF files and receives a CADU UDP stream for each polarity. Still I wanted to learn the GRB ingestion process and do a more centralized processing (CSPP-GEO has several python scripts and a java ingestion server). So I downloaded their test data and started making the ingestor.

The ingestion process is not fully complete right now, but it does output SUVI and ABI imaging in 16 bit PGM format and optionally a PNG image (with values scaled to 8 bit). It also outputs other files as raw. The ingestion process is similar to GOES LRIT/HRIT since it uses CCSDS, but the frame size is different (2044 bytes instead 896 bytes) and it always have a second header for each packet (LRIT/HRIT doesn’t have a second header). Also ABI/SUVI images are compressed using JPEG2000 instead Goloumb Rice (SZIP), which makes easier to decompress (since its more standard than SZIP). The image segmentation is different having two parts of segmentation.

The first segmentation occurs from the original Image that is sub-divided in blocks in both axis (so a 2D Block grid). This requires a image buffer for drawing these blocks since they can be received out of order.&nbsp;The second segmentation occurs inside blocks, which looks similar to LRIT/HRIT segmentation since they’re only across Y axis and their output can be just appended.

Each segment of block is compressed using JPEG2000, meaning that for final image assemble all segments of block should be decompressed to assemble a block, then to assemble final image. These images always come as 16 bit / pixel since all sensors have higher than 8 bit depth, and that makes processing in C# (native language of OSP Ingestor) a bit tricky. For helping the image manipulations I created a [Image16](https://github.com/opensatelliteproject/grbdump/blob/master/ImageTools/Image16.cs) class that works similar to the Bitmap class on GDI+.

Another difference in the ingestion is that in LRIT/HRIT the files would have a segment counter in the header, but in the case of GRB the segments of the same file are identified by APID and Epoch in Microseconds. Basically any received image with the same APID and Epoch Timestamp are from the same image.

For testing purposes I made it save in a PGM file which is supported by GIMP and supports 16 bit. Then I can use GIMP 2.9.7 (which natively supports 16 bit imagery) to display / edit. I also made a PNG image saver that normalizes and scales down the 16 bit image to 8 bit, being possible to visualize with any program.

The full source code is available at&nbsp;[https://github.com/opensatelliteproject/grbdump](https://github.com/opensatelliteproject/grbdump) and instructions of how to use will come soon, but for now it supports UDP BBFrames / CADU on port 1234 (just compile, run and stream to port 1234 and you should have it ingesting and saving files).

## Sample Images

Here are some examples of Imagery got from CSPP-GEO Test Data (normalized and scaled images)

[![GOES 16 - SUVI - Fe132](https://farm5.staticflickr.com/4512/23784181498_d6d114eca6_n.jpg)](https://www.flickr.com/photos/energylabs/23784181498/in/album-72157686640324221/ "GOES 16 - SUVI - Fe132")

[![GOES 16 - SUVI - Fe132](https://farm5.staticflickr.com/4451/36926665434_903a3e74bf_n.jpg)](https://www.flickr.com/photos/energylabs/36926665434/in/album-72157686640324221/ "GOES 16 - SUVI - Fe132")

[![GOES 16 - CONUS Band 2](https://farm5.staticflickr.com/4465/37605293782_a67b702db6_n.jpg)](https://www.flickr.com/photos/energylabs/37605293782/in/album-72157686640324221/ "GOES 16 - CONUS Band 2")

More images at: [https://www.flickr.com/photos/energylabs/sets/72157686640324221](https://www.flickr.com/photos/energylabs/sets/72157686640324221)

And some False / True Color generated images:

[![GOES-16 False Color](https://farm5.staticflickr.com/4477/37604337052_3bd830017e_n.jpg)](https://www.flickr.com/photos/energylabs/37604337052/in/album-72157686640324221/ "GOES-16 False Color")

[![RGB Composite CONUS](https://farm5.staticflickr.com/4493/36965004104_888abc985b_n.jpg)](https://www.flickr.com/photos/energylabs/36965004104/in/album-72157686640324221/ "RGB Composite CONUS")

If you want to check the RAW images by yourself, I uploaded them here:&nbsp;[http://www.teske.net.br/lucas/osp/goes16/GRB/](https://www.teske.net.br/lucas/osp/goes16/GRB/)

Have fun!

## Cite this article

### Suggested citation

Lucas Teske. “GOES GRB First Light!” _Lets Hack It_, 2017. [https://lucasteske.dev/2017/10/goes-grb-first-light/](https://lucasteske.dev/2017/10/goes-grb-first-light/).

### BibTeX

```
@misc{teske2017goesgrbfirstlight,
  author = {Lucas Teske},
  title = {GOES GRB First Light!},
  year = {2017},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/2017/10/goes-grb-first-light/}
}
```
