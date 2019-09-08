---
id: 141
title: LeMaker Guitar Review
date: 2016-02-01T22:57:39-03:00
author: racerxdl
layout: post
guid: http://www.teske.net.br/lucas/?p=141
permalink: /2016/02/lemaker-guitar-review/
image: /wp-content/uploads/2016/02/lemaker-624x624.jpg
categories:
  - English
tags:
  - ARM
  - Chalk-Elec
  - LCD TouchScreen
  - Le Maker Guitar
  - LeMaker
  - Linux
  - Open Hardware
  - Open Source
  - OpenHardware
  - OpenSource
  - QFH
  - Receiver
  - RTL SDR
  - Satellite
  - SDR
  - Software Defined Radio
  - Ubuntu
  - Weather
  - Weather Satellite Receiver
format: image
---
<a title="20160119_191023" href="https://www.flickr.com/photos/energylabs/24762647165/in/dateposted-public/" data-flickr-embed="true"><img class="alignleft" src="https://farm2.staticflickr.com/1484/24762647165_1cff28db6d_n.jpg" alt="20160119_191023" width="180" height="320" /></a>

So I few weeks ago I received a **<a href="http://www.lemaker.org/product-guitar-index.html" target="_blank">LeMaker Guitar</a> **board that I won on a <a href="http://www.lemaker.org/project/index/project_id/27.html" target="_blank">contest</a>. I got really happy about that and they sent by DHL that made everything went really fast.

As usual, in Brazil the tax everything including prizes and samples, so I got R$90 of taxes over the board. I won&#8217;t complain much about it, because it was cheap and expected.

So after some time (sorry for the long time, I got really busy 🙁 ) I managed to write this review about this board!

<!--more-->

So talking about the board specs. This is a QuadCore ARM Cortex A9 with 1GB of RAM (a 2GB version is also available according to LeMaker).  
`<br />
 root@lemaker:~# cat /proc/cpuinfo<br />
 Processor : ARMv7 Processor rev 1 (v7l)<br />
 processor : 0<br />
 model name : ARMv7 Processor rev 1 (v7l)<br />
 BogoMIPS : 405.50<br />
 Features : swp half thumb fastmult vfp edsp thumbee neon vfpv3 tls<br />
 CPU implementer : 0x41<br />
 CPU architecture: 7<br />
 CPU variant : 0x4<br />
 CPU part : 0xc09<br />
 CPU revision : 1`

processor : 1  
model name : ARMv7 Processor rev 1 (v7l)  
BogoMIPS : 407.96  
Features : swp half thumb fastmult vfp edsp thumbee neon vfpv3 tls  
CPU implementer : 0x41  
CPU architecture: 7  
CPU variant : 0x4  
CPU part : 0xc09  
CPU revision : 1

processor : 2  
model name : ARMv7 Processor rev 1 (v7l)  
BogoMIPS : 407.96  
Features : swp half thumb fastmult vfp edsp thumbee neon vfpv3 tls  
CPU implementer : 0x41  
CPU architecture: 7  
CPU variant : 0x4  
CPU part : 0xc09  
CPU revision : 1

processor : 3  
model name : ARMv7 Processor rev 1 (v7l)  
BogoMIPS : 407.96  
Features : swp half thumb fastmult vfp edsp thumbee neon vfpv3 tls  
CPU implementer : 0x41  
CPU architecture: 7  
CPU variant : 0x4  
CPU part : 0xc09  
CPU revision : 1

Hardware : gs705a  
Revision : 0000  
Serial : 080f4635510a10bf

I&#8217;m also using **Lemunto for Guitar** distro, but it came with Android. I didn&#8217;t played much with android to be honest.

`<br />
 root@lemaker:~# uname -a<br />
 Linux lemaker 3.10.37 #2 SMP PREEMPT Sat Jan 16 14:33:53 CST 2016 armv7l armv7l armv7l GNU/Linux<br />
` 

The Lemunto can use Oficial Ubuntu ports (that as I remember is provided by Linaro) and that is really good because we can have most packages we need. For example I wanted **rtl-sdr** to starting using it as a station:

&nbsp;

`<br />
 root@lemaker:~# apt-get install rtl-sdr<br />
 Reading package lists... Done<br />
 Building dependency tree<br />
 Reading state information... Done<br />
 The following extra packages will be installed:<br />
 librtlsdr0<br />
 The following NEW packages will be installed:<br />
 librtlsdr0 rtl-sdr<br />
 0 upgraded, 2 newly installed, 0 to remove and 132 not upgraded.<br />
 Need to get 0 B/76.1 kB of archives.<br />
 After this operation, 293 kB of additional disk space will be used.<br />
 Do you want to continue? [Y/n] y<br />
 Selecting previously unselected package librtlsdr0:armhf.<br />
 (Reading database ... 78752 files and directories currently installed.)<br />
 Preparing to unpack .../librtlsdr0_0.5.3-3_armhf.deb ...<br />
 Unpacking librtlsdr0:armhf (0.5.3-3) ...<br />
 Selecting previously unselected package rtl-sdr.<br />
 Preparing to unpack .../rtl-sdr_0.5.3-3_armhf.deb ...<br />
 Unpacking rtl-sdr (0.5.3-3) ...<br />
 Processing triggers for man-db (2.7.0.2-5) ...<br />
 Setting up librtlsdr0:armhf (0.5.3-3) ...<br />
 Setting up rtl-sdr (0.5.3-3) ...<br />
 Processing triggers for libc-bin (2.21-0ubuntu4) ...<br />
` 

<a title="20160121_190716" href="https://www.flickr.com/photos/energylabs/24135805283/in/dateposted-public/" data-flickr-embed="true"><img class="alignleft" src="https://farm2.staticflickr.com/1518/24135805283_b864b107a7_n.jpg" alt="20160121_190716" width="320" height="180" /></a>

Also I wanted to test a <a href="http://www.chalk-elec.com/?page_id=1280#!/7-open-frame-universal-HDMI-LCD-with-capacitive-multi-touch/p/21750207/category=3094861" target="_blank">7&#8221; HDMI TouchScreen from Chalk-Elec</a> that I have here on my desk. It usually works with any HDMI device, but I had some problems with Chromecast for example. But it works really fine for my LeMaker Guitar!

&nbsp;

About the performance as using it as a **RTL-SDR Spectrum Server**, it was perfect. I could even sample **2.56Msps** through its 72.2Mbps wireless network (sadly **not** 5Ghz or AC network) without loss. But be noticed that I have about full signal here:`<br />
root@lemaker:~# iwconfig<br />
wlan0 IEEE 802.11bgn ESSID:"TVS" Nickname:"<WIFI@REALTEK>"<br />
Mode:Managed Frequency:2.457 GHz Access Point: 70:62:B8:6B:A6:3C<br />
Bit Rate:72.2 Mb/s Sensitivity:0/0<br />
Retry:off RTS thr:off Fragment thr:off<br />
Encryption key:****-****-****-****-****-****-****-**** Security mode:open<br />
Power Management:off<br />
Link Quality=97/100 Signal level=-54 dBm Noise level=0 dBm<br />
Rx invalid nwid:0 Rx invalid crypt:0 Rx invalid frag:0<br />
Tx excessive retries:0 Invalid misc:0 Missed beacon:0<br />
`  
So it might not be enough to do a full sample rate spectrum server, but if you just want to receive NOAA, or even broadcast NOAA signal using a Spectrum Server, you can make a software do to signal decimation to reduce the sample rate to 80KHz (a decimation of 32) and increase the ADC Resolution.

For now is just that. I expect to put it to work as a SDR Spectrum Station together with my Intel Edison and see which one performs better for receiving / processing NOAA APT Signals, and maybe LRPT signals. I just expected that this board came with a 5GHz / AC Wireless :/