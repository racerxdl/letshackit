---
title: Primary Header - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Primary Header

The Primary Header is a _single_ header that contains:

| Name | Type | Description |
| :--- | :--- | :--- |
| File Type Code | uint8\_t | Type Code of the file content |
| Header Length | uint32\_t | Combined Size of Primary + Secondary Headers |
| Data Length | uint64\_t | Size of the data inside this file |

### Table 3 - Primary Header Fields

The File Type Code is a ENUM that contains the following values:

| Name | Value |
| :--- | :--- |
| Image | 0 |
| Messages | 1 |
| Text | 2 |
| Encryption Key | 3 |
| Reserved | 4 |
| Meteorological Data | 128 |
| DCS | 130 |
| EMWIN | 214 |

### Table 4 - FileTypeCode ENUM Values

---

Sadly, at least NOAA Stations for GOES 13 / 16 doesn't always follow that file type codes, so I usually ignore them or just use for a preliminary processing just for display purpose. For example a EMWIN data might come with a Meteorological Data. There is other ways to detect the file type that will be described later, so I do not recommend using this field for checking the content type.

The secondary headers are just inlined in the rest of the header data. Since they have diferent lengths, you should always parse the HeaderType field \(that is present on all headers, primary or secondary\) to see how long the header is. They don't have any specific order and might come not ordered by it's type \(for instance the NOAA Specific Header \(type 129\) can come as first secondary header, and Image Structure Header \(type 1\) as a second secondary header\). In the next sections I will describe each one of the header types and when you should expect them.

<div class="pagination">
    <a href="{{ '/goes-satellite-hunt/file-types/lrit-header-description' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '1-image-structure-header' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
