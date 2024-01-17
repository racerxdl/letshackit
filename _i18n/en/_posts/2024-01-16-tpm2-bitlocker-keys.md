---
title: 'TPM 2.0: Extracting Bitlocker keys through SPI'
date: 2024-01-16T20:48:00-03:00
author: Lucas Teske
layout: post
image: /assets/gepeto/tpm2.0.jpg
categories:
  - Reverse Engineering
  - Satellite
  - SDR
tags:
  - Flash
  - PAX
  - Hardware Hacking
  - RE
  - Reverse Engineering
  - NAND
  - PAX
  - RT809H

---

The TPM 2.0, also known as Trusted Platform Module 2.0, is a hardware security feature embedded in many modern computers. Its purpose is to provide a secure way to store cryptographic keys and other sensitive data, such as passwords and digital certificates, aiming to protect against various security threats, including unauthorized access to a computer's hardware and software. TPM 2.0 represents an evolution of the original TPM specification, developed by the Trusted Computing Group (TCG), and features additional capabilities and resources, such as support for additional cryptographic algorithms and the ability to store larger amounts of data.

### Good Things

Currently, the Trusted Platform Module (TPM) is widely used by Full Disk Encryption (FDE) mechanisms and also by specific device encryption, as it is usually linked to the device (soldered on the motherboard).

It is noteworthy that, besides being an advanced security feature in modern machines, the communication protocol used by TPM Integrated Circuits (ICs) is quite simple. Generally, TPM ICs use the Serial Peripheral Interface (SPI) communication protocol, but they can also use the Low Pin Count (LPC) and Inter-Integrated Circuit (I2C) protocols. An important issue to raise is that users generally trust the TPM as a reliable security measure, however, bus traffic is often transmitted in plain text. For example, after the TPM is unlocked, the Windows Bitlocker key is transmitted in plain text on the bus.

For this article, the assumptions and analyses are based on the 2.0 specification, version 1.03v22 of the TPM (as of the current article date, the most used specification in home computers and servers), which is available here: [https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf](https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf)

Furthermore, it is important to mention that this article is based on two other articles, which can be found at the following links:

[https://labs.withsecure.com/publications/sniff-there-leaks-my-bitlocker-key](https://labs.withsecure.com/publications/sniff-there-leaks-my-bitlocker-key)

[https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network](https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network)

It should be noted that, to date, the applied knowledge has successfully allowed the extraction of a Bitlocker key in a real scenario.

### TPM SPI Transaction

A Trusted Platform Module (TPM) transaction through the Serial Peripheral Interface (SPI) protocol is a series of operations performed by a TPM device. These operations typically include TPM initialization, creation and management of cryptographic keys, and execution of cryptographic operations such as encryption and signing.

A common example of TPM usage is to protect the encryption keys of a system, allowing the system to boot only if the TPM permits after a series of security checks. Another example is creating a secure connection with another device by generating a unique key pair, storing the private key in the TPM, and sharing the public key with the other device.

TPM device transactions are usually executed by interacting with a TPM device driver, which is software that communicates with the TPM device and manages its operations. TPM device transactions are typically governed by the Application Programming Interface (API) of the TPM2.0 library.

There are various types of transactions that can be analyzed through SPI, but for the purpose of recovering Bitlocker keys, only two are relevant: FIFO Write and FIFO Read. Focusing on these two operations is necessary to access the Volume Master Key (VMK), which is responsible for encrypting the AES256-XTS key.

The VMK is encrypted by the TPM and stored in the Bitlocker header of the target disk. During the boot process, the Windows bootloader retrieves the encrypted VMK from the Bitlocker header and sends it to the TPM as a decryption request. The TPM then sends back the decrypted version of the VMK, assuming the TPM is correctly configured and all security checks have been passed. The outcome of the decryption process depends on the TPM configuration.

In systems with complete secure boot, the TPM requires multiple hashes to be correctly initialized during the early stages of the boot process. The specific details of this process are beyond the scope of this explanation, but it is important to note that each step of the system's boot process hashes the next step and loads it into the TPM. For example, the first step is a bootrom inside the CPU that checks the signature of the first stage of the BIOS.


### Intercepting the TPM

The Trusted Platform Module (TPM) chip is usually located on a motherboard in a way that is not easily accessible, for example, on the keyboard side of a laptop. However, since the Serial Peripheral Interface (SPI) is a bus protocol, it can be inferred that all SPI devices on the motherboard use the same clock and data lines. As a result, it is possible to connect a logic analyzer to the SPI flash memory storing the BIOS/UEFI code and monitor any SPI transactions that occur when the flash memory is inactive (when the chip select signal for the flash memory is low). This approach allows for detecting the relevant transactions to recover Bitlocker keys.
![](/assets/posts/patreon/Pasted image 20230124034954.png)
![](/assets/posts/patreon/Pasted image 20230124035004.png)

This method, however, can lead to potential complications if there are other devices connected to the same SPI bus, besides the SPI flash memory and the TPM. Although it is relatively unlikely that multiple devices are connected to the same bus in this context.

In pulseview, we can analyze the SPI bytes using the SPI decoder function.
![](/assets/posts/patreon/Pasted image 20230124035010.png)
![](/assets/posts/patreon/Pasted image 20230124035020.png)

Next, we need to set up the SPI decoder for the correct signals to be able to see the decoded bytes.
![](/assets/posts/patreon/Pasted image 20230124035029.png)

Then, you will notice that, as we leave the CS# polarity field as "**active-low**", it is decoding only the BIOS Flash transactions, not the "rest" of the bus.
![](/assets/posts/patreon/Pasted image 20230124035036.png)

If we select "**active-high**", we will analyze anything that is **not** BIOS flash (which is what we want):
![](/assets/posts/patreon/Pasted image 20230124035040.png)

Now we have analyzed bytes for the SPI, which makes it easier for us to work with them. Now we need to create a sigrok plugin to analyze it.


### Analyzing TPM in Sigrok / Pulseview

Creating a Sigrok plugin is a straightforward process, thanks to the detailed official guide available on the Sigrok website at [https://sigrok.org/wiki/Protocol_decoder_HOWTO](https://sigrok.org/wiki/Protocol_decoder_HOWTO). Given that we are working with the Serial Peripheral Interface (SPI) protocol, it is appropriate to use Sigrok's "Stacked Decoder" functionality, which allows chaining multiple decoders and using the output of one decoder as input for another. This approach simplifies the process, eliminating the need to manually locate and extract individual bits of data from the raw SPI data and allows focusing on the actual formed bytes produced by the Sigrok SPI decoder.

To start, you need to create a "tpmdecoder" folder in the plugins directory (on Linux, it's located at ~/.local/share/libsigrokdecode/decoders/), with the following files attached to this post:

-   **init**.py
-   pd.py

These are the necessary files for the decoder that was developed. Basically, a decoder for the TPM registers was created, as described in [https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf](https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf)

After creating and saving the PulseView project, you need to close and reopen it. The plugin should be loaded automatically. In the SPI plugin settings, in the "Stacked Decoder" option, the "TPM2.0" option should be available.
![](/assets/posts/patreon/Pasted image 20230124035119.png)
And after selecting, it will start to try to find TPM2.0 messages over the SPI data. ![](/assets/posts/patreon/Pasted image 20230124035129.png)

### Bitlocker Key

For this section, it is highly recommended to check out the [libbde](https://github.com/libyal/libbde/blob/main/documentation/BitLocker%20Drive%20Encryption%20(BDE)%20format.asciidoc) documentation on GitHub. The documentation contains almost all (if not all) information related to Bitlocker, including legacy versions.

The key we want to recover is actually the Bitlocker Volume Master Key, which has a specific format. We can use a regular expression to recover this key instead of trying to understand each request, which would take more time to create a decoder.

The data that is actually encrypted by the TPM is an FVE metadata entry, as described in section [5.3 of libbde](https://github.com/libyal/libbde/blob/main/documentation/BitLocker%20Drive%20Encryption%20(BDE)%20format.asciidoc#53-fve-metadata-entry). This presents some headers that can be matched with a regular expression.

```
2C000[0-6]000[1-9]000[0-1]000[0-5]200000(\w{64})
```


After all the header, the Volume Master Key (VMK) is concatenated. To find the key, just look for 64 characters (32 bytes, which corresponds to a 256-bit key).

To facilitate use, the attached decoder prints the found keys in the decoding terminal (so it is not necessary to use the PulseView interface, if not desired) and also shows in a separate line in PulseView.
![](/assets/posts/patreon/Pasted image 20230124035206.png)

### Accessing Data Using the Downloaded VMK

To access data encrypted by Bitlocker, we will use the dislocker project ([https://github.com/Aorimn/dislocker](https://github.com/Aorimn/dislocker)) to mount the partition as plain text. Before that, it is necessary to save the entire key as a file:


```bash
echo "66D96600C7..." | xxd -p -r > vmk.key
```

Then, we can use dislocker to create a device node with the plain text device, using partition n on sdx:


```bash
 mkdir -p mydisk && sudo dislocker-fuse -K vmk.key /dev/sdxn -- ./mydisk
```

For example, if the encrypted partition is on /dev/sda3, you can use:

```bash
mkdir -p mydisk && sudo dislocker-fuse -K vmk.key /dev/sda3 -- ./mydisk
```

A dislocker-file will be created inside the ./mydisk folder, representing the device and can be mounted as a normal partition.

```bash
sudo mount -o remove_hiberfile ./mydisk/dislocker-file /media/disk
```

Now, you can access the decrypted data in the /media/disk folder.


All Consolidated References
Here are all the consolidated references for you to check:

-   TPM 2.0 Specification - [https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf](https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf)

-   F-Secure - Sniff, there leaks - [https://labs.withsecure.com/publications/sniff-there-leaks-my-bitlocker-key](https://labs.withsecure.com/publications/sniff-there-leaks-my-bitlocker-key)

-   DolosGroup - From Stolen Laptop to Inside the company network - [https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network](https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network)

# Files

### `__init__.py`

```python
##
## This file is part of the libsigrokdecode project.
##
## Copyright (C) 2022 Lucas Teske <lucas@teske.com.br>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, see <http://www.gnu.org/licenses/>.
##

from .pd import Decoder
```

### `pd.py`

```python
##
## This file is part of the libsigrokdecode project.
##
## Copyright (C) 2022 Lucas Teske <lucas@teske.com.br>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, see <http://www.gnu.org/licenses/>.
##

import sigrokdecode as srd
import binascii, re
from enum import Enum

OPERATION_MASK = 0x80
SIZE_MASK = 0x3f
WAIT_MASK = 0x01

# Registers at https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf
# Page 63 (pdf 71) - Table 17

tpmRegisters = {
    0xD40000: "TPM_ACCESS_0",
    0xD4000C: "TPM_INT_VECTOR_0",
}

for i in range(4):
    tpmRegisters[0xD40008+i] = "TPM_INT_ENABLE_0"

for i in range(4):
    tpmRegisters[0xD40010+i] = "TPM_INT_STATUS_0"

for i in range(4):
    tpmRegisters[0xD40014+i] = "TPM_INTF_CAPABILITY_0"

for i in range(4):
    tpmRegisters[0xD40018+i] = "TPM_STS_0"

for i in range(4):
    tpmRegisters[0xD40024+i] = "TPM_DATA_FIFO_0"

for i in range(4):
    tpmRegisters[0xD40030+i] = "TPM_INTERFACE_ID_0"

for i in range(4):
    tpmRegisters[0xD40080+i] = "TPM_XDATA_FIFO_0"

for i in range(4):
    tpmRegisters[0xD40F00+i] = "TPM_DID_VID_0"

for i in tpmRegisters:
    print("{:08X} = {}".format(i, tpmRegisters[i]))

class State(Enum):
    READING_OP = 1
    READING_ARG = 2
    WAITING = 3
    TRANSFER = 4

class Decoder(srd.Decoder):
    api_version = 3
    id = 'tpm20'
    name = 'TPM2.0'
    longname = 'TPM 2.0'
    desc = 'A TPM 2.0 Protocol Decoder'
    license = 'gplv2+'
    inputs = ['spi']
    outputs = []
    tags = ['SPI', 'TPM']
    options = ()
    annotations = (
        ('text', 'Text'),                   # 0
        ('warning', 'Warning'),             # 1
        ('data-write', 'Data write'),       # 2
        ('data-read', 'Data read'),         # 3
        ('fifo-write', 'FIFO write'),       # 4
        ('fifo-read', 'FIFO read'),         # 5
        ('bitlocker-key', 'Bitlocker Key'), # 6
    )
    annotation_rows = (
         ('row-read', 'Read', (3, )),
         ('row-write', 'Write', (2, )),
         ('row-fifo-read', 'FIFO Read', (5, )),
         ('row-fifo-write', 'FIFO Write', (4, )),
         ('row-bitlocker-key', 'Bitlocker Key', (6, )),
    )
    binary = (
        ('packet-read', 'Packet read'),
        ('packet-write', 'Packet write'),
    )
    options = ()

    def __init__(self):
        self.reset()

    def reset(self):
        self.state = State.READING_OP

    def start(self):
        self.out_ann = self.register(srd.OUTPUT_ANN)
        self.out_python = self.register(srd.OUTPUT_PYTHON)
        self.out_binary = self.register(srd.OUTPUT_BINARY)

    def decode(self, ss, es, data):
        if len(data) == 3 and data[0] == "DATA":
            _, mosi, miso = data
            self.putdata(ss, es, mosi, miso)

    def report_transaction(self, start, end, ttype, addr, data):
        data = binascii.hexlify(bytearray(data)).decode("ascii")
        if addr in tpmRegisters:
            data = "{}: {}".format(tpmRegisters[addr], data)
        else:
            data = "RESERVED({:06X}): {}".format(addr, data)
        self.put(start, end, self.out_ann, [3 if ttype == 1 else 2, [data] ])

    def report_fifo(self, start, end, ttype, data):
        data = " ".join(["{:02X}".format(x) for x in data])
        self.put(start, end, self.out_ann, [5 if ttype == 1 else 4, [data))

    def report_bitlocker_key(self, start, end, key):
        self.put(start, end, self.out_ann, [6, [key))

    opIsRead = 0
    addr = 0
    numBytes = 0
    addrIdx = 0
    bytesRead = []
    transactionStart = 0
    transactionEnd = 0

    def putdata(self, ss, es, mosi, miso):
        if self.state == State.READING_OP:
            self.addr = 0
            self.opIsRead = (mosi & OPERATION_MASK) >> 7    # 1 = read, 0 = write
            self.numBytes = (mosi & SIZE_MASK) + 1          # Minimum transfer = 1 byte
            self.addrIdx = 0
            self.bytesRead = []
            self.state = State.READING_ARG
            self.transactionStart = ss
        elif self.state == State.READING_ARG:
            self.addr = (self.addr << 8) | mosi
            self.addrIdx = self.addrIdx + 1
            if self.addrIdx == 3:
                if miso & WAIT_MASK == 0: # Wait state
                    self.state = State.WAITING
                else:
                    self.state = State.TRANSFER
        elif self.state == State.WAITING:
            if miso & WAIT_MASK == 1: # Wait finished
                self.state = State.TRANSFER
        elif self.state == State.TRANSFER:
            if self.opIsRead == 1: # Read from device
                self.bytesRead.append(miso)
            else:   # Read from controller
                self.bytesRead.append(mosi)
            if len(self.bytesRead) == self.numBytes:
                self.transactionEnd = es
                #print("Transaction: ", self.bytesRead)
                self.report_transaction(self.transactionStart, self.transactionEnd, self.opIsRead, self.addr, self.bytesRead)
                if self.addr in tpmRegisters and tpmRegisters[self.addr] == "TPM_DATA_FIFO_0":
                    self.putfifo(self.transactionStart, self.transactionEnd, self.opIsRead, self.bytesRead)
                elif self.opIsRead == 0:
                    self.endfifo()

                self.state = State.READING_OP

    fifoType = -1 # 0 = Write, 1 = Read
    fifoData = []
    fifoStart = 0
    fifoEnd = 0

    def endfifo(self):
        if self.fifoType == -1:
            return # No FIFO
        self.report_fifo(self.fifoStart, self.fifoEnd, self.fifoType, self.fifoData)

        data = "".join(["{:02X}".format(x) for x in self.fifoData])
        key = re.findall(r'2C000[0-6]000[1-9]000[0-1]000[0-5]200000(\w{64})', data)
        if key:
            print("Bitlocker Key: {}".format(key[0]))
            self.report_bitlocker_key(self.fifoStart, self.fifoEnd, key[0])
        self.fifoData = []
        self.fifoType = -1

    def putfifo(self, start, end, ttype, data):
        if self.fifoType != ttype:
            self.endfifo()
            self.fifoType = ttype
            self.fifoStart = start
        self.fifoEnd = end
        for i in data:
            self.fifoData.append(i)
```
