---
title: Header Structured Record - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Header Structured Record

This header contains the headers information a structured string

| Name | Type | Description |
| :--- | :--- | :--- |
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

<div class="pagination">
    <a href="{{ '129-noaa-specific-header' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '131-rice-compression-record' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
