## It is not possible to dismiss a controller and present another within the same runloop.

http://openradar.appspot.com//19045528

Summary:
It is not possible to dismiss a controller and present another within the same runloop. This seems like an arbitrary restriction which is especially problematic with the transition to UIViewController-based alert views.

Steps to Reproduce:
Open the attached example, click on the button inside the popover, then check the log.

Expected Results:
Should show an alert view displaying “Will never be displayed”. But doesn’t happen.

Actual Results:
Shows another alert after some time explaining the bug.

Regression:
This worked with UIAlertView.

Notes:
Using a dispatch_async on the main thread would fix the issue, but this is code smell.

Tested on iOS 10 GM, not fixed.
