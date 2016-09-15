## UISearchController animations issues

http://openradar.appspot.com/21682685

Summary:

While migrating PSPDFKit to the new UISearchController API, we noticed a few issues with implicit animations. 

On iOS 9b2:
- the search bar placeholder text doesn't animate from center alignment to left alignment the first time search is invoked (works fine afterwards though)
- the table view row deselection on the searchResultsController is abrupt instead of animated (as observable on a regular UITableViewController with clearsSelectionOnViewWillAppear enabled - the default configuration)

On iOS 8, the search bar placeholder animation works, the however the deselection does not occur at all.

Steps to Reproduce:

Extract the attached archive. The animations can be observed in the attached GIF (recorded on iOS 9).
The archive also contains a slightly modified version of the Apple TableSearch example. The only changes made were 1.) adding a launch storyboard for proper display on iPhone 6 and commenting a line that immediately deselected the selected cell (commented with a “//PSPDFKit” prefixed comment). 

Expected Results:

The placeholder text would always animate & the selected row deselection would be animated like usual for UITableViewController. 

Actual Results:

See Summary. 

Regression:

iOS 9.0b2, iOS 8.4, iPhone and iPad.
