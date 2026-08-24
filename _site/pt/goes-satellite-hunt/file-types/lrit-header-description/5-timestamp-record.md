---
title: "Timestamp Record - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → Timestamp Record This timestamp record contains a packed timestamp in CCSDS Time format. Name Type Description days uint16_t Number of days since January 1st, 1958 ms uint32_t Number of milliseconds of the..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# Timestamp Record

This timestamp record contains a packed timestamp in CCSDS Time format.

| Name | Type | Description |
| --- | --- | --- |
| days | uint16\_t | Number of days since January 1st, 1958 |
| ms | uint32\_t | Number of milliseconds of the day |

### Table 10 - Timestamp Record Fields

This timestamp is sent using a UTC timezone (GMT) but it’s not always present in all files.

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
