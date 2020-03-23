---
title: Image Structure Header - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Image Structure Header

This header is included on **any** image type, and contains information of how the image is encoded inside the LRIT file.

| Name | Type | Description |
| :--- | :--- | :--- |
| BitsPerPixel | uint8\_t | How many BitsPerPixel the image has |
| Columns | uint16\_t | Number of columns |
| Lines | uint16\_t | Number of lines |
| CompressionType | uint8\_t | Type of the Compression |

### Table 5 - Image Structured Header Fields

The first three fields are straight forward to understand since they're default image fields. They're required since most of the images are RAW compressed images and the parser needs to know how to process them. _BitsPerPixel_ defines how many bits each pixel has. Most images has 8 bits per pixel, meaning they're gray scale images with every byte representing an pixel. For some images that might come as 24 bits per pixel meaning its \(probably\) a RGB 8bpp image, meaning each pixel contains three bytes, each one representing one color. The _CompressionType_ field defines which type of compression is used to store the image. The table below shows the possible types.

| Value | Name |
| :--- | :--- |
| 0 | No Compression \(raw\) |
| 1 | Goloumb Rice \(LRIT Rice\) |
| 2 | JPEG |
| 5 | GIF |
| 10 | ZIP |

### Table 6 - CompressionType ENUM

For _JPEG_ / _GIF_ / _ZIP_ compression types it is possible to just dump the entire Data Section of the LRIT file and process it as a normal _JPEG_ / _GIF_ / _ZIP_ file. The relay stations doesn't remove any headers and the _Data_ section is a normal file. Actually OpenSatelliteProject does that when the _Compression Type_ field is any of these three values.

For Goloumb Rice \(know in NOAA libraries as LritRice\) the output is a RAW image data that should be processed acording to the fields _BitsPerPixel_, _Columns_, _Lines_. More details about the compression is described at [Rice Compression Record](/file-types/lrit-header-description/131-rice-compression-record.md), that will always come when _Compression Type_ field is LRIT RICE.

<div class="pagination">
    <a href="{{ 'primary-header' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '2-image-navigation-record' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
