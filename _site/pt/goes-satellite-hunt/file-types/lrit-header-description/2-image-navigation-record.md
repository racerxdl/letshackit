---
title: "Image Navigation Record - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → Image Navigation Record This header is one of the most interesting things you can get. It is used to map a specific pixel to a coordinate (latitude / longitude) in the image..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# Image Navigation Record

This header is one of the most interesting things you can get. It is used to map a specific pixel to a coordinate (latitude / longitude) in the image (and vice-versa). This header is not mandatory on any of the images, and some satellite relays doesn’t include it. For example Himawari 8 relays over GOES-16 doesn’t include Navigation Record. Open Satellite Project uses this header to generate Map Overlays and to define the coordinate of the center of the image (useful for non full disk scans).

| Name | Type | Description |
| --- | --- | --- |
| Projection Name | string ( 32 ) | The name of the Image Projection |
| Column Scaling Factor | uint32\_t | The Scaling Factor for each column |
| Line Scaling Factor | uint32\_t | The Scaling Factor for each line |
| Column Offset | uint32\_t | The Offset for Columns |
| Line Offset | uint32\_t | The Offset for Lines |

### Table 7 - Image Navigation Record Fields

For calculation of the Lat/Lon Coordinates a mathematical model described in [CGMS 03 - LRIT/HRIT Global Specification](http://www.cgms-info.org/documents/pdf_cgms_03.pdf) (page 20) should be used. A pratical implementation can be found on [Open Satellite Project GeoTools Class](https://github.com/opensatelliteproject/goesdump/blob/master/XRIT/Geo/GeoTools.cs).

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
