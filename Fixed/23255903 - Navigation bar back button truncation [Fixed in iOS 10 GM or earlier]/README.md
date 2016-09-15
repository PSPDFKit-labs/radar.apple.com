## Navigation bar does not reverse back button truncation

http://openradar.appspot.com/23255903

Summary:
When space is limited, a UINavigationBar will truncate the current back button. In English it tries the text ‘Back’ before removing the label entirely.

When bar button items are subsequently removed or the title becomes shorter, the back button is not extended again to its full length unless the bar’s layout is updated (by its frame changing).

Steps to Reproduce:
1. Open the attached sample project
2. Run the iOS app in the project
3. Follow the instructions in the app

Expected Results:
The back button should be restored to full length when sufficient space is available.

Actual Results:
After being truncated, the back button stays truncated as the bar contents are updated. Sometimes the back button title changes to ‘Back’ and then that text is truncated, which looks awful.

The UI is inconsistent: if you rotate then rotate back it looks different from how it started.

Version:
iOS 9.1 (13B143) Xcode 7.1 (7B91b)

Notes:
Other than tapping the button to force a layout update, you can also restore a correct layout by rotating the device or taping the back button.

Configuration:
iPhone 5S device and iPhone 6 Plus simulator
