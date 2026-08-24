---
title: "Symbol Output from GNU Radio - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → Symbol Output from GNU Radio So we could directly map it to Binary data now, but for reasons that I will explain in the next part of the Hunt, I will keep..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# Symbol Output from GNU Radio

So we could directly map it to Binary data now, but for reasons that I will explain in the next part of the Hunt, I will keep our symbols as it is and just convert to a Byte. So basically our output from GNU Radio will be a signed byte that can vary from -128 to 127, being -128 as 100% chance to be bit 0, and 127 as 100% chance to be bit 1. And the intermediate values as the corresponding chances. Basically I will have a byte that will represent the probability of a bit being 0 or 1. I will explain more in the next part of this article.

For now what we need to do is to get the Complex output from the M&M, get only the Real Part ( Component I ) transform to byte and output (to file or TCP Pipe).

![Two block diagrams: "Complex To Real" and "Float To Char Scale: 127", connected by wires.](/assets/goes-satellite-hunt/crlp.png)

Thats a simple two block operation. First we use&nbsp; **Complex to Real&nbsp;** block that will output a Float with the Real component of the complex number, and then convert to char multiplying by 127 (since the Complex is normalized). After that we can use&nbsp; **File Sink** to output to a file or create a vector stream to output to a TCP Socket. In my case I will use TCP Socket.

![Flow diagram with blocks: Complex To Real, Float To Char, Stream to Vector, TCP Sink.](/assets/goes-satellite-hunt/filesink.png)

The Stream to Vector just aggregates every 16 bytes before sending through TCP. This will reduce the TCP Packet Overhead. The TCP Sink parameters are:

- Input Type:&nbsp; **Byte**
- Address:&nbsp; **127.0.0.1**
- Port:&nbsp; **5000**
- Mode:&nbsp; **Client**
- Vec Length:&nbsp; **16**

With this parameters, when we run the GRC Flow, it will try to connect to localhost at port 5000 and send every group of 16 bytes (or if you prefer, symbols) through TCP. The next part of this article will deal with the software part to decode this and generate the packets for creating the output files. Below you can check my final flow. It also has some other blocks to have a better flexibility changing the parameters and also to show the waterfall / FFT of the input signal as well the constellation map. ![GNU Radio flowgraph for TCP demodulation with BPSK, AGC, filters, and GUI sinks.](/assets/goes-satellite-hunt/grc-flow.png)

You can find the GRC file here:&nbsp;[https://github.com/racerxdl/open-satellite-project/blob/master/GOES/demodulator/demod\_tcp\_qt.grc](https://github.com/racerxdl/open-satellite-project/blob/master/GOES/demodulator/demod_tcp_qt.grc)

## Cite este trabalho

### Citação sugerida

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
