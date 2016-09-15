## Broken rotation animations for modally presented UISplitViewControllers

http://openradar.appspot.com/20833783

Summary:

When presenting a UISplitViewController modally on iOS 8 the standard split view controller rotation animation no longer works as expected.

Steps to Reproduce:

Extract the provided archive and run the provided sample project. Follow the on-screen instructions. 
There’s also a bundled GIF screen capture that shown the issue with iOS simulator slow animations enabled. 

Expected Results:

The master view controller would be show and hidden gradually during rotation, just as it does when the UISplitViewController is the window root view controller. 

Actual Results:

The master view controller doesn’t animate. Instead it jumps to / from the hidden state when the rotation animation completes. 

Regression:

iOS 8+ (including iOS 8.3). iPad only (obviously). Can be observed in the iOS simulator. 

Notes:

iOS 7 prohibited modal presentation of UISplitViewControllers with a runtime exception. This is however no longer the case on iOS 8. The documentation also doesn’t state that this configuration wouldn’t be supported, although it does state that the use case is to use a split view controller as the window’s root view controller. I however see many use cases for modal split view controllers so I think it’s worth fixing the mentioned isse.
