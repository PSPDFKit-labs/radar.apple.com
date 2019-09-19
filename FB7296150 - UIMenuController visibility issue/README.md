## UIMenuController does not show menu with multiple open windows

FB7296150

Please provide a descriptive title for your feedback:
UIMenuController does not show menu with multiple open windows

Which area are you seeing an issue with?
UIKit

What type of feedback are you reporting?
Incorrect/Unexpected Behavior

Description
Please describe the issue and what steps we can take to reproduce it:
UIMenuController stops showing up the menu when it is being accessed in two windows of the same app simultaneously.
Two windows of the same app are running side by side which have controllers open that can show a UIMenu and a menu is visible in one of the window. If there is an interaction in the other window that results into the first responder or key window being changed to an object in the window where the action took place then the already visible menu in the other window is dismissed. If the user tries to tap again where the menu was dismissed in the window where there was no interaction, the menu stops showing up.

Steps to Reproduce:
1. Open the attached example project Gallery.xcodeproj.
2. Run the project on iPad running any of the beta versions of  iOS 13.
3. Open two windows(scenes) of the app side by side.
4. Tap on some of the photos in both the scenes and ensure that the menu is displayed in one of the window scene.
5. Tap on the *Push VC* navigation bar item on the top right to push a controller and make it the first responder.
6. The already visible menu will be dismissed in the window where the controller isn't pushed.
7. Tap on the photo again to show a menu in the window where it was dismissed.
8. Observe and if the menu shows up then go back to step 4 and perform that tap action swapping the window scenes.

Also attached a screen recording of this behavior and a sample project.