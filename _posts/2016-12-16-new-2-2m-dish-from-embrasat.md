---
id: 287
title: New 2.2m dish from Embrasat!
date: 2016-12-16T16:42:02-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=287
permalink: /2016/12/new-2-2m-dish-from-embrasat/
image: /wp-content/uploads/2016/12/20161214_192121-1-624x351.jpg
categories:
  - English
  - Satellite
  - SDR
tags:
  - 2.2m Prime Focus
  - Airspy
  - Antenna
  - Dish
  - Embrasat
  - English
  - Gnuradio
  - GOES
  - GOES 13
  - GOES 16
  - GOES-R
  - GQRX
  - HackRF
  - Hearsat
  - Linux
  - LRIT
  - Open Satellite Project
  - OSP
  - Prime Focus
  - RTLSDR
  - Satellite
  - SDR
  - Waveguide
  - Waveguide Feed
---
It has been some time since I posted something here about my satellite projects. So now I finished assembling my new dish! Previous (on GOES Satellite Hunt) I use a 1.9m TV dish that was cheap (R$200 or about US$70) and got really nice results (about 6dB SNR on LRIT and 10dB SNR on EMWIN). But I was willing to get the new GRB Signal from GOES-16 (previous named as GOES-R) that went up to Geostationary orbit last month. The GRB is the replacement for the GOES 13/14/15 GVAR signal. Basically GVAR is a rebroadcast of the partially processed data from the satellite. It is basically the raw sensor data packed in a format so the users can get and process by their own. The disadvantage of GVAR system over LRIT is that it does not have any error correcting methods. So either you have a very good signal, or you don&#8217;t have anything at all. The GRB signal that is on GOES-16 will send same raw data as the GVAR (actually it will send more data than GVAR, but thats another point) but now it will use DVB-S2, a market standard, for transmitting their data. Being DVB-S2 it does have error correcting like LRIT signal ( wikipedia has a good info about [DVB-S2](https://en.wikipedia.org/wiki/DVB-S2)). But the bandwidth of GRB is much higher than LRIT and GVAR (LRIT is 600kHz wide, GVAR is 2.5MHz wide and GRB is 9MHz wide) so I would need a bigger dish to get a good signal.

<!--more-->

# Embrasat Antennas

Being in Brazil has some advantages. Prime Focus TV dishes are still very common and cheap here. Talking with trango on hearsat I noticed that in the USA its not easy to find a prime focus dish anymore. The thing that there is bigger prime focus dishes than offset dishes in the market. In the USA its easier to find offset dishes than in Brazil (except for those normal TV ones like 60 / 80 / 90 cm diameter), but here its easier to find prime focus until 2.4m.

This time I decided to buy a better dish. I searched for national professional dishes to get a better dish. I didn&#8217;t found many, but one of them got my attention. [Embrasat](http://www.embrasat.com.br) has dishes from 1.8m to 4.5m and their customers are the biggest TV and Broadband Internet companies on the internet. So I decided to get a quote from them for the 2.2m and 2.6m dishes (bigger wouldn&#8217;t fit in my house and would be really expensive). So for those who are curious these was the values:

  * Antenna RTM-2200STD &#8211; R$1200
  * Base Kit (Kit &#8220;Chumbador&#8221;) &#8211; R$52
  * Shipping for Sao Paulo &#8211; R$169
  * Total: R$1421

  * Antenna RTM-2600STD &#8211; R$1870
  * Base Kit (Kit &#8220;Chumbador&#8221;) &#8211; R$69
  * Shipping for Sao Paulo &#8211; R$230,20
  * Total: R$2169,20

If you want to buy from Embrasat, I advise you to make a quote with them. These was the prices I got when I quoted (2016/11/18), that prices can vary over time and where you&#8217;re. I only putting these here for reference.

But at the same time I found a guy selling a new 2.2m dish from Embrasat on Mercado Livre. He said that he bought a few for a project, but didn&#8217;t used all of them so it was even packed on the original case. The price was cheaper: R$800 for the antenna and the Base Kit. I decided to buy from him. The total price with the shipping was something around R$900.

# The 2.2m Antenna

<img class="aligncenter size-large" src="https://i.imgur.com/BxjiJE3.jpg" width="1631" /> 

So the first thing I noticed it was bigger than I expected comparing to my 1.9m dish. It also came with a manual (the normal TV dishes doesn&#8217;t come). The antenna has a fiberglass body that has a special mixture in the resin so it would be reflective.

The overall weight was about 54kg but half of the weight is just the pole base.

<img class="aligncenter size-large" src="https://i.imgur.com/pKeUg7r.jpg" width="516" /> 

# Assembling the dish

The manual had assembling instructions for the dish. It&#8217;s pretty straight forward, and the total assembling time was about 2h (against 6h for my old 1.9m dish). Basically is just screw everything together. The only hard part is that the metal parts that actually bend the fiberglass pieces to the right position, so I had to be careful before tightening the screws to be able to bend the fiberglass to the correct holes. After assembled I noticed a **important thing**: The old TV dish has a 1.9m (actually 1.85m) total outer diameter. This embrasat dish has 2.2m **inner usefull diameter** (excluding the border of the antenna). That makes a huge difference since the border of the antenna usually (not the TV dish though) have a specific shape to reduce the noise generated from that part. The **total outer diameter** of the Embrasat dish is actually **2.4m**

<img class="aligncenter size-large" src="https://i.imgur.com/hdTwpZJ.png" width="1280 /> <img class="aligncenter size-large" src="https://i.imgur.com/zYn605K.png" width="720" />

<img class="aligncenter size-large" src="https://i.imgur.com/qr0HsIn.png" width="1280" /> 

# Mouting the base

The first thing we wanted (actually suggested by my father and uncle) to do for the base was to drill some holes in the ground to fix the Base Kit and make a concrete block. Sadly my floor surface is very bad and the concrete block went off with part of the floor surface on the first wind.

<img class="aligncenter size-large" src="https://i.imgur.com/503Pxxj.jpg" width="1602" /> 

So I decided to do a better approach to drill the and make a whole through the floor (the dish is on the house second floor) and use screw bar to fix everything on both sides. This would obviously require some waterproof work since if it rains it could flood my garage.

So I did the waterproof isolation with some Silicon Rubber around the screws on the floor and lots of PU Foam below the base. We did the PU Foam and put the base and tight the screws fast enough so the PU Foam would expand with the base over it, forcing the PU Foam to fill all the possible holes that the Silicon Rubber didn&#8217;t. The pressure also made the Silicon Rubber to fill better the holes. We waited one day to everything be ready and made some tests with water (and also we got a storm). Everything looks good now (no leaks so far).

<div style="width: 1641px" class="wp-caption aligncenter">
  <img class="size-large" src="https://i.imgur.com/61HIsZT.jpg" width="1631" />
  
  <p class="wp-caption-text">
    Bottom of the floor where the dish is fixed (the ceil).
  </p>
</div>

<div style="width: 1641px" class="wp-caption aligncenter">
  <img class="size-large" src="https://i.imgur.com/UWh9pQB.jpg" width="1631" />
  
  <p class="wp-caption-text">
    The fixed base of the dish.
  </p>
</div>

# The feed

For the feed I decided to get the wave guide from the last dish. Since this new dish is just in front of the old one (that I have later plans for) I removed the wave guide feed and made a adapter ring for the new dish. After finished, it actually looks pretty cool.

<img class="aligncenter size-large" src="https://i.imgur.com/3QGpjOL.jpg" width="1602" /> 

<img class="size-large aligncenter" src="https://i.imgur.com/pppwf6h.jpg" width="507" /> 

<img class="aligncenter size-large" src="https://i.imgur.com/232UcE2.jpg" width="1602" /> 

# Testing

So now let&#8217;s talk about numbers. How much did the new dish improve regarding the last dish? Actually a lot.

<div style="width: 1315px" class="wp-caption aligncenter">
  <img class="size-large" src="https://i.imgur.com/7D1xoPe.png" width="1305" />
  
  <p class="wp-caption-text">
    1.9m Dish with OpenSatelliteProject LRIT Demodulator
  </p>
</div>

<div style="width: 1019px" class="wp-caption aligncenter">
  <img class="size-large" src="https://i.imgur.com/0xAmxzb.png" width="1009" />
  
  <p class="wp-caption-text">
    2.2m Embrasat dish with Open Satellite Project LRIT Demodulator
  </p>
</div>

So the signal almost doubled (from 5.4dB SNR to 10dB SNR) and my lock is basically perfect now. Regarding the decoder errors:

<div style="width: 1048px" class="wp-caption aligncenter">
  <img class="size-large" src="https://i.imgur.com/zRtIjme.png" width="1038" />
  
  <p class="wp-caption-text">
    1.9m dish OpenSatelliteProject LRIT Decoder
  </p>
</div>

<div style="width: 742px" class="wp-caption aligncenter">
  <img class="size-large" src="https://i.imgur.com/OCDSHfo.png" width="732" />
  
  <p class="wp-caption-text">
    2.2m Dish OpenSatellite Project LRIT Decoder
  </p>
</div>

So the Viterbi Correction bits went down from 100 to 16 and the average RS Correction is now 0. Thats a huge improvement. Also notice that I still have some RS Corrections (and I shouldn&#8217;t). That problably means something is wrong on OSP Decoder (some analysis from me and trango made we believe that this is a mistake, since his decoder shows 0 RS all over the time and mine sometimes show something on the 4th RS Frame, and always on the 4th).

# Conclusion

I probably have some room for improvement on the feed. I didn&#8217;t tuned the position of the feed regarding the focus neither the rotation (the polarization is linear), but so far I got a very huge improvement in signal from GOES 13. For the GOES-16 I will need to replace the feed since GRB signals are Circular Polarized (two Channels, one LHCP and one RHCP). I&#8217;m looking forward for a Backfire Helix and a Dual CP Waveguide but both requires some complex assembling for this dish. I will keep you guys noticed about it.

If you want to check the LRIT signals yourself, I have some basebands recorded here: [http://www.teske.net.br/lucas/basebands/goes13/lrit/](https://www.teske.net.br/lucas/basebands/goes13/lrit/) . There is the old dish baseband and the new dish (you can check by date). They&#8217;re GQRX recordings, so its a raw GNU Radio Complex IQ Data, check the README for details.