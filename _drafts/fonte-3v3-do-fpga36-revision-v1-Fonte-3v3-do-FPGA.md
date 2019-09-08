---
id: 37
title: Fonte 3v3 do FPGA
date: 2014-10-01T16:25:57-03:00
author: racerxdl
layout: revision
guid: http://www.teske.net.br/lucas/?p=37
permalink: /2014/10/36-revision-v1/
---
Bom, alguns talvez lembrem que um pouco antes do Flisol de Salto uma das minhas placas de Desenvolvimento Xilinx Spartan 3A Evaluation Kit parou de funcionar. Descobri que era o regulador de 3.3V da placa que havia queimado (bom, eu meti em curto várias vezes sem querer, apesar de ele ter proteção, nunca é a prova de falhas). Por sorte eu tinha outra e pude apresentar o projeto.

Mas ontem resolvi arrumar a placa de algum jeito. Infelizmente o regulador 3.3V apesar de não ser caro, tem algo em torno de 2mm²  e é em QFN, um SMD que os pinos dele são em baixo do chip.

Ou seja, era um mísero quadrado minúsculo que mesmo que tivesse seus pinos para o lado seria quase humanamente impossível de soldar. Então resolvi apelar. Tinha um Regulador de 3.3V 3A aqui num canto, uma placa boa e bem feita (vinda da China) e resolvi ligar no lugar do regulador 3.3V.

Não ficou tão bonito, mas está funcionando perfeitamente, e agora tenho um regulador mais robusto também de 3.3V para o que eu precisar:

![image](https://media.tumblr.com/tumblr_lt0oi5atqO1qh7srd.jpg)