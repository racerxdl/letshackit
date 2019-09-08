---
id: 330
title: Some LNA tests for HRIT/LRIT
date: 2017-04-14T00:24:25-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=330
permalink: /2017/04/some-lna-tests-for-hritlrit/
image: /wp-content/uploads/2017/04/20170413_133029-624x351.jpg
categories:
  - English
  - Satellite
  - SDR
tags:
  - Airspy
  - Antenna
  - GOES
  - Hearsat
  - HRIT
  - LRIT
  - NOAA
  - RTL SDR
  - RTLSDR
  - Satellite
  - SDR
  - Software Defined Radio
---
So I was talking with @luigi on [OSP RocketChat](https://osp.teske.net.br/) and he noticed that one of the LNA&#8217;s I suggested alogn with the LNA4ALL (the SPF5189) got a comment on ebay saying that it doesn&#8217;t work on L Band.

[<img class="alignnone size-full wp-image-331" src="https://www.teske.net.br/lucas/wp-content/uploads/2017/04/Captura-de-tela-de-2017-04-13-23-55-56.png" alt="" width="612" height="195" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2017/04/Captura-de-tela-de-2017-04-13-23-55-56.png 612w, https://www.teske.net.br/lucas/wp-content/uploads/2017/04/Captura-de-tela-de-2017-04-13-23-55-56-300x96.png 300w" sizes="(max-width: 612px) 100vw, 612px" />](https://www.teske.net.br/lucas/wp-content/uploads/2017/04/Captura-de-tela-de-2017-04-13-23-55-56.png)

So that was weird to me, since I have 5 of them, and one currently in use with my GOES setup. So I decided to do a **small** and **crude** benchmark for L Band comparing no LNA with LNA4ALL and SPF5189.

<!--more-->

So the test I wanted to do was pretty simple: check how the LNAs was effective over LRIT/HRIT band (L Band at 1.7GHz). Both LNA4ALL and SPF5189 works better for lower frequencies (like said by jlxsolutionsinc, VHF/UHF) but they also perform (according to datasheet) really well on L Band. So I made a very simple setup here. Since I already had a very good HRIT signal (1694.1MHz, about 1MHz BW, 10dB SNR) I decided to get a 24dB Attenuator to try to reduce the signal and simulate a low signal environment. Not sure if that&#8217;s the ideal test, but it would give a good estimate of how it would work.

So there would be three scenarios:

  1. Airspy R2 directly on the attenuator output.
  2. Airspy R2 with LNA4ALL after attenuator output.
  3. Airspy R2 with SPF5189 after attenuator output.

Both SPF5189 and LNA4ALL was supplied by a Lipo Power supply to avoid any noises and instabilities. The LNA4ALL was running over 12V with the 100R in series and the SPF5189 was running over 5V linear regulator on 12V battery.

<blockquote class="imgur-embed-pub" lang="en" data-id="x1l96Y7">
  <p>
    <a href="http://imgur.com/x1l96Y7">View post on imgur.com</a>
  </p>
</blockquote>



I found that with 24dB attenuator the signal just vanished with 0dB LNA gain on the airspy, so I cranked up a bit so it would appear as a weak signal so it would have a best comparison. I found that 4dB was good so here is the GQRX screenshot for the Airspy directly on the output of attenuator:

<blockquote class="imgur-embed-pub" lang="en" data-id="zcRqzsv">
  <p>
    <a href="http://imgur.com/zcRqzsv">View post on imgur.com</a>
  </p>
</blockquote>



The SPF5189 result:

<blockquote class="imgur-embed-pub" lang="en" data-id="rrbu30P">
  <p>
    <a href="http://imgur.com/rrbu30P">View post on imgur.com</a>
  </p>
</blockquote>



And the LNA4ALL result:

<blockquote class="imgur-embed-pub" lang="en" data-id="WHkJVQp">
  <p>
    <a href="http://imgur.com/WHkJVQp">View post on imgur.com</a>
  </p>
</blockquote>



So by just analyzing these three pictures I can get some conclusions:

  * The SPF5189 does work on L Band (you can see that clearly it amplified the weak signal)
  * It is comparable* to LNA4ALL
  * The guy that said it only works with VHF/UHF must have some bad unit or doesn&#8217;t know how to use it right.

Some details worth mention:

  * Although the SPF5189 is much cheaper than LNA4ALL and does look to perform as good, the performance chip-wise is about the same, but keep in mind that since there are only Chinese boards you might get a bad manufacturer or seller that have bad quality LNAs.
  * There are several boards that use SPF5189 and the board design impact the performance about as much as the actual LNA chip. With LNA4ALL you will be sure that you have a good board, with SPF5189 you can buy the link I mention in the end of this post, but be warned that you might get a LNA that doesn&#8217;t match exactly what you want.
  * LNA4ALL has more features than this SPF5189 I bought. You can use Bias T, have onboard regulator (so flexible voltage range) and its smaller.
  * I notice that some cases the SPF board I have perform better, that may due the shield that comes with the board.
  * I use on my GOES setup since its cheaper than LNA4ALL and works good. Sadly for me that is in Brazil, the bad thing about LNA4ALL is the shipping cost (no cost on China devices).

&nbsp;

I hope that helps understanding that the SPF5189 does work on L Band and its a cheap alternative for someone who might want few LNAs for LRIT/HRIT setup. Of course this test is not  the best test that could be done with the LNAs but this gives an idea how it performs on L Band.

For those who want to buy:

LNA4ALL (send an email to Adam): <http://lna4all.blogspot.com/>

SPF5189: <http://www.ebay.com/itm/LNA-50-to-4000MHz-SPF5189-NF-0-6dB-LNA-RF-amplifier-FM-HF-VHF-UHF-Ham-Radio-/152224877094?hash=item23714f4a26:g:SEoAAOSwGtRXxrXk>

For those that are in Brazil and are curious about: I bought two times with Adam and one on eBay. None of them got taxes. The way Adam send is safe, but keep in mind that Brazilian Customs can always apply taxes to stuff.