---
id: 16
title: Motivos pelos quais eu não gostei do Intel Galileo
date: 2014-02-08T20:57:35-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=60
permalink: /2014/02/motivos-pelos-quais-eu-nao-gostei-do-intel-galileo/
categories:
  - Sem categoria
---
![image](https://31.media.tumblr.com/4e74c437f3037fbd3ae0905530ca57a8/tumblr_inline_n0pcy2WDDv1rvy8i7.jpg)

Consegui minha placa Intel Galileo na semana da Campus Party. Peguei ela mais por curiosidade. A minha real intenção sobre ela seria comparar o processador dela ao Raspberry Pi. O Raspberry Pi como muitos sabem usa um processador bem ultrapassado. Os seus 700MHz já não significam muita coisa. Porém ele tem uma boa GPU que é capaz de decodificar videos 1080p e rodar aplicativos OpenGL.

<!--more-->

Eu sempre tive a ideia de que a Intel só faz \*porcaria\* nos seus produtos. Antes que venham falar \*fanboy da AMD\* o meu ponto contra a Intel é o x86, o que me coloca contra a AMD também. Há também o aspecto contra na questão das GPUs, porém não vou entrar em detalhes sobre isso agora.

De qualquer maneira eu já não esperava muita coisa. Já esperava vacilos tensos da Intel. Porém eu tive várias surpresas (poucas boas, e muitas ruins) ao usar o Intel Galileo.

Vou começar falando de quando abri a caixa. A caixa é bem bonita, e a placa, devo admitir, que também é. Olhando a placa fiquei vasculhando por conectores, e para minha surpresa: Não existe HDMI. É pois é. E o \*poderoso\* Processador Quark não tem nem GPU internamente. No começo até pensei : Bom, ele tem Mini PCIe, poderiamos colocar uma GPU. &#8211; Porém, não existem GPU Mini PCIe por ai.

> Ok, decepção um marcada. Embora já esperada.

Vasculhando a caixa, achei a fonte. A intel pensou no planeta inteiro quando foi pegar essa fonte. Ela tem adaptadores para todos os padrões de tomadas que eu conheço. Ponto Positivo.

Mas a alegria dura pouco, vasculhando mais descubro: APENAS a fonte vem. Nem um mísero cabo USB vem junto na caixa. O que é? Eles deduzem que todo desenvolvedor tem cabo USB em casa? Ou é apenas pra poderem ganhar mais US$10 vendendo um cabo USB?

> Ok, decepção dois marcada.

Fiquei brincando uns dias com ela. Em geral somente sketches de arduino. Até o dia que quis colocar em algo prático: Meu quadcopter.

O Mini PCIe me chamou atenção e resolvi colocar uma placa Wireless Intel 3945ABG, uma das mais comuns placas Mini PCIe. Porém vi no site que não havia espaço na SPI interna para todos os drivers, e que deveria rodar num cartão MicroSD. Tá, isso não é ponto negativo nem positivo. A SPI tem 8MB e sejamos razoáveis: em 8MB você mal coloca o Linux com sistema básico pra rodar.

Ok, fiz o upgrade na firmware interna da placa através da IDE do Arduino para Galileo, e coloquei a firmware expandida no Cartão SD conforme o Guia falava. No guia eu vi que pelo Putty você poderia acessar a EFI ( é pois é, o Quark tem uma EFI! ) com menu de boot do grub e tudo mais. Fiquei horas e mais horas tentando acessar, até que descobri: Ela só é mostrada na porta Serial secundária, através de um Jack de áudio que é usado pra serial. Se não veio cabo USB, quanto mais o adaptador de serial né? Ponto negativo de novo.

O Serial Secundario poderia vir como uma parte do dispositivo USB Client como Composite Device. Existem VÁRIOS chips comerciais e baratos que fazem isso ( FTDI é um deles, e é usado no Arduino ). Nem pra colocarem essa serial como uma interface USB, nem que precisasse de outro cabo!

Um ponto positivo que achei vendo a placa: GPIO 3v3 e 5v. Trocável por um jumper. Isso é ótimo pra tornar compatível com a maioria dos &#8220;shields&#8221; de Arduino.

Bom, continuando meu trabalho, consegui rodar a firmware e acessar um shell através de uma &#8220;gambiarra&#8221;. Eu deduzi que por rodar um Linux, a IDE do Arduino na verdade estava compilando um aplicativo linux, com uma biblioteca modificada do arduino para fazer as chamadas através do Userspace do kernel. Então logo tentei rodar um system(&#8220;ifconfig eth0 10.0.5.99 netmask 255.255.255.0&#8221;); para ver se tinha como eu trocar o IP. E fiquei pingando pra ver se entrava. Bingo! Funcionou 😀

Deduzi então que havia um servidor telnet nele, comum em dispositivos embarcados. Logo: system(&#8220;telnetd -l /bin/sh&#8221;); E bingo novamente! Acesso ao shell. Porém depois que entrei no Shell e vasculhei as coisas me desapontei. Mesmo a imagem de 300MB do Linux \*mais completo\* pro intel galileo, vinha com meia duzia de módulos.  Para ter noção, nem o cdc-acm veio junto (necessário pra maioria dos adaptadores USB-Serial atuais), e infelizmente, nem o driver da minha placa Wireless (apenas os dos wireless BEM recentes da intel estavam la).

Ponto negativo, porém com solução: Recompilar através do BSP.

O BSP eu vou resumir, por que foi um dia inteiro mexendo nele pra tentar fazer funcionar. O resumo é: extremamente incompleto e mal feito. Por que? Simples:

  1. Não é possível compilar nada dele se você está num sistema 64 bit ou até mesmo num sistema 32 bit com kernel 64 bit (chroot). O toolchain e scripts do BSP do Galileo tentam compilar uma versão 64 só por você ter um kernel 64 bit.
  2. Vários links quebrados dentro dos próprios scripts, e sem mirrors.

Instalei uma máquina virtual Ubuntu 12.04 32 bit (conforme usado num tutorial no site da própria intel) e agora estou vendo se vai ir, e corrigindo os links quebrados na mão.

Então enquanto compilava fui ler o FAQ e descobri a cagada final da Intel. Essa cagada é relativa a GPIO do Galileo: <https://communities.intel.com/message/207619>

Vou copiar a sentença:

> Q: What is the maximum rate at which GPIO output pins can be updated?  
> The GPIO output pins on Intel® Galileo are provided by an I2C Port Expander that is running at standard mode (100 kHz). Each I2C request to update a GPIO requires approximately 2ms. In addition to software overhead, this restricts the frequency achievable on the GPIO outputs to approximately 230 Hz.

**GPIO I2C? 100KHz? 2ms?**

**Intel, WHAT ARE YOU DOING?**

**      **Para uma placa pra brincar (como a maioria das pessoas que compra um arduino faz), isso é irrelevante. Mas pra 90% das aplicações práticas, isso praticamente inutilizou as GPIOs. Até mesmo um ATTiny (microcontrolador mais fuleiro que tem usando core AVR) tem um delay BEM mais baixo que isso. E qualquer ARM usado para finalidade do galileo, as GPIO são endereçadas diretamente na memória do processador e são pinos diretamente ligados a ele. A GPIO poderia ser PELO MENOS USB. Isso daria um delay BEM menor em relação ao I2C (que mesmo assim poderia rodar no modo de 400kHz). Isso dai praticamente tirou de cogitação usar somente a Galileo no QuadCopter. Eu preciso de uma taxa de atualização maior que 230Hz nas GPIOs.

Bom por enquanto é só isso. Eu vou enviar esta página para a Intel, e por isso vou colocar uma frase, e as sugestões para que a Intel possa melhorar o Galileo CASO ela realmente queira tentar continuar nesse mercado.

Intel, se você quis fazer algo pra ser um Raspberry Pi, você falhou miseravelmente não colocando uma GPU e colocando tão pouca memória RAM. Se você quis fazer um Arduino pra ser melhor que os mais novos com ARM, falhou miseravelmente com sua GPIO.

Sugestões? Claro, não adianta criticar se não tem ideias para melhorar. Minhas sugestões são:

  1.  A Quark é um x86 baseado num Pentium. O consumo dele é bem mais alto que os ARMs equivalentes, porém mesmo assim acho que deve existir uma GPU nele, com suporte a OpenGL e decodificador de videos em 1080p (talvez até 2k). Isso REALMENTE faz falta num microcontrolador atualmente.
  2. Coloque cabos USB inclusos no pacote.
  3. Coloque todas as portas seriais disponíveis de modo a acessar USB. Ninguém mais hoje usa porta serial com conector DB-9. Esse conector é extremamente arcaico e só se usa para dispositivos legados.
  4. Faça sua GPIO integrada. Isso foi um dos seus maiores vacilos no Intel Galileo, é extremamente simples implementar isso dentro do próprio Quark. Nem que fique somente 3v3 igual aos novos Arduino com ARM e o Raspberry Pi. É uma tendência existirem apenas dispositivos 3v3. Se não for integrar, PELO MENOS coloque uma GPIO USB e não I2C.
  5. Sobre a memória RAM. Essa é a menor prioridade, 256MB de memória RAM é um overkill pra um arduino. Mas pra competir com Raspberry Pi você vai precisar de bem mais que isso.
  6. A Hardkernel fabrica placas com processadores ARM quadcore de 1.9GHz, 2GB de ram, e tem shields GPIO USB. Custam um pouco mais do que o Intel Galileo, e tem BEM mais recursos que ele. Sugiro vocês tentarem acompanhar isso.