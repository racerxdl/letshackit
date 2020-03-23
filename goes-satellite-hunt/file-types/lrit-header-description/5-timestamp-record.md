---
title: Timestamp Record - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Timestamp Record

This timestamp record contains a packed timestamp in CCSDS Time format.

| Name | Type | Description |
| :--- | :--- | :--- |
| days | uint16\_t | Number of days since January 1st, 1958 |
| ms | uint32\_t | Number of milliseconds of the day |

### Table 10 - Timestamp Record Fields

This timestamp is sent using a UTC timezone \(GMT\) but it's not always present in all files.

<div class="pagination">
    <a href="{{ '4-annotation-record' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ '6-ancillary-text' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
