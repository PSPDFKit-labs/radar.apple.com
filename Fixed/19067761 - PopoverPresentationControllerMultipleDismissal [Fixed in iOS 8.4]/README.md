## Dismissing a popover can also lead to dismissing it's parent controller (regression)

http://openradar.appspot.com/19067761

Summary:
Dismissing a popover can also lead to dismissing it's parent controller if the user double-taps to dismiss. This is a regression from iOS 7 where it works as expected.

Steps to Reproduce:
Open the attached example, then read the instructions in the alert and double-tap into the yellow area do see the issue.

Expected Results:
Should only ever dismiss the popover it controls, not the parent.

Actual Results:
Dismisses the parent as well.

Regression:
This works under iOS 7 and is a regression in iOS 8. The example isn’t built to be run under 7, but with changing this to a UIPopoverController it shows the same bug, but works fine on 7.

Notes:
The sample also shows UIKit pseudocode where you see that someone forgot checking [controller dismissing] in the code path where the delegate isn’t implemented - that’s whys simply implementing the delegate actually fixes the issue.
