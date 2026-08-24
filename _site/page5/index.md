---
title: "Home | Lets Hack It"
description: "August 05, 2017 Linux shim for Patching executable in run-time Linux shim for Patching executable in run-time That’s something I already did a long time and few people know. It’s not something hard or complex to do, but few people know how easy is to make a Library Shim. First,..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

August 05, 2017
# [Linux shim for Patching executable in run-time](/2017/08/linux-shim-for-patching-executable-in-run-time/)

Linux shim for Patching executable in run-time That’s something I already did a long time and few people know. It’s not something hard or complex to do, but few people know how easy is to make a Library Shim. First, what’s a shim? A shim is a small library that can intercept API calls transparently for a specific program / library. Basically it’s a proxy library that can transparently intercept some API calls to either change the content, monitor the data or just making a API translation. That has its variants over all Operating Systems (Linux, Mac OSX, Windows) but...

April 14, 2017
# [Some LNA tests for HRIT/LRIT](/2017/04/some-lna-tests-for-hritlrit/)

 ![](/wp-content/uploads/2017/04/20170413_133029-624x351.jpg)

So I was talking with @luigi on OSP RocketChat and he noticed that one of the LNA’s I suggested along with the LNA4ALL (the SPF5189) got a comment on ebay saying that it doesn’t work on L Band. So that was weird to me, since I have 5 of them, and one currently in use with my GOES setup. So I decided to do a small and crude benchmark for L Band comparing no LNA with LNA4ALL and SPF5189. So the test I wanted to do was pretty simple: check how the LNAs was effective over LRIT/HRIT band (L Band...

April 02, 2017
# [GOES 16 Test Week Results](/2017/04/goes-16-test-week-results/)

 ![](/wp-content/uploads/2017/04/goes-16-abi-624x312.jpg)

In the week from March 27th to 31 NOAA performed some new downstream tests over HRIT link on GOES-16. The idea was to transfer some CMI (Cloud and Moisture Imaging) products and see if the software developers and current stations could receive it fine. Before starting talking about that, please notice that&nbsp;all data sent so far is stated as&nbsp;test data and should not be used for any real world measurements. As NOAA states (and I forwarded on my last post): The user of that link assumes all risks related to the use of their data and NOAA disclaims and any...

March 25, 2017
# [GOES 16 Test Week](/2017/03/goes-16-test-week/)

Yesterday I received an email from NOAA (I’m on their “tester” list) about some tests on GOES-16 that will happen this week. Before I start talking about what will be the tests I want to be clear that GOES-16&nbsp;is NOT operational yet and any data received from the LRIT/HRIT downlink are&nbsp;test only data. This means the user of that link assumes all risks related to the use of their data and NOAA disclaims and any and all warranties, whether express or implied, including (without limitation) any implied warranties of merchantability or fitness for a particular purpose. So this week (...

January 25, 2017
# [GOES 16 in the house!](/2017/01/goes-16-in-the-house/)

 ![](/wp-content/uploads/2017/01/201701251701745-10-624x624.gif)

Few \*times\* ago I started to check on GOES 16 transmissions to see if I can get any data from it and make OpenSatelliteProject work with it. Me and @usa\_satcom noticed that the HRIT signal was transmitting using differential encoding that was not predicted on NOAA’s HRIT Specification (You can check it here&nbsp;http://www.goes-r.gov/users/hrit-links.html ). So I decided to send an email to NOAA asking what was the current HRIT specs for GOES-16. Of course I expected no answer from them (they would probably be really busy with GOES-16 Testing), but surprisingly they answered sending the specs and saying that any...
