## Rotation callbacks are called twice for controllers within a UISplitViewController

http://openradar.appspot.com/19810773

Summary:
Observe that all rotation callbacks in the content view controller are called twice; once from the UISplitViewController and a second time from the UIPresentationController. This is a regression from iOS 7; where they were simply called from UISplitViewController.

Steps to Reproduce:
Open attached sample, rotate iPad Simulator; observe this:

2015-02-12 12:46:01.236 SplitViewControllerRotationCallbackCalledTwice[66805:1957569] Called -[ContentViewController willRotateToInterfaceOrientation:duration:]
2015-02-12 12:46:01.237 SplitViewControllerRotationCallbackCalledTwice[66805:1957569] Called -[ContentViewController willRotateToInterfaceOrientation:duration:]
2015-02-12 12:46:01.239 SplitViewControllerRotationCallbackCalledTwice[66805:1957569] Called -[ContentViewController willAnimateRotationToInterfaceOrientation:duration:]
2015-02-12 12:46:01.242 SplitViewControllerRotationCallbackCalledTwice[66805:1957569] Called -[ContentViewController willAnimateRotationToInterfaceOrientation:duration:]
2015-02-12 12:46:01.655 SplitViewControllerRotationCallbackCalledTwice[66805:1957569] Called -[ContentViewController didRotateFromInterfaceOrientation:]
2015-02-12 12:46:01.655 SplitViewControllerRotationCallbackCalledTwice[66805:1957569] Called -[ContentViewController didRotateFromInterfaceOrientation:]

Expected Results:
Rotation callbacks should be called only once and in correct order.

Actual Results:
Double calls within the same runloop; broke quite a bit of our logic.

Regression:
Works as expected on iOS 7.

Notes:
At least that one was easy to reproduce.
