## UIPresentationController adaptivePresentationStyle is not called

http://openradar.appspot.com/22394107

Summary:
-[UIPresentationController adaptivePresentationStyle] is not called, and not deprecated.

My investigation suggests -[UIPresentationController adaptivePresentationStyle] is not called  if the app is linked on or after iOS 8.3. It is replaced by -[UIPresentationController adaptivePresentationStyleForTraitCollection:].

Steps to Reproduce:
1. Open the attached sample project with Xcode 7, which attempts to adapt to full screen for horizontally compact size classes, and logs when adaptivePresentationStyle is called.
2. Run it
3. Look for adaptivity, and look in the console

Expected Results:
For either this method to be called, or for it to be marked as deprecated, or at least documented as not being called. (My preference is deprecation.)

The presented view should be full screen on iPhone 6 Plus in portrait and a small box in the corner in landscape.

Actual Results:
This method is not called (nothing logged in the console), and nothing in the documentation suggests this method would not be called.

The view is in the example never adaptive, always appearing in the top left corner of the container.

Version:
iOS 9 beta 5

Notes:
Related bug: 22394065

Configuration:
iPhone 6 Plus simulator
