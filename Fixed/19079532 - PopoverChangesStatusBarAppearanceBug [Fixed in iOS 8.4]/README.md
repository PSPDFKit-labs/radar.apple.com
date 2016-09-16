## Presenting UIImagePickerController in a popover changes the status bar and also doesn't reset it.

http://openradar.appspot.com/19079532

Summary:
Presenting UIImagePickerController in a popover changes the status bar and also doesn't reset it.

Here’s an animated gif of the issue: http://cl.ly/image/393x3M2B1V1u

Steps to Reproduce:
Open the example, watch.

Expected Results:
A popover should never modify the status bar.

Actual Results:
The popover messes with the status bar.

Regression:
Works as expected in iOS 7. The example needs to be modified to use UIPopoverController, but the behavior on iOS 8 is the same broken one.

Notes:
Example is in Swift for extra fun :)
