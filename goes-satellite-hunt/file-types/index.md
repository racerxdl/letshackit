---
title: File Types - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# File Types

In last chapter we saw how to assemble our files , but we also need to know how to parse it. That part is somewhat tricky since even with the LRIT Protocol specification having some file formats, it heavily depends on how the manufacturer of the satellite and relay stations use it. Here I will describe the know file formats supported by [OpenSatelliteProject](https://github.com/opensatelliteproject) for GOES-13/14/15/16 LRIT and HRIT downlinks. It is known that MSG Satellites \(Meteosat\) have similar file types, but had not been tested by me.

These file formats are also described in [xritparser](https://github.com/opensatelliteproject/xritparser) project that is available in [python pip and runs](/pypi.python.org/pypi/xrit) on windows and have few useful tools that will be described.

<div class="pagination">
    <a href="{{ '/goes-satellite-hunt/file-assembler/viewing-the-files-content' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'lrit-header-description' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
