---
title: "Início | Lets Hack It"
description: "Lets Hack It August 08, 2026 Conectando ao ShadowNode com o MeshChatX Conectando ao ShadowNode com o MeshChatX Eu queria uma forma simples de mostrar para alguém que um nó Reticulum não é apenas um arquivo de configuração e um terminal cheio de logs. Dê um cliente para a pessoa,..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Lets Hack It
  

August 08, 2026
## [Conectando ao ShadowNode com o MeshChatX](/pt/2026/08/connect-to-shadownode-with-meshchatx)

Conectando ao ShadowNode com o MeshChatX Eu queria uma forma simples de mostrar para alguém que um nó Reticulum não é apenas um arquivo de configuração e um terminal cheio de logs. Dê um cliente para a pessoa, aponte-o para um nó público e, de repente, existe uma página para navegar e um hub de chat para acessar. É para isso que serve o ShadowNode. O nó público se chama ShadowLink TSK-0 e está operando a partir de São Paulo, Brasil. O cliente desktop mais fácil para este passo a passo é o MeshChatX, um cliente Reticulum completo com mensagens,...

April 26, 2026
## [Uma IA Consegue Escrever um Exploit Funcional?](/pt/2026/04/can-an-ai-write-a-working-exploit)

 ![Cyberpunk robot meditating in neon-lit rain-soaked city alley with floating digital shields.](/assets/posts/llm-exploit/llmexploit.jpg)

Eu e o Rodrigo Laneth estávamos discutindo sobre quão úteis os LLMs seriam realmente para pesquisa em segurança e pentesting. Não o tipo de útil “escreve um fuzz harness pra mim” – estávamos querendo saber se um LLM conseguiria ir de uma descrição de vulnerabilidade até um PoC de exploit funcional. Não apenas um crash, mas controle real de RIP. Então decidimos testar. O Problema do Gatekeeping de IA Se você já tentou usar OpenAI ou Anthropic para qualquer coisa relacionada a segurança, você sabe como é. Eles simplesmente recusam. O Rodrigo tentou submeter os detalhes da vulnerabilidade para o...

April 03, 2026
## [Engenharia Reversa da Bootrom do AIR105 - Um Mergulho Profundo no Processo de Boot do MH1903S](/pt/2026/04/reverse-engineering-air105-bootrom-mh1903s-boot-process)

 ![Yellow pixelated text "1903S" on a faded, speckled background with vertical lines.](/assets/Running%20code%20in%20a%20PAX%20Credit%20Card%20Payment%20Machine/9138886ea831b06c18888099fd0e26a6_MD5.jpeg)

Engenharia Reversa da Bootrom do AIR105: Um Mergulho Profundo no Processo de Boot do MH1903S O AIR105 é um microcontrolador seguro construído em torno do núcleo MH1903S — um processador ARM Cortex-M4F rodando a 168 MHz, projetado para terminais de pagamento e outras aplicações embarcadas críticas em segurança. Ele possui criptografia em hardware (SM2/SM3/SM4, AES, RSA-2048, SHA-256/384/512), memória OTP (One-Time Programmable) para armazenamento de chaves — embora, como veremos, a bootrom possa escrever em regiões OTP via protocolo UART, sendo mais adequado descrevê-la como armazenamento de acesso controlado do que verdadeiramente write-once — criptografia de flash on-the-fly via um motor...

September 05, 2025
## [Rodando código em uma máquina de cartão de crédito PAX (parte 1)](/pt/2025/09/running-code-in-pax-machines)

 ![Black-and-white screen displaying the word "CARALHO" with a stylized bird graphic.](/assets/Running%20code%20in%20a%20PAX%20Credit%20Card%20Payment%20Machine/7383f9c5e7832856c90b25549fb08115_MD5.jpeg)

Disclaimer Todos os procedimentos descritos aqui foram feitos com material disponível publicamente - Nenhuma falha de segurança foi realmente explorada aqui para obter execução de código. A técnica de troca de processador não contorna as proteções contra violações nem permite que uma máquina falsa efetue pagamentos. As máquinas de pagamento com cartão de crédito no Brasil geralmente estão no estado da arte em relação às medidas de segurança. Lembro-me uma vez que um funcionário da Elavon me disse que o Brasil recebeu todos os primeiros lançamentos de máquinas e sistemas de pagamento. Quando perguntei por que, ele disse: as fraudes...

January 16, 2024
## [TPM 2.0: Extrair chaves do Bitlocker por SPI](/pt/2024/01/tpm-2-extraindo-chaves-bitlocker)

 ![Microscope and tweezers precisely handling a microchip on a circuit board.](/assets/gepeto/tpm2.0.jpg)

O TPM 2.0, também conhecido como Trusted Platform Module 2.0, é um recurso de segurança de hardware que está incorporado em muitos computadores modernos. Sua finalidade é proporcionar uma maneira segura de armazenar chaves criptográficas e outros dados sensíveis, tais como senhas e certificados digitais, visando proteger contra diversas ameaças de segurança, incluindo acesso não autorizado ao hardware e software de um computador. O TPM 2.0 representa uma evolução da especificação original do TPM, desenvolvida pelo Trusted Computing Group (TCG), e apresenta recursos e capacidades adicionais, como suporte a algoritmos criptográficos adicionais e a capacidade de armazenar quantidades maiores de...
