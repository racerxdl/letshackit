---
title: "QFH Antenna and my first reception of NOAA! | Lets Hack It"
description: "Build a QFH antenna to receive NOAA weather satellite APT signals. Learn about circular polarization and using RTL-SDR with Intel Edison."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# QFH Antenna and my first reception of NOAA!

Written by Lucas Teske   
on 25 January 2016

[![20160119_203854](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/20160119_203854-169x300.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/20160119_203854.jpg)

So in my last post I was playing with my RTL-SDR with an Intel Edison. So I decided to build a QFH Antenna to be able to receive NOAA [APT](https://en.wikipedia.org/wiki/Automatic_picture_transmission) Signals. These NOAA Weather Satellites broadcast an APT signal with about 5 to 8 Watts at 2m band, and considering how low this power is, it might surprise you that these signals arrive pretty strong at earth surface. But the biggest challenge to receive these signals are not its power. Its all about movement.

These satellites are sun-synchronous low orbit satellites, that means they aren’t locked to earth rotation. Instead, they actually do one turn on earth in about 1 hour and half. So whenever the satellite is in range of your receiver, it will appear on one side of the horizon, and disappear on another one. This creates a need for a good omni directional antenna that can receive signals from anywhere. But not only this: The signal is rotating (a.k.a. circular polarization)

[![Circular.Polarization.Circularly.Polarized.Light_Right.Handed.Animation.305x190.255Colors](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/Circular.Polarization.Circularly.Polarized.Light_Right.Handed.Animation.305x190.255Colors.gif)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/Circular.Polarization.Circularly.Polarized.Light_Right.Handed.Animation.305x190.255Colors.gif)

So we need a antenna that can receive circular polarized signals. We have a few choices like QFH ( **Q** uadri **F** iliar **H** elix) , Double Cross Antenna (Double Dipole) or Turnstyle Antenna.

[![TurnStyle Antenna](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/homebrew_137MHz_turnstile.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/homebrew_137MHz_turnstile.jpg)

TurnStyle Antenna (Source: http://www.rtl-sdr.com/ )

[![Double Cross Antenna (Source: http://www.rtl-sdr.com/ )](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/DoubleCrossAntenna.jpg)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/DoubleCrossAntenna.jpg)

Double Cross Antenna (Source: http://www.rtl-sdr.com/ )

I decided to go for QFH because it was the easiest to be done with what I had.

## Building the Antenna

So for building an antenna, I first started searching some previous experiences with QFH in the internet. I found this website&nbsp;[http://www.jcoppens.com/ant/qfh/calc.en.php](http://www.jcoppens.com/ant/qfh/calc.en.php)&nbsp;that have a pretty good calculator. To be honest I did not like much how the layout of the calculator is (I think it is very confusing) but it gets the right values and can even generate drilling templates. But later I will make my own calculator and drilling generator for that.

So the default parameters were very good for me, and I printed the drilling guides for my tubes. For the mast (vertical tube) I had to use a 2m x 5cm PVC Pipe (sewer pipe) and for the Horizontal tubes I had to use a 2cm diameter PVC tube (sewer pipe as well). I bought 2m of it as well and it was enough.  
[![QFH Main Support](https://farm2.staticflickr.com/1620/24322927011_284622755a.jpg)](https://www.flickr.com/photos/energylabs/24322927011/in/album-72157663446128821/ "QFH Main Support")[![QFH Drilling Guide](https://farm2.staticflickr.com/1539/24297145512_5a8734a6aa.jpg)](https://www.flickr.com/photos/energylabs/24297145512/in/album-72157663446128821/ "QFH Drilling Guide")

[![QFH Drilling Guide](https://farm2.staticflickr.com/1544/24405407065_485f521d8f.jpg)](https://www.flickr.com/photos/energylabs/24405407065/in/album-72157663446128821/ "QFH Drilling Guide")

[![QFH Drilling Guide](https://farm2.staticflickr.com/1568/24405406975_561f1b6fb7.jpg)](https://www.flickr.com/photos/energylabs/24405406975/in/album-72157663446128821/ "QFH Drilling Guide")[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1548/23809947114_e9c4b0db78.jpg)](https://www.flickr.com/photos/energylabs/23809947114/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

So as you can see, the drilling templates were only used for positioning. First I was thinking about using copper pipe to to the horizontal guides, but I decided to use the 2cm PVC Pipe instead. So I just drilled a bigger hole. In the picture above, my RGE-06 Coax Cable for the conductor (I wish I had a copper braid coax 🙁 &nbsp;)

[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1560/23809942874_a1e5cceace.jpg)](https://www.flickr.com/photos/energylabs/23809942874/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1677/24142526480_28f90740ee.jpg)](https://www.flickr.com/photos/energylabs/24142526480/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

So the two top-most horizontal guides are on the same level, also is where the cables go out to I plug with the output. So I cut 80% of the pipe in the middle with the width of a pipe (so, 2cm). The two guides from the middle had to have holes in the ends so the Coax Cable passes through it.

[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1637/24142520850_1823b08b97.jpg)](https://www.flickr.com/photos/energylabs/24142520850/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

So first things first. I glued with hot glue and insulation tape the output cable on the side of the mast and drilled one additional hole at the top. This is needed because we need a 4 turn “balun” to match the unbalanced coax cable with a balanced antenna signal. So the hole was to pass the coax cable inside to exit on the top of the mast (so I can do the wirings there).[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1658/24355686161_54df968f9d.jpg)](https://www.flickr.com/photos/energylabs/24355686161/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1467/24329847562_f07f625efa.jpg)](https://www.flickr.com/photos/energylabs/24329847562/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1490/24438127645_3572527b11.jpg)](https://www.flickr.com/photos/energylabs/24438127645/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

After that I started winding the antenna. So I had to cut two pieces of 2m coax cable to do the two loops of the antenna. Firstly I made a mistake doing Left Handed Polarization instead of Right Hand Polarization. So just to help you guys: Make your right hand a L shape with your fingers with your Thumb parallel with the antenna. If you rotate your hand in the direction of your fingers, and the cable follows the direction of your fingers, you have Right Hand Polarization. If it doesn’t, it will probably do with your Left hand. Make sure your antenna is&nbsp; **Right Hand Polarized** not left. The cables should go top to down when you rotate your hand. If you have any doubts, take a look on the next picture. So if you are thinking about how the cables goes inside these tubings, basically just imagine as a O shape loop, with the O cut at the top of the mast (so actually a U shape lol)

[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1538/24142501410_edcb389134.jpg)](https://www.flickr.com/photos/energylabs/24142501410/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

&nbsp;

So here we have all 4 points + the output at the top.

&nbsp;

[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1673/24070322889_2697f6bc84.jpg)](https://www.flickr.com/photos/energylabs/24070322889/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

So it looks complicated to wire, but is not that hard. Take a look here:

[![250px-QFH_Feedpoint](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/250px-QFH_Feedpoint.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/250px-QFH_Feedpoint.png)

So basically if you rotate the antenna that the conductors make an X, you wire the left side cables with the conductor of the output, and right side cables with braid of the output. Please notice that for the 4 cables that arrive at the top, you need to short circuit the conductor and the braid, so the entire cable will act like one conductor.  
[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1651/24411896876_35a4037ddf.jpg)](https://www.flickr.com/photos/energylabs/24411896876/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

So this is what it looks after everything connected. I know it looks ugly, and thats why I wanted a copper braid coax cable :/  
[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1509/24438115035_1d80b3fb25.jpg)](https://www.flickr.com/photos/energylabs/24438115035/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

So after everything wired, the antenna looks like this:[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1560/24438109765_264057d4d8.jpg)](https://www.flickr.com/photos/energylabs/24438109765/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

## First Test

So just after I finished wiring everything up, I got my laptop, my SDR and my antenna and went out to test it on the first satellite that would pass. So besides the antenna is on the ground on the picture, I actually held the antenna still on the wall, pointing upwards. I got a good signal, but not for a long time because the antenna was too low and since there is a lot of houses (and even my roof was higher than the antenna) I did not get much of the horizon for it. So I went to fix it.

[![Quadrifiliar Helix Antenna for 137MHz](https://farm2.staticflickr.com/1607/23811303963_897fc17025.jpg)](https://www.flickr.com/photos/energylabs/23811303963/in/album-72157663446128821/ "Quadrifiliar Helix Antenna for 137MHz")

## Fixing the antenna

So I had to search a place on the roof to get the antenna fixed. So I found a corner that was perfect for that. Also I got a longer PVC Pipe and fixed on my antenna, so I could fix better.

[![QFH In place!](https://farm2.staticflickr.com/1648/24227344919_96f477f007.jpg)](https://www.flickr.com/photos/energylabs/24227344919/in/album-72157663446128821/ "QFH In place!")

So this is how it looks from the street.[![QFH In place seen from the street](https://farm2.staticflickr.com/1625/23966968584_e2cd388b73.jpg)](https://www.flickr.com/photos/energylabs/23966968584/in/album-72157663446128821/ "QFH In place seen from the street")

I also got a LNA (Low noise amplifier) in the antenna (you can see on the first picture) because I wanted the cable to go straight to my room, and this is about 10m of coax cable. I used a coax cable that have a power conductor on the side (it is used for Security Cameras, so you can pass power together with the signal). But I just noticed that the LNA had a too wide band (5 MHz to 1GHz) and this was amplifing as well the Floor Noise and Cross Band interference.

## New Filters

So I decided to start with a basic filter and then go to a better filter (which I didnt yet). The simplest way I thought was to try to remove the FM Radio Band (88 to 108MHz) and the 200MHz+ Band. The perfect filter for removing specific frequencies are the Notch Filters. I found a very simple notch filter that is done by using a piece of coax cable cut in 1/4 of the wavelength you want to strip out from your signal. So I made two coax notch filters: One for 106MHz and other for 270MHz. The 270MHz filter have a 135MHz pass band, and the 106MHz should attenuate the 88-108MHZ band a little. This should reduce my noise floor.

[![Notch Filters for removing 106MHz band and 270MHz band.](https://farm2.staticflickr.com/1514/24595103135_58aa51cd5d.jpg)](https://www.flickr.com/photos/energylabs/24595103135/in/album-72157663446128821/ "Notch Filters for removing 106MHz band and 270MHz band.")

So before putting the filter at the antenna, I ran some tests here in my desk. The test were simple: I had the best Spectrum Analyzer I could have – The SDR. So I just got another LNA I had here and wired like this:

> Random FM Radio Antenna **=\>** Filters&nbsp; **=\>&nbsp;** LNA **=\>** SDR

So in this way I could test how effective the Filter would be.Here is the result:

[![102MHz Band without the filter](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/a.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/a.png)

102MHz Band without the filter

[![102MHz Band with the filter](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/b.png)](https://www.teske.net.br/lucas/wp-content/uploads/2016/01/b.png)

102MHz Band with the filter

Also, I had no attenuation at 135-138MHz band. So I decided to put the filter on the antenna.

[![QFH + LNA + Notch Filters](https://farm2.staticflickr.com/1521/23966969304_f8fe2be32f.jpg)](https://www.flickr.com/photos/energylabs/23966969304/in/album-72157663446128821/ "QFH + LNA + Notch Filters")

## Tests and Results

So yesterday (24/01/2016, saturday) I saw that the NOAA Satellites would pass directly over my home, so I decided to power up the antenna and give a try. Here are the results ! 😀

[![NOAA 15 at 23 Jan 2016 20:54:53 GMT](https://farm2.staticflickr.com/1473/24486808972_70b77f85a5.jpg)](https://www.flickr.com/photos/energylabs/24486808972/in/album-72157663446128821/ "NOAA 15 at 23 Jan 2016 20:54:53 GMT")

[![NOAA 18 at 23 Jan 2016 21:19:02 GMT](https://farm2.staticflickr.com/1541/23966990724_7d00b0d6ed.jpg)](https://www.flickr.com/photos/energylabs/23966990724/in/album-72157663446128821/ "NOAA 18 at 23 Jan 2016 21:19:02 GMT")

[![NOAA 15 SDRSharp](https://farm2.staticflickr.com/1666/24299644810_9609d9ca4f.jpg)](https://www.flickr.com/photos/energylabs/24299644810/in/album-72157663446128821/ "NOAA 15 SDRSharp")

## Cite this article

### Suggested citation

Lucas Teske. “QFH Antenna and my first reception of NOAA!” _Lets Hack It_, 2016. [https://lucasteske.dev/2016/01/qfh-antenna-and-my-first-reception-of-noaa/](https://lucasteske.dev/2016/01/qfh-antenna-and-my-first-reception-of-noaa/).

### BibTeX

```
@misc{teske2016qfhantennaandmyfirstreceptionofnoaa,
  author = {Lucas Teske},
  title = {QFH Antenna and my first reception of NOAA!},
  year = {2016},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/2016/01/qfh-antenna-and-my-first-reception-of-noaa/}
}
```
