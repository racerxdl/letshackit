---
title: LNA and Filter - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# The LNA and Filter

So in my failure setups I was having a REALLY huge noise from the GSM Band at 1800MHz. That was: even without any LNA I could get like 10dB of GSM signal. So mybit suggested me to use some filtering to wipe out this signal. So I bought some Lorch Filters \(recommeded and sold by him\) that has a center frequency of 1675MHz and 150MHz bandwidth \(so from 1600 to 1750 MHz\).

![](/assets/goes-satellite-hunt/30414447265_b5267bc07a_z.jpg)

I also bought 3 LNA4ALL \(one with connectors, two without\) to use in this and other projects.

![](/assets/goes-satellite-hunt/30328132191_2f6efce701_z.jpg)

So if you want to build this as well, I strongly suggest to buy some LNA4ALL from Adam \(its the manufacturer\). They’re used by a lot of people around the world and they’re high end ones and relatively cheap \(not for us in Brazil, but he sends in registered letter, so it never gets taxes and arrives in two or three weeks\). More info: [http://lna4all.blogspot.com/](http://lna4all.blogspot.com/)

I also bought some  aluminum boxes \(in Santa Efigenia as well, but now in [Multcomercial](http://loja.multcomercial.com.br/)\) for putting these LNA and filters. I made some tests with the topology **Feed -&gt; LNA -&gt; Filter**, but it looked like the GSM Signals was overloading the LNA. So I decided for a non-optimal setup that is **Feed -&gt; Filter -&gt; LNA **that gave me what I want. So them I just tried to fit everything inside a box and here is the result:

![](/assets/goes-satellite-hunt/30328135831_df23530552_z.jpg)

Then I finished by gluing in the CanAntenna:

![](/assets/goes-satellite-hunt/30328137581_895896ba9e_z.jpg)

And that's it!

<div class="pagination">
    <a href="{{ 'dish-feed' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'pointing-the-antenna' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
