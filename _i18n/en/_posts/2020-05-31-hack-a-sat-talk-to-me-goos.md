---
id: 46
title: Hack a Sat - Talk to me, Goose
date: 2020-05-31T19:02:00-03:00
author: Lucas Teske
layout: post
guid: https://medium.com/@lucasteske/hack-a-sat-talk-to-me-goose-531aac28783
permalink: /2020/05/hack-a-sat-talk-to-me-goose/
image: /assets/posts/medium/1_b23VUAe-7ZvnQF4MIZO73A.png
categories:
  - English
  - Hacking
  - Linux
  - CTF
  - SDR

tags:
  - Camera
  - Hacking
  - CTF
  - Hackasat
  - CTF Writeup
  - Satellite
  - XTCE

---
# Hack a Sat — Talk to me, Goose

The “Talk to me, Goose challenge” on Hackasat

This challenge is just after the “Can you hear me now?” challenge (see [Hack a Sat - Can you hear me now?](/2020/05/hack-a-sat-can-you-hear-me-now/) ). Now LaunchDotCom has a new Satellite called Carnac 2.0.

There are two attached files. The first one is the manual of the satellite in which we can see the onboard equipment:

![System Diagram of Carnac 2.0 Satellite](/assets/posts/medium/1_Yn5BggzZddP21yFopKx9PA.png)*System Diagram of Carnac 2.0 Satellite*

There is also a XTCE file in which the Telemetry Data looks the same as previous challenge, but now there is a Command Section which implies that we will need to send commands back to the satellite. If we connect to the telemetry server and run the bonus script form the previous challenge, we will see that is only transmitting EPS

![EPS Telemetry Data](/assets/posts/medium/1_QGRnvC2S4sj_gM_8HHvXGQ.png)*EPS Telemetry Data*

Also you can see that most of the equipments are off. The one that interest us is the FLAG_ENABLE which enables the FLAG Generator equipment to output our flag.

So I went directly to the XTCE to find a Enable Flag command that would toggle that. I found this section:

![EnableFLAG command](/assets/posts/medium/1_GgD477ihhBIjwsjG9yQReQ.png)*EnableFLAG command*

The logic is the same as applied for the previous flag, but now instead is for encoding a command and sending back to the satellite. We can assume we can send data back using the same connection we opened to the telemetry server. So I first created a encoder for the header:

```python
enableflag = {
  "c_version": 0,
  "c_type": 1,
  "c_sechd": 0,
  "c_gpflags": 3,
  "c_apid": 103,
  "c_ssc": 0,
  "c_plen": 2
}

def EncodeHeader():
  data = bytearray(b'\x00' * 6)
  data[0] = (enableflag["c_version"] << 5) + (enableflag["c_type"] << 4) + (enableflag["c_sechd"] << 3) + ((enableflag["c_apid"] >> 8) & 0x7)
  data[1] = enableflag["c_apid"] & 0xFF
  data[2] = (enableflag["c_gpflags"] << 6) + (enableflag["c_gpflags"] >> 8)
  data[3] = enableflag["c_ssc"] & 0xFF
  data[4] = (enableflag["c_plen"]) >> 8
  data[5] = (enableflag["c_plen"]) & 0xFF
  return data

```

Then the missing data would be 3 bytes:

* CMD => Which tells the command to execute
* PARAM => The command parameter
* PowerState => To enable the power

Since we would need to send data back, I decided to use the pwntools library ( see [http://docs.pwntools.com/en/stable/](http://docs.pwntools.com/en/stable/) ) and make a realtime decoder for the telemetry.

```python
from pwn import *

import sys, struct, binascii

from pprint import pprint


APID_FLAG_PACKET = 102
APID_EPS_PACKET = 103
APID_PAYLOAD_PACKET = 105

enableflag = {
  "c_version": 0,
  "c_type": 1,
  "c_sechd": 0,
  "c_gpflags": 3,
  "c_apid": 103,
  "c_ssc": 0,
  "c_plen": 2
}

def EncodeHeader():
  data = bytearray(b'\x00' * 6)
  data[0] = (enableflag["c_version"] << 5) + (enableflag["c_type"] << 4) + (enableflag["c_sechd"] << 3) + ((enableflag["c_apid"] >> 8) & 0x7)
  data[1] = enableflag["c_apid"] & 0xFF
  data[2] = (enableflag["c_gpflags"] << 6) + (enableflag["c_gpflags"] >> 8)
  data[3] = enableflag["c_ssc"] & 0xFF
  data[4] = (enableflag["c_plen"]) >> 8
  data[5] = (enableflag["c_plen"]) & 0xFF
  return data

def DecodeHeader(data):
  c_version = (data[0] & 0xE0) >> 5
  c_type = (data[0] & 0x10) >> 4
  c_sechd = (data[0] & 0x8) >> 3
  c_apid = ((data[0] & 0x7) << 8) + data[1]
  c_gpflags = (data[2] & 0xC0) >> 6
  c_ssc = ((data[2] & 0x3F) << 8) + data[3]
  c_plen = (data[4]<< 8) + (data[5])
  return c_version, c_type, c_sechd, c_apid, c_gpflags, c_ssc, c_plen

def DecodeFlag(data):
  bitstream = []
  for i in range(len(data)):
    for b in format(data[i], "08b"):
      bitstream.append(b)

  flagdata = ""

  while len(bitstream) > 0:
    b = ""
    for i in range(7):
      if len(bitstream) > i:
        b += bitstream[i]

    if b != "":
      flagdata += chr(int(b, 2))
    bitstream = bitstream[7:]

  return flagdata

def DecodeEPS(data):
  battemp = data[0:2]
  voltage = (struct.unpack(">H", data[2:4])[0])
  low_pwr_thresh = (struct.unpack(">H", data[4:6])[0])
  data = data[6:]

  LOW_PWR_MODE  = (data[0] & (1 << 0)) > 0
  BATT_HTR      = (data[0] & (1 << 1)) > 0
  PAYLOAD_PWR   = (data[0] & (1 << 2)) > 0
  FLAG_PWR      = (data[0] & (1 << 3)) > 0
  ADCS_PWR      = (data[0] & (1 << 4)) > 0
  RADIO1_PWR    = (data[0] & (1 << 5)) > 0
  RADIO2_PWR    = (data[0] & (1 << 6)) > 0

  data = data[1:]

  PAYLOAD_ENABLE = (data[0] & (1 << 0)) > 0
  FLAG_ENABLE    = (data[0] & (1 << 1)) > 0
  ADCS_ENABLE    = (data[0] & (1 << 2)) > 0
  RADIO1_ENABLE  = (data[0] & (1 << 3)) > 0
  RADIO2_ENABLE  = (data[0] & (1 << 4)) > 0

  data = data[1:]
  print(len(data))
  BAD_CMD_COUNT = struct.unpack(">I", data[:4])[0]

  return {
    "low_pwr_thresh": low_pwr_thresh,
    "voltage": voltage,
    "LOW_PWR_MODE": LOW_PWR_MODE,
    "BATT_HTR": BATT_HTR,
    "PAYLOAD_PWR": PAYLOAD_PWR,
    "FLAG_PWR": FLAG_PWR,
    "ADCS_PWR": ADCS_PWR,
    "RADIO1_PWR": RADIO1_PWR,
    "RADIO2_PWR": RADIO2_PWR,
    "PAYLOAD_ENABLE": PAYLOAD_ENABLE,
    "FLAG_ENABLE": FLAG_ENABLE,
    "ADCS_ENABLE": ADCS_ENABLE,
    "RADIO1_ENABLE": RADIO1_ENABLE,
    "RADIO2_ENABLE": RADIO2_ENABLE,
    "BAD_CMD_COUNT": BAD_CMD_COUNT,
  }


rv = remote("goose.satellitesabove.me", 5033)
rv.recvuntil(b"Ticket please:")
rv.send(b"ticket{delta76170foxtrot:GCOmAUq4Fz8K0PQ1qFpviGNJXkI0FmI2eIDZ9BB2EvbrZwD0EoKIt0af4wyrI0W7QA}\n")
v = rv.recvuntil(b"Telemetry Service running at ")
v = str(rv.recv(), encoding="utf8")

host, port = v.split(":")
port = int(port)

print("Connecting %s:%d" %(host, port))

r = remote(host, port)

data = b""

s = 0

while True:
  try:
    data = r.recv()
    print("Received %d bytes" %len(data))

    c_version, c_type, c_sechd, c_apid, c_gpflags, c_ssc, c_plen = DecodeHeader(data)
    data = data[6:]
    if c_apid == APID_FLAG_PACKET:
      flag = DecodeFlag(data)
      print("THE FLAG: %s" % flag)
    elif c_apid == APID_EPS_PACKET:
      print("EPS: ")
      eps = DecodeEPS(data)
      pprint(eps)
    else:
      print("GOT PACKET %d with LENGTH %d" %(c_apid, c_plen))
      print(binascii.hexlify(data))
  except Exception as e:
    print("ERROR: ", e)
    break

rv.close()
r.close()
```

If you see the code, I also implemented it to find which telemetry server to connect. So it basically connects to the main server, presents the ticket, gets the address of the telemetery server and then operates the telemetry server. I also let the EPS and FLAG decoder enabled on this one.

![Realtime Telemetry Decoding](/assets/posts/medium/1_J86N_zazHwBqairuHCIlgg.png)*Realtime Telemetry Decoding*

Then I made a function called SendEnables which would send data back to the satellite trying to enable the flag.

```python
def SendEnables():
  r.send(EncodeHeader() + b"\x00\x02\x01") # Payload

  # (...)
  while True:
  try:
    SendEnables()
    data = r.recv()
    # (...)
```

The first two bytes are the restriction imposed by the EnableFLAG command according to XTCE. The third byte represents the PowerState in which value 1 is for POWER ON state.

Sadly, that didn’t worked. The satellite seemed to be ignoring the command since the BAD_CMD_COUNT field wasn’t increasing. Then I started playing with other enables. I noticed that the voltage value was increasing every time I received a EPS packet. According to the doc this value is a two byte encoded float in some weird way.

![VoltageType definition](/assets/posts/medium/1_FJ_GNpNWFstomDCulVZs_w.png)*VoltageType definition*

I tried for a few hours to understand what that that meant. I couldn’t figure out so I just decoded as a uint16. I couldn’t figure out to calculate so I just assumed its a normal uint16 that would have direct correlation to voltage itself.

So I imagine that it was some sort of voltage related issue since when the voltage value reached the same value as LOW_POWER_THRESH the connection went off. So I decided to encode the command to send the LOW_POWER_THRESH change values.

![LOW_PWR_THRES command](/assets/posts/medium/1_ny8lIZj3RH0JmfHMkPrrhQ.png)*LOW_PWR_THRES command*

Since that would have PLENGTH =3, I did another function to create the header (yes, I was lazy).

```python
def EncodeHeader2():
  data = bytearray(b'\x00' * 6)
  data[0] = (enableflag["c_version"] << 5) + (enableflag["c_type"] << 4) + (enableflag["c_sechd"] << 3) + ((enableflag["c_apid"] >> 8) & 0x7)
  data[1] = enableflag["c_apid"] & 0xFF
  data[2] = (enableflag["c_gpflags"] << 6) + (enableflag["c_gpflags"] >> 8)
  data[3] = enableflag["c_ssc"] & 0xFF
  data[4] = (3) >> 8
  data[5] = (3) & 0xFF
  return data

# (...)
r.send(EncodeHeader2() + b"\x00\x0C" + struct.pack(">H", 1000)) # LW_PWR_THRES
```

And since I had no clue how to encode that, I send some random values (like 65535, 0, 32768). All of them were incrementing the BAD_CMD_COUNT which probably mean that I was not encoding valid values. So I decided a bruteforce approach to find out which values were valid.

Since it was slow, I decided to send 100 commands each time send enable was calculated.

```python
def SendEnables():
  global s
  print("Sending enable %d" % s)
  for i in range(100):
    r.send(EncodeHeader2() + b"\x00\x0C" + struct.pack(">H", s)) # LW_PWR_THRES
    s += 1
```

I was only expecting it to not increment the BAD_CMD_COUNT sometime, so I could find out the range of valid values. But after it reached 1200

![FLAG FOUND!](/assets/posts/medium/1_rbUMCcuP6CmzB1Dh1lqmxg.png)*FLAG FOUND!*

The flag poped out!

```
flag{delta76170foxtrot:GJiGsdjw9Kdc5UONnu06i42WeTMVNH1OzOKJTzIq6lJPbLCtb3AsRu2YUVGn-Slb2vnXh2vLC36D-xvKISAKD68}\x00\x19\x03\x00\x03@)L}
```

There was a very big moment of laugh in my team because of that (we were in discord and everyone was seeing my screen in that moment). That must not be a safe way to control a satellite :P

Full Script

```python

from pwn import *

import sys, struct, binascii

from pprint import pprint


APID_FLAG_PACKET = 102
APID_EPS_PACKET = 103
APID_PAYLOAD_PACKET = 105

enableflag = {
  "c_version": 0,
  "c_type": 1,
  "c_sechd": 0,
  "c_gpflags": 3,
  "c_apid": 103,
  "c_ssc": 0,
  "c_plen": 2
}

def EncodeHeader():
  data = bytearray(b'\x00' * 6)
  data[0] = (enableflag["c_version"] << 5) + (enableflag["c_type"] << 4) + (enableflag["c_sechd"] << 3) + ((enableflag["c_apid"] >> 8) & 0x7)
  data[1] = enableflag["c_apid"] & 0xFF
  data[2] = (enableflag["c_gpflags"] << 6) + (enableflag["c_gpflags"] >> 8)
  data[3] = enableflag["c_ssc"] & 0xFF
  data[4] = (enableflag["c_plen"]) >> 8
  data[5] = (enableflag["c_plen"]) & 0xFF
  return data

def EncodeHeader2():
  data = bytearray(b'\x00' * 6)
  data[0] = (enableflag["c_version"] << 5) + (enableflag["c_type"] << 4) + (enableflag["c_sechd"] << 3) + ((enableflag["c_apid"] >> 8) & 0x7)
  data[1] = enableflag["c_apid"] & 0xFF
  data[2] = (enableflag["c_gpflags"] << 6) + (enableflag["c_gpflags"] >> 8)
  data[3] = enableflag["c_ssc"] & 0xFF
  data[4] = (3) >> 8
  data[5] = (3) & 0xFF
  return data


def DecodeHeader(data):
  c_version = (data[0] & 0xE0) >> 5
  c_type = (data[0] & 0x10) >> 4
  c_sechd = (data[0] & 0x8) >> 3
  c_apid = ((data[0] & 0x7) << 8) + data[1]
  c_gpflags = (data[2] & 0xC0) >> 6
  c_ssc = ((data[2] & 0x3F) << 8) + data[3]
  c_plen = (data[4]<< 8) + (data[5])
  return c_version, c_type, c_sechd, c_apid, c_gpflags, c_ssc, c_plen

def DecodeFlag(data):
  bitstream = []
  for i in range(len(data)):
    for b in format(data[i], "08b"):
      bitstream.append(b)

  flagdata = ""

  while len(bitstream) > 0:
    b = ""
    for i in range(7):
      if len(bitstream) > i:
        b += bitstream[i]

    if b != "":
      flagdata += chr(int(b, 2))
    bitstream = bitstream[7:]

  return flagdata

def DecodeEPS(data):
  battemp = data[0:2]
  voltage = (struct.unpack(">H", data[2:4])[0])
  low_pwr_thresh = (struct.unpack(">H", data[4:6])[0])
  data = data[6:]

  LOW_PWR_MODE  = (data[0] & (1 << 0)) > 0
  BATT_HTR      = (data[0] & (1 << 1)) > 0
  PAYLOAD_PWR   = (data[0] & (1 << 2)) > 0
  FLAG_PWR      = (data[0] & (1 << 3)) > 0
  ADCS_PWR      = (data[0] & (1 << 4)) > 0
  RADIO1_PWR    = (data[0] & (1 << 5)) > 0
  RADIO2_PWR    = (data[0] & (1 << 6)) > 0

  data = data[1:]

  PAYLOAD_ENABLE = (data[0] & (1 << 0)) > 0
  FLAG_ENABLE    = (data[0] & (1 << 1)) > 0
  ADCS_ENABLE    = (data[0] & (1 << 2)) > 0
  RADIO1_ENABLE  = (data[0] & (1 << 3)) > 0
  RADIO2_ENABLE  = (data[0] & (1 << 4)) > 0

  data = data[1:]
  print(len(data))
  BAD_CMD_COUNT = struct.unpack(">I", data[:4])[0]

  return {
    "low_pwr_thresh": low_pwr_thresh,
    "voltage": voltage,
    "LOW_PWR_MODE": LOW_PWR_MODE,
    "BATT_HTR": BATT_HTR,
    "PAYLOAD_PWR": PAYLOAD_PWR,
    "FLAG_PWR": FLAG_PWR,
    "ADCS_PWR": ADCS_PWR,
    "RADIO1_PWR": RADIO1_PWR,
    "RADIO2_PWR": RADIO2_PWR,
    "PAYLOAD_ENABLE": PAYLOAD_ENABLE,
    "FLAG_ENABLE": FLAG_ENABLE,
    "ADCS_ENABLE": ADCS_ENABLE,
    "RADIO1_ENABLE": RADIO1_ENABLE,
    "RADIO2_ENABLE": RADIO2_ENABLE,
    "BAD_CMD_COUNT": BAD_CMD_COUNT,
  }


rv = remote("goose.satellitesabove.me", 5033)
rv.recvuntil(b"Ticket please:")
rv.send(b"ticket{delta76170foxtrot:GCOmAUq4Fz8K0PQ1qFpviGNJXkI0FmI2eIDZ9BB2EvbrZwD0EoKIt0af4wyrI0W7QA}\n")
v = rv.recvuntil(b"Telemetry Service running at ")
v = str(rv.recv(), encoding="utf8")

host, port = v.split(":")
port = int(port)

print("Connecting %s:%d" %(host, port))

r = remote(host, port)

data = b""

s = 0

def SendEnables():
  global s
  print("Sending enable %d" % s)
  for i in range(100):
    r.send(EncodeHeader2() + b"\x00\x0C" + struct.pack(">H", s)) # LW_PWR_THRES
    s += 1


while True:
  try:
    SendEnables()
    data = r.recv()
    # data += chunk
    print("Received %d bytes" %len(data))

    c_version, c_type, c_sechd, c_apid, c_gpflags, c_ssc, c_plen = DecodeHeader(data)
    data = data[6:]
    if c_apid == APID_FLAG_PACKET:
      flag = DecodeFlag(data)
      print("THE FLAG: %s" % flag)
    elif c_apid == APID_EPS_PACKET:
      print("EPS: ")
      eps = DecodeEPS(data)
      pprint(eps)
      if eps["RADIO2_ENABLE"] == True:
        r.send(EncodeHeader() + b"\x00\x02\x01") # Flag
    else:
      print("GOT PACKET %d with LENGTH %d" %(c_apid, c_plen))
      print(binascii.hexlify(data))
    # data = data[c_plen+1:]
  except Exception as e:
    print("ERROR: ", e)
    break

rv.close()
r.close()
```