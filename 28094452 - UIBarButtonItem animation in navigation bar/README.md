## UIBarButtonItems with custom views animate differently to regular bar button items

http://openradar.appspot.com/28094452

Area:
UIKit

Summary:
Calling -[UINavigationItem setRightBarButtonItem:animated:] with an array of regular system bar button items and items with a `customView` results in the custom items animating in slower than the system items.

Steps to Reproduce:
1. Run the attached sample project in Xcode 8b6, on a device or simulator running iOS 9.3 or higher. 
2. Tap the "Toggle" button

Expected Results:
The central red item should animate in alongside the system items

Actual Results:
The central red item animated in much slower than the system items.

Version:
iOS 9.3 (13E233) and iOS 10.0b6 (14A5339a)

Notes:
Sample: https://www.dropbox.com/s/2qmesjysngmmrk0/BarButtonTests.zip?dl=0

Configuration:
Xcode 8b6 (8S201h), iPhone 6s simulator

Tested on iOS 10 GM, not fixed.
