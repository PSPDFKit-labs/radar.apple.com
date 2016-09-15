## UIPrintInteractionController crashes when being presented.

http://openradar.appspot.com/20963891

Summary:
UIPrintInteractionController keeps an unsafe_unretained reference to an object that can be deallocated, causing a crash.

Steps to Reproduce:
Open Example. Tap button a few times. Observe crash. Enable Zombies to see *** -[UINavigationController _popoverController]: message sent to deallocated instance 0x7fca83c0b390.

Expected Results:
No Crash.

Actual Results:
Crash.

Notes:
There seem to be some improvements in iOS 8.4b3 where it doesn’t crash as often, but it’s still pretty easy to get it to crash if you tap the button a bit faster.
