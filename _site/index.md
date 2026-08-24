---
title: "Home | Lets Hack It"
description: "August 08, 2026 Connecting to ShadowNode with MeshChatX Connecting to ShadowNode with MeshChatX I wanted a simple way to show somebody that a Reticulum node is not just a configuration file and a terminal full of logs. Give the person a client, point it at a public node, and suddenly..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

August 08, 2026
# [Connecting to ShadowNode with MeshChatX](/2026/08/connect-to-shadownode-with-meshchatx)

Connecting to ShadowNode with MeshChatX I wanted a simple way to show somebody that a Reticulum node is not just a configuration file and a terminal full of logs. Give the person a client, point it at a public node, and suddenly there is a page to browse and a chat hub to join. That is what ShadowNode is for. The public node is called ShadowLink TSK-0, and it is running from São Paulo, Brazil. The easiest desktop client for this walkthrough is MeshChatX, an all-in-one Reticulum client with messaging, NomadNet browsing, Relay Chat, and an interface manager. There is...

April 26, 2026
# [Can an AI Write a Working Exploit?](/2026/04/can-an-ai-write-a-working-exploit)

 ![Cyberpunk robot meditating in neon-lit rain-soaked city alley with floating digital shields.](/assets/posts/llm-exploit/llmexploit.jpg)

Me and Rodrigo Laneth were having a discussion about how useful LLMs would actually be for cybersecurity research and pentesting. Not the “write me a fuzz harness” kind of useful – we were wondering if an LLM could go from a vulnerability description all the way to a working exploit PoC. Not just a crash, but actual RIP control. So we decided to test it. The AI Gatekeeping Problem If you’ve ever tried to use OpenAI or Anthropic for anything security-related, you know the drill. They just refuse. Rodrigo tried submitting the vulnerability details to both OpenAI Codex and Anthropic...

April 03, 2026
# [Reverse Engineering the AIR105 Bootrom - A Deep Dive into the MH1903S Boot Process](/2026/04/reverse-engineering-air105-bootrom-mh1903s-boot-process)

 ![Yellow pixelated text "1903S" on a faded, speckled background with vertical lines.](/assets/Running%20code%20in%20a%20PAX%20Credit%20Card%20Payment%20Machine/9138886ea831b06c18888099fd0e26a6_MD5.jpeg)

Reverse Engineering the AIR105 Bootrom: A Deep Dive into the MH1903S Boot Process The AIR105 is a secure microcontroller built around the MH1903S core — an ARM Cortex-M4F processor running at 168 MHz, designed for payment terminals and other security-critical embedded applications. It features hardware cryptography (SM2/SM3/SM4, AES, RSA-2048, SHA-256/384/512), OTP (One-Time Programmable) memory for key storage — though as we’ll see, the bootrom can write to OTP regions via the UART protocol, so it’s better thought of as controlled-access storage rather than truly write-once — on-the-fly flash encryption via a cache encryption engine, and a battery-backed key processing unit...

September 05, 2025
# [Running code in a PAX Credit Card Payment Machine (part1)](/2025/09/running-code-in-pax-machines)

 ![Black-and-white screen displaying the word "CARALHO" with a stylized bird graphic.](/assets/Running%20code%20in%20a%20PAX%20Credit%20Card%20Payment%20Machine/7383f9c5e7832856c90b25549fb08115_MD5.jpeg)

Disclaimer All procedures described here were done with public available stuff - No security flaws were actually explored here to get code execution. The processor swap technique does not bypass the tamper protections neither allow a fake machine to actually emit payments. Brazilian credit card payment machines usually are in state of the art regarding security measures. I remember once a Elavon employee told me that Brazil got all the first releases of payment machines and systems. When asked why, he said: frauds in Brazil are sophisticated enough, that if the system is secure enough to Brazil, it works for...

January 16, 2024
# [TPM 2.0: Extracting Bitlocker keys through SPI](/2024/01/tpm2-bitlocker-keys)

 ![Microscope and tweezers precisely handling a microchip on a circuit board.](/assets/gepeto/tpm2.0.jpg)

The TPM 2.0, also known as Trusted Platform Module 2.0, is a hardware security feature embedded in many modern computers. Its purpose is to provide a secure way to store cryptographic keys and other sensitive data, such as passwords and digital certificates, aiming to protect against various security threats, including unauthorized access to a computer’s hardware and software. TPM 2.0 represents an evolution of the original TPM specification, developed by the Trusted Computing Group (TCG), and features additional capabilities and resources, such as support for additional cryptographic algorithms and the ability to store larger amounts of data. Good Things Currently,...
