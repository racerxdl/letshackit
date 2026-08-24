---
title: "Home | Lets Hack It"
description: "Lets Hack It June 14, 2020 Hacking a ESP32 into FPGA Board Hacking a ESP32 into FPGA Board Colorlight Hub 5A-75B V6.1 Board Last year I saw a russian guy that found out that this cheap board (US$15~) had an Lattice ECP5 FPGA, which is compatible with Open Source Tool-chains..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Lets Hack It
  

June 14, 2020
## [Hacking a ESP32 into FPGA Board](/2020/06/hacking-a-esp32-into-fpga-board)

 ![Green circuit board with multiple black connectors, USB port, and labeled components.](/assets/posts/medium/1_ALnLx9L06FSciqeEV5OCuQ.png)

Hacking a ESP32 into FPGA Board Colorlight Hub 5A-75B V6.1 Board Last year I saw a russian guy that found out that this cheap board (US$15~) had an Lattice ECP5 FPGA, which is compatible with Open Source Tool-chains for synthesis. He was running a RISC-V Core inside that and piping the serial through the ethernet ports. I wanted to get one and start playing by myself. These boards are relatively cheap, about US$15 and contains a Lattice ECP5 FPGA ( LFE5U-25F-6BG381C ), 4MB DRAM, Two Gigabit Ethernet and several level shifters for I/O. This is good because: That’s a very...

May 31, 2020
## [Hack a Sat - Talk to me, Goose](/2020/05/hack-a-sat-talk-to-me-goose/)

 ![Black screen with white text describing a cybersecurity challenge involving a satellite and flag submission.](/assets/posts/medium/1_b23VUAe-7ZvnQF4MIZO73A.png)

Hack a Sat — Talk to me, Goose The “Talk to me, Goose challenge” on Hackasat This challenge is just after the “Can you hear me now?” challenge (see Hack a Sat - Can you hear me now? ). Now LaunchDotCom has a new Satellite called Carnac 2.0. There are two attached files. The first one is the manual of the satellite in which we can see the onboard equipment: System Diagram of Carnac 2.0 Satellite There is also a XTCE file in which the Telemetry Data looks the same as previous challenge, but now there is a Command Section which implies...

May 30, 2020
## [Hack a Sat - Phasors to Stun](/2020/05/hack-a-sat-phasors-to-stun/)

 ![Black screen with white text describing a CTF challenge about demodulating SDR data to find a flag.](/assets/posts/medium/1_R1n7vaNfInOP6BCFXkjv1Q.png)

Hack a sat  —  Phasors to Stun The challenge I got really excited about it because it’s a SDR one. And everyone that knows me know that I love SDR stuff. The zip file itself contains a wav file which they told us is not an audio but an radio signal File command to show what the wave file is If we open in audacity we will see a very interesting pattern: Audacity view of the wave file That looks like a 2-FSK demodulated file (see https://en.wikipedia.org/wiki/Frequency-shift\_keying). When you demodulate a 2-FSK I/Q from correctly from a Radio, it will...

May 30, 2020
## [Hack a Sat - Can you hear me now?](/2020/05/hack-a-sat-can-you-hear-me-now/)

 ![Black screen with white text describing a satellite telemetry decoding challenge.](/assets/posts/medium/1_87tDTK5_FodI9TghHRpznQ.png)

Hack-a-sat — Can you hear me now? That challenge asked us to decode a Telemetry data that was being sent over a TCP port. If you open the netcat, the following happen: Then if you connect to the Telemetry Service using netcat: In the provided zip file there is a telemetry.xtce file which is a XML file that tells us how the binary packet is encoded. A quick search over the internet lead me to the Wikipedia: https://en.wikipedia.org/wiki/XML\_Telemetric\_and\_Command\_Exchange It is defined in the CCSDS Green Book (the spec https://public.ccsds.org/Pubs/660x0g1.pdf ) The file has several sections. I will describe a few of them:...

December 30, 2019
## [Integrating Hacked Touch Panel into Home Assistant](/2019/12/integrating-hacked-touch-panel-into-home-assistant/)

 ![Touch panel controls for Lucas's bedroom, showing four options with status indicators.](/assets/posts/medium/1_hBwbHXERpWD5N8ZGqqlXMw.png)

Integrating Hacked Touch Panel into Home Assistant In the previous article I showed a simple hack of a chinese Touch Panel. Now I have successfully integrated it Home Assistant and I’m able to turn my room light on / off. Here is how. From now on I will assume you have ESPHome working on your machine and Home Assistant configured. ESPHome is very easy to install if you have python pip: pip install esphome Should install everything you need. First let’s create our project. I will call it touchpanel.yml: esphome: # Change it for any name you want. This is...
