## left bar button items have gap to the back button

http://openradar.appspot.com/25799068

Summary:
When there is a large number of right bar button items and on the left of a `UINavigationBar` there is a back button shown and a left bar button item, the navigation bar removes the text of the back button to make room for the right item, yet it doesn’t seem to remove the space that would be required by the back button label from the layout.

Steps to Reproduce:
0. Open the attached Sample Project
1. Run it on an iPhone 6
2. Tap the ‘Push’ button

Expected Results:
The bar button item labeled ’leftItem’ is drawn right next to the back button, making room for the right bar button items.

Actual Results:
There is a pretty large gap between the left item and the back button, resulting in an overlap of the left bar button item and the left most right bar button item.

Regression:


Notes:
If the gap needs to be there in order to distinguish the item from the back button text, it would be at least preferable if the navigation bar would either remove items from the left or the right side until no overlapping is shown anymore. As the buttons are overlapping, you can’t tap both anyway. So there is no reason to leave a broken looking UI on the screen if it is also non-functional.

Sample code: https://github.com/PSPDFKit-labs/radar.apple.com/tree/master/25799068%20-%20NavBarItemSpacing

Tested on iOS 10 GM, not fixed.
