---
title: Symbol Output from GNU Radio - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Symbol Output from GNU Radio

So we could directly map it to Binary data now, but for reasons that I will explain in the next part of the Hunt, I will keep our symbols as it is and just convert to a Byte. So basically our output from GNU Radio will be a signed byte that can vary from -128 to 127, being -128 as 100% chance to be bit 0, and 127 as 100% chance to be bit 1. And the intermediate values as the corresponding chances. Basically I will have a byte that will represent the probability of a bit being 0 or 1. I will explain more in the next part of this article.

For now what we need to do is to get the Complex output from the M&M, get only the Real Part \( Component I \) transform to byte and output \(to file or TCP Pipe\).

![](/assets/goes-satellite-hunt/crlp.png)

Thats a simple two block operation. First we use **Complex to Real **block that will output a Float with the Real component of the complex number, and then convert to char multiplying by 127 \(since the Complex is normalized\). After that we can use **File Sink**to output to a file or create a vector stream to output to a TCP Socket. In my case I will use TCP Socket.

![](/assets/goes-satellite-hunt/filesink.png)

The Stream to Vector just aggregates every 16 bytes before sending through TCP. This will reduce the TCP Packet Overhead. The TCP Sink parameters are:

* Input Type: **Byte**
* Address: **127.0.0.1**
* Port: **5000**
* Mode: **Client**
* Vec Length: **16**

With this parameters, when we run the GRC Flow, it will try to connect to localhost at port 5000 and send every group of 16 bytes \(or if you prefer, symbols\) through TCP. The next part of this article will deal with the software part to decode this and generate the packets for creating the output files. Below you can check my final flow. It also has some other blocks to have a better flexibility changing the parameters and also to show the waterfall / FFT of the input signal as well the constellation map.![](/assets/goes-satellite-hunt/grc-flow.png)

You can find the GRC file here: [https://github.com/racerxdl/open-satellite-project/blob/master/GOES/demodulator/demod\_tcp\_qt.grc](https://github.com/racerxdl/open-satellite-project/blob/master/GOES/demodulator/demod_tcp_qt.grc)

<div class="pagination">
    <a href="{{ 'synchronization-and-clock-recovery' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '/goes-satellite-hunt/frame-decoder' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
