## Status bar inset applied twice

http://openradar.appspot.com/23256354

Summary:
When UISearchController is used in a view in a popover presentation that adapts from popover to full screen, the table view ends up inset 20 points lower than expected.

It appears the status bar inset is applied twice: once by the navigation controller and once by the search presentation controller.

Steps to Reproduce:
1. Open the attached sample project
2. Run the app on iPad Air 2
3. Follow the instructions in the app

Expected Results:
After cancelling, the top of the search bar should be aligned with the bottom of the navigation bar.

Actual Results:
The search bar is 20 points too low. Indeed, the whole table view content is inset 20 points from the top.

Version:
iOS 9.1 Xcode 7.1 (7B91b)

Notes:


Configuration:
iPad Air 2 simulator

Attachments:
'SearchStatusBarInset.zip' was successfully uploaded.

- - - - - - - - - -

If you look carefully, the table content is 20 points too low immediately after rotation, but it isn’t easy to see until search is cancelled. You can get a good sense of what’s going on by logging or setting a breakpoint in the table view’s `setContentInset:`.



Tested on iOS 10 GM, still broken.
