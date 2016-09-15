## UISearchBar content colour customisation

http://openradar.appspot.com/23262835

Summary:
UISearchBar provides no API for conveniently customising its search text, placeholder text and accessory images. This can make content hard to see when using the minimal style on certain backgrounds, especially dark backgrounds.

Steps to Reproduce:
Show a UISearchBar with the minimal style on a dark background

A sample project is attached which shows a couple of bad cases. Uncomment line 15 in AppDelegate.m to see the the placeholder text disappear.

Expected Results:
For there to be an API to conveniently set the content colour(s), or perhaps for the bar’s tintColor to be used for the text colour. Or at least for UIBarStyleBlack to make the text near-white so it works well on all dark backgrounds.

Actual Results:
We have to fiddle around with subview hacking or private API, and using custom images just to change the colour.

Version:
iOS 9, Xcode 7.1 (7B91b)

Notes:
Using UIBarStyleBlack on the search bar helps slightly if the background is pure black.

Configuration:
iPhone 5S device and iPhone 6 simulator
