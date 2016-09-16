## iOS 9 regression: UITableView section background is white when visibleCells is called at the wrong time.

http://openradar.appspot.com/23904182

UITableView section background is white when visibleCells is called at the wrong time (namely in viewWillAppear:).
This took me a while to track down. It’s a regression that appeared first on iOS 9.0. 8.3/8.4 work as expected (haven’t tested earlier versions but this never popped up so I assume is’s really a new bug in iOS 9)

We update visible cells in viewWillAppear: instead of calling reloadData to improve performance and keep the selection intact.

As soon as we call `visibleCells` or any of the related API (indexPathsForVisibleRows or cellForRowAtIndexPath) then under certain conditions UIKit reloads views: https://twitter.com/steipete/status/676832422902763520

This was the original bug:
https://twitter.com/steipete/status/676818752630059008

This is how things should look:
http://cl.ly/2H1j253r3H2A

Steps to Reproduce:
See example. Uncomment the call to visibleCells to work around the issue.

Expected Results:
The cell section background color should not change depending on when we query cells.

Tested on iOS 10 GM, not fixed.
