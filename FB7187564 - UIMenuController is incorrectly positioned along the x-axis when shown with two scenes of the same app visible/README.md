## UIMenuController is incorrectly positioned along the x-axis when shown with two scenes of the same app visible

FB7187564

Please provide a descriptive title for your feedback:
UIMenuController is incorrectly positioned along the x-axis when shown with two scenes of the same app visible
Which area are you seeing an issue with?
UIKit
What type of feedback are you reporting?
Incorrect/Unexpected Behavior
Description
Please describe the issue and what steps we can take to reproduce it:
When showing a UIMenuController while multiple scenes of the same app are open, one of the scenes incorrectly positions the menu controller on its x position.

Steps to reproduce:
- Open the attached example project Gallery.xcodeproj.
- Run the project on an iPad running iOS 13b8 or 13.1b1.
- Open 2 scenes of the app side by side.
- Tap on some of the photos in the collection view in both scenes.
- See the menu controller pop up. But the x-position is wrong for all presentations of the menu controller in one of the 2 window scenes of the app. In the other scene, the menu is always correctly positioned.

The UIMenuController is shown from GalleryViewController.swift via the showMenu(from: UIView, rect: CGRect) API.
However, it does not matter if using the new UIMenuController API that was introduced in iOS 13, or the old deprecated API for showing the menu. The incorrect positioning happens for both APIs.

Note: This does not happen for menu controllers that are presented by the system, like the text copy menu in search bars or text fields.