## UIPopover + Keyboard = App freezes.

http://openradar.appspot.com/19556505

Summary:
Presenting a keyboard from within a popover can result in a state where the application is completely frozen.

Steps to Reproduce:
Launch example. Tap the “Okay, let’s freeze!” button and observe the process to make it freeze.

Expected Results:
See a text field in the popover.

Actual Results:
Application completely freezes, UIKit loops within layoutSublayers endlessly. There’s no way to get the app into a working state again.

Regression:
Works correctly under iOS 7.1 (uncomment the old popover logic to try it in the example)

Notes:
Haven’t found a great workaround for this nasty bug yet. Any comments greatly appreciated.
