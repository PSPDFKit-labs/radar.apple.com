http://openradar.appspot.com/32482871

Originator:	steipete	
Number:	rdar://32482871	Date Originated:	31-May-2017 10:46 AM
Status:	Open	Resolved:	
Product:	iOS + SDK	Product Version:	10.3.2
Classification:	Crash/Hang/Data Loss	Reproducible:	Always
 
Summary:
Creating too many background tasks overloads Springboard and crashes it, or makes the whole OS act weird / no longer opens apps, causes resprings and so on. See https://twitter.com/steipete/status/869822321216933889 for a video.

Steps to Reproduce:
Open attached Sample and run on device.

Expected Results:
Creating excessive background tasks should not impact Springboard.

Actual Results:
Springboard (and thus, objectively the whole OS) gets sluggish.

Version:
10.3.2

Notes:
We ran into this bug with https://pdfviewer.io/ only after releasing the update and got a ton of 1-star reviews and were multiple days in emergency mode before we found the cause.

We wrapped all access to file coordination into background tasks, which caused the excessive creation (not as excessive as in this example, but still enough to cause crashes). We got reports of whole resprings with the Apple logo but mostly observed the issues in the video of my tweet: https://twitter.com/steipete/status/869822321216933889

Other people (OvercastFM) ran into this as well. This is more widespread and many people do not know about this edge case.

We wrapped the coordination calls because older documentation (iOS 7) stated that this is a requirement, before the documentation was silently updated to state that file coordinators take care of creating background tasks directly.