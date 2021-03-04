---
title: 'Rotor de Antena - Parte 1'
date: 2021-03-03T20:57:00-03:00
author: Lucas Teske
layout: post
image: /assets/posts/tracker-mount/head.jpg
categories:
  - English
  - Reverse Engineering
  - Satellite
  - SDR
tags:
  - Airspy
  - EMWIN
  - English
  - GOES
  - Hearsat
  - LRIT
  - RE
  - Reverse Engineering
  - Sat
  - Satellite
  - SDR

---

A uns anos atrás eu comprei um rotor para câmera da Pelco, modelo PT175-24P. Esse rotor é feito para carregar uma câmera com lente de até 8kg, e contém dois motores bifásicos reversiveis internamente. Minha ideia era (e é) colocar uma parabólica acoplada, e controlar seu movimento para rastrear satélites. Assim eu poderia executar a recepção de satélites de baixa órbita.

![Esquema Interno](/assets/posts/tracker-mount/motor-schematic.jpg)*Esquema Interno*

<hr>

O problema do sistema original da pelco, é que são dois motores de 24V AC, o que torna um VFD (Variable Frequency Driver) nescessário para controlar a velocidade e um sistema de loop fechado com algum sensor de angulo. Isso torna um pouco complexo o controle preciso da antena, então um colega (PY2UEP) sugeriu fazer uma modificação para trocar os motores por motor de passo. A grande vantagem dos motores de passo é que seus passos são sempre de mesmo comprimento. Logo se o motor der N passos em um sentido, e N passos no sentido contrário, ele irá retornar **exatamente** a mesma posição. Isso permite o uso de circuitos abertos (onde apenas no começo você move tudo para a posicao de referencia, e depois você não usa o feedback para corrigir nada).

![Motor de Passo](/assets/posts/tracker-mount/photo_2021-03-03_20-56-30.jpg)*Motor de Passo*

# Fazendo a limpeza

Comecei então por abrir o rotor e fazer uma super limpeza. Limpar toda graxa antiga e tudo mais.

![Interior da Pelco](/assets/posts/tracker-mount/photo_2021-03-02_20-19-46.jpg)*Interior da Pelco*
![Interior da Pelco](/assets/posts/tracker-mount/photo_2021-03-02_20-19-46-2.jpg)*Interior da Pelco*

Desmontei tudo, e dei um belo banho de querosene para remover a graxa. Os dois rolamentos do azimute estavam bem travados (a graxa secou tanto que parecia cola) então deixei de um dia pro outro na querosene e depois limpei com um pincel. Após toda limpeza, os rolamentos parecem novos!

![](https://www.youtube.com/watch?v=9Y2FpSlNss8)

O resto das peças eu joguei praticamente tudo dentro de um balde e enchi de querosene com um pouco de água. Depois fiquei mexendo as peças dentro (como são todas de metal bem resistente) "girando" o balde, como se eu estivesse misturando com uma colher. Após um tempo assim, deixei um tempo decantar e depois fiz varias lavagens com água e detergente pra remover toda querosene.

![Balde com peças](/assets/posts/tracker-mount/photo_2021-03-03_19-23-52.jpg)*Balde com peças lavadas*

As correias eu também deixei de molho na querosene e depois usei um pincel para tirar os pedaços encrustrados de graxa.

![Correias](/assets/posts/tracker-mount/photo_2021-03-03_19-23-53.jpg)*Correias na querosene*

Após tudo limpo, comecei a montagem colocando os dois rolamentos do azimute no lugar. O da parte inferior é preso no interior da pessa sob pressão, por isso foi nescessário o uso de um martelo. Com cuidado e um guia fui empurrando a peça até ficar praticamente rente com a parte de baixo. Após isso fiz a montagem do suporte do azimute.

![](https://www.youtube.com/watch?v=5wpSKRn5RnM)

E logo após coloquei o redutor e a correia do azimute no lugar.

![](https://www.youtube.com/watch?v=bE6B3GejGmA)


Depois foram coisas mais faceis: parafusar tudo novamente. No fim, eu deixei aberto para que pudesse planejar os motores de passo:

![Montagem da Pelco Aberta](/assets/posts/tracker-mount/photo_2021-03-03_22-51-36.jpg)*Montagem da Pelco aberta*

Próximo passo é desmontar os motores originais para adaptar o eixo aos motores de passo!

![Motor do Azimute](/assets/posts/tracker-mount/photo_2021-03-03_22-56-26-2.jpg)*Motor do Azimute*

![Motor da Elevação](/assets/posts/tracker-mount/photo_2021-03-03_22-56-26.jpg)*Motor da Elevação*

