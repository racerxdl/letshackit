---
title: "File Types - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → File Types In last chapter we saw how to assemble our files , but we also need to know how to parse it. That part is somewhat tricky since even with the..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# File Types

In last chapter we saw how to assemble our files , but we also need to know how to parse it. That part is somewhat tricky since even with the LRIT Protocol specification having some file formats, it heavily depends on how the manufacturer of the satellite and relay stations use it. Here I will describe the know file formats supported by [OpenSatelliteProject](https://github.com/opensatelliteproject) for GOES-13/14/15/16 LRIT and HRIT downlinks. It is known that MSG Satellites (Meteosat) have similar file types, but had not been tested by me.

These file formats are also described by the [xritparser](https://github.com/opensatelliteproject/xritparser) project, which is available from [PyPI](https://pypi.org/project/xrit/) and includes useful tools that will be described here.

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
