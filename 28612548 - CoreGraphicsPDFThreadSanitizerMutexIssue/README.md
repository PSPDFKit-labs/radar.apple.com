steipete | Home | Recent Comments | My Radars | Add a Radar | My API Key | Sign out 

 Search
Open Radar
Community bug reports
ThreadSanitizer: use of an invalid mutex (e.g. uninitialized or destroyed) (CoreGraphics+0x34650f) in ripl_retain
Originator:	steipete	Modify My Radar
Number:	rdar://28612548	Date Originated:	04-Oct-2016 08:06 PM
Status:	Open	Resolved:	
Product:	iOS SDK (CoreGraphics)	Product Version:	iOS 10GM
Classification:	Bug	Reproducible:	Always
 
Peter Steinberger04-Oct-2016 08:06 PM

Area:
Something not on this list

Summary:
While using ThreadSanitizer on PSPDFKit, we detected an issue in the CoreGraphics PDF backend. Looks like a mutex is used but not initialized.

This might go unnoticed or crash hard - it's undefined and is definitely bad; and at the same time a one-line code modification will fix that.

Steps to Reproduce:
Open Sample.
Run tests.
Observe Thread Sanitizer trigger.

Expected Results:
Thread Sanitizer should run through cleanly.

Actual Results:
==================
WARNING: ThreadSanitizer: use of an invalid mutex (e.g. uninitialized or destroyed) (pid=76396)
    #0 pthread_mutex_lock <null>:284 (libclang_rt.tsan_iossim_dynamic.dylib+0x00000003179e)
    #1 ripl_retain <null>:174 (CoreGraphics+0x00000034650f)
    #2 __invoking___ <null>:178 (CoreFoundation+0x00000007e05b)
    #3 start <null>:141 (libdyld.dylib+0x00000000468c)

  Location is heap block of size 144 at 0x7d240000dc80 allocated by main thread:
    #0 calloc <null>:284 (libclang_rt.tsan_iossim_dynamic.dylib+0x000000040702)
    #1 RIPLayerCreateUndefined <null>:174 (CoreGraphics+0x000000347eba)
    #2 __invoking___ <null>:178 (CoreFoundation+0x00000007e05b)
    #3 start <null>:141 (libdyld.dylib+0x00000000468c)

  Mutex M3247 (0x7d240000dcd0) created at:
    #0 pthread_mutex_lock <null>:284 (libclang_rt.tsan_iossim_dynamic.dylib+0x00000003179e)
    #1 ripl_retain <null>:174 (CoreGraphics+0x00000034650f)
    #2 __invoking___ <null>:178 (CoreFoundation+0x00000007e05b)
    #3 start <null>:141 (libdyld.dylib+0x00000000468c)

SUMMARY: ThreadSanitizer: use of an invalid mutex (e.g. uninitialized or destroyed) (CoreGraphics+0x34650f) in ripl_retain
==================

Version:
iOS 10 GM

Notes:
Thread Sanitizer is *seriously* awesome. Thank you!

Configuration:
iPad Pro 9.7 Simulator, Xcode 8 GM

Attachments:
Comments
Sample available at https://github.com/PSPDFKit-labs/radar.apple.com

By steipete at Oct. 4, 2016, 6:10 p.m. (reply...)  Edit  Remove
Add a comment 
Please note: Reports posted here will not necessarily be seen by Apple. All problems should be submitted at bugreport.apple.com before they are posted here. Please only post information for Radars that you have filed yourself, and please do not include Apple confidential information in your posts. Thank you!

Running on Google App Engine (HRD, Python 2.7). Source code on GitHub. Answers to Frequently Asked Questions. On Twitter.