---
title: "Home | Lets Hack It"
description: "January 16, 2024 NAND Flash Memory Analysis and Decoding - Unveiling ECC Scattering in Unknown Devices Exploring NAND Memories When in possession of a device whose internals one wishes to understand, accessing the content of the flash memory is not always straightforward. Due to the nature of NAND memories, an..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

January 16, 2024
# [NAND Flash Memory Analysis and Decoding - Unveiling ECC Scattering in Unknown Devices](/2024/01/decoding-and-analysis-nand-flash)

 ![](/assets/posts/analise-e-decodificacao-flash/flash-cell-programmed.svg)

Exploring NAND Memories When in possession of a device whose internals one wishes to understand, accessing the content of the flash memory is not always straightforward. Due to the nature of NAND memories, an error correction algorithm is applied to all content, which can cause unintentional obfuscation of the content. Some manufacturers of processors that directly control NAND-type memories or developers of “protected” software choose to customize the way these algorithms function. In this article, we will explore the basic structure of flash memory, why error correction exists, and how to identify the scattering of the error correction algorithm used....

January 16, 2024
# [STM32F0x Protected Firmware Dumper](/2024/01/stm32f0x-protected-firmware-dumper)

 ![USB-to-SWD debugger board with pin header and green circuit board](/assets/posts/patreon/Pasted%20image%2020230124035811.png)

In the process of my hobby hardware hacking, I encountered a Chinese clone of a HASP HL dongle equipped with a STM32F042G6U6 processor. My intention was to clone it, and during my exploration, I discovered four pins from the SWD debug interface located at the bottom of the PCB. I soldered a 4-pin header to these pins for ease of access. Utilizing my Segger J-Link as a debug probe, although any JTAG adapter should suffice, I paired it with OpenOCD. Given that the chipset is recognized by OpenOCD, I crafted a script to extract all possible data, conditional upon enablement....

April 01, 2021
# [Antenna Rotor - Part 2](/2021/04/rotor-antenna-parte-2)

 ![Black stepper motor with wires and gear shaft, surrounded by tools on a workbench.](/assets/posts/tracker-mount-2/assembled-elevation-shaft.jpg)

Continuing the tracker project, I managed to make some significant progress. As Demilson (PY2UEP) had cut the original motors, I did the same. The azimuth motor was too rusted and I eventually destroyed one of the coils (which I wanted to salvage the wire), but in the end the shaft went out. After removing the shaft, I broke the magnet with a hammer until there was any piece left. That way, the only thing that would be left there is the shaft and the hexagon magnet support. Motor shaft showing the hexagon support For the elevation motor, I made a...

March 03, 2021
# [Antenna Rotor - Part 1](/2021/03/rotor-antenna-parte-1)

 ![Beige industrial fan with attached wire, resting on wooden surface in workshop.](/assets/posts/tracker-mount/head.jpg)

A few years ago I bought a Pelco Câmera Rotor, model PT175-24P. This rotor is made for carrying a camera with up to 8kg, and contains two biphase reversable motors internally. My idea was (and is) to put a satellite dish coupled, and control its movement to track satellites. Then I could use it to receive Low Orbit Satellites. Internal Schematics The problem of the original system from pelco, is that they’re two 24V AC Motors, which would require a VFD (Variable Frequency Driver) to control the speed and a closed-loop system with a angle sensor. That would make it...

October 12, 2020
# [Introduction to FPGA](/2020/10/introducao-a-fpga)

 ![White "FPGA" text centered over a green and purple circuit board pattern.](/assets/FPGA.jpg)

(So far) Only available in Portuguese
