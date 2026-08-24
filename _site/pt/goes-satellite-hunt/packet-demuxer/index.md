---
title: "Packet Demuxer - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → Packet Demuxer In the last chapter I showed how to get the frames from the demodulated bit stream. In this chapter I will show you how to parse these frames and get..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# Packet Demuxer

In the last chapter I showed how to get the frames from the demodulated bit stream. In this chapter I will show you how to parse these frames and get the packets that will on next chapter generate the files that GOES send. I will first add C code to the code I did in the last chapter to separated all the virtual channels by ID. But mainly this chapter will be done in python (just because its easier, I will eventually make a C code as well to do the stuff).

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
