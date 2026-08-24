---
title: "Home | Lets Hack It"
description: "Lets Hack It December 16, 2016 New 2.2m dish from Embrasat! It has been some time since I posted something here about my satellite projects. So now I finished assembling my new dish! Previous (on GOES Satellite Hunt) I use a 1.9m TV dish that was cheap (R$200 or about..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Lets Hack It
  

December 16, 2016
## [New 2.2m dish from Embrasat!](/2016/12/new-2-2m-dish-from-embrasat/)

 ![](/wp-content/uploads/2016/12/20161214_192121-1-624x351.jpg)

It has been some time since I posted something here about my satellite projects. So now I finished assembling my new dish! Previous (on GOES Satellite Hunt) I use a 1.9m TV dish that was cheap (R$200 or about US$70) and got really nice results (about 6dB SNR on LRIT and 10dB SNR on EMWIN). But I was willing to get the new GRB Signal from GOES-16 (previous named as GOES-R) that went up to Geostationary orbit last month. The GRB is the replacement for the GOES 13/14/15 GVAR signal. Basically GVAR is a rebroadcast of the partially processed data...

November 28, 2016
## [My Tesla Coils](/2016/11/my-tesla-coils/)

 ![](/wp-content/uploads/2016/11/5620739994_1080ae890f_o-624x351.jpg)

So I added a Page (http://www.teske.net.br/lucas/my-tesla-coils/) with my Tesla Coil Projects. It’s not by far all my videos (or my attempts) but shows some of the projects I did in the past. Checkout if you’re interested in Sparks and Music!

November 13, 2016
## [137MHz Bandpass filter for NOAA / Meteor Satellites](/2016/11/137mhz-bandpass-filter-for-noaa-meteor-satellites/)

 ![](/wp-content/uploads/2016/11/newfilter_predict-624x482.png)

Yesterday I saw a new blog post by Adam (9a4qv) in LNA4ALL. The post (here) talks about a band pass filter he did for Weather Satellites and I decided to try as well. Unfortunately I don’t have a exact match for that components at home, so I tried to do something with the components I have. So the lower value I had for capacitors was 10pF, and the needed values for Adam’s Filter is 1pF, 4.7pF and 15pF. I decided then to use 10 in series to do the 1pF, 2 in series for the 4.7pF (that will be 5pF)...

November 07, 2016
## [GOES Satellite Hunt (Part 5 – File Assembler)](/2016/11/goes-satellite-hunt-part-5-file-assembler/)

 ![](/wp-content/uploads/2016/11/3Zz7gvgh-624x568.jpg)

In the last chapter of my GOES Satellite Hunt, I explained how to obtain the packets. In this part I will explain how to aggregate and decompress the packets to generate the LRIT files. &nbsp;This part will be somewhat quick, because most of the hard stuff was already done in the last part. Sadly the decompression algorithm is a modified RICE algorithm, and the Linux version of the library provided by NOAA cannot be used anymore because of incompatibilities between GCC ABIs ( The NOAA library has been compiled with GCC 2). Until I reverse engineer and create a open...

November 06, 2016
## [GOES Satellite Hunt (Part 4 – Packet Demuxer)](/2016/11/goes-satellite-hunt-part-4-packet-demuxer/)

 ![](/wp-content/uploads/2016/11/5YBmBKt-624x129.png)

In the last chapter I showed how to get the frames from the demodulated bit stream. In this chapter I will show you how to parse these frames and get the packets that will on next chapter generate the files that GOES send. I will first add C code to the code I did in the last chapter to separated all the virtual channels by ID. But mainly this chapter will be done in python (just because its easier, I will eventually make a C code as well to do the stuff). De-randomization of the data One of the missing...
