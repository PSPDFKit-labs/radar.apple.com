## Setting preferredContentSize doesn't always correctly update the size if navigationBarHidden changes.

http://openradar.appspot.com/19175472

Summary:
Setting preferredContentSize doesn't always correctly update the size if navigationBarHidden changes.

Steps to Reproduce:
Open example. Observe that the popover is too large; it should be exactly the size to fit 5 rows, but there is one extra, which is the space for the hidden top toolbar.

Expected Results:
Should be sized correctly.

Actual Results:
Popover size is too large.

Regression:
Doesn’t work on iOS 7 either.

Notes:
Not sure if I’m doing something wrong here, when I change the call order I can make it work, however the call order here should not be relevant. It looks like changing preferredContentSize doesn’t propagate upwards (doesn’t call _preferredContentSizeDidChangeForChildViewController: if it’s the same value.)
