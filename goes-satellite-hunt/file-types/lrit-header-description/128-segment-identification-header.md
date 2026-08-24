---
title: "Segment Identification Header - GOES Satellite Hunt | Lets Hack It"
description: "Written by Lucas Teske on 19 February 2017 Part of GOES Satellite Hunt Project overview → Segment Identification Header This header is used in Images to identify a segmented image data. It will only be present in images that are segmented in several LRIT files (which is most of LRIT..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Written by Lucas Teske   
on 19 February 2017

# 

# Segment Identification Header

This header is used in Images to identify a segmented image data. It will only be present in images that are segmented in several LRIT files (which is most of LRIT Rice compressed images).

| Name | Type | Description |
| --- | --- | --- |
| Image ID | uint16\_t | Image ID |
| Sequence | uint16\_t | The segment number |
| Start Column | uint16\_t | X Position of first column of this segment |
| Start Line | uint16\_t | Y Position of first line of this segment |
| Max Segments | uint16\_t | Total Number of Segments of the image |
| Max Columns | uint16\_t | Total number of columns of the image (across all segments) |
| Max Rows | uint16\_t | Total number of rows of the image (across all segments) |

### Table 13 - Segment Identification Header Fields

The fields of this header is pretty straight forward. It indicates how the final image should be assembled using the segments. By running Open Satellite Project for a long time I found that all images come segmented by horizontal segments meaning that all _Start Column_ should be same across the same image segments. For identifying the Image one should use _Image ID_ field, that is the same across all segments of same image. The fields _Max Columns_ and _Max Rows_ should be used for pre-allocating the buffer (if needed) for assembling the final image.

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
