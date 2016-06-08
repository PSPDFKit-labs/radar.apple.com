Summary:
When a view controller is not the status bar view controller, its presented view controllers can not become the status bar view controller. For example, when a popover presented a view controller full screen, the full screen view controller is not used to specify the status bar appearance.

Steps to Reproduce:
1. Open and run the attached sample project, which has three view controllers: Master, Little, and Big. Initially Master is the status bar view controller.
2. Tap anywhere to make Master present Little in a popover.
3. Tap Little to make it present Big full screen.

Expected Results:
The full screen view controller, Big, should specify the status bar appearance, so it should use dark text (UIStatusBarStyleDefault).

Actual Results:
Master is still being used for the status bar appearance, so it uses light text (UIStatusBarStyleLightContent).

Version:
iOS 9, Xcode 7.0 beta 6 (7A192o)

Notes:
Workaround:

The view controller in the popover can set its modalPresentationCapturesStatusBarAppearance to YES, then forward its presenting view controller’s status bar preferences.

Configuration:
Various iPhone and iPad simulators

Still issue in iOS 9.3.2