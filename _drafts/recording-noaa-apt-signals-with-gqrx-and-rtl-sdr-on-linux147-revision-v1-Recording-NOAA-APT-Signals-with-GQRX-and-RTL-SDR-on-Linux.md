---
id: 171
title: Recording NOAA APT Signals with GQRX and RTL-SDR on Linux
date: 2016-02-04T22:26:57-03:00
author: racerxdl
layout: revision
guid: http://www.teske.net.br/lucas/2016/02/147-revision-v1/
permalink: /2016/02/147-revision-v1/
---
<div id="attachment_150" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17.png" rel="attachment wp-att-150"><img aria-describedby="caption-attachment-150" class="size-large wp-image-150" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17-1024x670.png" alt="GQRX NOAA 18 Signal" width="625" height="409" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17-1024x670.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17-300x196.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17-768x502.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17-624x408.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17.png 1271w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-150" class="wp-caption-text">
    GQRX NOAA 18 Signal
  </p>
</div>

So you all saw my last posts [ <a href="https://www.teske.net.br/lucas/2016/01/play-with-sdr-and-intel-edison/" target="_blank">Play with SDR and Intel Edison!</a> <a href="https://www.teske.net.br/lucas/2016/01/qfh-antenna-and-my-first-reception-of-noaa/" target="_blank">QFH Antenna and my first reception of NOAA! </a>] but I actually didn&#8217;t explained how to capture and decode APT Signals using your computer (in this case, with Linux). So here it is! For this article I&#8217;m using Ubuntu 15.04, but actually any distro will work well (I think most of them have the needed packages)

<!--more-->

So the first thing you need to do is to get all needed **hardware** to start playing. I&#8217;ve already tested my i7 Skylake Laptop, a Intel Edison and LeMaker Guitar for these uses. For my Laptop and LeMaker guitar you can use only them to do the stuff, because they both have graphical interface for the GQRX. For the Intel Edison all you can do is open a **rtl_tcp** spectrum server as my <a href="https://www.teske.net.br/lucas/2016/01/play-with-sdr-and-intel-edison/" target="_blank">sdr edison article</a> explains, and receive the spectrum in any other machine (including LeMaker Guitar).

## Hardware Needed

So for the hardware you will need:

<li style="padding-left: 30px;">
  RTL-SDR Dongle ( <a href="http://www.amazon.com/RTL-SDR-Blog-RTL2832U-Software-Telescopic/dp/B011HVUEME/ref=sr_1_1?ie=UTF8&qid=1454625132&sr=8-1&keywords=RTL-SDR" target="_blank">Amazon (USA)</a> , <a href="http://produto.mercadolivre.com.br/MLB-716281274-receptor-sdr-usb-dvb-t-sdrdabfm-hdtv-rtl-2832u-r820t-_JM" target="_blank">Mercado Livre (Brazil)</a>, <a href="http://www.dx.com/p/rtl2832u-r820t-mini-dvb-t-dab-fm-sdr-usb-dvb-t-stick-235224#.VrPRxXUrLCI" target="_blank">Dealextreme (International)</a> )
</li>
<li style="padding-left: 30px;">
  Quadrifiliar Helix Antenna or Double Crossed Dipole for 2m band (preferably in 137MHz center frequency and 75 Ohms ) [ <a href="https://www.teske.net.br/lucas/2016/01/qfh-antenna-and-my-first-reception-of-noaa/" target="_blank">Here what I did</a> ]
</li>
<li style="padding-left: 30px;">
  A computer ( PC, LeMaker Guitar, Intel Edison )
</li>
<li style="padding-left: 30px;">
  <em>Optional: LNA Amplifier, if your antenna is far from the computer ( 4m+ )</em>
</li>

So after you get all your hardware, and assemble it ( my QFH Antenna Article have some details about it ). It is basically plug your RTL-SDR Dongle at USB Port and attach to your Antenna. The original antenna &#8220;works&#8221; [ You can **hear** the signal, but not receive images ], but I suggest to build a proper antenna.

## Installing the softwares

So I will use Ubuntu 15.04 as an example here for receiving signals. The instructions for any **Debian** based distribution should be exact the same. For **RedHat** based, use _yum_ instead of _apt-get_. You can also use your favorite package manager inside your distribution.

The packages that we will need are:

  1. <a href="http://sdr.osmocom.org/trac/wiki/rtl-sdr" target="_blank">librtlsdr0</a>
  2. <a href="http://gqrx.dk/download" target="_blank">gqrx-sdr</a>
  3. <a href="http://gpredict.oz9aec.net/" target="_blank">gpredict</a>
  4. <a href="http://www.audacityteam.org/" target="_blank">Audacity</a>
  5. <a href="http://atpdec.sourceforge.net/" target="_blank">atp-dec</a> or <a href="http://jthatch.com/APT3000/APT3000.html" target="_blank">APT3000 (web)</a> or <a href="https://github.com/racerxdl/open-satellite-project" target="_blank">OpenSatelliteProject</a> or <a href="http://www.wxtoimg.com/" target="_blank">WXtoIMG (not opensource)</a>

Most distributions include in their repositories the librtlsdr, some include gqrx (for ubuntu you can get the upstream from their website), and atp-dec none of them include (sadly, because it is a very nice application). You can also use for decoding APT Signals the APT3000 webpage and my project OpenSatelliteProject. GPredict should also be included in most major distributions.

## Tracking a Satellite with GPredict

So the first thing we need to do is track our Satellites. The only three APT active Satellites are NOAA 15, 18 and 19.

So open GPredict and go to menu **Edit => Update TLEs => From Network **to update GPredict internal database of TLEs. You can also obtain the TLEs on <a href="https://www.space-track.org" target="_blank">https://www.space-track.org</a> . NASA keeps all TLEs up-to-date at space-track. You should Update your TLEs at least once per month.

After that, lets configure the satellites we want to visualize by clicking on the arrow <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-arrow.png" rel="attachment wp-att-153"><img class="alignnone size-full wp-image-153" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-arrow.png" alt="gpredict-arrow" width="27" height="28" /></a> and go to **Configure**.

<div id="attachment_154" style="width: 573px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-select-sats.png" rel="attachment wp-att-154"><img aria-describedby="caption-attachment-154" class="size-full wp-image-154" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-select-sats.png" alt="Select Satellites to Track on GPredict" width="563" height="453" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-select-sats.png 563w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-select-sats-300x241.png 300w" sizes="(max-width: 563px) 100vw, 563px" /></a>
  
  <p id="caption-attachment-154" class="wp-caption-text">
    Select Satellites to Track on GPredict
  </p>
</div>

So you can search for **NOAA** and add the 15, 18 and 19 satellites to the tracking list. I also added ISS (International Space Station) and METEOR-M satellites (I wanted to try to capture LRPT Signals as well, but no success so far). Also click at the **+** button to add a new GroundStation. Create any name you want ( I will name _MyGroundStation_ ) and pick up a location (or if you know your coordinates, fill with it). After that, hit **OK** button. You should return to the main screen with all satellites on it.

<a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-main-1.png" rel="attachment wp-att-156"><img class="alignleft wp-image-156 size-medium" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-main-1-293x300.png" alt="GPredict Main Screen" width="293" height="300" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-main-1-293x300.png 293w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-main-1-624x639.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-main-1.png 689w" sizes="(max-width: 293px) 100vw, 293px" /></a>

&nbsp;

So now you can track all the satellites! So let me give you a few hints about this software:

  1. At the **radar view** you can see on the top-right the indication of which satellite and how much time it will take to be visible. That doesn&#8217;t mean also if it will be capturable (usually if you don&#8217;t have a good antenna, you cannot receive the image in the edges of the horizon), but it will give you a prediction of the next satellite. Also you can check where the satellite is at the radar view.
  2. In the **map-view** the yellow circle around the satellite is the horizon, or in another words: the range of the satellite. So if you are on edge of this circle, it means the satellite will look that is on the horizon for you.
  3. You can **right-click** at the Satellite name on map to show a **Ground Track** (where the satellite will pass), show **Next Pass** to show the next time after the radar time the satellite will pass and show **Future Passes** that will predict where the satellite will pass in next days.

So now, you just need to program yourself to be available when a satellite passes over your ground station. The satellites have a orbit arround 1h30, but that doesn&#8217;t mean their orbit position are the same everytime it passes. As I observed, these NOAA satellites usually passes on the _same location** **_once per week. So just have attention when it will pass over your station. Before moving to the next step, please have at least 10 minutes on the clock before the satellite passes.

## Capturing the Satellite Signal

So now open **GQRX** to start the look up / capture of the Signal. After you open, it will probably ask you to configure the GQRX. If not, click at the <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_setup_icon.png" rel="attachment wp-att-104"><img class="alignnone size-full wp-image-104" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_setup_icon.png" alt="gqrx_setup_icon" width="37" height="34" /></a> to open the configuration.

<div id="attachment_159" style="width: 320px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-33-47.png" rel="attachment wp-att-159"><img aria-describedby="caption-attachment-159" class="size-full wp-image-159" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-33-47.png" alt="Configuration of GQRX" width="310" height="445" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-33-47.png 310w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-33-47-209x300.png 209w" sizes="(max-width: 310px) 100vw, 310px" /></a>
  
  <p id="caption-attachment-159" class="wp-caption-text">
    Configuration of GQRX
  </p>
</div>

Since the total bandwidth we need is about 40kHz, we can super-sample and decimate to increase the ADC resolution. So with a 32x decimation, we should increase 2.5 Bits ( log 32 in base 4 ) in the ADC Resolution. It also filters some of the noise because of the low pass filter to decimate. This gives us a better SNR at the output.

If you noticed the RTL-SDR goes up to 3.2Msps of Sample Rate **but** above 2.56Msps the Realtek IC starts loosing bytes. So you can get 3.2Msps, but not continuous. Because of that I use 2.56Msps since it is the highest rate you can get without samples being drop.

After that, click **OK** and the GQRX should open.

<div id="attachment_160" style="width: 960px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gqrx_start.png" rel="attachment wp-att-160"><img aria-describedby="caption-attachment-160" class="size-full wp-image-160" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gqrx_start.png" alt="Start screen of GQRX" width="950" height="652" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gqrx_start.png 950w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gqrx_start-300x206.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gqrx_start-768x527.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gqrx_start-624x428.png 624w" sizes="(max-width: 950px) 100vw, 950px" /></a>
  
  <p id="caption-attachment-160" class="wp-caption-text">
    Start screen of GQRX
  </p>
</div>

So now lets first setup the **Audio Output Folder** by clicking on the **&#8230;** button at the Audio Panel. Just make sure to select a folder, because once here I ran GQRX, clicked Rec and recorded everything. After recording I noticed that the folder field was empty, and my file went to limbo.

Now we have the basic configuration of the GQRX done. So now lets setup the demodulator. In the **Receiver** **Options** configure:

  1. **Filter Width** => Wide
  2. **Filter Shape **=> Sharp or Normal
  3. **Mode** => WFM (mono)
  4. **Frequency Bar** => 0.000 kHz

In **FFT Settings** setup:

  1. **Ref Level** => 0dB
  2. **dB Range** => 104dB
  3. **Peak Detect** => Clicked

In **Input Controls** setup:

  1. **Hardware AGC** => OFF
  2. **Swap I/Q **=> OFF
  3. **No Limits** => OFF
  4. **DC Remove **=> ON
  5. **IQ Balance** => ON
  6. **LNA Gain** => 20dB

In <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_frequency_bar.png" rel="attachment wp-att-105"><img class="alignnone size-full wp-image-105" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_frequency_bar.png" alt="gqrx_frequency_bar" width="369" height="40" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_frequency_bar.png 369w, https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_frequency_bar-300x33.png 300w" sizes="(max-width: 369px) 100vw, 369px" /></a> set your satellite Frequency:

  * **NOAA 15** => 137.620 MHz
  * **NOAA 18** => 137.9125 MHz
  * **NOAA 19** => 137.1 MHz

Now we can start the SDR Spectrum Capture by clicking at <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_power_button.png" rel="attachment wp-att-106"><img class="alignnone size-full wp-image-106" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_power_button.png" alt="gqrx_power_button" width="38" height="34" /></a>

## Adjusting the capture

So there are few adjustments to be done. First of them is the **Center Frequency**. These cheap RTL-SDRs tend to drift a few 10&#8217;s of kHZ from the actual frequency, so you might have to change the frequency a bit find the signal. So if  your antenna is good, you should see the signal as soon as the satellite come in range. You should also play a bit with the **LNA Gain** setting to see where it gives you the bigger diference between the satellite signal and the floor noise (the bottom line in the spectrum). Here is a sample of how the signal looks:

<div id="attachment_161" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-41-10.png" rel="attachment wp-att-161"><img aria-describedby="caption-attachment-161" class="size-large wp-image-161" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-41-10-1024x670.png" alt="Low signal when the satellite is in the edge of the horizon." width="625" height="409" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-41-10-1024x670.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-41-10-300x196.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-41-10-768x502.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-41-10-624x408.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-41-10.png 1271w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-161" class="wp-caption-text">
    Low signal when the satellite is in the edge of the horizon.
  </p>
</div>

So as soon you find the signal, hit the **Rec** button to start recording the audio, and play with the values to get the less noise as possible. Also push the grey block over the signal to be around 40kHz (you can check in the _Receiver Options_ screen at _Filter Width_). After getting everything setup, sit down and relax while the satellite passes. Notice that as the signal increases, the APT signal audio starts to be more recognizable from the noise. Here after a few seconds that the satellite come in range, I get a nice and clear audio from the APT Signal.

<div id="attachment_162" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-45-28.png" rel="attachment wp-att-162"><img aria-describedby="caption-attachment-162" class="wp-image-162 size-large" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-45-28-1024x576.png" alt="GQRX NOAA Record in Progress" width="625" height="352" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-45-28-1024x576.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-45-28-300x169.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-45-28-768x432.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-45-28-624x351.png 624w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-162" class="wp-caption-text">
    GQRX NOAA Record in Progress
  </p>
</div>

You might want to adjust the gray block to have the _red_ line centered on the center _spike_. The signal will drift to the left because of _Doppler Effect_. This is usually not needed if you have a wide enough gray block (filter), because most APT Decoding softwares compensate for doppler effect using APT Sync Signal.

<div id="attachment_163" style="width: 635px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-50-19.png" rel="attachment wp-att-163"><img aria-describedby="caption-attachment-163" class="wp-image-163 size-large" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-50-19-1024x576.png" alt="I started Recording at 137.909MHz and it drift almost to 137.904MHz." width="625" height="352" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-50-19-1024x576.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-50-19-300x169.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-50-19-768x432.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-50-19-624x351.png 624w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-163" class="wp-caption-text">
    I started Recording at 137.909MHz and it drift almost to 137.904MHz.
  </p>
</div>

After the satellite gets out of range (or the signal is to noisy), click the **Rec** button again to stop recording. The output audio file should be on your target folder.

## Processing the Audio File

Now the first thing is to normalize and resample the wav file. All the current APT Decoding softwares expect a **Mono 11025 Hz WAV File**, but the recorded wav is stereo and in 48kHz. So we will use Audacity to do all of these. So open your wav file in audacity.

<div id="attachment_165" style="width: 924px" class="wp-caption aligncenter">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity0.png" rel="attachment wp-att-165"><img aria-describedby="caption-attachment-165" class="wp-image-165 size-full" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity0.png" alt="Audacity with the Wav File" width="914" height="560" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity0.png 914w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity0-300x184.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity0-768x471.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity0-624x382.png 624w" sizes="(max-width: 914px) 100vw, 914px" /></a>
  
  <p id="caption-attachment-165" class="wp-caption-text">
    Audacity with the Wav File
  </p>
</div>

With the file opened, first squash the two channels into one by going to the menu **Tracks => Stereo Track to Mono**. This should remove the second track and set the audio to mono.

<div id="attachment_166" style="width: 924px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity1.png" rel="attachment wp-att-166"><img aria-describedby="caption-attachment-166" class="size-full wp-image-166" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity1.png" alt="Mono Track" width="914" height="560" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity1.png 914w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity1-300x184.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity1-768x471.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity1-624x382.png 624w" sizes="(max-width: 914px) 100vw, 914px" /></a>
  
  <p id="caption-attachment-166" class="wp-caption-text">
    Mono Track
  </p>
</div>

Now we need to normalize it because our signal is too low. To do so, go to **Effects => Normalize**. Keep the defaults settings and hit **OK**. You should have a much bigger signal.

<div id="attachment_167" style="width: 924px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity2.png" rel="attachment wp-att-167"><img aria-describedby="caption-attachment-167" class="size-full wp-image-167" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity2.png" alt="Normalized Signal in Audacity" width="914" height="560" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity2.png 914w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity2-300x184.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity2-768x471.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity2-624x382.png 624w" sizes="(max-width: 914px) 100vw, 914px" /></a>
  
  <p id="caption-attachment-167" class="wp-caption-text">
    Normalized Signal in Audacity
  </p>
</div>

Now in the bottom of the screen, change the **Project Rate** to **11025** and then go to **Tracks => Change Sampling Rate**. The new sampling rate should be 11025 already, so just hit **OK**. You will see that the signal will change and attenuate a bit.

<div id="attachment_168" style="width: 924px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity3.png" rel="attachment wp-att-168"><img aria-describedby="caption-attachment-168" class="size-full wp-image-168" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity3.png" alt="Resampled Signal. Some noise disappeared. " width="914" height="560" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity3.png 914w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity3-300x184.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity3-768x471.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity3-624x382.png 624w" sizes="(max-width: 914px) 100vw, 914px" /></a>
  
  <p id="caption-attachment-168" class="wp-caption-text">
    Resampled Signal. Some noise disappeared.
  </p>
</div>

Now you can hit normalize again just to make sure that the signal is normalized.

<div id="attachment_169" style="width: 924px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity4.png" rel="attachment wp-att-169"><img aria-describedby="caption-attachment-169" class="size-full wp-image-169" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity4.png" alt="Normalized Signal Resampled" width="914" height="560" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity4.png 914w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity4-300x184.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity4-768x471.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity4-624x382.png 624w" sizes="(max-width: 914px) 100vw, 914px" /></a>
  
  <p id="caption-attachment-169" class="wp-caption-text">
    Normalized Signal Resampled
  </p>
</div>

Now you can go **File => Export Audio** and make sure you export a 16 Bit PCM with Signal Microsoft WAV File. I usually keep my original file, and name this processed one as myoriginalfilename_11025.wav. Now we are ready to decode.

**Decoding using APT 3000**

The easiest way now is to decode using APT 3000 webpage. It doesn&#8217;t produce great results always, but it it very good if you have a good signal. So just go to <a href="http://jthatch.com/APT3000/APT3000.html" target="_blank">http://jthatch.com/APT3000/APT3000.html</a> and browse your recently edited file. It should take some time and then decode the image. Click **View AB** to see the full image.

<div id="attachment_170" style="width: 635px" class="wp-caption alignnone">
  <a href="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/apt3000.png" rel="attachment wp-att-170"><img aria-describedby="caption-attachment-170" class="size-large wp-image-170" src="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/apt3000-1024x821.png" alt="APT 3000 Decoded Image" width="625" height="501" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2016/02/apt3000-1024x821.png 1024w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/apt3000-300x241.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/apt3000-768x616.png 768w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/apt3000-624x500.png 624w, https://www.teske.net.br/lucas/wp-content/uploads/2016/02/apt3000.png 1180w" sizes="(max-width: 625px) 100vw, 625px" /></a>
  
  <p id="caption-attachment-170" class="wp-caption-text">
    APT 3000 Decoded Image
  </p>
</div>

Congratulations! You got your first weather satellite recording! YEY!

&nbsp;