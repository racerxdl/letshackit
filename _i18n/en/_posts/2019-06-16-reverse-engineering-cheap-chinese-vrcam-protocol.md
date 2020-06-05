---
id: 39
title: Reverse Engineering cheap chinese "VRCAM" protocol
date: 2019-06-16T12:00:00-03:00
author: Lucas Teske
layout: post
guid: https://medium.com/@lucasteske/reverse-engineering-cheap-chinese-vrcam-protocol-515c37a9c954
permalink: /2019/06/reverse-engineering-cheap-chinese-vrcam-protocol/
image: /assets/posts/medium/0*5_jc2oOyiJRbfezD.jpg
categories:
  - English
  - Camera
  - Hacking
tags:
  - Camera
  - Hacking
  - English
---

# Reverse Engineering cheap chinese "VRCAM" protocol

That’s not the first time I get a Chinese hardware that has some proprietary protocol that does not follow a single standard. It’s funny because when you get a VERY cheap thing, you expect to use many standards as possible to reduce the development cost, but some chinese developers just want to do it yourselves.

I present you the "VRCAM" and it’s SOUP protocol (any relation to SOAP is just a mere coincidence :P)

![VRCAM](/assets/posts/medium/0*5_jc2oOyiJRbfezD.jpg)

## The Hardware

Let’s first start with the hardware itself. It’s a 2 Megapixel sensor with 1280x960 video resolution. It features 3 IR Lamps (same model as the raspberry cam), has bidirectional audio (you can send audio to the camera, and receive it from it). It supports both wifi and ethernet connections and features a "Auto PTZ" (which is just a software remapping of the image). It is very cheap (in local brazillian market you can find it for R$90 which is US$23, consider that usually things has a 60% tax over it, and you will see how cheap that is) and as always I wanted to give a try.

Inside, the camera has two boards: A main board and a secondary Wifi / SD board.

![The main board](/assets/posts/medium/0*5TFe884bl2lS08Ug.jpg)*The main board*

![The secondary board](/assets/posts/medium/0*39EiCjbgxvq_Vwcn.jpg)*The secondary board*

The WiFi chip is a RTL8188, which is a nice USB Wireless adapter.

![RTL8188FTV](/assets/posts/medium/1*lnaX3dIFByoBYHJ8J8QzFg.png)*RTL8188FTV*

In the mainboard we have the main processor which is a Anyka AK3918 which is a 400MHz ARM9 processor with embedded DDR2 RAM. It is a specific IP Camera SoC and it has Hardware accelerators for: MP3,Wav, Speex, H264 and MJPEG.

![](/assets/posts/medium/1*joj8o9rxsVzQpoXv_JFkBQ.png)

The back of that board has a painted chip (probably to hide which is the real model of the chip) which just looks like a normal regulator.

![](/assets/posts/medium/1*Rna323ta1jYKck0-Uh37Cg.png)

So you can see that there is also a TX/RX/GND marking over there, which is the label for three pins mostly below the camera packaging. And yeah you guessed right: its the debug serial port. Sadly there is not much that it outputs from it:

![](/assets/posts/medium/1*9kFM1kpoIMg0LgDCAgRrYw.png)

So long story short: That’s basically a Bananna Pi camera ([http://www.banana-pi.org/d1.html](http://www.banana-pi.org/d1.html)) which some custom board. That’s make sense since its a very cheap camera, they wouldn’t bother making something from scratch. But still it does not make sense creating a new whole non standard protocol for that.

## Let’s find out what it does

The first thing I wanted to try is to reverse the VRCAM android application ([https://play.google.com/store/apps/details?id=com.generalcomp.vrcam](https://play.google.com/store/apps/details?id=com.generalcomp.vrcam)). Java applications are usually easy to decompile and reverse engineer, and even if it does have native libraries, developers are usually lazy to obfuscate them. The issue is that specifically the VRCAM developer was too damn lazy and included TOO many libraries inside the application. That should give you a rough idea (there are more folders):

![Huawei + Xiaomi + Amazon + Aliplay + Alibaba. WTH?](/assets/posts/medium/1*H_qbyxw2mc44mp356pGMhg.png)*Huawei + Xiaomi + Amazon + Aliplay + Alibaba. WTH?*

This quickly seemed a very bad application to reverse engineer. Also most of the protocol itself was inside some native libraries. So I decided to go the other way and sniff everything first. IP Cameras usually lack any type of crypto and sends everything plain text. The few ones that doesn’t, negotiate a static AES/DES key in plain text which can be caught by the sniffer.

To do the sniffing, I did what I usually did when one of the endpoints is wireless: Used my Ubiquiti Unifi.

Some people really don’t know how usefull a linux wifi router is, and Ubiquiti was nice enough to embed a tcpdump inside the Unifi firmware. This allows me to do this in my laptop:

```bash
ssh admin@10.10.5.150 -C tcpdump -i ath4 -s 65535 -w — | wireshark -k -i -
```

That spawns a tcpdump in my unifi and pipes the tcpdump output to a wireshark running in my machine. The thing is that since one of the ends is on wifi (in this case my phone), unifi sees everything.

The first thing I want to do is to check which IP phone got in the DHCP leases. The IP is 10.10.5.151.

Then since everything is flowing through that unifi (including my laptop) I created the following filter in Wireshark:
```pcap
ip.addr == 10.10.5.151
```

So anything that goes from/to 10.10.5.151 will be shown. Otherwise it will filter out. Also there is a lot of useless packets (for us) so we need to filter these out, also added the camera IP 10.10.5.131

```pcap
(ip.addr == 10.10.5.151 || ip.addr == 10.10.5.123) and !igmp and !mdns
```

![](/assets/posts/medium/1*gEiM0kWk4c0elMc9GDRpYg.png)

Bingo! Got some packets. The interesting part is the first 4 UDP packets. Since in the VRCAM software you never setup what’s the camera IP it should has some way to find the cameras in the network. So I was expecting some sort of broadcast with the cameras answering directly to the host, and guess what we got? The phone did a UDP broadcast in port 9014 (also 9015, but let’s see 9014 first) with the following payload
```xml
<SOUP version="1.1"><Discover eseeid="1580470229" remote_playback="" remote_setup=""/>
</SOUP>
```
To be honest I couldn’t stop laugh when I saw the **SOUP** and the **SOAP** like syntax. Do the developer of this protocol though SOUP is also a type of SOAP?

Jokes a part, when my phone sent that request, it received back a UDP packet with the following content:
```xml
<SOUP version="1.1">
 <Discover eseeid="1580470229" ch="1" version="2.5.47.0+0.7.73" vendor="JUAN@GZ" remote_playback="true" remote_setup="true" >
 <transfer name="udx" version="1.0" port="0" />
 <transfer name="ltcp" version="1.0" port="64444" />
 </Discover>
</SOUP>
```

It reports two transfers *udx and ltcp*. I have no idea what those two are, but LTCP specify a port in which we have some packets later. So to be easier, let’s change the wireshark filter a bit:
```pcap
tcp.port == 64444 and tcp.len > 0
```

This way we will see any packet that has a content (a.k.a. not signaling packet) and flows through port 64444.

Let’s analyze the first packets:

```
0000   4c 54 43 50 00 00 00 7a                           LTCP...z

0000   3c 53 4f 55 50 20 76 65 72 73 69 6f 6e 3d 22 31   <SOUP version="1
0010   2e 30 22 3e 3c 61 75 74 68 20 75 73 72 3d 22 61   .0"><auth usr="a
0020   64 6d 69 6e 22 20 70 73 77 3d 22 61 64 6d 69 6e   dmin" psw="admin
0030   22 20 65 73 65 65 69 64 3d 22 22 20 6e 61 74 3d   " eseeid="" nat=
0040   22 73 79 6d 6d 65 74 72 69 63 22 20 63 6c 69 65   "symmetric" clie
0050   6e 74 3d 22 22 20 69 6d 65 69 3d 22 22 20 69 73   nt="" imei="" is
0060   70 3d 22 22 20 62 75 64 64 6c 65 69 64 3d 22 22   p="" buddleid=""
0070   2f 3e 3c 2f 53 4f 55 50 3e 00                     /></SOUP>.
```

So that look pretty simple. There is a LTCP and then 4 bytes. These 4 bytes has 0x7A inside it which I would say its a uint32 representing a size of a packet. In decimal that’s 122, which is the length of the content in the next packet.

Since TCP is a streaming protocol, any data you send can be segmented into several packets, the developer of the protocol probably made that "protocol wrapper" to make it easier to manage the packet contents.

And again we se a SOUP packet, and guess what? A login packet.
```xml
<SOUP version="1.0"><auth usr="admin" psw="admin" eseeid="" nat="symmetric" client="" imei="" isp="" buddleid=""/></SOUP>
```

Even though the LTCP specifies a size, the strings are null terminated.

So since it looks like that’s the LTCP protocol, I will be refering everything as the LTCP content. But before that, let’s make a simple python snippet that can Read / Send packets in LTCP:

```python
#!/usr/bin/env python

import socket, struct, os, binascii

UOS = "\xFFUOS"

HOST = '10.10.5.123'     # Camera IP Address
PORT = 64444             # Camera Port
tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
dest = (HOST, PORT)
print "Connecting to %s:%s" %dest
tcp.connect(dest)
print "Connected"

def ReadNBytes(n):
  buff = ""
  while len(buff) != n:
    buff += tcp.recv(n-len(buff))

  return buff

def ReadPacket():
  o = tcp.recv(8)
  if not o[:4] == "LTCP":
    print "Packet not LTCP"
    exit(1)
  s = struct.unpack(">I", o[4:])[0]
  data = ReadNBytes(s)
  return data

def SendPacket(data):
  print ">>>> Sending %s" %data
  s = struct.pack(">I", len(data))
  data = "LTCP" + s + data
  tcp.send(data)

SendPacket('<SOUP version="1.0"><auth usr="admin" psw="admin" eseeid="" nat="symmetric" client="" imei="" isp="" buddleid=""/></SOUP>\x00')

d = ReadPacket()
print "Received %s: "%d
```

That should do the job. Whenever you want to send something just call SendPacket and when you want to receive, just call ReadPacket.

## The Protocol

When the phone sends the login packet, it sends back a SOUP packet with the result of the login. In case of success
```xml
<SOUP version="1.0"><auth usr="admin" psw="admin" error="0"/></SOUP>
```

In case of failure:
```xml
<SOUP version="1.0"><auth usr="admin" psw="admin2" error="2"/></SOUP>
```

After that it does a sort of channel creation:
```xml
<SOUP version="1.1"><vcon cmd="create" id="1478658439" app="RemoteSetup" /></SOUP>
```

And after that … did you though the SOUP was far enough? Now check this:
```xml
<SOUP version="1.1"><vcon cmd="data" id="1478658439" length="500"/></SOUP>\x00{"Version":"1.0.0","Method":"get","IPCam":{"DeviceInfo":{},"ModeSetting":{},"AlarmSetting":{"MotionDetection":{},"MessagePushSchedule":[]},"SystemOperation":{"TimeSync":{},"DaylightSavingTime":{"Week":[{},{}]}},"PromptSounds":{},"ChannelStatus":[{}],"ChannelInfo":[{"Channel":0,"Model":"","Version":""}],"ledPwm":{"channelInfo":[]},"TfcardManager":{},"OsscloudSetting":{},"WirelessManager":{},"ptzManager":{}},"CapabilitySet":{},"Authorization":{"Verify":"","username":"admin","password":"admin"}}
```

A SOUP of of SOAP+JSON! Ba-dum-tss! When the device sends that to the camera, the camera answer with the {} replaced with the parameters:
```xml
<SOUP version="1.1"><vcon cmd="data" id="1908742553" length="1318"/></SOUP>\x00{ "Version": "1.0.0", "Method": "get", "IPCam": { "DeviceInfo": { "FWVersion": "2.5.47.0", "Model": "P2", "ID": "F3811580470229", "OEMNumber": "391807", "FWMagic": "SlVBTiBBSzM5MThFVjIwMCBQWC1YLUEgRklSTVdBUkUgQ09QWVJJR0hUIEJZIEpVQU4=" }, "ModeSetting": { "AudioEnabled": true, "SceneMode": "auto", "Definition": "BD", "ConvenientSetting": "outside", "IRCutFilterMode": "auto" }, "AlarmSetting": { "MotionDetection": { "Enabled": true, "SensitivityLevel": "low" }, "MessagePushSchedule": [ { "Weekday": "0,1,2,3,4,5,6", "BeginTime": "00:00:00", "EndTime": "23:59:59", "id": 0 } ], "MessagePushEnabled": true, "ScheduleSupport": true }, "SystemOperation": { "TimeSync": { "LocalTime": "", "UTCTime": "1560696269", "TimeZone": -300 }, "DaylightSavingTime": { "Week": [ { }, { } ] } }, "PromptSounds": { "Enabled": true, "Type": "portuguese", "TypeOption": [ "chinese", "english", "german", "russian", "korean", "spanish", "portuguese" ] }, "ChannelStatus": [ { } ], "ChannelInfo": [ { "Channel": 0, "Model": "", "Version": "" } ], "ledPwm": { "channelInfo": [ ] }, "TfcardManager": { "Operation": "format", "Status": "no_tfcard", "ScheduleSupport": false }, "OsscloudSetting": { }, "WirelessManager": { }, "ptzManager": { } }, "CapabilitySet": { }, "Authorization": { "Verify": "", "username": "admin", "password": "" } }
```

And guess what’s inside the FWMagic?
```
JUAN AK3918EV200 PX-X-A FIRMWARE COPYRIGHT BY JUAN
```

So let’s skip to the interesting part: Getting the video. That’s done by setting up a video channel.

## Setting up the video channel

That’s pretty simple tough, after authenticating in the channel you can just send:
```xml
<SOUP version="1.0"><streamreq ch="vin0" stream="stream0" opt="start"/></SOUP>
```

The camera should answer with the following payload and start streaming:
```xml
<SOUP version="1.0"><streamreq ch="vin0" stream="stream0" opt="start" cam_des="P2"/></SOUP>
```

It worth notice that it streams in LTCP format, so we need to unpack it as well.

Some of the packets start with a UOS mark which I’m not really sure what it is, but if we just skip that 4 bytes with UOS everything should be great. So here is a python script that outputs to a file:

```python
#!/usr/bin/env python


import socket, struct, os, binascii

UOS = "\xFFUOS"

HOST = '10.10.5.123'     # Endereco IP do Servidor
PORT = 64444            # Porta que o Servidor esta
tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
dest = (HOST, PORT)
print "Connecting to %s:%s" %dest
tcp.connect(dest)
print "Connected"

def ReadNBytes(n):
  buff = ""
  while len(buff) != n:
    buff += tcp.recv(n-len(buff))

  return buff

def ReadPacket():
  o = tcp.recv(8)
  if not o[:4] == "LTCP":
    print "Packet not LTCP"
    exit(1)
  s = struct.unpack(">I", o[4:])[0]
  data = ReadNBytes(s)
  return data

def SendPacket(data):
  print ">>>> Sending %s" %data
  s = struct.pack(">I", len(data))
  data = "LTCP" + s + data
  tcp.send(data)


SendPacket('<SOUP version="1.0"><auth usr="admin" psw="admin" eseeid="" nat="symmetric" client="" imei="" isp="" buddleid=""/></SOUP>\x00')

d = ReadPacket()
print "Received %s: "%d

SendPacket('<SOUP version="1.0"><streamreq ch="vin0" stream="stream0" opt="start"/></SOUP>\x00')

d = ReadPacket()
print "<<<< Received %s: "%d

f264 = open("test.264", "wb")

print "Receiving"
while True:
  d = ReadPacket()
  if d[:4] == UOS:
    d = d[4:]
  f264.write(d)

f264.close()
```

Then ffplay should be able to open it:

![H264 Stream Video](/assets/posts/medium/1*bwLRxu2AvUyBzf-LB5RtDw.png)

Also a variant of that script that works in pipe:

```python
#!/usr/bin/env python


import socket, struct, os, binascii, sys

UOS = "\xFFUOS"

HOST = '10.10.5.123'     # Endereco IP do Servidor
PORT = 64444            # Porta que o Servidor esta
tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
dest = (HOST, PORT)
tcp.connect(dest)

def ReadNBytes(n):
  buff = ""
  while len(buff) != n:
    buff += tcp.recv(n-len(buff))

  return buff

def ReadPacket():
  o = tcp.recv(8)
  if not o[:4] == "LTCP":
    exit(1)
  s = struct.unpack(">I", o[4:])[0]
  data = ReadNBytes(s)
  return data

def SendPacket(data):
  s = struct.pack(">I", len(data))
  data = "LTCP" + s + data
  tcp.send(data)


SendPacket('<SOUP version="1.0"><auth usr="admin" psw="admin" eseeid="" nat="symmetric" client="" imei="" isp="" buddleid=""/></SOUP>\x00')
ReadPacket()
SendPacket('<SOUP version="1.0"><streamreq ch="vin0" stream="stream0" opt="start"/></SOUP>\x00')
ReadPacket()

# print "Receiving"
while True:
  d = ReadPacket()
  if d[:4] == UOS:
    d = d[4:]
  sys.stdout.write(d)
  sys.stdout.flush()
```

Which can be ran like this:
```bash
python receive-stream.py | ffplay -f h264 -
```

After all of that I have no clue what would make someone create such horrible protocol for a commercial product. Why not just follow standards? The AK3918 SDK has a RTSP example which a nice configuration page. What the HELL was the developer was thinking when doing that? Obfuscating stuff? I’m pretty sure he failed in that too. And the bad thing is that I saw few bunch of cameras that uses the same protocol.

The next post here will be about Cameras / DVR from the Brazillian company Intelbras ([https://www.intelbras.com/pt-br/](https://www.intelbras.com/pt-br/)) which claims to have a own proprietary protocol named Intelbras-1 (Spoiler alert: is not theirs).

See you next time!
