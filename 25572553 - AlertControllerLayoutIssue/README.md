## UIAlertController doesn't lay itself out correctly if no title is set - weird edges ahead!

http://openradar.appspot.com/25572553

Summary:
UIAlertController doesn't lay itself out correctly if no title is set.

Steps to Reproduce:
Open sample, press black button. Run with iPad Air 2. Notice that the borders are incorrect. Screenshot: http://cl.ly/2t2R1Z3O2K44

Expected Results: Discussable.

1) UIActionSheet actually presented itself IN the popover. I would prefer this style, it’s also more in line with Apple’s HIG of only showing one popover at all times.

2) If this isn’t possible (and it certainly would be a larger change) let’s at least make the layout correct. We got support requests at PSPDFKit where our customers complained for this bug, and it sucks that I have to tell them that it’s actually a UIKit problem and we’ll have to find some kind of terrible workaround that probably involves doing unspeakable things that might cause forward compatibility issues.

Actual Results:
Borders should not be cut off.

Regression:
This didn’t happen with UIActionSheet, however that one also presents differently.

Notes:
Doesn’t happen for all sides, definitely happens when the button is on the right side.
