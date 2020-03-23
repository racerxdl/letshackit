---
title: NOAA Specific Header - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# NOAA Specific Header

This header specifies some of NOAA specific stuff meaning it is only applicable for GOES Satellites.

| Name | Type | Description |
| :--- | :--- | :--- |
| Signature | string \(4\) | "NOAA" |
| Product ID | uint16\_t | Product ID of the file |
| Sub Product ID | uint16\_t | Sub Product ID of the file |
| Parameter | uint16\_t | A product / sub product specific parameter |
| Compression Type | uint8\_t | Compression Type |

### Table 14 - NOAA Specific Header Fields

This header is very useful for defining the type of the file and how to process it. Open Satellite Project uses both _Product ID_ and _Sub Product ID_ fields to decide how to process the LRIT file.

| Value | Description |
| :--- | :--- |
| 0 | No Compression |
| 1 | Lossless Compression |
| 2 | Lossy Compression |

### Table 15 - NOAA Specific Header Compression Type Enum

| Value | Description |
| :--- | :--- |
| 1 | NOAA Text |
| 3 | Other Satellites Relay \(Satellite Specific\) |
| 4 | Other Satellites Relay \(Satellite Specific\) |
| 6 | Weather Data |
| 7 | ABI Relay |
| 8 | DCS |
| 9 | HRIT EMWIN |
| 13 | GOES 13 ABI |
| 14 | GOES 14 ABI |
| 15 | GOES 15 ABI |
| 16 | GOES 16 ABI |
| 42 | EMWIN |
| 43 | HIMAWARI 8 ABI |

### Table 16 - NOAA Product ID Enum

For more details of _Product _/ _Sub Product_ IDs please refer to Open Satellite Project Source Code \( [XRIT/PacketData/Presets.cs](https://github.com/opensatelliteproject/goesdump/blob/70a99e3eb089fd2421133e05766c38541ab32fbf/XRIT/PacketData/Presets.cs) \)

<div class="pagination">
    <a href="{{ '128-segment-identification-header' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '130-header-structured-record' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
