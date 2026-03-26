---
id: 18
title: Um presente inesperado na Campus Party!
date: 2015-02-18T17:40:39-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=92
permalink: /2015/02/um-presente-inesperado-na-campus-party/
image: /wp-content/uploads/2015/04/tumblr_inline_njxos3euZM1rvy8i7.jpg
categories:
  - Sem categoria
tags:
  - apm
  - arduino
  - ARM
  - atom
  - drone
  - dualcore
  - edison
  - galileo
  - gift
  - intel
  - internet das coisas
  - internet of things
  - iot
  - multiwii
  - mwc
  - pixhawk
  - presente
  - quadricoptero
  - x86
---
Como a maioria sabe, todos os anos eu vou para o evento anual **Campus Party**. Apesar de eu achar que ele está decaindo a cada ano que se passa, ainda há muito o que se aproveitar lá além de rever os amigos da internet nesta oportunidade anual.

Este ano fui também chamado para a cerimônia de abertura (estreia) do **Intel Edison** no Brasil. Como muitos sabem (e os que não sabem é só ler meu post anterior) eu fiz várias críticas ao **Intel Galileo**, muitas delas as quais foram corrigidas na sua segunda versão (Galileo Gen 2).

Apesar da ideia da Intel sobre IoT (Internet of Things) para o Galileo, minha ideia inicial era ter um processador melhor para o meu quadricóptero. A **IMU** (unidade de movimento inercial) de um quadricóptero faz operações matemáticas complexas ao nível computacional embarcado (operações matriciais em ponto flutuante) e mesmo as melhores controladoras sendo processadores **ARM**, usam processadores relativamente simples (sem **NEON** e outros sistemas de **SIMD** (Single Instruction Multiple Data) ).

<!--more-->

O problema é que apesar do **Quark** (processador do galileo) ter um clock relativamente alto (400MHz) ele não possui nenhum tipo de SIMD (nem o MMX que é o mais simples de todos), e pela natureza da arquitetura x86 (especificamente i585 no caso do quark) ele é praticamente equivalente a um ARM de 250MHz, consumindo um pouco mais.

Quando vi a Intel anunciando o Edison, fiquei interessado pois ele parecia ter um processador melhor que o Quark. Oficialmente anunciado com um Atom Dual-Core de 500MHz, 1GB de ram, 4GB de flash, Wifi e Bluetooth, tudo num único &#8220;encapsulamento&#8221; (no caso é uma placa minuscula, não necessariamente tudo dentro de um chip). Eu realmente estava considerando em comprar, mas estava com a dúvida se não seria mais uma decepção.

Para minha surpresa, ganhei um da Intel na Campus Party!<figure>

![image](https://31.media.tumblr.com/9f4837d6d4215d9058669a67a329091b/tumblr_inline_njxos3euZM1rvy8i7.jpg) </figure> 

No caso, ganhei o kit de desenvolvimento arduíno-compatível da intel, onde se inclui um Edison e uma placa de desenvolvimento com um header de arduino. Custando quase R$1200 aqui no Brasil (embora lá fora não seja nem tão perto de caro assim), sem dúvida é o presente mais caro que já recebi de alguma empresa!<figure>

![image](https://31.media.tumblr.com/17df3e0211c39886ef916d652db7b18d/tumblr_inline_njxpiymhQX1rvy8i7.jpg) </figure> 

O Edison em si é a placa a direita, dentro da embalagem de plástico. A esquerda temos a placa de desenvolvimento arduino-compativel.

## Review do Hardware

A ideia principal do Edison é ser um hardware **stackable**. Isso significa que seus acessórios e placas-filha idealmente seguem um padrão e permitem serem empilhadas como na foto abaixo da **SparkFun** mostra:<figure>

![image](https://31.media.tumblr.com/43db77adb12a9d8ec307f2eef6e92fc8/tumblr_inline_njxpnwLIMn1rvy8i7.jpg) </figure> 

Vendo a placa por cima, ela é **completamente** diferente do Intel Galileo. Nitidamente o foco não é competir com um Arduíno e não diretamente com um Raspberry PI. O Intel Edison foi feito para sistemas de _Internet of Things_, um conceito que surgiu a pouco tempo sobre &#8220;conectar todas as coisas a internet&#8221;. Além disso a ideia é facilitar a construção de gadgets **wearables** (vestíveis). Por isso, o Edison não tem GPU (como um raspberry tem) porém tem Wireless N e Bluetooth 4.0 LE, permitindo interações sem fio.<figure>

![image](https://31.media.tumblr.com/c9c212165ede6e502d6fd5b8285a2326/tumblr_inline_njxpthBQqj1rvy8i7.jpg) </figure> 

A placa contém um header arduíno-compatível com **muitos** level-translation e drivers de corrente para tornar a I/O 1.8V do Edison em uma I/O 5V usual de um arduíno, tornando praticamente _todos_ os shields compatíveis com o mesmo.

Do lado direito da placa encontramos 2 portas de entrada micro-usb, uma chave, uma porta USB Host e um power-plug. Um dos conectores micro-usb contém um chip FTDI (FT232) que é basicamente um conversor USB-Serial. Este conversor USB-Serial está ligado a uma porta serial do Edison que contém um serviço rodando que aceita programas da IDE do Arduíno (existe uma versão diferente da IDE no site da Intel) onde você poderá enviar **sketches de arduíno** da mesma maneira que faz com qualquer Arduíno. Já na outra porta USB você está ligado direto com a porta USB Slave do Edison, onde ao colocar em seu computador disponibilizará uma série de periféricos para ele:

  1. **Uma rede Ethernet virtual entre o Edison e seu computador** &#8211; O edison estará pré-configurado com IP 192.168.2.15 e você poderá acessa-lo via SSH
  2. **Uma porta serial virtual** &#8211; Esta porta serial terá a visualização do boot do sistema inteiro além de um dos terminais do Linux que roda no Edison.
  3. **Um dispositivo de bloco formatado com VFAT** &#8211; Uma parte da memória flash interna do edison é formatada em VFAT para que usuários de Windows possam enviar arquivos para dentro do Edison facilmente.<figure>

![image](https://31.media.tumblr.com/3decc004689b74bc6194078074984455/tumblr_inline_njxq8eTFKn1rvy8i7.jpg) </figure> 

Ao topo da placa podemos ver 5 botões. Dois são de **RESET**, um apenas para o shield, e outro para o Edison. Isso é interessante pois nem sempre é necessário resetar todo hardware do Edison (devido ao sketch ser apenas um programa rodando), mas é mais comum ter que resetar um shield. Um botão de **POWER** (semelhante a de seu computador), um botão para acesso a **FIRMWARE RECOVERY** e outro botão de **MODO RECOVERY**. Ao lado desses botões podemos ver também um slot para cartão micro-sd.<figure>

![image](https://31.media.tumblr.com/56f78dd63d83c27993b5700e0ca45c32/tumblr_inline_njxqg4YgPR1rvy8i7.jpg) </figure> 

## Entrando no Edison

Então vamos ao que interessa! Acessar o Edison. Meu primeiro acesso ao Edison se deu no mesmo dia na Campus Party. Eu estava com meu amigo Luckas Judocka que também estava interessado em ver os recursos disponíveis no pequeno computador da Intel. A primeira coisa que fizemos foi (após montar tudo) liga-lo numa porta USB de meu notebook. Eu gostaria de saber se ele poderia ser alimentado pela USB. E para minha felicidade: SIM! ele pode ser alimentado pela porta USB.

**Mas vale a nota da Intel**: O pico de consumo do Edison pode superar a corrente máxima da porta USB (_500mA_) e pode haver problemas de estabilidade se o Edison for alimentado pela por USB e ter programas &#8220;pesados&#8221; usando 100% da CPU e seu Wifi/Bluetooth. No caso do meu notebook eu não me preocupei muito pois as portas USB dele são feitas para External Charging e suportam uma corrente de até 2A. E de qualquer forma para 90% dos casos o consumo do Edison será bem inferior ao limite das portas USB.

Ligado na porta USB (pela porta USB Client direta do Edison) reparei que alguns dispositivos surgiram em meu linux: um **USB ACM device**, vulga porta Serial Virtual via USB, usada para acessar o terminal do linux rodando no Edison, um dispositivo de blocos de 800MB formatado em VFAT, e uma porta de rede.

Usando o PuTTY e conectando ao dispositivo **/dev/ttyACM0** loguei como root (sem senha por padrão no Edison) e fui logo ver o conjunto de instruções:

> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi **mmx** fxsr **sse** **sse2** ss ht tm pbe syscall **nx** rdtscp lm constant\_tsc arch\_perfmon pebs bts rep\_good nopl xtopology nonstop\_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl **vmx** est tm2 **ssse3** cx16 xtpr pdcm pcid **sse4_1** **sse4_2** x2apic popcnt tsc\_deadline\_timer **aes** xsave **avx** f16c rdrand lahf\_lm ida arat epb xsaveopt pln pts dtherm tpr\_shadow vnmi flexpriority ept vpid fsgsbase smep erms

Destaquei algumas que me impressionaram, mas no geral o que posso dizer é que _ele é um Atom usual de 5 geração_._ _Isso significa algumas coisas para um usuário que não sabe diretamente o que são essas instruções que eu grifei: Maior segurança (isso é importante para IoT) e também mais rapidez em sistemas que usem **AoT** or **JIT** como _Java_ e _NodeJS _(pois estes aproveitam as instruções mais avançadas para otimizar códigos.

Para o meu caso, duvido muito que chegarei a usar todas elas, porém é interessante ter o recurso de **SSE** para efetuar operações matriciais de ponto flutuante de maneira rápida. Além disso o meu amigo Luckas se impressionou com o fato do Edison ter suporte a **AES** via hardware (criptografia), pois isso não é tão comum mesmo nos ARMs mais atuais. Além disso o processador aceita extensões de virtualização (**VMX**) o que permite brincar um pouco com máquinas virtuais dentro do linux instalado (embora haja uma limitação de processador/memória).

## Resumo

Ainda preciso fazer mais alguns testes porém o Edison é promissor para o uso num quadricóptero. Planejo portar toda framework da **Pixhawk** para o Edison e usar ele para processar os movimentos da Pixhawk e adicionar alguns recursos extras de controle. Em breve posto notícias 😀