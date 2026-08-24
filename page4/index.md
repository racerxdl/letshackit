---
title: "Home | Lets Hack It"
description: "Lets Hack It December 29, 2019 Hacking Dimmer Touch Panel with ESP8266 Hacking Dimmer Touch Panel with ESP8266 I bought two of these LED Touch Panel Dimmers in Banggood and they look pretty good. But since my house automation has its own way to controlling the lights I wonder if..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Lets Hack It
  

December 29, 2019
## [Hacking Dimmer Touch Panel with ESP8266](/2019/12/hacking-dimmer-touch-panel-with-esp8266/)

 ![Two rectangular wall-mounted dimmer switches, black and white, with volume control buttons.](/assets/posts/medium/0_NB2IwKOMRoAK5Yr5.png)

Hacking Dimmer Touch Panel with ESP8266 I bought two of these LED Touch Panel Dimmers in Banggood and they look pretty good. But since my house automation has its own way to controlling the lights I wonder if I could hack them to send info to Home Assistant. The first thing I opened one of them to check what’s inside. It has two boards connected by a Flat Cable Touch Panel Board Dimmer Board The dimmer board does have some micro controller that looks like a PIC, few mosfets and a buzzer. The touch panel has a WTC801SPI controller. WTC801SPI...

December 21, 2019
## [Creating your own GSM Network with LimeSDR](/2019/12/creating-your-own-gsm-network-with-limesdr/)

 ![Terminal output showing OsmoTRX software logs and configuration settings for a radio transceiver.](/assets/posts/medium/1_KbNtmYsmaCMVJinWnJdhFg.png)

Creating your own GSM Network with LimeSDR DISCLAIMER: This procedure is highly illegal basically anywhere in the world. Be sure to run this in a closed RF environment (aka Faraday Cage) This article works with any LimeSDR version. For this example we will use the Osmocom GSM Stack in the NITB (Network in the box) mode. In this mode the phones connected to you BTS will be able to call each other and send SMS messages. There is also the Interconnect mode in which the BSC (Base Station Controller) connects to a ISDN or IPBX (for example Asterisk) to manage...

October 25, 2019
## [Dahua / Intelbras MitM Attack](/2019/10/dahua-intelbras-mitm-attack/)

 ![White dome security camera with Intelbras branding and lens visible.](/assets/posts/medium/0_EtFMEwgxuAJGBNT0.jpg)

Dahua / Intelbras MitM Attack How to perform a very simple MitM Attack on a Intelbras/Dahua IP Cameras / DVR. This uses Ettercap to do an ARP Poison and a simple GoLang Script to fetch the username/password. Disclaimer: This type of attack is basically illegal anywhere in the world. My intentions with this tutorial is to demonstrate why you should ALWAYS use a TLS connection for ANYTHING. Use for you own risk. For the purpose of responsible disclosure, I contacted Intelbras on Twitter on 11/08/2019 and let them know I expected a reply from them until 17/08/2019. If they didn’t...

June 16, 2019
## [Reverse Engineering cheap chinese "VRCAM" protocol](/2019/06/reverse-engineering-cheap-chinese-vrcam-protocol/)

 ![White dome security camera with central lens, speaker grilles, and mounting holes on perforated surface.](/assets/posts/medium/0*5_jc2oOyiJRbfezD.jpg)

Reverse Engineering cheap chinese “VRCAM” protocol That’s not the first time I get a Chinese hardware that has some proprietary protocol that does not follow a single standard. It’s funny because when you get a VERY cheap thing, you expect to use many standards as possible to reduce the development cost, but some chinese developers just want to do it yourselves. I present you the “VRCAM” and it’s SOUP protocol (any relation to SOAP is just a mere coincidence :P) The Hardware Let’s first start with the hardware itself. It’s a 2 Megapixel sensor with 1280x960 video resolution. It features...

October 15, 2017
## [GOES GRB First Light!](/2017/10/goes-grb-first-light/)

 ![](/wp-content/uploads/2017/10/36965004104_888abc985b_z-624x374.jpg)

When the GOES-16 was first announced I got interested in their GRB Downlink (although the first try was at HRIT downlink). Basically GRB is a replacement for the old PDR downlink in GOES 13/14/15 generation, which gives few advantages over the old link: Uses market standard DVB-S2 Generic Stream Have FEC (as defined by DVB-S2) Higher bandwidth Easier to receive due DVB-S2 FEC For those who don’t know, the GRB is a direct rebroadcast of GOES data, with minimum processing as possible (usually just packaged into NetCDF files with calibration parameters) and is intended for anyone that want’s to get...
