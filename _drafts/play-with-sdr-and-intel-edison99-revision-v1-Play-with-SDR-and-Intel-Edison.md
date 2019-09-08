---
id: 108
title: Play with SDR and Intel Edison!
date: 2016-01-15T23:42:59-03:00
author: Lucas Teske
layout: revision
guid: http://www.teske.net.br/lucas/2016/01/99-revision-v1/
permalink: /2016/01/99-revision-v1/
---
So some people already saw in my facebook that I started playing with SDRs (Software Defined Radio).

I always wanted to do my own radio receiver, and I did some in the past. But it&#8217;s very hard to adapt the radio for anything new you want do to, and also when you want to process data in your computer things become harder.

So a few months ago I found a nice tutorial of how to get NOAA Satellite Images using a cheap DVB-T (Digital Video Broadcast &#8211; Terrestrial) dongle that can be used as SDR. It costs about R$70 (roughly US$10) and the model I got (with R820T2 tuner) can tune from 24MHz to 1.74GHz!!!

## What is inside this spectrum?

Actually a lot:

  * FM Audio Radio Broadcasts
  * VHF / UHF Television (Both Digital and Analog)
  * Weather Satellites (APT, LRPT, HRPT)
  * ADB-S (Air Traffic Telemetry)
  * FM Air Traffic Radio
  * And more

So my goal was to receive NOAA APT Signals (I even made a decoder!) but I don&#8217;t have a good enough antenna (yet).

## The problem

So I made up a piece of antenna with two copper pipes (I call a piece, because its a dipole from a Double Cross Antenna) (I will make a tutorial later how to do it) to have better reception for the 2m band (~135Mhz) but every time a satellite was in range, I would need to go outdoor and turn on my laptop and start capturing. This was annoying.

<!--more-->

### The solution

So I though: I have an Intel Edison board here. Why not? Let&#8217;s make a remote Radio Receiver!

## Pieces needed

  * A Intel Edison
  * A Box
  * A RTL2832U Dongle ( Search for RTL SDR on Mercado Livre, Amazon, Ebay. You will find one)
  * Power Supply for Edison
  * (Optional) Custom Antenna to receive lower frequencies than UHF

So if you&#8217;re lazy to make a new antenna, just use the original one. It works very fine for strong signals. Sometimes I can even pickup a NOAA Satellite signal using it.

## Compiling RTL-SDR in Edison

For our remote station we will need **rtl_tcp** program that opens a TCP Server to send the baseband packets through network to another machine. So for that we need to compile the **rtl-sdr** package from scratch.

One of its dependencies is the **libusb**, but there is no oficial Intel repository with it. So I used this tutorial: <a href="http://alextgalileo.altervista.org/edison-package-repo-configuration-instructions.html" target="_blank">http://alextgalileo.altervista.org/edison-package-repo-configuration-instructions.html</a>

So I will resume the tutorial. Just add the lines below to **/etc/opkg/base-feeds.conf** and run **opkg update**

<pre class="wiki">src/gz all http://repo.opkg.net/edison/repo/all
src/gz edison http://repo.opkg.net/edison/repo/edison
src/gz core2-32 http://repo.opkg.net/edison/repo/core2-32</pre>

After that, lets install the libusb and git

<pre class="wiki">opkg install libusb-0.1-dev git</pre>

Now we can compile the rtlsdr inside edison:

<pre class="wiki">git clone git://git.osmocom.org/rtl-sdr.git
mkdir build
cd build
cmake ../
make
make install</pre>

So before continuing, the Edison Linux doesn&#8217;t have the **ld.so.conf** properly configured. So let&#8217;s do it! Fill the file with these lines:

<pre class="wiki">/lib
/usr/lib
/usr/local/lib</pre>

And then run:

<pre class="wiki">ldconfig</pre>

Now we can plug our dongle and see if everything is working fine! (Don&#8217;t forget to change the switch on the side of the USB conector to the direction towards the USB Plug!)

Plug it and run:

<pre class="wiki">rtl_test</pre>

You should get a output like this:

<pre class="wiki">root@TVS-RADIO:~# rtl_test
Found 1 device(s):
  0:  Realtek, RTL2838UHIDIR, SN: 00000001

Using device 0: Generic RTL2832U OEM
Found Rafael Micro R820T tuner
Supported gain values (29): 0.0 0.9 1.4 2.7 3.7 7.7 8.7 12.5 14.4 15.7 16.6 19.7 20.7 22.9 25.4 28.0 29.7 32.8 33.8 36.4 37.2 38.6 40.2 42.1 43.4 43.9 44.5 48.0 49.6 
[R82XX] PLL not locked!
Sampling at 2048000 S/s.

Info: This tool will continuously read from the device, and report if
samples get lost. If you observe no further output, everything is fine.

Reading samples in async mode...
</pre>

## Creating startup scripts

So now we just need to create the startup scripts to start **rtl_tcp** at boot. This is pretty simple, but as normal, the Linux of Edison is missing a few things. So let&#8217;s create **/etc/init.d/** to put our startup script.

mkdir /etc/init.d

And then create a file called **startsdr** inside put:

<pre class="brush: bash; title: ; notranslate" title="">#!/bin/bash

ps | grep rtl_tcp | grep -v grep
if [ $? -eq 1 ]
then
nohup /usr/local/bin/rtl_tcp -a 0.0.0.0 &amp;amp;amp;amp;
else
echo &quot;Already running&quot;
fi
</pre>

and run:

<pre class="brush: bash; title: ; notranslate" title="">chmod +x /etc/init.d/startsdr
update-rc.d startsdr defaults
</pre>

After that, the **rtl_tcp** should start automatically at boot.

## The box

For the box, I just got a normal plastic box to put everything inside. Notice that I have a MCX -> BNC cable adapter, because I use a home-made external antenna. You can use your original one as well. So here are some pictures:  
<a title="Intel Edison Remote Radio Station" href="https://www.flickr.com/photos/energylabs/23777188854/in/dateposted-public/" data-flickr-embed="true"><img src="https://farm2.staticflickr.com/1520/23777188854_7609982531_n.jpg" alt="Intel Edison Remote Radio Station" width="180" height="320" /></a>  
<a title="Dipole Antenna Cable / Balun" href="https://www.flickr.com/photos/energylabs/24109779170/in/dateposted-public/" data-flickr-embed="true"><img src="https://farm2.staticflickr.com/1513/24109779170_521017e648_n.jpg" alt="Dipole Antenna Cable / Balun" width="180" height="320" /></a>  
<a title="Intel Edison Remote Radio Station" href="https://www.flickr.com/photos/energylabs/24322927171/in/dateposted-public/" data-flickr-embed="true"><img src="https://farm2.staticflickr.com/1545/24322927171_449677d905_n.jpg" alt="Intel Edison Remote Radio Station" width="320" height="180" /></a>  


## Testing it

So now let&#8217;s test it! Have the IP Address of the Edison on the hand and go to your computer! Here I usually use Linux for testing stuff, so in linux you can use <a href="http://gqrx.dk/" target="_blank">GQRX</a> to connect to the SDR. For windows you can use SDR#

  1. Click on **Configure I/O Devices ** <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_setup_icon.png" rel="attachment wp-att-104"><img class="alignnone size-full wp-image-104" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_setup_icon.png" alt="gqrx_setup_icon" width="37" height="34" /></a>
  2. Select **RTL-SDR Spectrum Server** at **Device** section.
  3. On **Device string** use **rtl\_tcp=YOUR\_EDISON_IP:1234**
  4. On **Sample Rate** you can select the sample rate (that implies in signal bandwidth). I usually uses **2.56MSps (2560000)**. But depending on the quality of the wifi signal on Edison, you may not be able to reach that sample rate (this is about 24Mbps of throuput on your wireless). For FM Radio receiving **250kSps (250000)** should be enough.
  5. Keep **Bandwidth **in 0,000000 MHz
  6. Keep **LNB LO** ** **in 0,000000 MHz
  7. Click **OK**
  8. Set the frequency in the **Frequency Bar** to a know FM Radio Frequency<img class="alignnone size-full wp-image-105" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_frequency_bar.png" alt="gqrx_frequency_bar" width="369" height="40" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_frequency_bar.png 369w, https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_frequency_bar-300x33.png 300w" sizes="(max-width: 369px) 100vw, 369px" />
  9. Set **Filter** to **Normal** in **Receiver Options**
 10. Set **Mode **to **WFM (stereo)**
 11. Click at **Start DSP Processing **<a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_power_button.png" rel="attachment wp-att-106"><img class="alignnone size-full wp-image-106" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_power_button.png" alt="gqrx_power_button" width="38" height="34" /></a>
 12. Have fun!

<a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/Captura-de-tela-de-2016-01-16-00-23-38.png" rel="attachment wp-att-107"><img class="alignnone size-full wp-image-107" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/Captura-de-tela-de-2016-01-16-00-23-38.png" alt="Captura de tela de 2016-01-16 00-23-38" width="840" height="782" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/Captura-de-tela-de-2016-01-16-00-23-38.png 840w, https://www.teske.net.br/lucas/wp-content/uploads/2016/01/Captura-de-tela-de-2016-01-16-00-23-38-300x279.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/01/Captura-de-tela-de-2016-01-16-00-23-38-768x715.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/01/Captura-de-tela-de-2016-01-16-00-23-38-624x581.png 624w" sizes="(max-width: 840px) 100vw, 840px" /></a>