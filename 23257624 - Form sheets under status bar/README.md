 
Summary:
Form sheets appear underneath the status bar on iPad in horizontally compact environments (This happens when using Split View.)

This only happens if we prevent adaptivity. By default form sheets adapt to full screen presentations.

Steps to Reproduce:
A sample project is attached which demonstrates the problem. Run it on an iPad Air 2 in portrait in Split View.

1. Present a view controller with its modalPresentationStyle set to UIModalPresentationFormSheet
2. Prevent adaptivity by returning UIModalPresentationNone to adaptivePresentationStyleForPresentationController: or adaptivePresentationStyleForPresentationController:traitCollection:
3. Present the view controller on iPad in a horizontally compact width

Expected Results:
The top of the presented view should be just underneath the status bar, as it is on iPhone.

Actual Results:
The presented view is shown underneath the status bar, and the navigation bar is only 44 points high, so some content is covered.

Version:
iOS 9, Xcode 7.1 (7B91b)

Notes:
This problem does not happen if the presented view has a preferredContentSize. This can be seen by setting SPECIFY_CONTENT_SIZE to 1 in DetailViewController.m.

Configuration:
iPad Air 2 simulator

Still issue in iOS 9.3.2