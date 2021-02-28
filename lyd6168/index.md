---
title: LYD6168
date: 2021-01-16T18:25:00-03:00
author: Lucas Teske
layout: page
permalink: /lyd6168
image: /assets/lyd6168/20201022_103045.jpg
---


## This is a WIP document with my research about these LYD6168 chinese panels.

--------------

Everything started when I bought 6 of these panels (thanks to [my supporters at twitch](https://github.com/racerxdl/biggateboy#special-thanks)) for the Big Gate Boy project (a gigantic gameboy). I previously played with some other chinese panels with FM6126 and FM6127 chips, which although needed an FPGA to be able to display 18 bit color, worked nice.

Then I got the suprise that the 6 panels (which were not cheap for Brazillian standards) were a totally different chip: LYD6168

The thing that scared me about it was that besides knowing the LYD was a short for [Leyard](http://leyard.com/), there were actually zero information about the chip on the internet. I spend some of the live streams together with my supporters trying to find a datasheet or any info about the chip (searching even in chinese search engines). The only information we got was S-PWM. Also any code from the internet to control HUB75 panels, didn't even lit the panel. I couldn't be sure if my panels were dead or just were completely different than anything.


I tried to reach Leyard from china, Leyard from Brazil. But chinese leyard just ignored me, and Brazillian Leyard said they don't know any LYD6168 panel. I also tried to reach the Chinese Seller and he said it is compatible with my [Colorlight Hub 5A-75B board](https://s.click.aliexpress.com/e/_AbrRvE).

Funny enough, I even got the original chinese software to test it and after a while trying and failing (because the seller just said "it works") I discovered that for S-PWM chips, **there was another firmware** for the FPGA.

The software for upgrading can be found at colorlight website: [Colorlight LEDUpgrade V3.0](https://www.colorlight-led.com/download/colorlight-ledupgrade-v3-0-set-up.html). The firmware can be upgraded through network, but **the cable should be connected directly to you ethernet card**. I even tried using a USB 3.0 Gigabit card, and it didn't work.

Also since the 5A-75B Ethernet clocks are fixed, it will **only work on gigabit ethernet**

After some trouble to get it working, I managed to upgrade it with a **S-PWM Ready** firmware which was at least trying to display something. Funny enough in Colorlight LED software, selecting the LYD6168 preset **doesn't work**. I had to test **manually every supported controller** to see which one displayed the image correctly. The LYD6168 seens to display something but it was completely wrong. Finally I found out that LYD6168 panel correspond to MBI5153 made by Macroblocks and that Leyard does silicon OEM of their chips. Sadly, some people reported that their LYD6168 chips worked as a ICN2035 (which it doesn't here). That probably means leyard just threw shit at the fan by selling the same IC package with different silicon inside.

![Displaying a gameboy screenshot 1:1](/assets/lyd6168/20201029_001922.jpg)

Since my steps to find out which controller the panel had is probably usefull for future use, I will list my steps to get this panel working.

* [Upgrade FPGA (_TODO_)](/lyd6168/upgrade-fpga)
* [Testing LED Panels](/lyd6168/testing-ic)

## MBI5153

The good thing about MBI5153 that there is a [datasheet available](/assets/lyd6168/MBI-MBI5153GP_C183654.pdf). Reading a bit the datasheet, we can see that they're **totally** different than FM6126/6127 chips. The 6126 chips didn't had any controller internally and were basically some fancy shift-registers. The MBI5153 are a complete different thing: The PWM are embedded, and the chip can fit the **whole frame of scanlines** inside it. Look at this:

![MBI5153 Block Diagram](/assets/lyd6168/mbi5153-blocks.svg)

So here we have a 14-bit counter for 16 bit comparators which outputs PWM for 16 outputs, which means we have 14-bit per color control. So after that data is latched into the MB5153, it will generate the led brightness by itself. That enables low speed microcontrollers to control that.

Also, they can hold up to 32 scanlines, which means my 128x64 panel **can hold an entire frame**. This means if I want to display a static image, I can just "send" the image to the panel, and keep pulsing the **GCLK** signal to display the image and controlling the **line address** bits for changing the scanlines.




