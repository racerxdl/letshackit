---
title: "Recording NOAA APT Signals with GQRX and RTL-SDR on Linux | Lets Hack It"
description: "Record NOAA APT signals with GQRX and RTL-SDR on Linux. A complete guide to decoding weather satellite images."
image: "https://lucasteske.dev/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17-624x408.png"
---

# Recording NOAA APT Signals with GQRX and RTL-SDR on Linux

 ![Recording NOAA APT Signals with GQRX and RTL-SDR on Linux](/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17-624x408.png)Written by Lucas Teske   
on 5 February 2016

[![GQRX NOAA 18 Signal](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17-1024x670.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-44-17.png)

GQRX NOAA 18 Signal

So you all saw my last posts [&nbsp;[Play with SDR and Intel Edison!](https://www.teske.net.br/lucas/2016/01/play-with-sdr-and-intel-edison/)&nbsp;[QFH Antenna and my first reception of NOAA!&nbsp;](https://www.teske.net.br/lucas/2016/01/qfh-antenna-and-my-first-reception-of-noaa/)] but I actually didn’t explained how to capture and decode APT Signals using your computer (in this case, with Linux). So here it is! For this article I’m using Ubuntu 15.04, but actually any distro will work well (I think most of them have the needed packages)

So the first thing you need to do is to get all needed&nbsp; **hardware** to start playing. I’ve already tested my i7 Skylake Laptop, a Intel Edison and LeMaker Guitar for these uses. For my Laptop and LeMaker guitar you can use only them to do the stuff, because they both have graphical interface for the GQRX. For the Intel Edison all you can do is open a&nbsp; **rtl\_tcp** spectrum server as my [sdr edison article](https://www.teske.net.br/lucas/2016/01/play-with-sdr-and-intel-edison/) explains, and receive the spectrum in any other machine (including LeMaker Guitar).

## Hardware Needed

So for the hardware you will need:

- RTL-SDR Dongle ( [Amazon (USA)](http://www.amazon.com/RTL-SDR-Blog-RTL2832U-Software-Telescopic/dp/B011HVUEME/ref=sr_1_1?ie=UTF8&qid=1454625132&sr=8-1&keywords=RTL-SDR)&nbsp;, [Mercado Livre (Brazil)](http://produto.mercadolivre.com.br/MLB-716281274-receptor-sdr-usb-dvb-t-sdrdabfm-hdtv-rtl-2832u-r820t-_JM), [Dealextreme (International)](http://www.dx.com/p/rtl2832u-r820t-mini-dvb-t-dab-fm-sdr-usb-dvb-t-stick-235224#.VrPRxXUrLCI)&nbsp;)
- Quadrifiliar Helix Antenna or Double Crossed Dipole for 2m band (preferably in 137MHz center frequency and 75 Ohms ) [[Here what I did](https://www.teske.net.br/lucas/2016/01/qfh-antenna-and-my-first-reception-of-noaa/)&nbsp;]
- A computer ( PC, LeMaker Guitar, Intel Edison )
- _Optional: LNA Amplifier, if your antenna is far from the computer ( 4m+ )_

So after you get all your hardware, and assemble it ( my QFH Antenna Article have some details about it ). It is basically plug your RTL-SDR Dongle at USB Port and attach to your Antenna. The original antenna “works” [You can&nbsp; **hear** the signal, but not receive images], but I suggest to build a proper antenna.

## Installing the softwares

So I will use Ubuntu 15.04 as an example here for receiving signals. The instructions for any&nbsp; **Debian** based distribution should be exact the same. For&nbsp; **RedHat** based, use&nbsp;_yum_ instead of&nbsp;_apt-get_. You can also use your favorite package manager inside your distribution.

The packages that we will need are:

1. [librtlsdr0](http://sdr.osmocom.org/trac/wiki/rtl-sdr)
2. [gqrx-sdr](http://gqrx.dk/download)
3. [gpredict](http://gpredict.oz9aec.net/)
4. [Audacity](http://www.audacityteam.org/)
5. [atp-dec](http://atpdec.sourceforge.net/) or [APT3000 (web)](http://jthatch.com/APT3000/APT3000.html) or [OpenSatelliteProject](https://github.com/racerxdl/open-satellite-project)&nbsp;or [WXtoIMG (not opensource)](http://www.wxtoimg.com/)

Most distributions include in their repositories the librtlsdr, some include gqrx (for ubuntu you can get the upstream from their website), and atp-dec none of them include (sadly, because it is a very nice application). You can also use for decoding APT Signals the APT3000 webpage and my project OpenSatelliteProject. GPredict should also be included in most major distributions.

## Tracking a Satellite with GPredict

So the first thing we need to do is track our Satellites. The only three APT active Satellites are NOAA 15, 18 and 19.

So open GPredict and go to menu&nbsp; **Edit =\> Update TLEs =\> From Network&nbsp;** to update GPredict internal database of TLEs. You can also obtain the TLEs on&nbsp;[https://www.space-track.org](https://www.space-track.org)&nbsp;. NASA keeps all TLEs up-to-date at space-track. You should Update your TLEs at least once per month.

After that, lets configure the satellites we want to visualize by clicking on the arrow&nbsp;[![gpredict-arrow](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-arrow.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-arrow.png)&nbsp;and go to&nbsp; **Configure**.

[![Select Satellites to Track on GPredict](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-select-sats.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-select-sats.png)

Select Satellites to Track on GPredict

So you can search for&nbsp; **NOAA** and add the 15, 18 and 19 satellites to the tracking list. I also added ISS (International Space Station) and METEOR-M satellites (I wanted to try to capture LRPT Signals as well, but no success so far). Also click at the **+** button to add a new GroundStation. Create any name you want ( I will name&nbsp;_MyGroundStation_ ) and pick up a location (or if you know your coordinates, fill with it).&nbsp;After that, hit&nbsp; **OK** button. You should return to the main screen with all satellites on it.

[![GPredict Main Screen](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-main-1-293x300.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gpredict-main-1.png)

&nbsp;

So now you can track all the satellites! So let me give you a few hints about this software:

1. At the&nbsp; **radar view** you can see on the top-right the indication of which satellite and how much time it will take to be visible. That doesn’t mean also if it will be capturable (usually if you don’t have a good antenna, you cannot receive the image in the edges of the horizon), but it will give you a prediction of the next satellite. Also you can check where the satellite is at the radar view.
2. In the&nbsp; **map-view** the yellow circle around the satellite is the horizon, or in another words: the range of the satellite. So if you are on edge of this circle, it means the satellite will look that is on the horizon for you.
3. You can&nbsp; **right-click** at the Satellite name on map to show a&nbsp; **Ground Track** (where the satellite will pass), show&nbsp; **Next Pass** to show the next time after the radar time the satellite will pass and show&nbsp; **Future Passes** that will predict where the satellite will pass in next days.

So now, you just need to program yourself to be available when a satellite passes over your ground station. The satellites have a orbit around 1h30, but that doesn’t mean their orbit position are the same everytime it passes. As I observed, these NOAA satellites usually passes on the&nbsp;\_same location **&nbsp;** \_once per week. So just have attention when it will pass over your station. Before moving to the next step, please have at least 10 minutes on the clock before the satellite passes.

## Capturing the Satellite Signal

So now open&nbsp; **GQRX** to start the look up / capture of the Signal. After you open, it will probably ask you to configure the GQRX. If not, click at the&nbsp;[![gqrx_setup_icon](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_setup_icon.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_setup_icon.png)&nbsp;to open the configuration.

[![Configuration of GQRX](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-33-47.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-33-47.png)

Configuration of GQRX

Since the total bandwidth we need is about 40kHz, we can super-sample and decimate to increase the ADC resolution. So with a 32x decimation, we should increase 2.5 Bits ( log 32 in base 4 )&nbsp;in the ADC Resolution. It also filters some of the noise because of the low pass filter to decimate. This gives us a better SNR at the output.

If you noticed the RTL-SDR goes up to 3.2Msps of Sample Rate&nbsp; **but** above 2.56Msps&nbsp;the Realtek IC starts loosing bytes. So you can get 3.2Msps, but not continuous. Because of that I use 2.56Msps since it is the highest rate you can get without samples being drop.

After that, click&nbsp; **OK** and the GQRX should open.

[![Start screen of GQRX](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gqrx_start.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/gqrx_start.png)

Start screen of GQRX

So now lets first setup the&nbsp; **Audio Output Folder** by clicking on the&nbsp; **…** button at the Audio Panel. Just make sure to select a folder, because once here I ran GQRX, clicked Rec and recorded everything. After recording I noticed that the folder field was empty, and my file went to limbo.

Now we have the basic configuration of the GQRX done. So now lets setup the demodulator. In the&nbsp; **Receiver**  **Options** configure:

1. **Filter Width** =\> Wide
2. **Filter Shape&nbsp;** =\> Sharp or Normal
3. **Mode** =\> WFM (mono)
4. **Frequency Bar** =\> 0.000 kHz

In&nbsp; **FFT Settings** setup:

1. **Ref Level** =\> 0dB
2. **dB Range** =\> 104dB
3. **Peak Detect** =\> Clicked

In&nbsp; **Input Controls** setup:

1. **Hardware AGC** =\> OFF
2. **Swap I/Q&nbsp;** =\> OFF
3. **No Limits** =\> OFF
4. **DC Remove&nbsp;** =\> ON
5. **IQ Balance** =\> ON
6. **LNA Gain** =\> 20dB

In&nbsp;[![gqrx_frequency_bar](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_frequency_bar.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_frequency_bar.png)&nbsp;set your satellite Frequency:

- **NOAA 15** &nbsp;=\> 137.620 MHz
- **NOAA 18** &nbsp;=\> 137.9125 MHz
- **NOAA 19** &nbsp;=\> 137.1 MHz

Now we can start the SDR Spectrum Capture by clicking at&nbsp;[![gqrx_power_button](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_power_button.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/gqrx_power_button.png)

## Adjusting the capture

So there are few adjustments to be done. First of them is the&nbsp; **Center Frequency**. These cheap RTL-SDRs tend to drift a few 10’s of kHZ from the actual frequency, so you might have to change the frequency a bit find the signal. So if &nbsp;your antenna is good, you should see the signal as soon as the satellite come in range. You should also play a bit with the&nbsp; **LNA Gain** setting to see where it gives you the bigger diference between the satellite signal and the floor noise (the bottom line in the spectrum). Here is a sample of how the signal looks:

[![Low signal when the satellite is in the edge of the horizon.](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-41-10-1024x670.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-41-10.png)

Low signal when the satellite is in the edge of the horizon.

So as soon you find the signal, hit the&nbsp; **Rec** button to start recording the audio, and play with the values to get the less noise as possible. Also push the grey block over the signal to be around 40kHz (you can check in the&nbsp;_Receiver Options_ screen at&nbsp;_Filter Width_). After getting everything setup, sit down and relax while the satellite passes. Notice that as the signal increases, the APT signal audio starts to be more recognizable from the noise. Here after a few seconds that the satellite come in range, I get a nice and clear audio from the APT Signal.

[![GQRX NOAA Record in Progress](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-45-28-1024x576.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-45-28.png)

GQRX NOAA Record in Progress

You might want to adjust the gray block to have the&nbsp;_red_ line centered on the center&nbsp;_spike_. The signal will drift to the left because of&nbsp;_Doppler Effect_. This is usually not needed if you have a wide enough gray block (filter), because most APT Decoding softwares compensate for doppler effect using APT Sync Signal.

[![I started Recording at 137.909MHz and it drift almost to 137.904MHz.](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-50-19-1024x576.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/Captura-de-tela-de-2016-02-04-18-50-19.png)

I started Recording at 137.909MHz and it drift almost to 137.904MHz.

After the satellite gets out of range (or the signal is too noisy), click the&nbsp; **Rec** button again to stop recording. The output audio file should be on your target folder.

## Processing the Audio File

Now the first thing is to normalize and resample the wav file. All the current APT Decoding softwares expect a **Mono 11025 Hz WAV File** , but the recorded wav is stereo and in 48kHz. So we will use Audacity to do all of these. So open your wav file in audacity.

[![Audacity with the Wav File](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity0.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity0.png)

Audacity with the Wav File

With the file opened, first squash the two channels into one by going to the menu&nbsp; **Tracks =\> Stereo Track to Mono**. This should remove the second track and set the audio to mono.

[![Mono Track](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity1.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity1.png)

Mono Track

Now we need to normalize it because our signal is too low. To do so, go to&nbsp; **Effects =\> Normalize**. Keep the defaults settings and hit&nbsp; **OK**. You should have a much bigger signal.

[![Normalized Signal in Audacity](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity2.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity2.png)

Normalized Signal in Audacity

Now in the bottom of the screen, change the&nbsp; **Project Rate** to&nbsp; **11025** and then go to&nbsp; **Tracks =\> Change Sampling Rate**. The new sampling rate should be 11025 already, so just hit&nbsp; **OK**. You will see that the signal will change and attenuate a bit.

[![Resampled Signal. Some noise disappeared.](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity3.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity3.png)

Resampled Signal. Some noise disappeared.

Now you can hit normalize again just to make sure that the signal is normalized.

[![Normalized Signal Resampled](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity4.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/audacity4.png)

Normalized Signal Resampled

Now you can go&nbsp; **File =\> Export Audio** and make sure you export a 16 Bit PCM with Signal Microsoft WAV File. I usually keep my original file, and name this processed one as myoriginalfilename\_11025.wav. Now we are ready to decode.

**Decoding using APT 3000**

The easiest way now is to decode using APT 3000 webpage. It doesn’t produce great results always, but it it very good if you have a good signal. So just go to&nbsp;[http://jthatch.com/APT3000/APT3000.html](http://jthatch.com/APT3000/APT3000.html)&nbsp;and browse your recently edited file. It should take some time and then decode the image. Click&nbsp; **View AB** to see the full image.

[![APT 3000 Decoded Image](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/apt3000-1024x821.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/02/apt3000.png)

APT 3000 Decoded Image

Congratulations! You got your first weather satellite recording! YEY!

&nbsp;

## Cite this article

### Suggested citation

Lucas Teske. “Recording NOAA APT Signals with GQRX and RTL-SDR on Linux.” _Lets Hack It_, 2016. [https://lucasteske.dev/2016/02/recording-noaa-apt-signals-with-gqrx-and-rtl-sdr-on-linux/](https://lucasteske.dev/2016/02/recording-noaa-apt-signals-with-gqrx-and-rtl-sdr-on-linux/).

### BibTeX

```
@misc{teske2016recordingnoaaaptsignalswithgqrxandrt,
  author = {Lucas Teske},
  title = {Recording NOAA APT Signals with GQRX and RTL-SDR on Linux},
  year = {2016},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/2016/02/recording-noaa-apt-signals-with-gqrx-and-rtl-sdr-on-linux/}
}
```
