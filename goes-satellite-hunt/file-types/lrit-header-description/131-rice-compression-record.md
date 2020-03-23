---
title: Rice Compression Record - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Rice Compression Record

This header exposes the LRIT Rice \(Gouloumb Rice\) compression parameters to be able to decompress the data from LRIT file.

| Name | Type | Description |
| :--- | :--- | :--- |
| Flags \(or mask\) | uint16\_t | Flags for Decompression |
| Pixels per Block | uint8\_t | Number of pixels per decompression block |
|  |  |  |

### Table 18 - Rice Compression Record Fields

NOAA uses Goloumb Rice to compress the ABI Sensor Images. NOAA provided a static library to be used to decompress the images for Windows and Linux. Sadly both versions are very old and the linux library is broken due GCC ABI Changes. Luckily talking with some people at NOAA, I discovered that their LritRice compression algorithm is actually [SZip](https://support.hdfgroup.org/doc_resource/SZIP/) \(same used in NetCDF\).

Although SZip algorithm is proprietary, NASA is the copyright holder and doesn't plan to keep the patent \(see [patent.txt](https://github.com/erget/libaec/blob/cmake-install-instructions/doc/patent.txt)\), even so, the algorithm itself has some restrictions that doesn't forbidden to use for decompressing. Metioning the HDFGroup Licensing Terms:

> Commercial users may use the software to decode any data. Further, they may use the software in internal activities that do not involve or result in the development of an Szip-based software product.  
> [https://support.hdfgroup.org/doc\_resource/SZIP/](https://support.hdfgroup.org/doc_resource/SZIP/)

That means we're free to use it for decompressing the LRIT file.

I checked the HDF4 source code, and it looked very confusing and bad, luckily I found a nice alternative called [Adaptive Entropy Coding library](https://github.com/erget/libaec) that works really nice and fast \(and also have a compatibility wrapper for SZip\). It is also available in most of modern linux distributions which makes easier to use.

For anyone that is using the NOAA LritRice library and wants to switch to libaec \(it works under windows as well\), in Open Satellite Project I did [a wrapper](https://github.com/opensatelliteproject/decompressor) that exposes a single function to decompress with the same usage of the LritRice.

```c
int LIBSATDECOMPRESS_API Decompress(char *input, char *output, size_t inputLength, size_t outputLength, int bitsPerPixel, int pixelsPerBlock, int pixelsPerScanline, int mask) {
  SZ_com_t params;

  mask = mask | SZ_RAW_OPTION_MASK; // By default NOAA dont as for RAW, but their images are RAW. No Compression header.

  params.options_mask = mask;
  params.bits_per_pixel = bitsPerPixel;
  params.pixels_per_block = pixelsPerBlock;
  params.pixels_per_scanline = pixelsPerScanline;

  size_t destLen = pixelsPerScanline;
  int status = SZ_BufftoBuffDecompress(output, &destLen, input, inputLength, &params);

  return status != AEC_OK ? status : destLen;
}
```

For the method parameters map:

1. input - The Input Data
2. output - The Output Buffer
3. inputLength - The size of the input buffer
4. outputLength - The size of the output buffer
5. bitsPerPixel  - How many bits per pixel \(usually 8, but can be seen at [Image Structure Header](/file-types/lrit-header-description/1-image-structure-header.md) \)
6. pixelsPerBlock - Number of pixels per compression block
7. pixelsPerScanLine - Number of pixels in a line \( can also be seen at [Image Structure Header](/file-types/lrit-header-description/1-image-structure-header.md)  \) 

The expected decompressed output size \(in bytes\) should be calculated with being:

```
(columns * lines * bitsPerPixel) / 8
```

<div class="pagination">
    <a href="{{ '130-header-structured-record' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '132-dcs-filename-record' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
