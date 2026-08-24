---
title: "Bobinas de Tesla | Lets Hack It"
description: "Um arquivo visual dos projetos de bobinas de Tesla SSTC, DRSSTC e com centelhador de Lucas Teske, incluindo arcos musicais, controle por FPGA, notas técnicas, fotos e gravações."
image: "https://lucasteske.dev/wp-content/uploads/2016/11/5620739994_1080ae890f_o.jpg"
---

Escrito por Lucas Teske   
em 28 Novembro 2016

# Bobinas de Tesla

Alta tensão · potência ressonante · 2011–2012
## Potência ressonante, faíscas controladas por FPGA e um pouco de música.

Um arquivo da oficina com SSTCs, DRSSTCs, interruptores musicais, circuitos experimentais de realimentação e toda a evolução da ZARC—de um protótipo de 600 W a uma máquina controlada por FPGA com quatro canais.

[Explorar as construções principais](#coil-milestones)[Ver os experimentos de bancada](#coil-experiments)

13construções documentadas

16gravações

2011–2012período do arquivo

![Arcos elétricos roxos se ramificando a partir da DRSSTC ZARC em uma oficina escura](/wp-content/uploads/2016/11/5620739994_1080ae890f_o.jpg)
_DRSSTC ZARC em funcionamento_

Diário da oficina
## Um arquivo de faíscas, falhas e hardware funcional

Estas são as construções que sobreviveram o suficiente para serem documentadas. Juntas, registram experimentos com componentes de chaveamento, realimentação, sintonia, modulação de áudio, construção mecânica e controle por FPGA.

As datas são dos envios dos vídeos, não necessariamente das construções. Normalmente houve pouco tempo entre a gravação e o envio.

SSTC27 de agosto de 2012

### ZINC SSTC

Bobina portátil com modulação de áudio

A última bobina de Tesla que construí foi uma SSTC compacta, controlada por dois MOSFETs IRFP250N e um driver de GDT em protoboard. Eu a projetei para viajar e demonstrar arcos musicais fora da oficina usando o interruptor de áudio da ZARC.

- SSTC
- 2 × IRFP250N
- Audio

[![](https://i.ytimg.com/vi/vFWoArNIBew/hqdefault.jpg) Demonstração da ZINC ](https://www.youtube.com/watch?v=vFWoArNIBew)

SSTC23 de novembro de 2011

### SSTC sem Driver

Realimentação direta por transformador de corrente

Uma SSTC experimental de meia onda e sem driver, baseada em um circuito que eu projetei. Um transformador de corrente no secundário alimenta diretamente os gates dos MOSFETs. Nunca otimizei o circuito, mas a realimentação funcionou.

- Driverless
- Half-wave
- CT feedback

[![](https://i.ytimg.com/vi/poqmtvrZDk0/hqdefault.jpg) Teste da SSTC sem driver ](https://www.youtube.com/watch?v=poqmtvrZDk0)

[![Diagrama do circuito da SSTC sem driver](https://i.imgur.com/Th0JOug.png) ](https://i.imgur.com/Th0JOug.png)

DRSSTC16 de setembro de 2011

### ZARC com Interruptor MIDI em FPGA

Quatro canais em rede de 220 VAC

A configuração final da ZARC combinava um interruptor MIDI polifônico de quatro canais em FPGA com o controlador na base da bobina. O limite era de 400 A; após dessintonizar um pouco a bobina, a corrente medida no primário ficou abaixo de 320 A.

- DRSSTC
- FPGA MIDI
- 320 A peak

[![](https://i.ytimg.com/vi/gAdmvSDJwfU/hqdefault.jpg) Apresentação com MIDI em FPGA ](https://www.youtube.com/watch?v=gAdmvSDJwfU)[![](https://i.ytimg.com/vi/BHmwMWUPKDc/hqdefault.jpg) Falha do Variac ](https://www.youtube.com/watch?v=BHmwMWUPKDc)

DRSSTC6 de abril de 2011

### ZARC — Base Sintonizada

A montagem mecânica final de 1 kW

Refiz a base da ZARC e refinei a sintonia até chegar à configuração final—cerca de 1 kW de entrada, 110 VAC dobrados para aproximadamente 320 VDC no barramento e pico de 300 A em uma ponte completa com IRG4PC50UD. Continua sendo um dos meus projetos favoritos de engenharia elétrica.

- DRSSTC
- 1 kW
- 300 A peak

[![](https://i.ytimg.com/vi/8PSwmFOdTWc/hqdefault.jpg) Teste 1 da base sintonizada ](https://www.youtube.com/watch?v=8PSwmFOdTWc)[![](https://i.ytimg.com/vi/M4n_VW-3P9c/hqdefault.jpg) Teste 2 da base sintonizada ](https://www.youtube.com/watch?v=M4n_VW-3P9c)

[![Base reconstruída da ZARC vista de cima e de frente](https://c2.staticflickr.com/6/5180/5583127713_041b5428d4_n.jpg) ](https://www.flickr.com/photos/energylabs/5583127713/in/album-72157626476042126/)[![Vista frontal da base reconstruída da ZARC](https://c7.staticflickr.com/6/5142/5583715958_dd2a87e698_n.jpg) ](https://www.flickr.com/photos/energylabs/5583715958/in/album-72157626476042126/)[![Iluminação por LEDs dentro da base da ZARC](https://c1.staticflickr.com/6/5096/5578809376_7a91391356_n.jpg) ](https://www.flickr.com/photos/energylabs/5578809376/in/album-72157626476042126/)[![DRSSTC ZARC produzindo arcos com metade da potência](https://c2.staticflickr.com/6/5143/5620107121_cb3cc9f639_n.jpg) ](https://www.flickr.com/photos/energylabs/5620107121/in/album-72157626476042126/)

DRSSTC4 de março de 2011

### ZARC — Primeiro Teste com Estrutura Completa

Estrutura final, sintonia inicial

A ZARC chegou à estrutura física final antes do último ajuste de sintonia. O interruptor ainda era a versão inicial, mas o sistema produziu arcos de quase 70 cm com estabilidade muito melhor.

- DRSSTC
- 70 cm arcs
- Prototype

[![](https://i.ytimg.com/vi/AjZxN-Oh8hQ/hqdefault.jpg) Teste 1 da estrutura final ](https://www.youtube.com/watch?v=AjZxN-Oh8hQ)[![](https://i.ytimg.com/vi/W45HzzltVCU/hqdefault.jpg) Teste 2 da estrutura final ](https://www.youtube.com/watch?v=W45HzzltVCU)

DRSSTC26 de fevereiro de 2011

### DRSSTC Musical

A primeira DRSSTC com modulação de áudio que funcionou de forma confiável na linha da ZARC. As tentativas anteriores quase sempre terminaram em explosões; este protótipo finalmente transformou o interruptor em música e arcos estáveis.

- DRSSTC
- Audio modulation

[![](https://i.ytimg.com/vi/3jsGwaVaCh8/hqdefault.jpg) Teste da DRSSTC musical ](https://www.youtube.com/watch?v=3jsGwaVaCh8)

DRSSTC26 de fevereiro de 2011

### Mini DRSSTC

Uma DRSSTC compacta do mesmo período de desenvolvimento, construída para explorar a topologia em uma escala menor.

- DRSSTC
- Compact

[![](https://i.ytimg.com/vi/9iRUjJxLCXo/hqdefault.jpg) Teste da Mini DRSSTC ](https://www.youtube.com/watch?v=9iRUjJxLCXo)

SSTC26 de fevereiro de 2011

### Micro SSTC de 1,5 MHz

Uma SSTC de onda contínua operando a 1,5 MHz com uma ponte completa de MOSFETs IRF740—uma frequência de chaveamento deliberadamente agressiva para esse componente.

- SSTC
- 1.5 MHz
- IRF740

[![](https://i.ytimg.com/vi/q4ZZiwBTu18/hqdefault.jpg) Teste em 1,5 MHz ](https://www.youtube.com/watch?v=q4ZZiwBTu18)

SSTC26 de fevereiro de 2011

### SSTC Média 3

Interruptor com modulação de áudio

Esta montagem reutilizou o secundário das outras SSTCs médias e da minha primeira DRSSTC, mas recebeu um terminal de topo diferente e modulação de áudio.

- SSTC
- Audio modulation
- Shared secondary

[![](https://i.ytimg.com/vi/FZI4-mv9B-w/hqdefault.jpg) Teste da SSTC Média 3 ](https://www.youtube.com/watch?v=FZI4-mv9B-w)

DRSSTC2011

### Primeira DRSSTC Funcional

Minha primeira DRSSTC funcional usava realimentação por transformador de corrente no primário e uma meia ponte de IGBTs STGW30NC60WD. A rede de 127 VAC retificada e dobrada fornecia cerca de 300 VDC ao barramento principal.

- DRSSTC
- 300 V bus
- STGW30NC60WD

[![](https://i.ytimg.com/vi/rj4tLlkp_sc/hqdefault.jpg) Primeira DRSSTC funcional ](https://www.youtube.com/watch?v=rj4tLlkp_sc)

SSTC26 de fevereiro de 2011

### SSTC Média CW em Meia Onda

Um secundário médio de 30 × 10 cm operando em onda contínua com dois MOSFETs IRFP260N e uma fonte retificada em meia onda, sem filtragem.

- SSTC
- CW
- 2 × IRFP260N

[![](https://i.ytimg.com/vi/z0nRNUIxOzo/hqdefault.jpg) Teste CW em meia onda ](https://www.youtube.com/watch?v=z0nRNUIxOzo)

SGTC26 de fevereiro de 2011

### Bobina de Tesla com Centelhador ZVS

Experimento alimentado por flyback

Uma bobina com centelhador alimentada por um transformador flyback em um driver Mazzilli ZVS, com dois MOSFETs IRFP250N a 30 VDC e um banco de capacitores de 1 nF e 40 kV.

- SGTC
- Flyback
- 1 nF / 40 kV

[![](https://i.ytimg.com/vi/7xrbQroWcrg/hqdefault.jpg) Teste da bobina com centelhador ZVS ](https://www.youtube.com/watch?v=7xrbQroWcrg)

DRSSTC26 de fevereiro de 2011

### ZARC — Protótipo de 600 W

O protótipo inicial da ZARC produzia arcos de quase 50 cm com 600 W. Ele introduziu IGBTs IRG4PC50U com diodos ultrarrápidos reversos para amortecer os picos de tensão reversa.

- DRSSTC
- 600 W
- 50 cm arcs

[![](https://i.ytimg.com/vi/VxdQy4QUH6Q/hqdefault.jpg) Teste do protótipo da ZARC ](https://www.youtube.com/watch?v=VxdQy4QUH6Q)

Arquivo de alta tensão

Estas são notas históricas de projetos, não instruções de montagem. Bobinas de Tesla envolvem tensões letais e energia armazenada; reproduzir este trabalho exige conhecimento adequado de engenharia de alta tensão e controles de segurança.
