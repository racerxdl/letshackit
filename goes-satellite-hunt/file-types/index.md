---
title: File Types - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
citation_work: goes-satellite-hunt
---

# File Types

In last chapter we saw how to assemble our files , but we also need to know how to parse it. That part is somewhat tricky since even with the LRIT Protocol specification having some file formats, it heavily depends on how the manufacturer of the satellite and relay stations use it. Here I will describe the know file formats supported by [OpenSatelliteProject](https://github.com/opensatelliteproject) for GOES-13/14/15/16 LRIT and HRIT downlinks. It is known that MSG Satellites \(Meteosat\) have similar file types, but had not been tested by me.

These file formats are also described by the [xritparser](https://github.com/opensatelliteproject/xritparser) project, which is available from [PyPI](https://pypi.org/project/xrit/) and includes useful tools that will be described here.

<div class="pagination">
    <a href="{{ '/goes-satellite-hunt/file-assembler/viewing-the-files-content' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="lrit-header-description" class="right arrow">&#8594;</a>
</div>
