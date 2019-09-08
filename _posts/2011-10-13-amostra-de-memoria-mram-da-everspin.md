---
id: 38
title: Amostra de Memória MRAM da Everspin
date: 2011-10-13T16:42:09-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=38
permalink: /2011/10/amostra-de-memoria-mram-da-everspin/
categories:
  - Sem categoria
---
A muito tempo atrás pedi amostras de uma memória magnética da **[Everspin](http://www.everspin.com/)** para fazer testes aqui, porém depois me deparei com o problema de que ela é 3.3V.

De qualquer maneira agora tenho um FPGA para brincar com ela.

O modelo de amostra é a **MR2A16AYS35**, uma MRAM de 1M de endereço e 16 Bits de &#8220;palavra&#8221;, totalizando **16Mbit** ou **2 Mbytes**.

MRAM é um acrônimo para _Magneto-resistive Random Access Memory_, que é uma memória RAM **não-volátil** (não perde os dados quando se desliga). Ela é considerada a chave para o futuro da computação, principalmente portátil. Com ela vem o conceito de &#8220;**boot-instantâneo**&#8221; onde seu computador ao apertar o botão de ligar, estará já pronto para uso.

O por que disso? É bem simples na realidade. Os armazenamentos não-volateis (por exemplo cartões de memória, HD&#8217;s, pendrives) são muito lentos para se trabalhar diretamente neles, e devido a isso se usa a Memória RAM, que é muito mais rápida, porém perde seu conteúdo ao se remover a energia. E até pior no caso das atuais **DDR** que são baseadas na **DRAM**, onde seu conteúdo precisa ser &#8220;refrescado&#8221; de tempos em tempos (a memória precisa de um pulso pra recarregar os valores 1 dentro dela, se não ela perde. Isso é devido ao dado propriamente dito ser armazenado em um capacitor, que perde sua energia com o tempo)

<!--more-->

Para isso, todos os dados a serem trabalhados tem de ser transferidos do armazenamento não-volátil para a memória RAM. No processo de &#8220;**boot**&#8221; do computador, as informações do sistema operacional são carregadas na memória para serem trabalhadas. Isso demanda o tempo de cópia e acesso a fonte de memória não-volátil.

Com a MRAM os nossos sistemas podem mudar radicalmente neste aspecto, por que elas tem uma taxa de acesso próxima as **SRAM** (tipo mais simples de RAM, não tão rápida quantas as DDR mas são de interface simples e MUITO mais rápidas que um armazenamento não-volátil atual) e ao mesmo tempo não perdemos os dados quando desligados. Ela retem toda informação mesmo sem energia. Com isso tempos um armazenamento não-volátil muito mais rápido que os atuais.

Mas então o que isso significa para o &#8220;**boot-instantâneo**&#8220;? É algo bem simples na realidade. Para que vamos carregar algo em outra memória, se podemos trabalhar ela diretamente onde está armazenada? As MRAM servirão tanto como memória de trabalho quanto de armazenamento, assim qualquer informação necessária não precisará ser copiada de um meio lento para um rápido. Como todas as informações já estarão na memória de trabalho, ao ligar, tudo já estará disponível para uso.

É claro que o boot real do computador não é apenas a cópia de dados do meio não-volátil para o volátil, e por isso o &#8220;boot-instantâneo&#8221; está entre aspas. Há muitos processos feitos no boot do computador assim como inicialização dos dispositivos de hardware (suas placas de vídeo, som, rede etc&#8230;), porém já é um ganho precisar processar apenas uma vez a inicialização do sistema. Na verdade o computador se ganhará algo o Sleep Mode dos smartphones (iPhone, Android etc..).

Sim eu sei, existe já o modo de colocar o PC para hibernar ou suspenso, mas mesmo assim ele demora até voltar não é?

De qualquer maneira, aqui ta uma foto da placa <span style="text-decoration: line-through;">*feia*</span> que fiz para fazer uma interface para ela. Irei no futuro brincar um pouco com ela. Lembrando que ela retem os dados em no mínimo 20 anos (o que é bastante, embora não pareça os cartões de memória de hoje retem por menos tempo).

![image](https://media.tumblr.com/tumblr_lt0s263i661qh7srd.jpg)