Summary:
Adding a hidden window on iOS is a common way to add HUD overlay elements or other small features - iOS does this as well with it's text effects window. In iOS 8 however, a hidden window now affects rotation. As soon as we call addWindowForHUD the view rotates, which is should not. For some reason the rootViewController of the hidden view is consulted instead of the keyWindow's rootViewController. This is a regression from iOS 7.

Steps to Reproduce:
Open attached WindowRotationIssue example. Works on both iOS 7 and 8. Only iOS 8 exhibits the bug.

Expected Results:
Only the keyWindow should be consulted for rotation callbacks.

Actual Results:
The rootViewController in our hidden window is called for rotation callbacks.

Regression:
This is a regression from iOS 7.

Notes:
Looking at -[UIWindow setRootViewController:] there's a new UIApplicationLinkedOnOrAfter check for iOS 8 that calls tryBecomeRootViewControllerInWindow: if running iOS 8.

Here’s my full debug log for this issue:
https://gist.github.com/steipete/8df39fea0d39680a7a6b


Update June 8, 2016:
Tested with iOS 9.3.2 - still broken.