---
title: "Image Data Function Record - GOES Satellite Hunt | Lets Hack It"
description: "Written by Lucas Teske on 19 February 2017 Part of GOES Satellite Hunt Project overview → Image Data Function Record This header describes the physical meaning of the Image included in the LRIT File. It may contain calibration data depending on the image type. Name Type Description Data string Data..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Written by Lucas Teske   
on 19 February 2017

# 

# Image Data Function Record

This header describes the physical meaning of the Image included in the LRIT File. It may contain calibration data depending on the image type.

| Name | Type | Description |
| --- | --- | --- |
| Data | string | Data |

### Table 8 - Image Data Function Record Fields

The _Data_ field is consisted by several map values in `key := value` format with some special meanings.

| Key | Description |
| --- | --- |
| $HALFTONE | Specifies a Halftone Grayscale Data. |
| $DISCRETE | Specifies a Discrete Type that each value has a specific meaning |
| $OVERLAY | Specifies a Overlay Data |
| \_NAME | Name of the image |
| \_UNIT | Unit used for the data |
| _a number_ | A map to defined values |

This is usually used for marking overlays or calibration data. One great example to explain is a thermal infrared channel that has a map for each pixel value to it’s corresponding temperature. In this case, there will be a _$HALFTONE_ field defined with the number of bits that are relative to the map, a _\_UNIT_ field with the type of unit, for example _Degrees Kelvin_, and then several `number := number` maps representing each value. For example:

```
$HALFTONE:=8
_NAME:=Calibrated Infrared
_UNIT:=Degree Kelvin
0:=330
1:=329.5
2:=329
3:=328.5
4:=328
5:=327.5
6:=327
7:=326.5
8:=326
9:=325.5
10:=325
11:=324.5
12:=324
13:=323.5
(...)
```

A pixel with value 11 mean its temperature is 324.5 Degrees Kelvin.

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
