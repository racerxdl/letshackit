---
title: Viewing the files content - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Viewing the files content

I still need to do some program to parse, but at least for now there is the [**xrit2pic**](http://www.alblas.demon.nl/wsat/software/soft_msg.html) that can parse some of the GOES LRIT \(and other satellites LRIT\) files. If you want to make your own parser, most of the files are easy to process. The Text files are just raw text data \(so just skip the headers\), the images are in raw format \(check the headers to see how they’re composed\). Some aditional details about the headers that I mapped are here: [https://github.com/racerxdl/open-satellite-project/blob/master/GOES/standalone/packetmanager.py\#L172-L260](https://github.com/racerxdl/open-satellite-project/blob/master/GOES/standalone/packetmanager.py#L172-L260)

In a future article I will make a User Guide to my LRIT Decoder. For now I want to make it better and with a more user friendly interface, so this articles are intended to someone who wants to understand how the protocol works. These are some data I got from GOES 13:

![](/assets/goes-satellite-hunt/g13fd.png)

![](/assets/goes-satellite-hunt/meteosatfd.png)

![](/assets/goes-satellite-hunt/wefax.png)

Text Messages:

> ————————————–  
> LRIT Admin Message \#011  
> Start:14-April-2010  
> End:20-December-2018  
> Distribution: East and West  
> Subject: LRIT contact information  
> ————————————–  
> The LRIT Systems team, in an effort to be more responsive  
> to the user community, would like for users to have  
> contact information. In the event that a user notices any  
> long term trends or anomalies in the LRIT data stream, or  
> has suggestions or comments. We ask that contact be made  
> via email to LRIT@noaa.gov.
>
> If more immediate matters arise, that the user deems as  
> urgent, we advise the use of the following operational  
> facility phone number: 301-817-3880.  
> ————————————–



<div class="pagination">
    <a href="{{ 'file-name-from-header' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '/goes-satellite-hunt/file-types' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
