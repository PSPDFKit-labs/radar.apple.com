Peter Steinberger20-Nov-2014 07:10 PM

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

Update: June 8, 2016: Tested with iOS 9.3.2, same issue