---
title: "Header Structured Record - GOES Satellite Hunt | Lets Hack It"
description: "Written by Lucas Teske on 19 February 2017 Part of GOES Satellite Hunt Project overview → Header Structured Record This header contains the headers information a structured string Name Type Description Data string Data Table 17 - Header Structured Record Fields Example: NOAALRIT 1 NLfieldlen 2 NLagency 4 CHAR NLprodID..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Written by Lucas Teske   
on 19 February 2017

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
