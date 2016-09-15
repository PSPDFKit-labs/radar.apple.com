## With certain configurations, it's possible that during a popover dismissal the parent container also gets dismissed.

http://openradar.appspot.com/18512973

Summary:
With certain configurations, it's possible that during a popover dismissal the parent container also gets dismissed.

Steps to Reproduce:
1. Open PopoverDismissalRegression, iPad iOS 8
2. Watch how the modal sheet appears and the popover.
3. Tap outside of the popover to dismiss it
4. Observe that the parent modal controller also disappears.
5. Try the same with iOS 7.1 and see that it works as expected.

Expected Results:
No dismissal of the parent view controller

Actual Results:
Parent vc is dismissed as a regression from iOS 7.

Version:
iOS 8

Notes:


Configuration:
iPad Simulator