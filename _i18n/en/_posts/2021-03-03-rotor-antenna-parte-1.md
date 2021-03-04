---
title: 'Antenna Rotor - Part 1'
date: 2021-03-03T20:57:00-03:00
author: Lucas Teske
layout: post
image: /assets/posts/tracker-mount/head.jpg
categories:
  - English
  - Reverse Engineering
  - Satellite
  - SDR
tags:
  - Airspy
  - EMWIN
  - English
  - GOES
  - Hearsat
  - LRIT
  - RE
  - Reverse Engineering
  - Sat
  - Satellite
  - SDR

---

A few years ago I bought a Pelco Câmera Rotor, model PT175-24P. This rotor is made for carrying a camera with up to 8kg, and contains two biphase reversable motors internally. My idea was (and is) to put a satellite dish coupled, and control its movement to track satellites. Then I could use it to receive Low Orbit Satellites.

![Internal Schematics](/assets/posts/tracker-mount/motor-schematic.jpg)*Internal Schematics*

<hr>

The problem of the original system from pelco, is that they're two 24V AC Motors, which would require a VFD (Variable Frequency Driver) to control the speed and a closed-loop system with a angle sensor. That would make it a bit complex to control the antenna, so a friend of my (PY2UEP) suggested to modify it to use stepper motors instead. The big advantage of stepper motors is that their steps always has the same length. So if the motor goes N steps in one direction and then N steps in the oposite direction, it will return **exactly** where it started. That allows for open-loop circuits (where you just calibrate the start and then you dont need a feedback to fix everything).

![Stepper Motor](/assets/posts/tracker-mount/photo_2021-03-03_20-56-30.jpg)*Stepper Motor*

# Make the cleaning

Then I started opening the rotor and make a super-clean. Remove all old grease and dust.

![Pelco Interior](/assets/posts/tracker-mount/photo_2021-03-02_20-19-46.jpg)*Pelco Interior*
![Pelco Interior](/assets/posts/tracker-mount/photo_2021-03-02_20-19-46-2.jpg)*Pelco Interior*

I disassembled everything and then made a querosene bath to remove grease from everywhere. Two of the azimuth rollers were well stuck (the grease was so dry that it looked like a glue), so I left in the querosene until the next day and then cleaned up with a paint brush. After all the cleaning, the rollers looks new!

![](https://www.youtube.com/watch?v=9Y2FpSlNss8)

The rest of the parts I basically tossed inside a bucket and filled with querosene with a bit of water. Then I started stiring the parts inside. After a while, I let it sit and made several washes with water and soap to remove all querosene.

![Bucket with parts](/assets/posts/tracker-mount/photo_2021-03-03_19-23-52.jpg)*Bucket with washed parts*

The belts I left on the querosene for a few minutes and then used a paint brush to remove all stuck pieces of grease.

![Belts](/assets/posts/tracker-mount/photo_2021-03-03_19-23-53.jpg)*Belts in querosene*

After all clean-up, I started the re-assembly by putting the two azimuth rollers in place. The one from below is stuck inside the piece under pressure, so I needed to use a hammer. With a lot of care, I managed to push the piece until it fit perfectly with the surface of the base. After that I pushed the azimuth axis through the roller.

![](https://www.youtube.com/watch?v=5wpSKRn5RnM)

Just after that, I put the reduction gears and the azimuth belt in place.

![](https://www.youtube.com/watch?v=bE6B3GejGmA)

After that, everything was easy: just screw everything together. In the end I left it open so I could plan the position of the stepper motors:

![Open Pelco Mount](/assets/posts/tracker-mount/photo_2021-03-03_22-51-36.jpg)*Open Pelco Mount*

The next step is to disassemble the original motors and adapt the axis for the stepper motors!

![Azimuth Motor](/assets/posts/tracker-mount/photo_2021-03-03_22-56-26-2.jpg)*Azimuth Motor*

![Elevation Motor](/assets/posts/tracker-mount/photo_2021-03-03_22-56-26.jpg)*Elevation Motor*

