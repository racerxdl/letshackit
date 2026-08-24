---
title: "GOES Satellite Hunt | Lets Hack It"
description: "Um guia prático completo para receber o LRIT do GOES-13, do hardware de antena em banda L e da demodulação BPSK à decodificação CCSDS e à montagem de imagens meteorológicas."
image: "https://lucasteske.dev/assets/goes-satellite-hunt/g13fd.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

Guia de campo detalhado · GOES-13 · Publicado em 2017
# GOES Satellite Hunt

Monte uma estação terrestre em banda L e acompanhe cada transformação, das amostras de radiofrequência aos produtos meteorológicos LRIT completos. O guia conecta hardware prático de RF, GNU Radio, codificação de canal, quadros CCSDS, transporte de pacotes e arquivos de imagem como um único sistema.

[Comece pela motivação](/pt/goes-satellite-hunt/motivation)[Abrir o Open Satellite Project](https://github.com/opensatelliteproject)

 ![Imagem infravermelha de disco completo da Terra, recuperada da transmissão LRIT do GOES-13](/assets/goes-satellite-hunt/g13fd.png)

1. [Receber o sinal em banda L](/pt/goes-satellite-hunt/the-hardware-setup/)
2. [Recuperar os símbolos BPSK](/pt/goes-satellite-hunt/the-demodulator/)
3. [Decodificar os quadros CCSDS](/pt/goes-satellite-hunt/frame-decoder/)
4. [Extrair os canais virtuais](/pt/goes-satellite-hunt/packet-demuxer/)
5. [Montar os produtos LRIT](/pt/goes-satellite-hunt/file-assembler/)

## Do sinal à imagem

Um registro prático da investigação, organizado como um guia técnico reutilizável.

Este trabalho começou como uma série de cinco posts, escrita enquanto eu fazia a engenharia reversa do downlink do GOES-13 no fim de 2016. Reorganizei o material aqui para explicar toda a cadeia de recepção de forma coerente e mantê-lo útil junto à pesquisa do GOES-16 que veio depois.

A investigação levou diretamente ao [Open Satellite Project](https://github.com/opensatelliteproject). Muitas das mesmas ideias também se aplicam a satélites meteorológicos com protocolos de downlink relacionados, incluindo a família Meteosat.

## Capítulos

Leia em ordem para acompanhar o pipeline completo ou vá direto à camada que está implementando.

01Contexto
### Motivação

Por que receber o GOES diretamente, o que o projeto buscou demonstrar e como o sistema completo se encaixa.

[Começar o guia](/pt/goes-satellite-hunt/motivation)

02Hardware de RF
### Montagem do hardware

Monte a parabólica, construa um alimentador cilíndrico em guia de onda, adicione filtragem e amplificação e aponte a antena.

[Montar o receptor](/pt/goes-satellite-hunt/the-hardware-setup/)

03Processamento de sinais
### O demodulador

Mova o espectro gravado para a banda-base, filtre e reamostre, recupere portadora e relógio e produza símbolos BPSK.

[Recuperar os símbolos](/pt/goes-satellite-hunt/the-demodulator/)

04Codificação de canal
### Decodificador de quadros

Encontre o marcador de sincronização, resolva a ambiguidade de fase, aplique a decodificação de Viterbi e recupere quadros CCSDS de tamanho fixo.

[Decodificar os quadros](/pt/goes-satellite-hunt/frame-decoder/)

05Transporte
### Demultiplexador de pacotes

Desembaralhe o fluxo, corrija erros Reed–Solomon, separe canais virtuais e reconstrua pacotes espaciais.

[Extrair os pacotes](/pt/goes-satellite-hunt/packet-demuxer/)

06Produtos
### Arquivos e formatos LRIT

Processe cabeçalhos LRIT, descomprima imagens codificadas em Rice, nomeie os produtos e interprete o catálogo completo de arquivos.

[Montar os arquivos](/pt/goes-satellite-hunt/file-assembler/)

[Consultar a referência de arquivos LRIT](/pt/goes-satellite-hunt/file-types/)[Ler a conclusão](/pt/goes-satellite-hunt/ending)

Este guia é publicado sob a [licença Creative Commons Atribuição-CompartilhaIgual](https://creativecommons.org/licenses/by-sa/2.5/br/); correções são bem-vindas.

Agradeço à **#hearsat** comunidade no StarChat por me ajudar a aprender SDR de satélites, especialmente [@usa-satcom](https://twitter.com/usa_satcom) e [@devnulling](https://twitter.com/devnulling), e à minha família pelo apoio a um telhado cheio de parabólicas e antenas.

## Cite este trabalho

### Citação sugerida

Lucas Teske. “GOES Satellite Hunt.” _Lets Hack It_, 2017. [https://lucasteske.dev/goes-satellite-hunt/](https://lucasteske.dev/goes-satellite-hunt/).

### BibTeX

```
@misc{teske2017goessatellitehunt,
  author = {Teske, Lucas},
  title = {GOES Satellite Hunt},
  year = {2017},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/goes-satellite-hunt/}
}
```
