## presenting view controller is nil

http://openradar.appspot.com/22394059

Summary:
When the UIViewControllerTransitioningDelegate method 
- presentationControllerForPresentedViewController:presentingViewController:sourceViewController: is called, the presenting view controller is unexpectedly nil.

Steps to Reproduce:
1. Open the attached sample project, which implements presentationControllerForPresentedViewController:presentingViewController:sourceViewController: and asserts all the arguments are non-nil
2. Run it
3. Tap to present a view controller

Expected Results:
For no assertion to fail. I.e. for presented, presenting, and source to to non-nil, as they are documented as nonnull.

Actual Results:
presenting is nil.

Version:
iOS 9 beta 5

Notes:
Workaround: the source is often good enough so we are currently basing decisions about what presentation controller to return by querying `presenting ?: source`.

Configuration:
iPhone 4S iOS 9 simulator
