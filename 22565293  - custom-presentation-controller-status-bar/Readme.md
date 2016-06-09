Summary:
When a view controller is presented, it may or may not become the view controller specifying the appearance of the status bar. There is no public API to control this,  forcing custom UIPresentationController subclasses to make their presented view controller the status bar view controller.

Regression:

Behaviour appears to have changed in iOS 8.3. iOS 8.1 has the opposite problem of the status bar never changing for custom presentation controllers.

Workaround:

There is a private method that can be overridden to achieve the desired result. 

_shouldChangeStatusBarViewController

Set FIX_USING_PRIVATE_API to 1 in CentralPresentationController.m to enable this and see that everything works.

Using modalPresentationCapturesStatusBarAppearance on the presented view controller is not appropriate because this is only queried if the presentation controller returns NO to _shouldChangeStatusBarViewController.

Steps to Reproduce:
1. Open and run the attached sample project on any iOS device or simulator.
2. Tap to present a view controller with a custom presentation controller

Expected Results:
We do not want the presented view controller to be used for the status bar in this case, as it does not occupy the top portion of the screen. There should be a way for the presentation controller to specify this is desired.

Actual Results:
The presented view controller is used for the status bar, resulting in black on dark green, which is hard to read. Searching for ‘status bar’ on the UIPresentationController class reference returns no results.

Version:
iOS 9 beta 5, Xcode 7.0 beta 6 (7A192o)

Notes:
It would make sense to me if _shouldChangeStatusBarViewController was replaced by a public property on UIPresentationController returning an enum with three possible values:

• Always change status bar view controller, ignoring modalPresentationCapturesStatusBarAppearance (presented view is opaque, covering the top of the screen — e.g. full screen)
• Never change status bar view controller, ignoring modalPresentationCapturesStatusBarAppearance (presented view does not cover the top of the screen — e.g. popover)
• Defer to the presented view controller’s modalPresentationCapturesStatusBarAppearance (presented view covers the top of the screen and may be transparent — e.g. over full screen)

Configuration:
iPad Air, various simulators

Still reproducible in iOS 9.3.2