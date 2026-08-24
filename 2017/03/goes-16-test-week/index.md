---
title: "GOES 16 Test Week | Lets Hack It"
description: "NOAA's GOES-16 test week runs March 27-31. Discover the HRIT and CMI downlink schedules and how to receive satellite imagery using OpenSatelliteProject."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# GOES 16 Test Week

Written by Lucas Teske   
on 25 March 2017

Yesterday I received an email from NOAA (I’m on their “tester” list) about some tests on GOES-16 that will happen this week. Before I start talking about what will be the tests I want to be clear that GOES-16&nbsp; **is NOT operational ye**** t **and any data received from the LRIT/HRIT downlink are&nbsp;** test only data **.** This means the user of that link assumes all risks related to the use of their data and NOAA disclaims and any and all warranties, whether express or implied, including (without limitation) any implied warranties of merchantability or fitness for a particular purpose.**

So this week ( from 27th to 31st March ) HRIT will go into a new test phase that will send out DCS, Environmental Messages and charts through. They also will send from 16h to 20h UTC on Monday (27th) some CMI (Cloud and Moisture Imaging) data. That might be interesting for anyone that have a 1.5m+ dish that can run Linear Polarization at 1694MHz and be interested in trying out the super-alpha version of OpenSatelliteProject, that is already compatible to HRIT.

Please keep in mind that while OSP does support HRIT, it doesn’t mean it will support the new products coming out from HRIT link. They’re currently testing sending NetCDF files over HRIT, and so far OSP doesn’t support those. In normal case (no bugs) the output product should be stored in a folder named Unknown with the filename provided by NOAA. Regardless of that I will be trying to record the IQ / decoder output in the CMI period and run the OSP over all week in GOES-16.

While running in GOES-16 the Twitter / Instagram bots will not be outputting any GOES-13 data (sadly I only have one dish so far) but may output the products from GOES-16.

Some useful links for you if you’re interested in more information:

- OpenSatelliteProject help chat:&nbsp;[https://osp.teske.net.br](https://osp.teske.net.br)
- OpenSatelliteProject forum:&nbsp;[http://hearsat.online/viewforum.php?f=18](http://hearsat.online/viewforum.php?f=18)
- OpenSatelliteProject Twitter:&nbsp;[https://twitter.com/OpenSatProject](https://twitter.com/OpenSatProject)
- OpenSatelliteProject Instagram: [http://instagram.com/opensatelliteproject/](http://instagram.com/opensatelliteproject/)
- OpenSatelliteProject Github:&nbsp;[https://github.com/opensatelliteproject](https://github.com/opensatelliteproject)
- GOES-16 Mission Information:&nbsp;[http://www.goes-r.gov/](http://www.goes-r.gov/)

## Cite this article

### Suggested citation

Lucas Teske. “GOES 16 Test Week.” _Lets Hack It_, 2017. [https://lucasteske.dev/2017/03/goes-16-test-week/](https://lucasteske.dev/2017/03/goes-16-test-week/).

### BibTeX

```
@misc{teske2017goes16testweek,
  author = {Lucas Teske},
  title = {GOES 16 Test Week},
  year = {2017},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/2017/03/goes-16-test-week/}
}
```
