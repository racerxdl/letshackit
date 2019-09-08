---
id: 35
title: Electronics Hacking
date: 2014-10-01T16:25:16-03:00
author: Lucas Teske
layout: revision
guid: http://www.teske.net.br/lucas/?p=35
permalink: /2014/10/34-revision-v1/
---
Bom, decidi postar hacks de eletrônica aqui também. Até por que são mais frequentes que os meus hacks. Ai vai umas fotos de um sensor CMOS que soldei numa placa pra facilitar, e verei um dia de brincar com ela:

![image](https://media.tumblr.com/tumblr_lt0n9vc8yv1qh7srd.jpg) 

![image](https://media.tumblr.com/tumblr_lt0nbkzIYb1qh7srd.jpg) 

É um Sensor CMOS VGA Colorido, que roda em 3.3V. A sua interface também é CMOS (muitas vezes o sensor é cmos, mas a interface é analógica) e como o nível de tensão é 3v3 é fácil de eu trabalhar com um FPGA. Devo ter tirado isso de uma webcam ou câmera de vigilância, não lembro.

A resolução é 644&#215;484 pixels, porém ela tem uma área morta como qualquer câmera, logo não é tudo isso que é aproveitável. Outro ponto positivo, diz o datasheet que ela é capaz de chegar a 30FPS de taxa de amostragem, o que me leva a pensar que não foi uma webcam, e sim uma câmera de vigilância.

De qualquer maneira não irei brincar com ela hoje, e não tenho previsões. Preciso estudar muito ainda como funciona os sensores. A unica coisa que sei até agora é que ela trabalha com varredura dos sub-pixels, a cada clock tenho 10 Bits que demonstram a intensidade do sub-pixel.

Porém o datasheet é meio confuso, em alguns lugares parece que eu tenho o dado do pixel, e em outros parece o dado do sub-pixel. De qualquer maneira, não é apenas tacar numa tela o dado, é preciso processar ele antes. Esse sensor usa um filtro bayer padrão o que nos dá para cada pixel, dois sub-pixels verde, um vermelho e um azul. Num estudo rápido que fiz, o motivo de ter dois sub-pixels verdes e apenas um das outras cores, é o fato do olho humano ser mais sensível a cor verde devido ao numero de cones (mais sensíveis a cor verde) ser o dobro do numero de bastonetes. Então precisarei ver o que vou fazer.

De qualquer maneira, se alguém quiser o datasheet (não são muitos sites que tem o detalhado, então upei o detalhado no <a href="http://www.energylabs.com.br/project" target="_blank">Project Source</a>) ele está nesta pasta:

<http://www.energylabs.com.br/project/?dir=Outros/Datasheets>

É isso ae!