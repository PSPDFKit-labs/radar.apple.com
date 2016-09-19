## Reading an alert controller’s popoverPresentationController property changes behavior

http://openradar.appspot.com/27448488

Summary:
A view controller in a regular width presents a second view controller such that the second view controller is in a compact width. For example by using the `formSheet` or `popover` presentation style. The second view controller then presents an alert controller with the action sheet style. The resulting presentation style of the alert controller depends on whether its popoverPresentationController property is read. (See actual results below.)

The popoverPresentationController source location ought to be set up in the interests of separating concerns, since the view controller should not make assumptions about how it is presented. It might be presented full screen in a different part of the app. The view controller should not have to know about this.

If someone wants to show the action sheet as a sheet inside a popover or form sheet, that person should be very sure about the context the view controller is presented in to be sure it never goes into a regular width environment, remembering that even if the presenting view controller is in a compact width at the time of presentation, that might change while the presentation is active.

Steps to Reproduce:
1. Run attached sample on iPad, fullscreen, iOS 10
2. Observe the action sheet shows as a sheet
3. Change SHOW_AS_SHEET in SecondViewController.m to 0
4. Run again and observe the action sheet shows as a popover

Expected Results:
I wound definitely not expect reading popoverPresentationController to change behaviour.

Since the alert controller is presented from a compact width, I think I would expect an inline sheet rather than a popover.

What would be super awesome is if setting the modalPresentationStyle had an effect so we could choose between `popover` and `overCurrentContext` — and maybe `overFullScreen` and `custom` too.

Actual Results:
If the alert controller’s popoverPresentationController is set up with a source location, then the action sheet appears as a popover. If the popoverPresentationController is not read at all, then the action sheet appears as a sheet. If the popoverPresentationController is read, but the source location is not set up, UIKit tries to use a popover but raises the exception about missing source location.

Version:
iOS 10 beta 2, Xcode 8 beta 2

Notes:
We keep up-to-date sample projects at https://github.com/PSPDFKit-labs/radar.apple.com

Configuration:
iPad Pro big, iPad Pro small simulator

Tested on iOS 10 GM, not fixed.
