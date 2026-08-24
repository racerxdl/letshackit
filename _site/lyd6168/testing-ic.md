---
title: "LYD6168 - Testing LED Panels | Lets Hack It"
description: "Written by Lucas Teske on 16 January 2021 Getting the panel to work with a Colorlight 5A-75B The way I did is use a Colorlight Hub 5A-75B board with their original firmware and software. The software I used is Colorlight LED Vision 6.9. Just becareful that when you open, it..."
image: "https://lucasteske.dev/assets/lyd6168/photo_2021-02-28_04-18-44.jpg"
---

![Dialog box listing LCD driver IC chip series for selection, with MB1513 highlighted.](/assets/lyd6168/photo_2021-02-28_04-18-44.jpg)Written by Lucas Teske   
on 16 January 2021

# 

## Getting the panel to work with a Colorlight 5A-75B

The way I did is use a [Colorlight Hub 5A-75B board](https://s.click.aliexpress.com/e/_AbrRvE) with their original firmware and software. The software I used is [Colorlight LED Vision 6.9](https://www.colorlight-led.com/download/Colorlight_LEDVISION_6_9_Setup.html). Just becareful that when you open, it will send packets like crazy and will probably DoS your network.

1. Plug the 5A-75B in your computer ethernet card and plug the 5V power supply to the 5A-75B
2. Open LEDVISION 6.9 software
3. Go to Control -\> LED Screen Settings (the password is `168`) 
  - ![LED Screen Settings](/assets/lyd6168/photo_2021-02-28_04-16-51.jpg)

4. Select _Use Net Card_ and click _Auto Select_. It should scan and find your 5A-75B on the right side 
  - ![LED Screen Settings](/assets/lyd6168/photo_2021-02-28_04-17-15.jpg)

5. Click on _Receiver Card Parameters_
  - ![Receiver Card Parameters](/assets/lyd6168/photo_2021-02-28_04-17-25.jpg)

6. Select _Screen Param_ -\> _From Computer (Immediate Effect)_
  - ![Receiver Card Parameters](/assets/lyd6168/2021-02-28_04-22.jpg)

7. You can try selecting a preset (which didn’t work for me) clicking in the button _Load_
  - ![Load](/assets/lyd6168/2021-02-28_04-20.jpg)

8. Or just click the _Inteligent Setting_ button to manually configure the controller. 
  - ![Intelligent Setting](/assets/lyd6168/2021-02-28_04-34.jpg)

9. Then you can click in _Select Driver IC_ to change the IC 
  - ![Select Driver IC](/assets/lyd6168/2021-02-28_04-21.jpg)

10. Which should show you a lot of information. 
  - ![Drivers](/assets/lyd6168/photo_2021-02-28_04-18-44.jpg)

[Next: MBI5153](/lyd6168#mbi5153)
