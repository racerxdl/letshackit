---
title: "Annotation Record - GOES Satellite Hunt | Lets Hack It"
description: "Written by Lucas Teske on 19 February 2017 Part of GOES Satellite Hunt Project overview → Annotation Record The annotation record is used for defining a filename for the LRIT file. It is optional according to LRIT specification but all files received so far contains it. For DCS Files this..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Written by Lucas Teske   
on 19 February 2017

# 

# Annotation Record

The annotation record is used for defining a filename for the LRIT file. It is optional according to LRIT specification but all files received so far contains it. For DCS Files this should be overrided with [DCS Filename Record](/goes-satellite-hunt/file-types/lrit-header-description/132-dcs-filename-record), since DCS files will also contain this field, but after content is extracted it should be named as the DCS Filename Header says.

| Name | Type | Description |
| --- | --- | --- |
| Filename | string (64) | The Filename |

### Table 9 - Annotation Record Fields

## Cite this work

### Suggested citation

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
