Summary:
The UIMenuController will be presented clipped in landscape mode. The UITextEffectsWindow created by the menu has the wrong coordinates. This only happens if the LaunchImage is missing, so currently this is an issue for iPhone 5/5s/6/6+. It does work flawlessly on an iPhone 4s.

Steps to Reproduce:
Open attached example. Rotate to landscape. Tap in the middle. Notice that the menu is clipped: http://cl.ly/image/3y1i1d2B461h

Expected Results:
The menu should not be clipped.

Actual Results:
The menu is clipped = only partially visible.

Regression:
This is a regression in iOS 8 and worked as expected in iOS 7

Notes:
I suspect some code in the rotation logic of the UITextEffectsWindow update the frame incorrect if the window isn’t actually full-screen as it is due to the compatibility mode. We know that adding a LaunchImage is a possibility but this is still an issue for many apps that are already released.

Fixed in iOS 9.0