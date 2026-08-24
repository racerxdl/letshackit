---
title: "Header Structured Record - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → Header Structured Record This header contains the headers information a structured string Name Type Description Data string Data Table 17 - Header Structured Record Fields Example: NOAALRIT 1 NLfieldlen 2 NLagency 4..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# Header Structured Record

This header contains the headers information a structured string

| Name | Type | Description |
| --- | --- | --- |
| Data | string | Data |

### Table 17 - Header Structured Record Fields

Example:

```
NOAALRIT 1
      NLfieldlen 2
      NLagency 4 CHAR NLprodID 2
      NLprodSubID 2
      NLprodParm 2
      NLcompressflag 1
      ImageStruct 1
      ISfieldlen 2
      ISbitsperpix 1
      ISimagecols 2
      ISimagelines 2
      IScompressflag 1
```

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
