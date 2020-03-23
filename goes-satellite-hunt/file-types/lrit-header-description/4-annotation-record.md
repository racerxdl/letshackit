---
title: Annotation Record - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Annotation Record

The annotation record is used for defining a filename for the LRIT file. It is optional according to LRIT specification but all files received so far contains it. For DCS Files this should be overrided with [DCS FIlename Record](/file-types/lrit-header-description/132-dcs-filename-record.md), since DCS files will also contain this field, but after content is extracted it should be named as the DCS Filename Header says.

| Name | Type | Description |
| :--- | :--- | :--- |
| Filename | string \(64\) | The Filename |

### Table 9 - Annotation Record Fields

<div class="pagination">
    <a href="{{ '3-image-data-function-record' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '5-timestamp-record' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
