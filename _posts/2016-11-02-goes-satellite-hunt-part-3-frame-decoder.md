---
id: 216
title: GOES Satellite Hunt (Part 3 – Frame Decoder)
date: 2016-11-02T17:50:34-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=216
permalink: /2016/11/goes-satellite-hunt-part-3-frame-decoder/
image: /wp-content/uploads/2016/11/qqk3UwA-624x135.png
categories:
  - Reverse Engineering
  - Satellite
tags:
  - AGC
  - Airspy
  - Automatic Gain Control
  - Bug
  - Compile
  - Convolutional Code
  - Convolutional Encoding
  - EMWIN
  - English
  - GNU Radio
  - Gnuradio
  - GOES
  - GRC
  - Hearsat
  - LRIT
  - Osmocom
  - RE
  - Reed Solomon
  - Reverse Engineering
  - Root Raised Cosine Filter
  - RRC Filter
  - RS
  - Sat
  - Satellite
  - SDR
  - Statistics
  - Viterbi
---
In the last chapter of GOES Satellite Hunt, I explained how I did the BPSK Demodulator for the LRIT Signal. Now I will explain how to decode the output of the data we got in the last chapter.

One thing that is worth mentioning is that most (if not all) weather satellites that transmit digital signals use the CCSDS standard packet format, or at least something based on it. For example this frame decoder can be used (with some modifications due QPSK instead BPSK) for LRPT Signals from Meteor Satellites (I plan to do a LRPT decoder as well in the future, and I will post about it). I will not describe my entire code here, just the pieces for decoding the data. I will also not write the entire code here, since it can be checked in github. So before start see the picture below (again). We will some info from it as well.

<div style="width: 861px" class="wp-caption aligncenter">
  <img src="https://i.imgur.com/lx7lioZ.png" width="851" />
  
  <p class="wp-caption-text">
    LRIT Signal Specifications
  </p>
</div>

<!--more-->

# Convolution Encoding, Frame Synchronization and Viterbi

The first thing we need to do is sync our frame starts. For making easier to find the packet start, these bit streams has something called **preamble**. The preamble is basically a period when the bits sent does not actually contains any data, besides a information that informs the decoder that this is the frame start. Usually the preamble consists in a fixed 32 bits synchronization word. Most of the satellite systems use the standard CCSDS Synchronization Word that is **0x1ACFFC1D** ( or in bits: **00011010 11001111 11111100 00011101** ). So basically we can use this to find where our data starts. After we find these 32 bits we will have the start of the data. Also with two sync words, we can find the period of our frame (or, how many bits the frame has). But things can never be that easy: The data is Convolution Encoded (including the Sync Word). Why is the data Convolution Encoded? That&#8217;s simple: Its a way to correct errors (bit swaps). So let me talk a bit of convolution encoding.

# Convolution Encoding

Convolution Encoding basically is a process that generates parity of original data as the output. This parity has a special feature that is constructing a Trellis Diagram Sequence.

<div style="width: 1210px" class="wp-caption aligncenter">
  <a href="https://commons.wikimedia.org/wiki/File:Convolutional_code_trellis_diagram.svg#/media/File:Convolutional_code_trellis_diagram.svg"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Convolutional_code_trellis_diagram.svg/1200px-Convolutional_code_trellis_diagram.svg.png" alt="Convolutional code trellis diagram.svg" width="1200" /></a>
  
  <p class="wp-caption-text">
    By Qef &#8211; Own work, Public Domain. Click on the image for details
  </p>
</div>

A trellis diagram of two bits (as shown by the image), for every pair of bits, there is only two possible next two bits. For example if my pair is 00, the only possible next pair is 00 or 10. By convolution encoding a data, we generate parity that follows the Trellis diagram, in this way if we have errors in our bit stream, we can use a statistical way to find the most possible path in the trellis diagram that represents that data, then correcting the errors.

So how actually the data is encoded? The image below will show a example of convolution encoder:

<pre><a href="https://commons.wikimedia.org/wiki/File:Convolutional_encoder_non-recursive.png#/media/File:Convolutional_encoder_non-recursive.png"><img class="aligncenter" src="https://upload.wikimedia.org/wikipedia/commons/2/21/Convolutional_encoder_non-recursive.png" alt="Convolutional encoder non-recursive.png" /></a>
By <a class="extiw" title="wikipedia:User:Teridon" href="https://en.wikipedia.org/wiki/User:Teridon">Teridon</a> at <a class="extiw" title="wikipedia:" href="https://en.wikipedia.org/wiki/">English Wikipedia</a> - <span class="int-own-work" lang="en">Own work</span> (<a class="extiw" title="en:User:Teridon" href="https://en.wikipedia.org/wiki/User:Teridon">Teridon</a>), Public Domain, <a href="https://commons.wikimedia.org/w/index.php?curid=12803371">Link</a></pre>

The image shows a **k=3**, **r=1/3** convolution encoder. The **k** parameter says how many bits our buffer has. For a **k=3** we will have a buffer of 3 bits. The **r** parameter gives us the rate of the encoder, in other words, how many bits our encoder produces. In this case, for every 1 bit we input to the encoder, we generate 3 bits. The encoder in the image also has three more parameters: **G1 = 111, G2 = 011, G3 = 101**. These are the **generator polynomials**. It&#8217;s always one generator polynomial per bit of output. So for r = 1/2 we would have 2 polys, for 1/6 we would have 6 polys. And here is how the encoder works:

  1. The buffer starts with all 0 (unless specified different)
  2. The input bit enters on the left side of the buffer, and shifts all the buffer bits to the right.
  3. Each polymonial says what bits should be sum to give the corresponding parity bit.
  4. Cycle repeats.

So let me give an example. Suppose we&#8217;re already with the **k **buffer filled with **101**. Our next bit is **1**. So we shift our buffer **k** right, and put our input bit on the left-most position. So our buffer now will have **110**. Now our 3 output bits will be:

  * **n0 = 1 + 1 + 0 = 0**
  * **n1 = 0 + 1 + 0 = 1**
  * **n2 = 1 + 0 + 0 = 1**

So why these values? The generic way to represent that is:

  * **n0 = k[0] ^ G0[0] + k[1] ^ G0[1] + k[2] ^ G0[2]**
  * **n1 = k[0] ^ G1[0] + k[1] ^ G1[1] + k[2] ^ G1[2]**
  * **n2 = k[0] ^ G2[0] + k[1] ^ G2[1] + k[2] ^ G2[2]**

Keep in mind, this is a mod 2 operation (we only have one bit output). So basically we just get every **buffer k** bits, xor with the corresponding position of the corresponding poly, and them sum to the output.

In this chapter we will use a lot of [**libfec**](https://github.com/quiet/libfec) routines to process our data. The first one is to encode the sync words.

# Encoding the sync word

First thing to do for frame sync is to convolution encode our sync word ( **0x1ACFFC1D** ). The LRIT signal uses a **k=7** and **r=1/2** with the poly&#8217;s **0x4F** and **0x6D**. We can use the **parity** function from libfec. So here is the code I use for encoding the word: http://codepad.org/3FJ1tVIG

<pre class="brush: cpp; title: ; notranslate" title="">#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;stdint.h&gt;
#include &lt;fec.h&gt;

int main(int argc,char *argv[]) {
  int polys[2] = {0x4f, 0x6d};
  char syncword[] = {0x1A, 0xCF, 0xFC, 0x1D};
  char outputword[64];

  uint64_t encodedWord = 0;

  char buff[2];

  unsigned int encstate;
  int wordSize = 4;
  int processedBytes = 0;
  int encodedWordPosition = 63;
  int outputwordPosition = 0;

  char c;

  encstate = 0;
  while(processedBytes &lt; wordSize){
    c = syncword[processedBytes];
    for(int i=7;i&gt;=0;i--){
      encstate = (encstate &lt;&lt; 1) | ((c &gt;&gt; 7) & 1);
      c &lt;&lt;= 1;
      // Soft Encoded Word
      outputword[outputwordPosition] = 0 - parity(encstate & polys[0]);
      outputword[outputwordPosition + 1] = 0 - parity(encstate & polys[1]);
      outputwordPosition += 2;

      // Encoded Word
      encodedWord |= (uint64_t)(1-parity(encstate & polys[0])) &lt;&lt; (encodedWordPosition);
      encodedWord |= (uint64_t)(1-parity(encstate & polys[1])) &lt;&lt; (encodedWordPosition-1);
      encodedWordPosition-=2;
    }
    processedBytes++;
  }

  printf("Encoded Word: 0x%016lx\n", encodedWord);
  printf("Soft Encoded Word: \n");
  for (int i=0; i&lt;64; i++) {
    printf("0x%x ", outputword[i] & 0xFF);
  }

  printf("\n");

  return 0;
}
</pre>

You can compile with gcc using:

<pre class="brush: bash; title: ; notranslate" title="">gcc encword.c -lfec -lm -o encword
</pre>

This should give you the encoded syncword as **0xfca2b63db00d9794**. But since we can have a phase ambiguity of 180 degrees in BPSK, we should also search for the inverted word that is **0x035d49c24ff2686b**. Just side note, these are actually the inverted syncwords that we will use for searching the frame start. The 0 degree is atually **0x035d49c24ff2686b** and 180 degree is **0xfca2b63db00d9794**. But since we&#8217;ll use a correlation filter search, we should use the inverted words to get maximum correlation.

Also the program will output the Soft Symbols for that Encoded Sync Word, that is basically for every bit 0 it will have a byte 0, for every bit 1 it will have a byte 0xFF (256). That&#8217;s because we are sure that these are the correct bits (so we get the maximum values). In our decoder we&#8217;ll convert the uint64_t encoded syncwords to a soft symbol array to use in the correlation filter.

# Frame Synchronization

Now we have the sync word, we can do the frame synchronization. I will use a correlation system to find the most probably location for the sync word. For that I will basically sum the difference of each XOR (UW[n] ^ data[i+n]) to a variable. The position that has the highest value (a.k.a. highest correlation) is where our word is most probably.

<pre class="brush: cpp; title: ; notranslate" title="">typedef struct {
  uint32_t uw0mc;
  uint32_t uw0p;
  uint32_t uw2mc;
  uint32_t uw2p;
} correlation_t ;


const uint64_t UW0 = 0xfca2b63db00d9794; // 0 degrees inverted phase shift
const uint64_t UW2 = 0x035d49c24ff2686b; // 180 degrees inverted phase shift

uint8_t UW0b[64]; // The Encoded UW0
uint8_t UW2b[64]; // The Encoded UW2

void initUW() {
  printf("Converting Sync Words to Soft Data\n");
  for (int i = 0; i &lt; 64; i++) {
    UW0b[i] = (UW0 &gt;&gt; (64-i-1)) & 1 ? 0xFF : 0x00;
    UW2b[i] = (UW2 &gt;&gt; (64-i-1)) & 1 ? 0xFF : 0x00;
  }
}

uint32_t hardCorrelate(uint8_t dataByte, uint8_t wordByte) {
  //1 if (a        &gt; 127 and       b == 255) or (a        &lt; 127 and       b == 0) else 0
  return (dataByte &gt;= 127 & wordByte == 0) | (dataByte &lt; 127 & wordByte == 255);
}


void resetCorrelation(correlation_t * corr) {
  memset(corr, 0x00, sizeof(correlation_t));
}

void checkCorrelation(uint8_t *buffer, int buffLength, correlation_t *corr) {
  resetCorrelation(corr);
  for (int i = 0; i &lt; buffLength - 64; i++) {
    uint32_t uw0c = 0;
    uint32_t uw2c = 0;

    for (int k = 0; k &lt; 64; k++) {
      uw0c += hardCorrelate(buffer[i+k], UW0b[k]);
      uw2c += hardCorrelate(buffer[i+k], UW2b[k]);
    }

    corr-&gt;uw0p = uw0c &gt; corr-&gt;uw0mc ? i : corr-&gt;uw0p;
    corr-&gt;uw2p = uw2c &gt; corr-&gt;uw2mc ? i : corr-&gt;uw2p;

    corr-&gt;uw0mc = uw0c &gt; corr-&gt;uw0mc ? uw0c : corr-&gt;uw0mc;
    corr-&gt;uw2mc = uw2c &gt; corr-&gt;uw2mc ? uw2c : corr-&gt;uw2mc;
  }
}

</pre>

With this piece of code, you can run **checkCorrelation(buffer, length, corr)** and get the correlation statistics. In the **corr** object you will have the fields **uw0p** and **uw2p** with the positions of the highest correlation of the buffer and in **uw0mc** and **uw2mc** you will have the correlation of that position. With this two values you can know the position that your sync word is, and what is the phase shift that the Costas Loop locked into (if uw0 is 0 degrees, if uw2 is 180 degrees). To correct the data if the output is 180 degrees phase shifted, just invert every bit in your sequence. I do that by XOR&#8217;ing every byte with **0xFF**. Now if you output this to a file and inspect with [BitDisplay](https://github.com/racerxdl/open-satellite-project/tree/master/Toolset/BitDisplay) you will see a pattern like this:

<div style="width: 1034px" class="wp-caption aligncenter">
  <img class="" src="https://i.imgur.com/pDE0R9Wh.png" width="1024" />
  
  <p class="wp-caption-text">
    Synced Frames
  </p>
</div>

See that the syncword is pretty clear in the bit display? You can use that to visually identify sync words or static data inside the frames. You can also notice that there are even more static data in the frames. We will talk about it later. Now our data is ready to decode.

# Decoding Frame Data

Now we&#8217;re ready to decode the frame data from the Convolution Code. For that we will use an algorithm called [**Viterbi**](https://en.wikipedia.org/wiki/Viterbi_algorithm). Viterbi is an algorithm to find hidden values in markov sequences. The Trellis Diagram from a Convolution Code is basically a markov sequence with hidden state (the hidden state is our data). Luckly the libfec includes a viterby for convolution encoded code with k=7 and rate=1/2. We&#8217;re going to use it. Its pretty straightforward to use it, but we need to have the frames in sync and know the frame period. You can discover the frame period (if you&#8217;re already didn&#8217;t) by checking the distance between sync words). In case of LRIT the frames are 8192 bits wide (1024 bytes) from which 32 bits (4 bytes) is the sync word. Since its convolution encoded with rate 1/2, we will have a encoded frame size of 16384 bits (or 2048 bytes). Using libfec we can decode it like this:

<pre class="brush: cpp; title: ; notranslate" title="">#include &lt;fec.h&gt;

#define VITPOLYA 0x4F
#define VITPOLYB 0x6D

uint8_t codedData[16384]; // Our coded frame data as soft symbols
uint8_t decodedData[1024]; // Our decoded frame
int viterbiPolynomial[2] = {VITPOLYA, VITPOLYB};

/* */
  void *viterbi;
  set_viterbi27_polynomial(viterbiPolynomial);
  if((viterbi = create_viterbi27(16384)) == NULL){
    printf("create_viterbi27 failed\n");
    exit(1);
  }
  // Now for each frame:
  init_viterbi27(viterbi, 0);
  update_viterbi27_blk(viterbi, codedData, 16384 + 6);
  chainback_viterbi27(viterbi, decodedData, 16384, 0);
  // decodedData will have the decoded stuff
</pre>

So as a side note now: Do you remember in the last chapter that I said about saving only the soft symbols? We synced using the soft symbols and viterbi will also use the soft symbols. What is the advantage? Since both Correlation Search and Viterbi are statistical algorithms, this increase the odds that a value that is on the middle of the decision tree (for example something close to 0 on a signed byte, that can be either bit 1 or bit 0) will not count much for the statistics. So a number that is on the middle can be either 0 or 1, viterbi will use that as a \*I can be any value\* in the trellis diagram and see which one is the most probably using other values in the sequence. This increases the quality of decoding the same as if you signal as about 2dB Higher SNR, and believe, that&#8217;s a HUGE improvement.

Usually after decoding a frame, you might also want to check the quality of the decoding. So a good way to measure is by re-encoding the signal and comparing the two streams of the original encoded signal and the expected encoded signal (the one you encoded).

<pre class="brush: cpp; title: ; notranslate" title="">/**/

void convEncode(uint8_t *data, int dataLength, uint8_t *output, int outputLen) {
  unsigned int encstate = 0;
  uint8_t c;
  uint32_t pos = 0;
  uint32_t opos = 0;

  memset(output, 0x00, outputLen);
  while (pos &lt; dataLength && (pos * 16) &lt; outputLen) {
    c = data[pos];
    for(int i=7;i&gt;=0;i--){
      encstate = (encstate &lt;&lt; 1) | ((c &gt;&gt; 7) & 1);
      c &lt;&lt;= 1;
      output[opos]   = ~(0 - parity(encstate & viterbiPolynomial[0]));
      output[opos+1] = ~(0 - parity(encstate & viterbiPolynomial[1]));

      opos += 2;
    }
    pos++;
  }
}

uint32_t calculateError(uint8_t *original, uint8_t *corrected, int length) {
  uint32_t errors = 0;
  for (int i=0; i&lt;length; i++) {
    errors += hardCorrelate(original[i], ~corrected[i]);
  }

  return errors;
}
/**/

convEncode(decodedData, 1024, correctedData, 16384);
uint32_t errors = calculateError(codedData, correctedData, 16384) / 2;
float signalErrors = (100.f * errors) / 8192;
/**/
</pre>

Then in the variable **signalErrors** you will have the percent of wrong bits that had been corrected in your frame output. After that if you output to a file and check with BitDisplay you will see something like this:

<div style="width: 1034px" class="wp-caption aligncenter">
  <img class="" src="https://i.imgur.com/IUd3ItLh.png" width="1024" />
  
  <p class="wp-caption-text">
    Decoded Frame View (cropped to the first bits only)
  </p>
</div>

The bitdisplay actually shows the 0 bits as white and 1 bits as black. So the overall perception is inverted. You can see the sync word pattern and just after that a pattern that looks like a counter. This counter is actually the frame counter. After that you can see a wide black bar and some small patterns on the right side of this bar. This is actually the 11 bit Virtual Channel ID. Since all channel IDs are usually lower than 64, most of the bits are 0.

Now if you strip the first 4 bytes of each 1024 byte frame, you will have a virtual channel frame from the satellite! In the next part I will show how to parse this frame data and extract the packets that will in the last chapter form our files. You can check my frame decoder code here:

<https://github.com/racerxdl/open-satellite-project/blob/225a36d4144c0fe0704eb50a8fbc428914f654c0/GOES/network/decoder_tcp.c>