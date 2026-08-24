---
title: "LNA and Filter - GOES Satellite Hunt | Lets Hack It"
description: "Written by Lucas Teske on 19 February 2017 Part of GOES Satellite Hunt Project overview → The LNA and Filter So in my failure setups I was having a REALLY huge noise from the GSM Band at 1800MHz. That was: even without any LNA I could get like 10dB of..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Written by Lucas Teske   
on 19 February 2017

# 

# The LNA and Filter

So in my failure setups I was having a REALLY huge noise from the GSM Band at 1800MHz. That was: even without any LNA I could get like 10dB of GSM signal. So mybit suggested me to use some filtering to wipe out this signal. So I bought some Lorch Filters (recommeded and sold by him) that has a center frequency of 1675MHz and 150MHz bandwidth (so from 1600 to 1750 MHz).

![Lorch Microwave SDF8-1675/R60-SISM component with serial number AA 734, metallic housing, gold connectors.](/assets/goes-satellite-hunt/30414447265_b5267bc07a_z.jpg)

I also bought 3 LNA4ALL (one with connectors, two without) to use in this and other projects.

![Three small electronic circuit boards with soldered components and connectors on a wooden surface.](/assets/goes-satellite-hunt/30328132191_2f6efce701_z.jpg)

So if you want to build this as well, I strongly suggest to buy some LNA4ALL from Adam (its the manufacturer). They’re used by a lot of people around the world and they’re high end ones and relatively cheap (not for us in Brazil, but he sends in registered letter, so it never gets taxes and arrives in two or three weeks). More info: [http://lna4all.blogspot.com/](http://lna4all.blogspot.com/)

I also bought some aluminum boxes (in Santa Efigenia as well, but now in [Multcomercial](http://loja.multcomercial.com.br/)) for putting these LNA and filters. I made some tests with the topology **Feed -\> LNA -\> Filter** , but it looked like the GSM Signals was overloading the LNA. So I decided for a non-optimal setup that is \*\*Feed -\> Filter -\> LNA \*\*that gave me what I want. So them I just tried to fit everything inside a box and here is the result:

![Metal enclosure housing electronic components, including circuit board and coaxial cable.](/assets/goes-satellite-hunt/30328135831_df23530552_z.jpg)

Then I finished by gluing in the CanAntenna:

![Hand holding a cylindrical, foil-wrapped electronic device with wires and a laptop in background.](/assets/goes-satellite-hunt/30328137581_895896ba9e_z.jpg)

And that’s it!

## Cite this work

### Suggested citation

Lucas Teske. “GOES Satellite Hunt.” _Lets Hack It_, 2017. [https://lucasteske.dev/goes-satellite-hunt/](https://lucasteske.dev/goes-satellite-hunt/).

### BibTeX

```
@misc{teske2017goessatellitehunt,
  author = {Teske, Lucas},
  title = {GOES Satellite Hunt},
  year = {2017},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/goes-satellite-hunt/}
}
```
