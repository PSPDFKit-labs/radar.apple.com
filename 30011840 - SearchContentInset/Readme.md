## UISearchController's table view does not layout properly when the enclosing UINavigationController has its toolbar visible

Summary:
When using a UISearchController inside a UITableViewController that itself is displayed in a UINavigationController whose toolbar is set to be visible, the search controller’s table view will get an inset at the top that is of size navigationbar+toolbar, leaving a 44.0pt gap between the navigation bar and the first row of the search results.

Steps to Reproduce:
- Open the sample project
- Run it on an iPad (tested with iPad Pro 12.9” and iPad Air 2 Simulator)
- Tap the ‘Tap Me’ button in the top right corner
- Tap the search bar of the view controller that just appeared in a popover
- Type something (one letter is enough)

Expected Results:
The results table view shows all entries, starting with the first cell right belog the navigation bar / search bar.

Actual Results:
- The result table view shows all entries, but there is a gap of 44pt between the navigation bar / search bar and the first cell.
- Checking the result table view’s contentInset reveals a top value of 88pt.

Regression:

Notes:
