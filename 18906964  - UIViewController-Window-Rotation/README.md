## Moving UIViewController from one window to another breaks rotation in iOS 8.1

http://openradar.appspot.com/18906964

Tested on iOS 9.3.2 - same issue (See how the main centered view is red after step 12)

Summary:
Moving a UIViewController instance from the main window to a different window by setting it as the rootViewController breaks rotation behavior on iOS 8.1. This is a regression that first occurred in iOS 8.1. iOS 8.0.x and iOS 7.x are not affected.

Steps to Reproduce:
Download the attached example project and perform the following steps:

1. Run on iPhone with iOS 8.1
2. Tap the "New Controller" button while in portrait mode
3. Notice that the blue view is now in fullscreen
4. Rotate the device to landscape
5. Notice that the rotation works properly
6. Rotate back to landscape
7. Dismiss by tapping the blue view
8. Tap the "Re-use Controller" button while in portrait mode
9. Notice that the blue view is now in fullscreen
10. Rotate to landscape
11. Notice that the landscape view is not properly sized
12. Restart the app before trying again to restore the initial state

Expected Results:
The blue view is properly sized to occupy the entire UIWindow.

Actual Results:
The blue view is improperly sized.

Version:
iOS 8.1

Notes:
Also broken in iOS 8.1.1b1. Affects both iPad and iPhone.

Configuration:
iPad Air 2

Tested on iOS 10 GM, not fixed.
