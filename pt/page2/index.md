---
title: "Início | Lets Hack It"
description: "January 16, 2024 Análise e Decodificação de Memória Flash NAND - Revelando a Dispersão ECC em Dispositivos Desconhecidos Explorando memórias NAND Quando em posse de um dispositivo a qual se deseja conhecer sobre, nem sempre é trivial o acesso ao conteúdo da memória flash. Devido a natureza das memórias NAND,..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

January 16, 2024
# [Análise e Decodificação de Memória Flash NAND - Revelando a Dispersão ECC em Dispositivos Desconhecidos](/pt/2024/01/analise-e-decodificacao-de-memoria-flash)

 ![](/assets/posts/analise-e-decodificacao-flash/flash-cell-programmed.svg)

Explorando memórias NAND Quando em posse de um dispositivo a qual se deseja conhecer sobre, nem sempre é trivial o acesso ao conteúdo da memória flash. Devido a natureza das memórias NAND, é aplicado para todo conteúdo um algoritmo de correção de erros que pode causar uma ofuscação não intencional do conteúdo. Alguns fabricantes de processadores que controlam diretamente memórias do tipo NAND ou programadores de software “protegido” optam por customizar o jeito que estes algoritmos funcionam. Neste artigo veremos como a estrutura básica de uma memória flash, por que a correção de erro existe e como identificar a dispersão...

January 16, 2024
# [STM32F0x Protected Firmware Dumper](/pt/2024/01/stm32f0x-protected-firmware-dumper)

 ![USB-to-SWD debugger board with pin header and green circuit board](/assets/posts/patreon/Pasted%20image%2020230124035811.png)

No processo do meu hobby de hackear hardware, encontrei um clone chinês de um dongle HASP HL equipado com um processador STM32F042G6U6. Minha intenção era cloná-lo, e durante minha exploração, descobri quatro pinos da interface de depuração SWD localizados na parte inferior da PCB. Soldei um conector de 4 pinos nesses pinos para facilitar o acesso. Utilizando meu Segger J-Link como uma sonda de depuração, embora qualquer adaptador JTAG deva ser suficiente, eu o combinei com o OpenOCD. Dado que o chipset é reconhecido pelo OpenOCD, eu criei um script para extrair todos os dados possíveis, condicionados à habilitação. adapter...

April 01, 2021
# [Rotor de Antena - Parte 2](/pt/2021/04/rotor-antenna-parte-2)

 ![Black stepper motor with wires and gear shaft, surrounded by tools on a workbench.](/assets/posts/tracker-mount-2/assembled-elevation-shaft.jpg)

Continuando o projeto do tracker, consegui alguns progressos significativos. Assim como o Demilson (PY2UEP) tinha cortado os motores originais, fiz o mesmo. O motor do azimute estava bem enferrujado e acabei estragando uma de suas bobinas (queria reaproveitar o fio), mas no fim o eixo saiu. Após o eixo removido, quebrei o imã com um martelo até que não sobrasse mais pedaços de imã no eixo, desta maneira restando apenas o suporte sextavado de onde era preso o imã. Eixo do motor do azimute mostrando o suporte sextavado do imã Já para o motor da elevação, fiz um corte lateral...

March 03, 2021
# [Rotor de Antena - Parte 1](/pt/2021/03/rotor-antenna-parte-1)

 ![Beige industrial fan with attached wire, resting on wooden surface in workshop.](/assets/posts/tracker-mount/head.jpg)

Há uns anos eu comprei um rotor para câmera da Pelco, modelo PT175-24P. Esse rotor é feito para carregar uma câmera com lente de até 8kg, e contém dois motores bifásicos reversíveis internamente. Minha ideia era (e é) colocar uma parabólica acoplada, e controlar seu movimento para rastrear satélites. Assim eu poderia executar a recepção de satélites de baixa órbita. Esquema Interno O problema do sistema original da pelco, é que são dois motores de 24V AC, o que torna um VFD (Variable Frequency Driver) necessário para controlar a velocidade e um sistema de loop fechado com algum sensor de...

October 12, 2020
# [Introdução a FPGA](/pt/2020/10/introducao-a-fpga)

 ![White "FPGA" text centered over a green and purple circuit board pattern.](/assets/FPGA.jpg)

Esta é a primeira parte do guia de programação para FPGAs! Este guia irá virar eventualmente um verilog4noobs para qualquer pessoa que quiser iniciar na área de programação de hardware possa ter um jeito fácil de conseguir! Iremos começar a explicar o que é um FPGA e como ele funciona. Para quem preferir, este artigo foi feito em base na Livestream sobre Verilog que fiz a um tempo atrás e está disponível no YouTube: https://www.youtube.com/watch?v=BcKwqju5gxA O que é um FPGA FPGA é uma abreviatura para Field Programmable Gate Array, ou Matriz de Portas Programáveis em Campo. O termo campo usado...
