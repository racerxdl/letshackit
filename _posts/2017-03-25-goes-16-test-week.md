---
id: 319
title: GOES 16 Test Week
date: 2017-03-25T12:38:50-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=319
permalink: /2017/03/goes-16-test-week/
categories:
  - English
  - Satellite
  - SDR
tags:
  - Airspy
  - Antenna
  - Automatic Gain Control
  - CMI
  - EMWIN
  - English
  - GRC
  - Hearsat
  - HRIT
  - Linux
  - LRIT
  - NetCDF
  - NOAA
  - SDR
  - Ubuntu
---
Yesterday I received an email from NOAA (I&#8217;m on their &#8220;tester&#8221; list) about some tests on GOES-16 that will happen this week. Before I start talking about what will be the tests I want to be clear that GOES-16 **is NOT operational ye****t** and any data received from the LRIT/HRIT downlink are **test only data**. **This means the user of that link assumes all risks related to the use of their data and NOAA disclaims and any and all warranties, whether express or implied, including (without limitation) any implied warranties of merchantability or fitness for a particular purpose.**

So this week ( from 27th to 31th march ) HRIT will go into a new test phase that will send out DCS, Environmental Messages and charts through. They also will send from 16h to 20h UTC on Monday (27th) some CMI (Cloud and Moisture Imaging) data. That might be interesting for anyone that have a 1.5m+ dish that can run Linear Polarization at 1694MHz and be interested in trying out the super-alpha version of OpenSatelliteProject, that is already compatible to HRIT.

Please keep in mind that while OSP does support HRIT, it doesn&#8217;t mean it will support the new products coming out from HRIT link. They&#8217;re currently testing sending NetCDF files over HRIT, and so far OSP doesn&#8217;t support those. In normal case (no bugs) the output product should be stored in a folder named Unknown with the filename provided by NOAA. Regardless of that I will be trying to record the IQ / decoder output in the CMI period and run the OSP over all week in GOES-16.

While running in GOES-16 the Twitter / Instagram bots will not be outputing any GOES-13 data (sadly I only have one dish so far) but may output the products from GOES-16.

Some usefull links for you if you&#8217;re interested in more information:

  * OpenSatelliteProject help chat: <https://osp.teske.net.br>
  * OpenSatelliteProject forum: <http://hearsat.online/viewforum.php?f=18>
  * OpenSatelliteProject Twitter: <https://twitter.com/OpenSatProject>
  * OpenSatelliteProject Instagram: <http://instagram.com/opensatelliteproject/>
  * OpenSatelliteProject Github: <https://github.com/opensatelliteproject>
  * GOES-16 Mission Information: <http://www.goes-r.gov/>