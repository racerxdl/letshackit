---
title: Positioning the Antenna - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Positioning the Antenna

So the last thing was to position the antenna. I actually did this before the step of the feed \(since I tested several other feed types\). But if you’re planning to build everything this should be the order that you do the stuff.

So in the past it would been tough to position an antenna, but today we have cellphones to help everything. One application I use in Android is [Satellite AR](https://play.google.com/store/apps/details?id=com.agi.android.augmentedreality). Another good one is [Pointer Antena](https://play.google.com/store/apps/details?id=ftl.satellitedishpointer.sdp).

Satellite AR has a preset list of Satellites \(including GOES\), and Pointer Antena allows you to fill with the coordinates of the satellite. Both are good and enough for positioning, just be carefull that your compass needs to be calibrated.

Another solution would be use [GPredict](http://gpredict.oz9aec.net/) or [Orbitron](http://www.stoff.pl/) to get the Elevation \(The inclination in relation to ground\) and Azimuth \(the bearing in relation to North\) angles  and position manually. I noticed that for my dish there is a working band of about 4 degrees of Azimuth and Elevation that the signal doesn’t change. I would recommend get your laptop / cellphone and hookup to the feed and check where you get the best signal.

Other two things that you need to care is related to the feed itself. Since we have a linear polarized feed, the rotation of the feed matters in relation to the satellite. This is less critical and I found that even 15 degrees rotation doesn’t change a lot the signal. Other thing is the focal point of the dish. You need to adjust the feed distance from the base of the dish to also get the best signal. Mine has the probe \(the linear feed inside the can\) in the focal point \(so the can opening is far ahead\). After all, you should get something like this \(got with airspy, 10MHz bandwidth\):![](/assets/goes-satellite-hunt/sdrsharp-goes.png)![](/assets/goes-satellite-hunt/zKq7Dkv.jpg)So the next step is the whole decoding process.

<div class="pagination">
    <a href="{{ 'lna-and-filter' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '/goes-satellite-hunt/the-demodulator' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
